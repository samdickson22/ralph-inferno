# Claude Provider Module

Extract existing Claude Code calls into `core/lib/claude.sh` provider.

## Krav
- `run_claude_code()` - Pipe prompts to `claude -p`
- `run_claude_vision()` - Handle `--image` flag
- `check_claude()` - Verify claude CLI installed
- Preserve existing timeout and permission flags

## Klart när
- [ ] All Claude calls extracted to provider module
- [ ] Existing ralph.sh behavior unchanged
- [ ] `run_claude_code "hello"` returns response
