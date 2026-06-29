# Design Gate MVP

A Claude Code plugin for teams that establishes a design-first, human-review development workflow.

Two hard gates:

1. Modifying production code is forbidden before the design is approved.
2. After implementation, work must enter `AWAITING_HUMAN_REVIEW`, where a human inspects the diff and approves it.

## Install

```bash
git clone git@github.com:yehjunwei/design-gate-mvp.git
cd design-gate-mvp
./install.sh
```

Then run inside Claude Code:

```text
/reload-plugins
```

## Usage

Just start working in the target repository (the gate takes effect automatically).

### 0. Customize settings (optional)

The gate ships with built-in defaults and needs no initialization. To customize the rules, run `/design-gate:init` first to generate `.design-gate/config.json`.

```text
/design-gate:init
```

### 1. Start a task

```text
/design-gate:start TASK-123 Implement an ABC feature
```

Produces a design document and waits for human review.

### 2. Approve the design

```text
/design-gate:approve-design TASK-123
```

Approve only after reviewing the design; production code can then be changed.

### 3. Approve the implementation

After implementation is complete, inspect `git diff` and approve once confirmed:

```text
/design-gate:approve-implementation TASK-123
```

## Remove the plugin

```bash
claude plugin uninstall design-gate@team-engineering-standards
```
