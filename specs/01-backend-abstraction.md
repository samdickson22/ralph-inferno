# Backend Abstraction Layer

Create `core/lib/backend.sh` with unified interface for LLM backends.

## Krav
- Source backend from config: `RALPH_BACKEND` env or config.json
- `run_backend_code()` dispatcher function
- `run_backend_vision()` dispatcher function
- `check_backend()` validation function
- Default to `claude` if not specified

## Implementation
Create file at `core/lib/backend.sh` with:
```bash
run_backend_code() { ... }
run_backend_vision() { ... }
check_backend() { ... }
```

## Klart när
- [ ] `source lib/backend.sh` works
- [ ] `run_backend_code "test"` dispatches correctly
- [ ] `check_backend` validates installation
