# 🔥 Ralph Inferno

```
🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥
🔥                                              🔥
🔥  ██████╗  █████╗ ██╗     ██████╗ ██╗  ██╗    🔥
🔥  ██╔══██╗██╔══██╗██║     ██╔══██╗██║  ██║    🔥
🔥  ██████╔╝███████║██║     ██████╔╝███████║    🔥
🔥  ██╔══██╗██╔══██║██║     ██╔═══╝ ██╔══██║    🔥
🔥  ██║  ██║██║  ██║███████╗██║     ██║  ██║    🔥
🔥  ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝  ╚═╝    🔥
🔥                                              🔥
🔥          I N F E R N O   M O D E             🔥
🔥                                              🔥
🔥  Build while you sleep. Wake to working code 🔥
🔥                   🌙 → ☀️                     🔥
🔥                                              🔥
🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥
```

AI-driven autonomous development workflow.

## Requirements

**Local machine:**
- Node.js (for npx)
- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) (`claude`)
- GitHub CLI (`gh`) - optional, for auto-detecting username

**VM (where Ralph runs):**
- A running VM/server (Hetzner, GCP, DigitalOcean, AWS, or your own)
- SSH access to the VM
- Git installed
- Claude Code CLI with either:
  - Anthropic API key (`ANTHROPIC_API_KEY`), or
  - Claude subscription (requires `claude login` on the VM)

**Optional:**
- Cloud CLI (`hcloud`, `gcloud`, `doctl`, `aws`) for VM management
- [ntfy.sh](https://ntfy.sh) for notifications

## Installation

```bash
npx ralph-inferno install
```

This will:
1. Show disclaimer (VM sandbox required)
2. Ask for your preferences (language, cloud provider, etc.)
3. Ask how Claude authenticates (subscription or API key)
4. Install Ralph core files to `.ralph/`
5. Create a `ralph` wrapper script

## Update

Update core files while preserving your config:

```bash
npx ralph-inferno update
```

## Workflow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           RALPH WORKFLOW                                     │
└─────────────────────────────────────────────────────────────────────────────┘

   YOUR IDEA
      │
      ▼
┌─────────────────┐
│ /ralph:discover │  ◄── Autonomous discovery loop
│                 │      Claude explores from all angles
│ Output: PRD.md  │      (Analyst, PM, UX, Architect, Business)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  /ralph:plan    │  ◄── Breaks down PRD into specs
│                 │
│ Output: specs/* │      (01-setup.md, 02-auth.md, etc.)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  /ralph:deploy  │  ◄── Push to GitHub, start on VM
│                 │      Choose mode: Quick/Standard/Inferno
└────────┬────────┘
         │
         ▼
┌─────────────────────────────────────────────────────────────────┐
│                     ON THE VM (AUTONOMOUS)                       │
│                                                                  │
│   ralph.sh runs specs → build → test → auto-fix → commit        │
│                                                                  │
└────────┬─────────────────────────────────────────────────────────┘
         │
         ▼
┌─────────────────┐
│  /ralph:review  │  ◄── Open tunnels, test the app
└────────┬────────┘
         │
         ▼
┌─────────────────────┐
│ /ralph:change-      │  ◄── If bugs found, generate CR specs
│ request             │      Then run /ralph:deploy again
└─────────────────────┘
```

### Commands

| Command | Description |
|---------|-------------|
| `/ralph:discover` | Autonomous discovery loop, creates PRD with web research |
| `/ralph:plan` | Creates implementation plan + spec files |
| `/ralph:deploy` | Push to GitHub, choose mode, start Ralph on VM |
| `/ralph:review` | Open SSH tunnels, test the app |
| `/ralph:change-request` | Document bugs, generate CR specs for fixes |
| `/ralph:status` | Check Ralph's progress on VM |
| `/ralph:abort` | Stop Ralph on VM |

### Deploy Modes

When running `/ralph:deploy`, you choose a mode:

| Mode | What it does |
|------|--------------|
| **Quick** | Spec execution + build verify only |
| **Standard** | + Playwright E2E tests + auto-CR generation |
| **Inferno** | + Design review + parallel worktrees |

### Example Session

```bash
# 1. Install Ralph in your project
npx ralph-inferno install

# 2. In Claude Code:
/ralph:discover    # Autonomous discovery with web research
/ralph:plan        # Generate specs from PRD
/ralph:deploy      # Choose mode, send to VM

# 3. Next morning:
/ralph:review      # Test what Ralph built

# 4. If bugs found:
/ralph:change-request  # Generate fix specs
/ralph:deploy          # Run fixes
```

## Safety

Ralph runs AI-generated code autonomously. For safety:

- **ALWAYS run on a disposable VM** - never on your local machine
- Review generated code before production
- Never store credentials in code

## Cloud Providers

Ralph supports multiple cloud providers for VM execution:

| Provider | CLI | Notes |
|----------|-----|-------|
| Hetzner | `hcloud` | Cheapest, great for Europe |
| Google Cloud | `gcloud` | Good free tier |
| DigitalOcean | `doctl` | Simple and reliable |
| AWS | `aws` | Enterprise option |
| SSH | - | Use your own server |

## Config File

Configuration is stored in `.ralph/config.json`:

```json
{
  "version": "1.0.1",
  "language": "en",
  "provider": "hcloud",
  "vm_name": "ralph-sandbox",
  "region": "fsn1",
  "github": {
    "username": "your-username"
  },
  "claude": {
    "auth_method": "subscription"
  },
  "notifications": {
    "ntfy_enabled": true,
    "ntfy_topic": "ralph-notifications"
  }
}
```

## Backends

Ralph supports multiple AI backends through a clean abstraction layer. You can choose your backend during installation or switch later.

### Backend Comparison

| Feature | Claude Code CLI | OpenCode CLI |
|---------|-----------------|--------------|
| **CLI Tool** | `claude` | `opencode` |
| **Installation** | npm (Node.js) | go (Golang) |
| **Auth Methods** | Subscription OR API key | API key only |
| **Vision Support** | Full | Not yet (MCP pending) |
| **Default** | Yes | No |
| **Best For** | Flat-rate usage with Claude Pro/Max | Pay-per-token, multiple providers |

### Claude Code CLI (Default)

The recommended backend for most users, especially with Claude Pro/Max subscription.

**Installation:**

```bash
npm install -g @anthropic-ai/claude-code
```

**Authentication options:**

1. **Claude Pro/Max subscription** (recommended for VM automation):
   ```bash
   # On the VM, run:
   claude login
   ```

2. **Anthropic API key** (pay-per-token):
   ```bash
   export ANTHROPIC_API_KEY="sk-ant-..."
   ```

**Configuration:**

```json
{
  "backend": "claude",
  "claude": {
    "auth_method": "subscription"
  }
}
```

**Features:**
- Full vision/image analysis support (design review screenshots)
- Direct integration with Claude Code skills
- Recommended timeout: 30 minutes (flat rate with MAX subscription)

### OpenCode CLI

Alternative backend using the OpenCode CLI with configurable providers.

**Installation:**

```bash
go install github.com/opencode-ai/opencode@latest
```

**Authentication:**

```bash
# For Anthropic provider:
export ANTHROPIC_API_KEY="sk-ant-..."

# For OpenRouter (multiple models):
export OPENROUTER_API_KEY="sk-or-..."
```

**Configuration:**

```json
{
  "backend": "opencode",
  "opencode": {
    "model": "anthropic/claude-sonnet-4-20250514"
  }
}
```

**Features:**
- Supports multiple API providers (Anthropic, OpenRouter, etc.)
- JSON output format with automatic parsing
- Agent-based architecture with specialized roles

**Limitations:**
- Vision support not yet implemented (requires MCP integration)
- Requires Go runtime for installation

### Switching Backends

**Method 1: Environment variable** (highest priority)

```bash
export RALPH_BACKEND=opencode
# or
export RALPH_BACKEND=claude
```

**Method 2: Config file** (`.ralph/config.json`)

```json
{
  "backend": "opencode"
}
```

**Method 3: Re-run installation**

```bash
npx ralph-inferno install
```

### Backend Troubleshooting

#### Claude Code CLI

| Issue | Solution |
|-------|----------|
| `claude: command not found` | Run `npm install -g @anthropic-ai/claude-code` |
| `Authentication required` | Run `claude login` on the VM |
| `Rate limited` | Switch to Claude Pro/Max subscription or wait |
| `Timeout errors` | Increase timeout in config (default: 1800s) |
| `Permission denied` | Ralph uses `--dangerously-skip-permissions` flag automatically |

**Verify installation:**

```bash
claude --version
```

#### OpenCode CLI

| Issue | Solution |
|-------|----------|
| `opencode: command not found` | Run `go install github.com/opencode-ai/opencode@latest` |
| `ANTHROPIC_API_KEY not set` | Export your API key: `export ANTHROPIC_API_KEY="..."` |
| `JSON parse error` | Check OpenCode version, update if needed |
| `Vision not supported` | Use Claude backend for design review features |
| `Model not found` | Verify model name in config (e.g., `anthropic/claude-sonnet-4-20250514`) |

**Verify installation:**

```bash
opencode --version
```

#### General Issues

| Issue | Solution |
|-------|----------|
| Backend not detected | Check `RALPH_BACKEND` env var and `.ralph/config.json` |
| Wrong backend running | Set `RALPH_BACKEND` env var (overrides config) |
| Skills not found | Re-run `npx ralph-inferno install` to copy skill files |

## Documentation

- [Architecture](docs/ARCHITECTURE.md) - System overview and memory model
- [CLI Flags](docs/CLI-FLAGS.md) - All ralph.sh options
- [Token Optimization](docs/TOKEN-OPTIMIZATION.md) - Cost-saving strategies

## Credits & Inspiration

Ralph Inferno builds on ideas from:

- [snarktank/ralph](https://github.com/snarktank/ralph) - Ryan Carson's original Ralph concept
- [how-to-build-a-coding-agent](https://github.com/ghuntley/how-to-build-a-coding-agent) - Geoffrey Huntley's agent patterns
- [claude-ralph](https://github.com/RobinOppenstam/claude-ralph) - Robin Oppenstam's implementation

## License

MIT
