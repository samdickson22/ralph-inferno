# Config Backend Field

Add backend selection to configuration system.

## Krav
- Add `backend` field to `.ralph/config.json` schema
- Values: `"claude"` or `"opencode"`
- Support `RALPH_BACKEND` environment variable override
- Environment variable takes precedence over config file

## Config Example
```json
{
  "backend": "opencode",
  "opencode": {
    "model": "anthropic/claude-sonnet-4-20250514"
  }
}
```

## Klart när
- [ ] Config schema updated
- [ ] Backend read from config in scripts
- [ ] Env var override works
