# Coding Best Practices

The purpose of these rules is to improve readability, testability, and long-term maintainability — not to chase formal perfection.

## 1. Scope discipline

- Implement only what the approved design defines.
- Do not do unrelated cleanup, renames, formatting, dependency upgrades, or features on the side.
- When you find a worthwhile improvement that is out of scope, record it as a follow-up; do not mix it into this change.
- Material deviations must update the design before being implemented.

## 2. Single Responsibility

- Each function performs one coherent operation.
- Each class owns one clear capability or policy.
- Each module aggregates highly related responsibilities.
- Separate orchestration, domain logic, persistence, transport, and presentation.
- Avoid stuffing unrelated logic into `Manager`, `Helper`, or `Utils` types.

## 3. Function size

- By default, functions should not exceed 40 lines of effective logic.
- Split by responsibility, not by arbitrary line counts.
- Prefer early returns to avoid deep nesting.
- Avoid using many boolean parameters to control different flows.
- When there are too many parameters that form a single concept, consider a value object.
- Reasonable exceptions must be recorded in the approved design.

## 4. Reuse

Before adding a new implementation, first search for:

- domain rules
- validators
- parsers
- adapters
- serializers
- error types
- test fixtures
- utility functions
- repository conventions

Order of reuse judgment:

1. An existing implementation with identical semantics exists: reuse it directly.
2. An existing abstraction can be extended without breaking cohesion: extend it.
3. At least two real callers share the same business rule: extract shared logic.
4. No suitable reuse point exists: add a small, focused implementation.
5. Do not build speculative abstractions for hypothetical future requirements.

Do not force sharing just because code looks similar; what should truly be shared is the same semantics and the same reason to change.

## 5. Readability

- Use intention-revealing names for identifiers.
- Prefer straightforward control flow over clever one-liners.
- Comments should explain the why, a constraint, or a trade-off — not restate obvious code.
- Do not leave commented-out code behind.
- Keep public interfaces minimal.
- Avoid premature optimization.

## 6. Error and state

- Validate external input at system boundaries.
- Do not swallow exceptions.
- Error contracts should be clear and consistent.
- Avoid hidden global state.
- Retry, timeout, idempotency, transaction, and concurrency behavior must be spelled out when relevant.

## 7. Tests

- Test externally observable behavior and important invariants.
- Include normal, boundary, failure, and regression cases.
- Tests should be deterministic.
- Do not over-rely on private implementation details.
- Bug fixes should, in principle, add a regression test.
- Do not weaken assertions or skip tests to accommodate incorrect behavior.

## 8. Security and operations

- Do not log secrets or sensitive payloads.
- Use parameterized queries and safe process invocation.
- Follow least privilege.
- External calls should have reasonable timeouts.
- Preserve necessary errors, logs, metrics, and observability.
