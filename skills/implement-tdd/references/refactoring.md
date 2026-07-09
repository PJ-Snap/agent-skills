# Refactoring

Load this during the REFACTOR step, after all tests are GREEN.

## Coding Standards

Apply these when cleaning up GREEN code:

- Write pure functions without side effects
- Assign one responsibility per function
- Name functions/variables descriptively
- Extract complex logic into helpers to reduce locals, statements, and branches per function
- Consolidate related arguments into typed containers (dataclass, TypedDict, Pydantic model)
- Flatten nested conditions/loops using early-return guards
- Prefer fewer return paths by resolving conditions early; drop elif after a return
- Deduplicate shared logic into a shared helper rather than copying blocks
- Name magic literals (constant, Enum, StrEnum) rather than inlining bare values
- Accept direct parameters, not nested properties
- Prefer immutable structures; minimize mutable state
- Use Pydantic v2 for external data (APIs, JSON, user input)
- Use frozen dataclasses or TypedDict for internal trusted data
- Use actual schemas/types in tests
- Prefer built-in generics: `list[str]`, `dict[str, int]`
- Use union syntax: `str | None` not `Optional[str]`
- Replace `Any` or `typing.Any` with concrete types
- Annotate types explicitly; include return types in signatures
- Prioritize readability over cleverness

## What to Look For

After all tests pass, scan for these refactor candidates:

1. **Duplication** — Extract shared logic into a helper.
2. **Shallow modules** — Move complexity behind simpler interfaces
   (see [deep-modules.md](deep-modules.md)).
3. **SOLID violations** — Apply principles where they reduce coupling naturally,
   not as a checklist exercise.
4. **What new code reveals about old code** — Sometimes the new code exposes
   existing duplication or awkward interfaces worth fixing.

## Rules

- Run tests after each refactor step. If a test fails, undo the refactor step
  and investigate — either the refactor changed behavior (fix the code) or the
  test was coupled to implementation (fix the test).
- Keep refactors small and atomic. One concern per change.
- Don't add features during refactoring. If you spot a missing behavior, note it
  and handle it in a new RED→GREEN cycle.
