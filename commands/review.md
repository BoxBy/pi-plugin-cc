---
description: "Code review via pi. Use when reviewing diffs, PRs, or code changes. Pi is free compute — use liberally."
argument-hint: "[--base <ref>] [--wait] [--background] [--focus <text>]"
---

# /pi:review

Delegate a code review to pi (free compute).

## Steps

1. Collect the diff:
   - If `--base` provided: `git diff $BASE...HEAD`
   - Default: `git diff` (unstaged) + `git diff --cached` (staged)
   - If no changes: `git diff HEAD~1`

2. Run pi:
   ```bash
   pi-cc run "Review this code diff for bugs, security issues, logic errors, and improvement suggestions. Be specific with file:line references.

   <diff>
   $DIFF_CONTENT
   </diff>

   $(if FOCUS: Focus especially on: $FOCUS)

   Output a structured review with severity ratings (critical/warning/info)." \
     $(if BACKGROUND: --bg)
   ```

3. If `--background`: report task ID, tell user to check `/pi:status`.
4. If `--wait` (default): wait, parse result, present in conversation. If critical issues found, suggest fixes.
