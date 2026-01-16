# Refactor test-loop.sh

Replace Claude calls in test analysis and vision with backend abstraction.

## Krav
- Replace line ~83 (test analysis): `claude -p` → `run_backend_code`
- Replace line ~177 (vision): `claude --image` → `run_backend_vision`
- Handle backends that don't support vision (graceful degradation)

## Vision Fallback
```bash
if ! run_backend_vision "$prompt" "$screenshot"; then
    log_warn "Vision not supported, skipping design review"
fi
```

## Klart när
- [ ] Test analysis uses backend abstraction
- [ ] Vision uses backend abstraction
- [ ] Graceful fallback when vision unavailable
