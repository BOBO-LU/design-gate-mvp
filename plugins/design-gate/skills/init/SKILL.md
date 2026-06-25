---
name: Init
description: 在目前 repository 建立 design-gate 設定檔與 docs/designs 目錄,讓規則可被 commit 與客製化。
disable-model-invocation: true
allowed-tools: Bash(python3 *)
---

在目前 repository 初始化 design-gate。

執行：

```bash
python3 "${CLAUDE_PLUGIN_ROOT}/scripts/design_gate.py" init
```

完成後告知 user 已建立 `.design-gate/config.json`、`.design-gate/state.json`、`docs/designs/`,並提醒 commit `config.json` 與 `docs/designs/`、把 `state.json` 加入 `.gitignore`。
