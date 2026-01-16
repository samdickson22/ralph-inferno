# IMPLEMENTATION_PLAN.md

## Epics Overview

| Epic | Namn | Status |
|------|------|--------|
| E1 | Backend Abstraction Layer | pending |
| E2 | OpenCode Provider Implementation | pending |
| E3 | Configuration & Installation | pending |
| E4 | Script Refactoring | pending |
| E5 | Skill/Command Parity | pending |
| E6 | Agent Configuration | pending |
| E7 | Testing & Validation | pending |

## Tasks

### Kritisk (E1: Backend Abstraction Layer)
- [ ] T1: Create `core/lib/backend.sh` with dispatch functions
- [ ] T2: Implement `run_backend_code()` dispatcher
- [ ] T3: Implement `run_backend_vision()` dispatcher
- [ ] T4: Add backend detection and validation
- [ ] **HARD STOP** - Verifiera abstraction layer fungerar med Claude

### Kritisk (E2: OpenCode Provider Implementation)
- [ ] T5: Create `core/lib/opencode.sh` provider module
- [ ] T6: Implement `run_opencode_code()` function
- [ ] T7: Implement `run_opencode_vision()` function (or stub)
- [ ] T8: Handle OpenCode JSON output parsing
- [ ] T9: Handle OpenCode authentication
- [ ] **HARD STOP** - Verifiera OpenCode provider fungerar standalone

### Hög (E3: Configuration & Installation)
- [ ] T10: Update `cli/install.js` to ask for backend choice
- [ ] T11: Add `backend` field to config.json schema
- [ ] T12: Support `RALPH_BACKEND` environment variable
- [ ] T13: Backend-specific auth configuration in install

### Hög (E4: Script Refactoring)
- [ ] T14: Refactor `ralph.sh` to use `run_backend_code()`
- [ ] T15: Refactor `test-loop.sh` code generation calls
- [ ] T16: Refactor `test-loop.sh` vision calls
- [ ] T17: Update `verify.sh` for backend detection
- [ ] **HARD STOP** - Verifiera full Ralph loop fungerar med båda backends

### Medium (E5: Skill/Command Parity)
- [ ] T18: Create `.opencode/command/` directory structure
- [ ] T19: Convert `ralph:discover.md` to OpenCode format
- [ ] T20: Convert `ralph:plan.md` to OpenCode format
- [ ] T21: Convert `ralph:deploy.md` to OpenCode format
- [ ] T22: Convert `ralph:review.md` to OpenCode format
- [ ] T23: Convert `ralph:change-request.md` to OpenCode format
- [ ] T24: Convert `ralph:status.md` to OpenCode format
- [ ] T25: Convert `ralph:abort.md` to OpenCode format
- [ ] T26: Convert `ralph:idea.md` to OpenCode format
- [ ] T27: Convert `ralph:preflight.md` to OpenCode format

### Medium (E6: Agent Configuration)
- [ ] T28: Create `.opencode/agent/ralph-build.md`
- [ ] T29: Create `.opencode/agent/ralph-plan.md`
- [ ] T30: Configure tool permissions for ralph agents

### Låg (E7: Testing & Validation)
- [ ] T31: Update installation to copy correct files per backend
- [ ] T32: Test full workflow with OpenCode backend
- [ ] T33: Document backend differences in README
- [ ] T34: Add backend switching documentation

---

## Progress

| Datum | Task | Resultat |
|-------|------|----------|
| 2026-01-15 | PRD Created | docs/prd.md |
| 2026-01-15 | Implementation Plan | docs/IMPLEMENTATION_PLAN.md |

---

## Learnings

| Problem | Lärdom |
|---------|--------|
| TBD | TBD |

---

## Blocked

None currently.

---

## Technical Notes

### Backend Dispatch Pattern
```bash
# lib/backend.sh
RALPH_BACKEND="${RALPH_BACKEND:-claude}"

run_backend_code() {
    case "$RALPH_BACKEND" in
        claude) run_claude_code "$@" ;;
        opencode) run_opencode_code "$@" ;;
    esac
}
```

### OpenCode CLI Mapping
```bash
# Claude: echo "prompt" | claude -p --dangerously-skip-permissions
# OpenCode: opencode run "prompt" --format json
```

### Key Files to Modify
1. `core/scripts/ralph.sh` - Line 158
2. `core/lib/test-loop.sh` - Lines 83, 177
3. `core/lib/verify.sh` - Backend check
4. `cli/install.js` - Backend selection
