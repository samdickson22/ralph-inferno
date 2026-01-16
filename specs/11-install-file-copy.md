# Install File Copy Logic

Update installation to copy backend-specific files.

## Krav
- If Claude: copy `.claude/commands/` to project
- If OpenCode: copy `.opencode/command/` and `.opencode/agent/`
- Create correct directory structure
- Handle update scenario (preserve user config)

## Logic
```javascript
if (backend === 'claude') {
  copyDir('core/.claude/commands', '.claude/commands')
} else if (backend === 'opencode') {
  copyDir('core/.opencode/command', '.opencode/command')
  copyDir('core/.opencode/agent', '.opencode/agent')
}
```

## Klart när
- [ ] Correct files copied per backend
- [ ] Directory structure created
- [ ] Update preserves user customizations
