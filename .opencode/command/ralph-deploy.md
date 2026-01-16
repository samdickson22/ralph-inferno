---
description: Deploy to VM via GitHub
agent: ralph-build
---

# /ralph-deploy - Deploy till VM via GitHub

Pusha projekt till GitHub och starta Ralph pa VM.

## Usage
```
/ralph-deploy
/ralph-deploy --overnight   # Stang av VM nar klar
/ralph-deploy --skip-requirements  # Hoppa over requirements check
```

## Prerequisites
- IMPLEMENTATION_PLAN.md eller specs/*.md maste finnas
- VM maste vara konfigurerad (~/.ralph-vm)
- GitHub repo maste finnas

## Instructions

Du ar en deployment-assistent. Kor dessa steg:

**STEG 1: VALIDERA**

Kor denna validering och STOPPA om nagot saknas:

```bash
echo "=== PRE-DEPLOY VALIDATION ==="

# 1. Specs maste finnas
SPEC_COUNT=$(ls -1 specs/*.md 2>/dev/null | grep -v "CR-" | wc -l | tr -d ' ')
if [ "$SPEC_COUNT" -eq 0 ]; then
    echo "FATAL: No specs found in specs/"
    echo "   Run /ralph-plan first to generate specs"
    exit 1
fi
echo "Found $SPEC_COUNT specs"

# 2. PRD bor finnas
if [ ! -f "docs/PRD.md" ] && [ ! -f "docs/prd.md" ]; then
    echo "WARNING: No PRD found in docs/"
    echo "   Recommended: Run /ralph-discover first"
fi

# 3. CLAUDE.md bor finnas
if [ ! -f "CLAUDE.md" ]; then
    echo "WARNING: No CLAUDE.md found"
    echo "   Ralph works better with project instructions"
fi

# 4. VM config
if [ ! -f "$HOME/.ralph-vm" ]; then
    echo "FATAL: No VM config found (~/.ralph-vm)"
    echo "   Create it with: echo 'VM_IP=x.x.x.x' > ~/.ralph-vm"
    exit 1
fi
source ~/.ralph-vm
echo "VM config: $VM_USER@$VM_IP"

# 5. Git remote
if ! git remote get-url origin > /dev/null 2>&1; then
    echo "FATAL: No git remote 'origin'"
    echo "   Add with: git remote add origin <url>"
    exit 1
fi
echo "Git remote OK"

echo ""
echo "=== VALIDATION PASSED ==="
```

Om nagot ar FATAL → **STOPPA** och be anvandaren fixa det.
Om nagot ar WARNING → Fraga om de vill fortsatta anda.

**STEG 2: REQUIREMENTS CHECK (om inte --skip-requirements)**

Kor requirements check LOKALT forst (inte pa VM):

```bash
# Hitta requirements.sh fran template eller scripts
if [ -f ".ralph/scripts/requirements.sh" ]; then
  .ralph/scripts/requirements.sh --check
elif [ -f ".ralph/templates/stacks/react-supabase/scripts/requirements.sh" ]; then
  .ralph/templates/stacks/react-supabase/scripts/requirements.sh --check
else
  echo "No requirements.sh found, skipping"
fi
```

Om requirements FAILAR:
- Visa vad som saknas
- Ge instruktioner for manuell fix (speciellt auth)
- STOPPA deploy tills fixat

Om requirements OK → fortsatt till steg 3.

**STEG 3: KOLLA CLAUDE AUTH PA VM**

Kor via SSH for att kolla om Claude ar autentiserad:
```bash
source ~/.ralph-vm
ssh $VM_USER@$VM_IP "claude --version 2>/dev/null && echo 'CLAUDE_OK' || echo 'CLAUDE_MISSING'"
```

Om `CLAUDE_MISSING` eller forsta gangen:

Las `.ralph/config.json` for att se `claude.auth_method`:

**Om `subscription`:**
```
Claude behover autentiseras pa VM:en (forsta gangen)

Kor foljande:
  1. ssh $VM_USER@$VM_IP
  2. claude login
  3. Folj instruktionerna i browsern
  4. Kor /ralph-deploy igen

Detta behover bara goras en gang per VM.
```
**STOPPA** och vanta pa att anvandaren gor detta.

**Om `api_key`:**
```
ANTHROPIC_API_KEY behover sattas pa VM:en

Kor foljande:
  1. ssh $VM_USER@$VM_IP
  2. echo 'export ANTHROPIC_API_KEY="sk-ant-..."' >> ~/.bashrc
  3. source ~/.bashrc
  4. Kor /ralph-deploy igen
```
**STOPPA** och vanta pa att anvandaren gor detta.

Om Claude redan fungerar → fortsatt till steg 4.

**STEG 4: VALJ MODE**

Fraga anvandaren med AskUserQuestion:

```
Vilken mode vill du kora Ralph i?

1. Standard (E2E + auto-CR) - Recommended
   Kor specs med Playwright-tester, genererar auto-fix vid fel

2. Quick (bara build)
   Snabbaste - bara spec-korning och build verify

3. Inferno (allt + parallel)
   Full kraft - E2E, auto-CR, design review, parallel worktrees
```

Spara valet:
- Standard → `RALPH_FLAGS="--orchestrate"`
- Quick → `RALPH_FLAGS=""`
- Inferno → `RALPH_FLAGS="--orchestrate --parallel"`

**STEG 5: PUSHA TILL GITHUB**
```bash
git add -A
git commit -m "Deploy: $(date +%Y-%m-%d_%H:%M)" || true
git push origin main
```

**STEG 6: STARTA PA VM**

Anvand RALPH_FLAGS fran steg 3. Kor via SSH:
```bash
# Hamta VM-config
source ~/.ralph-vm

# SSH till VM och kor (RALPH_FLAGS satts baserat pa mode-val)
ssh $VM_USER@$VM_IP << EOF
  # Cleanup - doda gamla processer innan vi startar
  echo "Cleaning up old processes..."
  supabase stop 2>/dev/null || true
  pkill -f "vite|next|node.*dev" 2>/dev/null || true
  sleep 2

  cd ~/projects

  # Klona eller uppdatera repo
  REPO_NAME=\$(basename \$(git remote get-url origin 2>/dev/null || echo "project") .git)

  if [ -d "\$REPO_NAME" ]; then
    cd "\$REPO_NAME"
    git pull origin main
  else
    gh repo clone \$(git remote get-url origin) "\$REPO_NAME"
    cd "\$REPO_NAME"
  fi

  # Installera node_modules om saknas
  [ -f "package.json" ] && [ ! -d "node_modules" ] && npm install

  # Gor ralph korbar
  chmod +x ralph .ralph/scripts/*.sh 2>/dev/null || true

  # Starta Ralph med vald mode
  nohup ./.ralph/scripts/ralph.sh $RALPH_FLAGS > ralph-deploy.log 2>&1 &
  echo "Ralph startad med PID: \$! (mode: $RALPH_FLAGS)"
EOF
```

**MODES:**
- Standard: `--orchestrate` (E2E + auto-CR)
- Quick: (inga flaggor) - bara build verify
- Inferno: `--orchestrate --parallel` (allt)

**STEG 7: BEKRAFTA**
Skriv ut:
```
DEPLOY KLAR!

Ralph kor nu pa VM: $VM_IP

Folj progress:
  - ntfy.sh (notifieringar)
  - ssh $VM_USER@$VM_IP 'tail -f ~/projects/REPO/ralph-deploy.log'

Nar klar:
  /ralph-review    # Oppna tunnlar och testa
```

**VIKTIGT:**
- Anvand `gh repo clone` INTE `git clone` (hanterar auth)
- Kor ralph.sh i bakgrunden med nohup
- Ge anvandaren kommandon for att folja progress
