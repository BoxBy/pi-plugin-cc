# pi-plugin-cc

Claude Code plugin for [pi coding agent](https://github.com/badlogic/pi-mono). Delegate reviews, brainstorming, cross-verification, and more to pi.

> **Note:** This plugin is derived from [codex-plugin-cc](https://github.com/openai/codex-plugin-cc) (Apache 2.0), adapted for pi.

## Install

```bash
# 1. Install pi
npm i -g @mariozechner/pi-coding-agent

# 2. Install plugin
claude plugin add --url https://github.com/BoxBy/pi-plugin-cc.git

# 3. Run setup (optional — verifies installation and initializes usage tracking)
/pi:setup
```

## Commands

| Command | Description |
|---------|-------------|
| `/pi:review` | Code review via pi |
| `/pi:adversarial-review` | Aggressive devil's advocate review |
| `/pi:ask` | Second opinion on anything |
| `/pi:brainstorm` | Generate N ideas, Claude selects |
| `/pi:rescue` | Delegate a task to pi |
| `/pi:super-pr` | Delegate PR review-fix loop |
| `/pi:cross-verify` | Independent verification of Claude's work |
| `/pi:explore` | Codebase exploration |
| `/pi:test` | Test generation and execution |
| `/pi:status` | Check running tasks |
| `/pi:result` | Get completed task result |
| `/pi:cancel` | Cancel running task |
| `/pi:setup` | Check installation and config |

## Routing

Pi can replace expensive subagent calls when running local models:

| Model level | Pi replacement |
|-------------|---------------|
| haiku | 100% replaced |
| sonnet (read/review/simple) | Replaced, sonnet reviews once |
| sonnet (complex/decide) | Sonnet leads, pi assists via RPC |
| opus | Not replaced |

## Architecture

```
pi-plugin-cc/
├── .claude-plugin/
│   ├── plugin.json            # Plugin manifest
│   └── marketplace.json       # Marketplace metadata
├── agents/                    # 3 agents (rescue, reviewer, brainstorm)
├── skills/                    # 4 skills (cli-runtime, result-handling, routing, cross-verify)
├── commands/                  # 13 slash commands
├── hooks/
│   ├── hooks.json             # SessionStart / PreToolUse / SessionEnd hooks
│   └── pi-caller-inject.sh    # Caller attribution hook (pi-cc + codex-cc)
├── scripts/
│   └── setup.sh               # Setup script
└── bin/pi-cc                  # Core CLI wrapper
```

## pi-cc CLI

```bash
pi-cc check                    # Verify pi installation
pi-cc run "prompt"             # Run pi (foreground)
pi-cc run "prompt" --bg        # Run pi (background, detached)
pi-cc status [task-id]         # Check task status
pi-cc result <task-id>         # Get task result
pi-cc cancel <task-id>         # Cancel task
pi-cc usage json               # Token usage (JSON)
pi-cc usage statusline         # Token usage (pi:i4.3k/o14)
```

## License

Apache 2.0 — see [LICENSE](LICENSE)
