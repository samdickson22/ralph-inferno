# OpenCode Provider Module

Create `core/lib/opencode.sh` with OpenCode-specific implementation.

## Krav
- `run_opencode_code()` using `opencode run "prompt"`
- `run_opencode_vision()` - stub or MCP integration
- `check_opencode()` - Verify opencode CLI installed
- Parse JSON output with `--format json`
- Handle streaming vs non-streaming modes

## CLI Mapping
```bash
# Input: prompt string
# Output: LLM response text
opencode run "$prompt" --format json | jq -r '.content'
```

## Klart när
- [ ] `run_opencode_code "hello"` returns response
- [ ] JSON output parsed correctly
- [ ] Vision function exists (even if stub)
