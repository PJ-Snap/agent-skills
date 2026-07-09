---
name: create-plan
disable-model-invocation: true
---

# Create an implementation plan

1. Read the attached spec. If no spec exists, ask the user whether to create one with the create-spec skill first or proceed with a freeform description.

2. Explore the repo to verify their assertions and understand the current state of the codebase.

3. If working from a spec, treat its Outcome, Architectural Constraints, Interfaces, State Model, and Acceptance Criteria as fixed. Interview only on implementation questions: module boundaries, phasing strategy, test approach, and codebase-specific patterns. When you encounter a non-obvious implementation decision—such as whether to keep it simple (KISS) or introduce abstraction, or which design pattern to use—ask the user for their preference before proceeding and give your recommendation. If working without a spec, interview broadly until you reach a shared understanding.

4. Sketch out the major modules you will need to build or modify to complete the implementation. Actively look for opportunities to extract deep modules that can be tested in isolation.

     A deep module (as opposed to a shallow module) is one which encapsulates a lot of functionality in a simple, testable interface which rarely changes.

5. Once you have a complete understanding of the problem and solution, use the template below to write the plan.

     Optimize output for LLM coding agent:
     - Explicit task framing
     - Unambiguous context
     - Clear outcome intent
     - Information dense
     - Each task maps 1:1 to a todo item — the implementing agent creates its todo list directly from the plan's tasks
     - Every design decision is resolved — no choices deferred to the implementer
     - Every behavior is falsifiable — if you can't write a pytest assertion for a `Then` clause as written, it's too vague

## Guardrails

- Keep modules single-responsibility; do not mix unrelated concerns.
- Minimize inter-component coupling; prefer clear interfaces and boundaries.
- Favor obvious, consistent, and predictable implementations over cleverness.
- Prioritize maintainable, extensible designs over short-term shortcuts.
- Do not preserve backward-compatibility shims; update all affected call sites directly.
- Deliver independent, testable value.
- Include risk mitigation where applicable.
- Validate assumptions against official documentation.
- Reduce complexity at the source; do not introduce abstraction layers or single-caller wrappers that merely relocate code.
- Extracted helpers must encapsulate a distinct responsibility or serve multiple callers; avoid trivial pass-throughs and needless indirection.
- Each task must be self-contained. If a task depends on output from a prior task, state the exact artifact (file, function, class) it expects to exist — do not reference by task number alone.
- No deferred decisions: never use phrases like "use an appropriate structure", "handle errors gracefully", or "as needed". Replace with the specific choice.

## Output

<!-- TEMPLATE START — Emit everything below as the plan output. -->
<!-- Guidance comments (<!-- ... -->) are instructions for you; do NOT emit them. -->

> **TDD Contract:** Each numbered behavior is one RED→GREEN→REFACTOR cycle.
> Implement them **in order, one at a time**:
> 1. **RED** — write a failing test for the behavior
> 2. **GREEN** — write the minimal code to pass it
> 3. **REFACTOR** — clean up while all tests stay green. **You MUST read and apply the rules in `.cursor/skills/implement-tdd/references/refactoring.md`** during this step.
>
> Do **not** batch-write tests or batch-write implementation.

### Overview
<!-- One-liner referencing the spec file path, plus a brief summary of the outcome. If no spec exists, summarize the problem and solution instead. -->

### Current Behavior
<!-- Brief description of current behavior in the codebase. -->

### Architectural Constraints
<!-- Restate the spec's Architectural Constraints section verbatim. These are inherited and non-negotiable. -->

### Implementation Decisions
<!-- Implementation-level decisions: module structure, library choices, codebase patterns.
     Must not contradict the architectural constraints above. -->

### File/Directory Structure
<!-- Show planned files and directories to be created or modified. Files should be small and focused.
     For each module, state its single responsibility explicitly.
     Identify ownership boundaries between modules to avoid mixed concerns.
     Explicitly define where shared helpers, pure functions, and typed containers (dataclasses/models) will reside to prevent monolithic files. -->

Frontend example:
```
app/                            # Owner: frontend application root; entry point for UI features
├── feature/                    # Owner: one product/domain feature; avoid cross-feature state/imports
│   ├── __init__.py
│   ├── contracts.py            # Sole responsibility: shared typed contracts (TypedDict/dataclass) for this feature
│   ├── constants.py            # Sole responsibility: feature-scoped constants/enums (no business logic)
│   └── state/                  # Feature state management only; no rendering concerns
│   │   ├── state.py            # Sole responsibility: state vars, derived values, and state mutations
│   └── components/             # UI presentation components only; no domain orchestration
│   │   ├── ui_component.py     # Sole responsibility: render one UI element from props/state
│   └── event_handlers/         # Event-to-action adapters; coordinate UI events and state/service calls
│   │   ├── __init__.py
│   │   ├── related_handlers.py     # Sole responsibility: related event handlers for a single user flow
│   │   ├── additional_handlers.py  # Sole responsibility: overflow handlers when one flow outgrows a single file
│   │   └── tests/
│   │       ├── __init__.py
│   │       ├── conftest.py
│   │       └── test_related_handlers.py     # Sole responsibility: public behavior tests for handler module
```

Backend example:
```
backend/                        # Owner: all backend features; entry point for server-side logic
├── feature/                    # Owner: one domain feature; no cross-domain state or imports
│   ├── __init__.py
│   └── shared/                 # Cross-feature primatives only
│   │   ├── constants.py        # Sole responsibility: place for constants and enums used in this module
│   │   ├── contracts.py        # Sole responsibility: shared TypedDicts/contracts
│   │   ├── schemas.py          # Sole responsibility: input/output validation contracts (Pydantic)
│   │   ├── models.py           # Sole responsibility: ORM definitions and DB schema for projects
│   │   └── utils/              # Cross-feature utilities
│   │       └── util.py         # Sole responsibility: utility logic
│   ├── service.py              # Sole responsibility: business logic orchestration consumed by the front-end; calls models and helpers only
│   └── domain/                 # Sole responsibility: one business logic domain
│   │   ├── __init__.py
│   │   ├── domain_logic.py     # Sole responsibility: non-orchestration business logic (rules, validation, calculations)
│   │   ├── helpers.py          # Sole responsibility: pure, stateless helper functions; no service or model imports
│   │   └── tests/
│   │       ├── __init__.py
│   │       ├── conftest.py
│   │       ├── test_logic.py      # Tests for business logic.py (public interface only; no internal implementation details)
│   │       └── test_helpers.py    # Tests for helpers.py (public interface only; no internal implementation details)
│   └── tests/
│       ├── __init__.py
│       ├── conftest.py
│       └── test_service.py     # Tests for service.py (public interface only; no internal implementation details)
```

---

### Phases

<!-- Split the work into one or more PRs.
     Simple changes = single PR. Complex changes = multiple PRs.
     Order PRs in a keystone-interface pattern: foundational/shared interfaces first, consuming code last. -->

#### PR 1 — [Short title]
<!-- One line describing the functionality delivered by this PR. -->

**Preserved interfaces** (do not modify)
<!-- List existing public interfaces, files, or behaviors that MUST remain unchanged in this PR.
     This prevents the implementing agent from "helpfully" refactoring adjacent code.
     Omit only if this is a greenfield PR with no existing code to preserve. -->
- `path/to/existing_module.function_name` — signature and behavior unchanged
- `path/to/untouched_file.py` — no modifications

##### Task 1.1 — [Short title]
<!-- One line describing the independently testable and usable behaviour this task delivers. -->

<!-- Describe module boundaries and responsibilities — where new/modified code lives and why.
     Do NOT prescribe file-level implementation details; the implementing agent determines
     the minimal code to pass each behavior's test. -->

**Module context**
<!-- Which modules/files are involved and their roles. Architectural guidance only —
     state responsibilities and boundaries, not line-by-line changes.
     Include import relationships between modules. -->
- `path/to/module.py` — [responsibility in this task]; imports `ClassName` from `path/to/dependency.py`
- `path/to/other_module.py` — [responsibility in this task]

**Public interface under test:**
<!-- Specify the full signature including parameter types and return type.
     All behaviors in this task must be asserted via this entry point —
     never through internal helpers or private methods. -->
```python
def function_name(param: ParamType, other: OtherType) -> ReturnType: ...
```
in `path/to/module.py`

**Verification:** `pytest path/to/module/tests/test_file.py::TestClassName`
<!-- Exact command to run to confirm all behaviors in this task pass.
     Must be specific enough that the agent doesn't guess or run the full suite. -->

**Behaviors** (implement in order)
<!-- Each numbered item is one RED→GREEN cycle. Order: tracer bullet first (proves the
     end-to-end path works), then core happy-path behaviors, then edge cases and error paths.
     State the ordering rationale in a comment above the list.

     Format each behavior as a pure observable assertion through the public interface,
     using multi-line Given/When/Then with each clause on its own line.
     Each clause has TWO parts: plain natural language, then a backtick-quoted literal:

       Given [precondition in natural language] `[starting fixture/state]`
       When [action in natural language] `[action via public interface]`
       Then [observable outcome in natural language] `[assertion expression]`

     Example:
       Given one entity node exists at the origin `existing_nodes = [{"id": "n1", "position": {"x": 0, "y": 0}}]`
       When the delta modifies that node's position `apply_delta(delta, existing_nodes, [])`
       Then the merged node has the new position `merged_nodes[0]["position"] == {"x": 50, "y": 100}`

     Rules:
     - Describe WHAT to verify, not HOW to implement it.
     - Do NOT describe the implementation that makes the test pass — only the assertion.
     - Test through the public interface only — never assert on internals.
     - Each behavior must survive an internal refactor unchanged.
     - Mark the first behavior as the tracer bullet: it must exercise the full vertical
       slice (input → logic → output) to prove the path works before building out.
     - Given clauses must specify CONCRETE state: literal fixture values, specific mock
       return values, actual data shapes. Not abstract preconditions like "a valid user".
     - Then clauses must be falsifiable: expressible as a single pytest assertion.
       If you cannot write `assert <expression>` for it, rewrite it until you can.
     - No forward references: do not say "uses the X from Task N". Instead name the
       exact artifact (function, class, file) that must already exist. -->

*Ordering rationale: [explain why this sequence — e.g., "tracer bullet proves the basic path, then add constraint side effects, then boundary/error cases"]*

1. **[Tracer bullet]**
   Given [concrete precondition in natural language] `[starting fixture/state]`
   When [action in natural language] `[action via public interface]`
   Then [observable outcome in natural language] `[assertion expression]`

2. Given [concrete precondition in natural language] `[starting fixture/state]`
   When [action in natural language] `[action via public interface]`
   Then [observable outcome in natural language] `[assertion expression]`

3. Given [concrete precondition in natural language] `[starting fixture/state]`
   When [action in natural language] `[action via public interface]`
   Then [observable outcome in natural language] `[assertion expression]`

**Non-TDD changes** (optional)
<!-- Changes that cannot be test-driven (e.g., comment/docstring fixes, constants in
     files with no test runner). List them explicitly so they are not silently omitted.
     Omit this section if all changes are covered by behaviors above. -->
- [Description of change and why it is not TDD-able]

##### Task 1.2 — [Short title]
<!-- Same structure as above. -->

**Module context**
- `path/to/module.py` — [responsibility in this task]; imports `X` from `path/to/dep.py`

**Public interface under test:**
```python
def function_name(param: Type) -> ReturnType: ...
```
in `path/to/module.py`

**Verification:** `pytest path/to/tests/test_file.py::TestClassName`

**Behaviors** (implement in order)

*Ordering rationale: [...]*

1. **[Tracer bullet]**
   Given [concrete precondition in natural language] `[starting fixture/state]`
   When [action in natural language] `[action via public interface]`
   Then [observable outcome in natural language] `[assertion expression]`

2. Given [concrete precondition in natural language] `[starting fixture/state]`
   When [action in natural language] `[action via public interface]`
   Then [observable outcome in natural language] `[assertion expression]`

---

<!-- Repeat the PR/Task structure for additional PRs as needed. -->

#### PR N — [Short title]
<!-- One line describing the functionality delivered by this PR. -->

**Preserved interfaces** (do not modify)
- `path/to/module.function` — unchanged

##### Task N.1 — [Short title]

**Module context**
- `path/to/module.py` — [responsibility]; imports `X` from `path/to/dep.py`

**Public interface under test:**
```python
def function_name(param: Type) -> ReturnType: ...
```
in `path/to/module.py`

**Verification:** `pytest path/to/tests/test_file.py::TestClassName`

**Behaviors** (implement in order)

*Ordering rationale: [...]*

1. **[Tracer bullet]**
   Given [concrete precondition in natural language] `[starting fixture/state]`
   When [action in natural language] `[action via public interface]`
   Then [observable outcome in natural language] `[assertion expression]`

2. Given [concrete precondition in natural language] `[starting fixture/state]`
   When [action in natural language] `[action via public interface]`
   Then [observable outcome in natural language] `[assertion expression]`

---

### Security Assessment

**Threat Modeling Required:** [Yes | No]

<!-- Assess if ANY of these conditions are true:
     - New system, feature, or material architecture changes
     - Crosses security boundaries (trust, roles, permissions, external/internal)
     - Increases attack surface (new endpoints, data flows)
     - Handles sensitive/confidential data
     - Modifies authentication or authorization
     - Introduces new attack vectors or invalidates security assumptions
     - Integrates with external systems or third-party services (e.g., data warehouses, APIs)

     If YES to any → Threat modeling required. Briefly explain which conditions apply. -->

**Rationale:** [Explanation of which conditions apply, or why none do.]

<!-- TEMPLATE END -->
