# Refactor verify.sh

Update backend detection and validation.

## Krav
- Replace `which claude` with `check_backend()`
- Show backend-specific error messages
- Validate correct backend is installed

## Current
```bash
which claude || { echo "Claude Code CLI not found"; exit 1; }
```

## Target
```bash
source "$SCRIPT_DIR/../lib/backend.sh"
check_backend || { echo "$RALPH_BACKEND not found"; exit 1; }
```

## Klart när
- [ ] Backend detection works for both
- [ ] Clear error messages per backend
- [ ] Script exits cleanly if backend missing
