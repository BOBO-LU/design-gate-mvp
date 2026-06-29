---
name: Approve Implementation
description: Record the final implementation approval after a human has inspected the actual diff and completed the review checklist.
disable-model-invocation: true
allowed-tools: Bash(python3 *)
---

Record the final implementation approval for task `$ARGUMENTS`.

Run:

```bash
python3 "${CLAUDE_PLUGIN_ROOT}/scripts/design_gate.py" approve-implementation "$ARGUMENTS"
```

This may only run when a human explicitly invokes this Skill.
