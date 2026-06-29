# Human Review Checklist

The reviewer must inspect the actual diff, not just Claude's summary.

- [ ] I inspected `git diff`
- [ ] The implementation matches the approved design
- [ ] There are no unrelated changes
- [ ] Functions follow Single Responsibility
- [ ] Functions over 40 lines have been split, or have an approved exception
- [ ] Reuse of existing functions / classes / modules has been considered
- [ ] There are no speculative abstractions
- [ ] Public APIs, data flow, state ownership, and error behavior are correct
- [ ] Tests include the necessary normal, boundary, failure, and regression coverage
- [ ] There are no weak assertions, skipped tests, or hidden failures
- [ ] Formatter, linter, type checker, build, and tests pass, or failures are explicitly accepted

Final approval:

`/design-gate:approve-implementation <task-id>`
