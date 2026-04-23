---
name: pi-routing
description: "Routes subagent tasks to pi when appropriate. Automatically consider pi before spawning any haiku or simple sonnet subagent. Pi is free compute — use it for read-only, review, simple generation, and brainstorming. Triggers when about to spawn a subagent with model=haiku, or when the task is READ-ONLY/REVIEW/GENERATE-SIMPLE/BRAINSTORM."
---

# Pi Routing

Before spawning a subagent, check if pi can handle it (free).

## 3-Stage Decision

### Stage 1: Pi Routing (free compute)
- **haiku level** → pi, always. `pi-cc run "..."`
- **sonnet + READ-ONLY/REVIEW/GENERATE-SIMPLE/BRAINSTORM** → pi, then sonnet reviews once
- **sonnet + GENERATE-COMPLEX/DECIDE** → sonnet leads, pi assists via RPC
- **opus** → Claude only (no pi)

### Stage 2: Existing Agent Match
- Check `.claude/agents/` for a fitting agent → use it
- No match → Stage 3

### Stage 3: Harness Dynamic Generation
- Analyze task → create `.claude/agents/{name}.md` on the fly
- Set `pi-eligible: true` if READ/REVIEW/SIMPLE nature
- Spawn the new agent (reusable next session)

## Task Classification

| Category | Examples | Route |
|----------|----------|-------|
| READ-ONLY | explore, search, analyze, docs lookup | pi |
| REVIEW | code review, lint, verify, test analysis | pi |
| GENERATE-SIMPLE | boilerplate, tests, docs, comments, stubs | pi |
| BRAINSTORM | ideas, alternatives, naming | pi |
| GENERATE-COMPLEX | architecture, algorithms, multi-file refactor | Claude |
| DECIDE | judgment, integration, conflict resolution | Claude |

## Sonnet Collaboration Patterns

**Pattern 1 (pi replaces):** pi completes task → sonnet reviews once → adopt or fix
**Pattern 2 (sonnet leads):** sonnet works, calls `pi --mode rpc` for exploration/generation → sonnet decides

## How to invoke pi

```bash
# Foreground (quick tasks)
pi-cc run "prompt"

# Background (long tasks)
pi-cc run "prompt" --bg
pi-cc status <id>
pi-cc result <id>
```

## Fallback

If `pi-cc check` fails → use Claude subagent as usual.
If pi quality insufficient → escalate to Claude.

## Override

User explicitly requests a specific model/agent → respect, don't redirect.
