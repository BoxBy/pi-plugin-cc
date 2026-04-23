# pi-plugin-cc Changelog

## 0.1.0 — 2026-04-22

### Added
- `bin/pi-cc` — CLI wrapper for running pi from Claude Code (foreground, background, queue)
- `hooks/pi-caller-inject.sh` — PreToolUse hook that injects `PI_CC_CALLER` / `CODEX_CC_CALLER` env vars for subagent attribution
- `hooks/hooks.json` — SessionStart (pi check), PreToolUse (caller inject), SessionEnd (cleanup)
- `scripts/setup.sh` — Automated setup script
- 13 slash commands: review, adversarial-review, ask, brainstorm, rescue, super-pr, cross-verify, explore, test, status, result, cancel, setup
- 3 agents: pi-brainstorm, pi-rescue, pi-reviewer
- 4 skills: pi-cli-runtime, pi-cross-verify, pi-result-handling, pi-routing
