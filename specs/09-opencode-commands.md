# OpenCode Command Files

Create `.opencode/command/` equivalents of Claude skills.

## Krav
- Create directory structure: `.opencode/command/`
- Convert all 9 ralph commands to OpenCode format
- Use YAML frontmatter with `description` and `agent`
- Preserve command functionality

## Format Conversion
```markdown
# Claude: .claude/commands/ralph:deploy.md
# /ralph:deploy - Deploy to VM
[content]

# OpenCode: .opencode/command/ralph-deploy.md
---
description: Deploy to VM
agent: ralph-build
---
[content]
```

## Files to Create
- ralph-discover.md
- ralph-plan.md
- ralph-deploy.md
- ralph-review.md
- ralph-change-request.md
- ralph-status.md
- ralph-abort.md
- ralph-idea.md
- ralph-preflight.md

## Klart när
- [ ] All 9 commands converted
- [ ] OpenCode recognizes `/ralph-*` commands
- [ ] Commands execute correctly
