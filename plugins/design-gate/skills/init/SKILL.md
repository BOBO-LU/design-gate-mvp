---
name: Init
description: Create the design-gate config file and docs/designs directory in the current repository, so the rules can be committed and customized.
disable-model-invocation: true
allowed-tools: Bash(python3 *)
---

Initialize design-gate in the current repository.

Run:

```bash
python3 "${CLAUDE_PLUGIN_ROOT}/scripts/design_gate.py" init
```

When done, tell the user that `.design-gate/config.json`, `.design-gate/state.json`, and `docs/designs/` have been created, and remind them to commit `config.json` and `docs/designs/` and to add `state.json` to `.gitignore`.
