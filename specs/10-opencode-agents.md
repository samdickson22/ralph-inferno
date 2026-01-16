# OpenCode Agent Configuration

Create Ralph-specific agents for OpenCode.

## Krav
- Create `.opencode/agent/ralph-build.md` - Full access agent
- Create `.opencode/agent/ralph-plan.md` - Read-only analysis
- Configure tool permissions matching Ralph's needs
- Set appropriate model and temperature

## ralph-build.md
```markdown
---
description: Ralph development agent with full tool access
mode: primary
temperature: 0.1
tools:
  write: true
  edit: true
  bash: true
permission:
  bash:
    "rm -rf *": deny
    "sudo rm *": deny
    "*": allow
---
You are Ralph, an autonomous development agent...
```

## ralph-plan.md
```markdown
---
description: Ralph planning agent (read-only)
mode: primary
temperature: 0.1
tools:
  write: false
  edit: false
permission:
  bash:
    "git *": allow
    "npm run *": allow
    "*": ask
---
You are Ralph in planning mode...
```

## Klart när
- [ ] Both agents created
- [ ] Agents selectable in OpenCode
- [ ] Permissions work as expected
