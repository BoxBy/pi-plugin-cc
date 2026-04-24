---
description: "Install and configure pi-plugin-cc. Checks pi installation, sets permissions, and initializes usage tracking. Run after first install."
argument-hint: "[--enable-review-gate] [--disable-review-gate]"
---

# /pi:setup

Run the automated setup to install/update all pi-plugin-cc components.

## Steps

1. Run setup script:
   ```bash
   bash "${CLAUDE_PLUGIN_ROOT}/scripts/setup.sh"
   ```

2. If `--enable-review-gate`:
   ```bash
   mkdir -p ~/.pi-cc-config
   echo '{"reviewGateEnabled":true}' > ~/.pi-cc-config/review-gate.json
   ```
   Tell user: "Review gate enabled."

3. If `--disable-review-gate`:
   ```bash
   echo '{"reviewGateEnabled":false}' > ~/.pi-cc-config/review-gate.json
   ```
   Tell user: "Review gate disabled."

4. Show current status:
   ```bash
   pi-cc check
   pi-cc usage json
   ```
