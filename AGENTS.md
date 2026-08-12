## Code Style Guidelines

**Architecture & Design**

- A durable end-state, clean architecture is prioritised over the short-term diff.
- Compatibility shims are not retained; affected callers are updated directly
- Existing codebase patterns and conventions are followed
- Dependencies require clear justification before introduction
- Abstraction layers are deferred until proven necessary
- Files maintain clear separation of concerns

**Function Design**

- Functions are pure (no side effects), with a single responsibility
- Names are descriptive for functions, variables, and parameters
- Function behaviour matches its name exactly
- Complex logic is extracted into internal helper functions (prefix with `_`)
- Trivial pass-through helpers are eliminated; small pure helpers that improve clarity are acceptable
- Functions accept direct parameters, not nested properties
- Functions follow composition over inheritance

**Clean Code**

- Nested conditions and loops are flattened where possible
- Dead code, commented-out code, and "removed" notes are deleted
- Common logic is extracted into shared functions
- Magic numbers and strings are replaced with named constants
- Backward compatibility shims are removed
- UI components use theme tokens instead of hardcoded colors
- Code is self-explanatory through clear structure and naming
- Comments and docstrings are kept super minimal — added only when truly beneficial (non-obvious *why*, a gotcha, an invariant), never to narrate what the code already says; no comment beats a comment that just narrates

**Data Structures & Types**

- Immutable data structures are preferred; mutable state is minimised
- Pydantic v2 is used for external/untrusted data (APIs, JSON, user input)
- Frozen dataclasses or TypedDict are used for internal trusted data
- Tests use actual schemas and types, not loose dicts or mocks
- Built-in generics (PEP 585): `list[str]`, `dict[str, int]`
- Union syntax (PEP 604): `str | None` not `Optional[str]`
- All type annotations are explicit, including return types; `typing.Any` is prohibited
- Imports are at module level unless lazy loading is justified

**Quality & Reliability**

- Edge cases and errors are handled consistently
- Fail fast. No fallback paths unless explicitly required: no broad catches, retries, `or default`, empty/placeholder returns, or alternate paths that hide failure. Fix the root cause. Model valid absence explicitly; surface expected errors as typed, tested states.
- Test coverage is maintained or improved
- Performance characteristics are maintained
- Readability is prioritised over cleverness
- No duplicate responsibilities: if a behaviour already has an owning module, changes must go through that module — never introduce a parallel code path that bypasses it
- Code patterns are consistent with surrounding codebase

## Testing instructions

- Tests for removed functionality are deleted; new and remaining tests cover only retained and newly introduced behavior.
- Each test function is named `test_<who/what>_<expected_outcome>_<condition>`. Related tests are grouped in classes named `TestFunctionOrFeature`.
- Every test body follows Arrange-Act-Assert with comment separators. Contains no control flow (`if`, `for`, `while`) — conditional logic hides which path ran and obscures failures.
- Each test asserts one behavior. Input variations of the same behavior use `@pytest.mark.parametrize`, never duplicate test functions or loops.
- Async tests are decorated with `@pytest.mark.asyncio`.
- Tests assert only on observable effects (return values, state changes, raised exceptions, calls to boundary mocks), never on implementation details. Refactor litmus: if a behaviour-preserving refactor breaks the test, the test is wrong.
- Mocking is minimal and boundary-only: mock DB queries, HTTP/API calls, file I/O, time, and external service clients. Keep real: the unit under test, data classes, Pydantic models, pure helpers, deterministic stdlib. Patches target the import location, not the definition site. `monkeypatch` is preferred for simple attribute/env overrides.
- Fixture chains are shallow (≤2 levels). Deeper chains indicate setup too complex for a unit test.
- All imports are at the top of the file; no scattered imports inside test functions.
- Each test class or logical block includes a comment: `# Why this test survives refactoring: <one sentence>`.
- Test files live in a `tests/` directory colocated with the code under test.
- Tests target business-logic-dense code: complex conditionals, state transitions, calculations, error paths, edge cases. Trivial pass-through code is not tested.

