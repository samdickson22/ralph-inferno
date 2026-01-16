# Refactor ralph.sh

Replace hardcoded Claude calls with backend abstraction.

## Krav
- Source `lib/backend.sh` at script start
- Replace line ~158: `claude -p` → `run_backend_code`
- Preserve timeout wrapping
- Preserve output capture

## Current (line 158)
```bash
output=$(echo "$prompt" | timeout $TIMEOUT claude --dangerously-skip-permissions -p 2>&1)
```

## Target
```bash
source "$SCRIPT_DIR/../lib/backend.sh"
output=$(run_backend_code "$prompt" "$TIMEOUT")
```

## Klart när
- [ ] ralph.sh uses backend abstraction
- [ ] Works with `RALPH_BACKEND=claude`
- [ ] Works with `RALPH_BACKEND=opencode`
