# PRD: OpenCode Backend Support for Ralph Inferno

## Overview

Add OpenCode as an alternative backend to Ralph Inferno, providing full feature parity with the existing Claude Code integration. Users should be able to choose between Claude Code or OpenCode during installation and runtime.

## Background

Ralph Inferno currently has tight coupling to Claude Code CLI. To support OpenCode, we need:
1. Backend abstraction layer
2. OpenCode-specific implementation
3. Configuration updates
4. Skill/command file adaptations

## Feature Requirements

### F1: Backend Abstraction Layer
Create a unified interface for LLM backends that abstracts:
- Code generation (piping prompts to CLI)
- Vision/screenshot analysis
- Streaming output capture
- Exit code handling
- Timeout management

### F2: OpenCode Provider Implementation
Implement OpenCode-specific functions:
- `run_opencode_code()` - Execute prompts via `opencode run`
- `run_opencode_vision()` - Handle image analysis (if supported)
- Authentication handling
- JSON output parsing (`--format json`)

### F3: Configuration System Updates
- Add `backend` field to `.ralph/config.json`
- Update `cli/install.js` to prompt for backend choice
- Support environment variable override: `RALPH_BACKEND`
- Backend-specific auth configuration

### F4: Script Refactoring
Update all scripts that call Claude directly:
- `ralph.sh` - Main execution loop
- `test-loop.sh` - E2E test analysis and CR generation
- `verify.sh` - Backend availability checks
- `orchestrator.sh` - If applicable

### F5: Skill/Command Parity
Adapt `.claude/commands/*.md` to work with both backends:
- Create `.opencode/command/*.md` equivalents
- Ensure skill registration works for both
- Update installation to copy correct skill files

### F6: Agent Configuration
For OpenCode's agent system:
- Create `.opencode/agent/ralph-build.md` - Full development agent
- Create `.opencode/agent/ralph-plan.md` - Analysis agent
- Mirror tool permissions from Claude setup

## Technical Mapping

### CLI Command Equivalence

| Feature | Claude Code | OpenCode |
|---------|-------------|----------|
| Non-interactive run | `claude -p` | `opencode run` |
| Pipe input | `echo "prompt" \| claude -p` | `opencode run "prompt"` |
| Skip permissions | `--dangerously-skip-permissions` | Configure in agent permissions |
| Image input | `--image path` | TBD - may need MCP/plugin |
| JSON output | N/A (text) | `--format json` |
| Timeout | External `timeout` command | Built-in or external |

### Configuration Mapping

| Claude Config | OpenCode Config |
|---------------|-----------------|
| `.claude/commands/*.md` | `.opencode/command/*.md` |
| `CLAUDE.md` (project instructions) | `.opencode/agent/*.md` or `opencode.json` |
| API key auth | Provider config in `opencode.json` |

### Agent/Skill File Format Comparison

**Claude Code Skill** (`.claude/commands/ralph:deploy.md`):
```markdown
# /ralph:deploy - Deploy to VM

Instructions here...
```

**OpenCode Command** (`.opencode/command/ralph-deploy.md`):
```markdown
---
description: Deploy to VM
agent: ralph-build
---
Instructions here...
```

## Non-Goals
- Desktop app integration (TUI only)
- Web UI support
- Multi-backend simultaneous use
- Provider-specific model selection UI

## Success Criteria
1. `npx ralph-inferno install` offers backend choice
2. All 9 ralph commands work with OpenCode
3. Full workflow (discover → plan → deploy → review) completes
4. E2E test loop and auto-CR generation work
5. Vision/design review works (or gracefully degrades)

## Open Questions
1. Does OpenCode support vision/image analysis natively?
2. How to handle permission differences between backends?
3. Should we support mixed mode (Claude for vision, OpenCode for code)?

## Design Tokens
N/A - This is infrastructure/backend work

## Out of Scope
- UI changes
- New features beyond backend parity
- Performance optimizations
