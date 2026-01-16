# Install Backend Choice

Update `cli/install.js` to prompt for backend selection.

## Krav
- Add prompt: "Which backend? 1) Claude Code 2) OpenCode"
- Store choice in config.json `backend` field
- Show backend-specific auth instructions
- Copy correct skill files based on backend

## Flow
```
? Which AI backend do you want to use?
  1) Claude Code (recommended)
  2) OpenCode
> 1
```

## Klart när
- [ ] Install prompts for backend
- [ ] Choice saved to config.json
- [ ] Correct files copied per backend
