---
name: Design Gate
description: >
  Use this Skill when the user requests implementation, feature development,
  bug fix, refactoring, migration, integration, optimization, or any code
  change. First clarify the requirements and the existing design, produce a
  design document, obtain explicit human approval before any coding begins,
  and request a human review of the actual diff once done.
effort: high
---

# Design Gate

This is a low-friction, design-first development workflow.

The goal is not to manufacture documents or add bureaucracy, but to avoid:

- Starting to code before understanding the requirements
- Claude filling in unconfirmed requirements on its own
- Implementation drifting beyond the original scope
- Functions that are too long or mix responsibilities
- Re-implementing logic that already exists
- Engineers reading only Claude's summary instead of reviewing the actual diff

Please read:

- `${CLAUDE_SKILL_DIR}/references/design-template.md`
- `${CLAUDE_SKILL_DIR}/references/coding-standards.md`
- `${CLAUDE_SKILL_DIR}/references/review-checklist.md`

## Workflow

The states proceed in order:

`DISCOVERY -> DESIGN -> DESIGN_APPROVED -> IMPLEMENTATION -> AWAITING_HUMAN_REVIEW -> COMPLETED`

States must not be skipped, and you must not assume that human approval has already happened.

## 1. DISCOVERY

Before starting to code:

1. Restate the problem, goals, and constraints in a few sentences.
2. Read the relevant production code, tests, interfaces, configuration, and documentation.
3. Identify existing functions, classes, modules, patterns, and test fixtures that can be reused.
4. Distinguish between:
   - confirmed facts
   - assumptions
   - open questions
   - non-goals
5. Ask only questions that genuinely affect the design, usually 2–4 per round.
6. Small changes do not need lengthy discussion; just state the key decisions clearly.

### Complexity

- `L0`: comments, typos, formatting, documentation-only — no change to runtime behavior.
- `L1`: localized bug fix, small internal change.
- `L2`: new feature, public API, class responsibility, or data flow change.
- `L3`: cross-service, persistence, security, concurrency, or architecture change.

`L1` may use a lightweight design; `L2/L3` use a full design.

## 2. DESIGN

Create:

`docs/designs/<task-id>-<feature-name>.md`

The design document must at least cover:

- problem, goal, non-goal
- existing behavior
- reuse candidates
- proposed class/function responsibilities
- data flow and error flow
- files expected to be modified
- test strategy
- the minimal viable solution
- risks and open questions

### Function design

Each function should have a single clear responsibility.

By default, each function should not exceed **40 lines of effective logic**:

- blank lines are not counted
- comment-only lines are not counted
- the function signature is not counted
- do not split mechanically just to hit a line count
- split along coherent responsibilities

If a single function is genuinely clearer above 40 lines, you must state the reason in the design document and have a human approve it.

### Design approval

Once the design is complete, stop; you must not begin modifying production code.

Ask the human to explicitly run:

`/design-gate:approve-design <task-id>`

The following must not be treated as formal approval:

- continue
- looks good
- no problem
- go ahead
- proceed

## 3. IMPLEMENTATION

Begin coding only after approval.

While implementing, follow these rules:

1. Do only what the approved design describes.
2. Do not perform cleanup, renames, dependency upgrades, generalization, or new features that are not in the design.
3. Prefer reusing existing functions, classes, modules, or patterns with the same semantics.
4. Do not wrongly abstract distinct concepts just to superficially remove duplication.
5. Keep functions, classes, and modules to a Single Responsibility.
6. By default, functions should not exceed 40 lines of effective logic.
7. Separate orchestration, domain logic, and I/O side effects as much as possible.
8. Public APIs, error contracts, and backward compatibility must match the design.
9. Add the normal, boundary, failure, and regression tests defined in the design.
10. Do not delete, skip, or weaken tests to let an incorrect implementation pass.
11. Do not hide lint, type-check, build, or test failures.

If implementation reveals that the design must change substantially:

1. Stop coding.
2. Update the design document.
3. Explain the deviation and its reasons.
4. Return to `DESIGN`.
5. Obtain approval again.

## 4. HUMAN REVIEW

After implementation is complete:

1. Run the applicable formatter, linter, type checker, build, and tests.
2. Run:
   `python3 "${CLAUDE_PLUGIN_ROOT}/scripts/design_gate.py" check`
3. Show:
   - `git status --short`
   - changed files
   - a diff summary
   - tests and commands executed
   - warnings / failures
   - deviations from the design
   - known limitations
4. Set the status to `AWAITING_HUMAN_REVIEW`.
5. Explicitly ask the human to inspect the actual `git diff`.
6. After the human review is complete, run:

`/design-gate:approve-implementation <task-id>`

Do not claim the task is complete before this.

## Language rules

- Conversation with the user: English
- Design document: English
- Code identifiers: English
- Code comments: follow the repository's existing conventions; use English when there is no convention
- Commit messages: follow the repository's existing conventions
- Status, commands, JSON keys, file paths: keep in English
