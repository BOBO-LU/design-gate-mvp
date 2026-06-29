---
name: Approve Design
description: Used to record explicit design approval after a human has reviewed the design document.
disable-model-invocation: true
allowed-tools: Bash(python3 *)
---

Record design approval for task `$ARGUMENTS`.

Run:

```bash
python3 "${CLAUDE_PLUGIN_ROOT}/scripts/design_gate.py" approve-design "$ARGUMENTS"
```

After approval succeeds, summarize the approved scope, then proceed to implementation.

Do not expand the scope.
