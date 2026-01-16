---
description: Review Ralph's work
agent: ralph-build
---

# /ralph-review - Review Ralph's work

Check if Ralph is done and review the results.

## Usage
```
/ralph-review
/ralph-review --tunnel   # Also open SSH tunnel for testing
```

## Instructions

**STEG 1: KOLLA OM RALPH KOR**

```bash
ssh ralph@$(cat ~/.ralph-vm | grep VM_IP | cut -d= -f2) 'pgrep -f "ralph.sh|claude" && echo "RUNNING" || echo "NOT_RUNNING"'
```

Om RUNNING:
```
Ralph kor fortfarande pa VM!

Folj progress:
  ssh ralph@VM_IP 'tail -f ~/projects/REPO/ralph-deploy.log'

Kom tillbaka nar Ralph ar klar.
```
STOPPA HAR - ge inte fler alternativ.

Om NOT_RUNNING → fortsatt till steg 2.

**STEG 2: KOLLA RESULTAT**

```bash
# Hamta senaste fran VM
source ~/.ralph-vm
ssh $VM_USER@$VM_IP "cd ~/projects/$(basename $(git remote get-url origin) .git) && git log --oneline -10"
```

Visa:
- Antal commits Ralph gjorde
- Vilka specs som kordes

**STEG 3: PULL CHANGES**

```bash
git pull origin main
```

**STEG 4: LISTA PRs (om nagra)**

```bash
gh pr list
```

**STEG 5: OPPNA TUNNEL (om --tunnel)**

```bash
# Oppna SSH tunnel for att testa appen
ssh -L 5173:localhost:5173 -L 54321:localhost:54321 $VM_USER@$VM_IP
```

Visa:
```
Tunnlar oppna!
- App: http://localhost:5173
- Supabase: http://localhost:54321

Tryck Ctrl+C for att stanga tunnlarna.
```
