#!/usr/bin/env bash
# pi-caller-inject.sh — Claude Code PreToolUse hook
#
# Purpose:
#   Detect pi-cc / codex-cc invocations and prepend the corresponding
#   CALLER env var based on stdin JSON's agent_type field. This lets
#   usage tracking attribute pi/codex usage to the specific subagent
#   that invoked them.
#
# Why single hook: Claude Code docs state "All matching hooks run in
# parallel", so two PreToolUse hooks both returning `updatedInput.command`
# would race. This single hook handles all caller injection.

set -euo pipefail

input=$(cat)
tool=$(jq -r '.tool_name // empty' <<< "$input")

# Extract original tool_input — `updatedInput` is a FULL replacement per Claude
# Code hooks docs, not a partial patch.
orig_input=$(jq -c '.tool_input // {}' <<< "$input")

# Non-Bash tools: pass through untouched
if [ "$tool" != "Bash" ]; then
  printf '%s\n' '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"allow"}}'
  exit 0
fi

cmd=$(jq -r '.tool_input.command // empty' <<< "$input")

# Determine caller from stdin JSON (subagent context → agent_type, main → "advisor").
# Sanitize with a sed whitelist — keep alnum + _.- only.
caller=$(jq -r '.agent_type // "advisor"' <<< "$input" | sed 's/[^A-Za-z0-9_.-]//g')
[ -z "$caller" ] && caller="advisor"

# Inject CALLER env vars IMMEDIATELY BEFORE each tool invocation (idempotent).
# Compound commands like `echo hi && pi-cc run x` must put the env var adjacent
# to `pi-cc`, not at the start of the whole command.
final_cmd="$cmd"
rewritten=0

_inject_env_before() {
  # args: tool envvar value
  local tool="$1" envvar="$2" value="$3"
  if ! printf '%s' "$final_cmd" | grep -qE "(^|[[:space:];&|()])${tool}[[:space:]]"; then
    return 0
  fi
  local before="$final_cmd"
  # Inject ${envvar}='${value}' before every `${tool} ` occurrence, then
  # cleanup duplicate if user already set an explicit ${envvar}= earlier.
  local injected
  injected=$(printf '%s' "$final_cmd" \
    | sed -E "s|([[:space:];&|()])${tool}[[:space:]]|\1${envvar}='${value}' ${tool} |g" \
    | sed -E "s|^${tool}[[:space:]]|${envvar}='${value}' ${tool} |")
  final_cmd=$(printf '%s' "$injected" \
    | sed -E "s|(${envvar}=[^[:space:];&|()]+)((([[:space:]]+[A-Za-z_][A-Za-z0-9_]*=[^[:space:];&|()]+))*)[[:space:]]+${envvar}='${value}'[[:space:]]|\1\2 |g")
  if [ "$final_cmd" != "$before" ]; then
    rewritten=1
  fi
  return 0
}

_inject_env_before "pi-cc"    "PI_CC_CALLER"    "$caller"
_inject_env_before "codex-cc" "CODEX_CC_CALLER" "$caller"

# If no rewrite happened, allow unchanged
if [ "$rewritten" = "0" ]; then
  printf '%s\n' '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"allow"}}'
  exit 0
fi

jq -n --arg c "$final_cmd" --argjson base "$orig_input" \
  '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"allow",updatedInput:($base + {command:$c})}}'
