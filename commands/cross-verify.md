---
description: "Cross-verify Claude's work with pi. Pi independently reviews recent changes for bugs, missed edge cases, and improvements. Free second opinion."
argument-hint: "[--file <path>] [--scope staged|unstaged|last-commit]"
---

# /pi:cross-verify

Have pi independently verify Claude's recent work.

## Steps

1. Determine scope:
   - `--file`: specific file
   - `--scope staged`: `git diff --cached`
   - `--scope unstaged`: `git diff`
   - Default: `git diff HEAD~1`

2. Run pi:
   ```bash
   pi-cc run "You are an independent code reviewer. Another AI agent made these changes. Review critically — assume nothing is correct until verified.

   Check for:
   - Logic errors and off-by-one bugs
   - Missing edge cases
   - Security vulnerabilities
   - Breaking changes to existing callers
   - Test coverage gaps

   Changes:
   $DIFF

   Be specific: file:line, what's wrong, suggested fix."
   ```

3. Present findings. If critical issues found, offer to fix immediately.
