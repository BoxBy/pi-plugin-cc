---
description: "Delegate codebase exploration to pi. Pi reads files, searches code, traces call chains, and reports findings. Use for 'how does X work?' questions."
argument-hint: "<question about the codebase>"
---

# /pi:explore

Have pi explore the codebase and report findings.

## Steps

1. Run pi with read-only tools:
   ```bash
   pi-cc run "Explore this codebase to answer the following question. Read files, search for patterns, trace call chains. Be thorough.

   Question: $ARGUMENTS

   Report:
   - Key files involved (with paths)
   - How the components connect
   - Data flow / call chain
   - Any notable patterns or concerns"
   ```

2. Present pi's findings. Use them as context for further work.
