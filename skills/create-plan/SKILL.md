---
name: create-plan
description: Create a self-contained, end-to-end TDD implementation prompt from a canonical Lavish plan or freeform description. Use when the user wants an implementation plan that a coding agent can execute directly through vertical RED-GREEN-REFACTOR cycles.
disable-model-invocation: true
---

## Plan the implementation

1. Establish the source of truth.
  - Read the attached canonical Lavish plan.
  - If no canonical plan exists, ask whether to create one with `create-lavish-plan` or proceed from the freeform description.
  - When using a canonical plan, preserve its resolved outcome, scope, required behavior, contracts, non-negotiable constraints, and completion conditions. Do not reopen those decisions.
  - Assign a stable sequential ID (`AC-01`, `AC-02`, ...) to every requirement and acceptance criterion. Preserve each criterion's complete meaning in a concise, independently understandable statement.
2. Ground the plan in the repository.
  - Explore the repository to verify user assertions and identify existing architecture, interfaces, test conventions, and relevant patterns.
  - Read `AGENTS.md` and treat it as the canonical repository convention.
  - Discover test, lint, type-check, quality, build, and regression commands from `AGENTS.md`, package configuration, task runners, and CI. Verify that every command and tool included in the plan exists; omit checks the repository does not support.
3. Resolve the implementation design before creating tasks.
  - Identify the modules, public interfaces, ownership boundaries, dependencies, data contracts, error behavior, and test approach.
  - Prefer deep modules: simple, stable, testable interfaces that encapsulate substantial functionality.
  - Design interfaces for testability: inject external dependencies instead of constructing them internally, return results instead of hiding behavior in side effects, isolate unavoidable side effects at system boundaries, and minimize methods and parameters.
  - If an implementation decision is non-obvious and materially changes architecture, complexity, or a public contract, recommend a choice and ask the user to decide. Otherwise resolve it before writing the plan.
4. Turn the design into an executable sequence of phases and tasks.
  - A Phase is an integration and product-capability milestone. It ends with a working,
   demonstrable system state and a checkpoint.
  - A Task is a bounded, testable, reviewable change with one explicit ownership boundary, a concrete outcome, and independent verification.
  - Extract the canonical plan's user flows, observable behaviors, contracts, acceptance criteria, constraints, and risks.
  - Identify the keystone interfaces: the smallest stable public contracts, schemas, domain operations, or integration boundaries that later work must use.
  - Order tasks around these keystone interfaces. Establish a contract and its tracer-bullet path before dependent capability, variants, edge cases, or presentation.
  - Create vertical phases. Each phase must connect every required layer to deliver one observable product capability end-to-end, even when the first version is intentionally narrow.
  - Never create horizontal phases such as “backend,” “frontend,” “database,” or “tests.” Include the backend, persistence, UI, and tests required for one capability in the same phase.
  - Give each phase an explicit demonstrable outcome and checkpoint: a named test suite, runnable workflow, API call, UI interaction, migration state, or comparable proof.
  - Split a phase into tasks only at explicit ownership boundaries. Each task owns one cohesive artifact or behavior, names and verifies every prerequisite contract, and leaves the repository in a testable state.
  - Map every `AC-*` criterion to at least one task behavior or phase checkpoint. Repeat each mapped criterion's ID and full statement inside every standalone task that owns it.
  - Put required hardening, variants, and negative paths in the earliest phase where the relevant keystone interface exists.
  - If a phase cannot demonstrate its capability without a later phase, merge or reorder the phases until it can.
5. Translate the required behavior into vertical TDD cycles.
  - Begin each task with one tracer-bullet behavior that proves its public path end-to-end.
  - Order the remaining behaviors as the smallest useful increments through the same public interface.
  - Make each behavior one complete RED → GREEN → REFACTOR cycle. Never plan all tests first and implementation afterward.
  - Specify concrete test setup, the public action, the observable result, and a representative assertion for every behavior.
  - Test behavior through public interfaces, not implementation details. Tests must survive behavior-preserving refactors.
  - Mock only external boundaries such as database queries, HTTP calls, file I/O, time, and service clients.
  - Separate non-TDD work only when no meaningful observable behavior can be tested, and state why.
6. Produce and validate the executable prompt.
  - Write direct, imperative instructions to the implementing coding agent.
  - Make the full output executable end-to-end when pasted into a fresh coding-agent conversation with only repository access.
  - Also make every task independently executable under the same fresh-agent condition.
  - Map each task 1:1 to an implementing agent todo item.
  - Resolve every design decision; do not defer choices to the implementer.
  - State every prerequisite as an exact artifact and contract with a verification method.
  - State every behavior so it has a falsifiable observable assertion.
  - Include exact task verification, phase checkpoints, and execution-time acceptance-conformance commands.
  - Perform planning-time coverage verification: every `AC-*` criterion maps to concrete implementation behavior and test or checkpoint evidence; no criterion is orphaned, represented only by prose, or deferred without an owning task.
  - Check execution readiness before emitting: all decisions are resolved; required files, tools, credentials, services, and test environments are available or explicitly identified as prerequisites; no manual input or approval is expected during execution; every task has one ownership boundary and independent verification; and dependencies form an executable sequence. Resolve or split anything that fails these checks.



## Plan guardrails

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
- Repeat all context, requirements, decisions, constraints, and commands needed by a task inside that task.
- Define task dependencies by exact artifact and verified contract, never by task number alone.
- Do not use vague instructions such as “use an appropriate structure,” “handle errors gracefully,” or “as needed.”
- Treat canonical outcomes, required behavior, public contracts, non-negotiable constraints, exclusions, and completion conditions as immutable. If repository reality conflicts with one, stop and report the blocker; never classify it as an acceptable deviation.



## Output

<!--
Emit one complete Markdown implementation prompt from the template below.
Replace every bracketed placeholder with verified repository-specific content.
Remove sections and commands that do not apply. Duplicate the phase and task
templates until the complete implementation is covered. Do not emit these HTML
comments, unresolved placeholders, references to this skill, the Lavish plan,
other plan sections, or prior conversation.
-->



# Implement [feature]

Implement this plan end to end. Create one todo item for every task, preserve the
given order, and continue through all phases without waiting for confirmation
unless a stated prerequisite is missing or materially different from its
contract.

## Outcome

[State the product outcome, implementation scope, and explicit exclusions.]

## Acceptance contract

<!--
List every canonical requirement and acceptance criterion exactly once. Assign
stable sequential IDs and preserve each criterion's complete meaning without
requiring access to the source plan. Map every AC ID to at least one
implementing behavior or phase checkpoint; there must be no orphaned criteria.
-->

- **AC-01:** [Concise, independently understandable requirement or acceptance criterion] — Task 1.1, behavior 1; verified by [exact test or Phase 1 checkpoint]
- **AC-02:** [Concise, independently understandable requirement or acceptance criterion] — Task 1.1, behavior 2; verified by [exact test or Phase 1 checkpoint]

## Verified repository state

[Describe the relevant current behavior, architecture, test conventions, and existing interfaces.]

## Resolved design

[State every cross-task architectural, contract, dependency, error-handling, testing, and phasing decision.]

## Security

**Threat modeling required:** [Yes | No]

**Rationale:** [State the applicable threats and mitigations, or why threat modeling is unnecessary.]

## Intended structure

<!-- Use the repository's actual layout; include only new or changed paths. -->

```text
[Show only relevant new or changed paths, with each path's sole responsibility.]
```



## Execution rules

- Read `AGENTS.md` before editing and follow all repository instructions.
- Execute phases and tasks in order. Keep the repository passing between tasks.
- Use strict vertical TDD: complete one RED → GREEN → REFACTOR cycle for one
behavior before writing the next test. Never batch tests or implementation.
- Test observable behavior through public interfaces. Do not assert internal
calls, private state, or implementation structure.
- Mock only external boundaries. Keep schemas, data classes, pure helpers, and
deterministic standard-library behavior real.
- Implement only enough production code to pass the current test. Do not
anticipate later behaviors or add speculative abstractions.
- Never refactor while RED. Run the relevant tests after every refactor step.
- If a test fails after a behavior-preserving refactor, rewrite the test when it
asserted implementation details; do not revert valid design improvements.
- If a planned test passes before implementation, determine whether the behavior
already exists or the test is ineffective before changing production code.
- Stop and report a blocker instead of inventing a parallel contract, fallback,
compatibility shim, or alternate architecture.



## Baseline preflight

Before editing:

1. Read `AGENTS.md`.
2. Run `git status --short` and preserve all pre-existing changes.
3. Verify every prerequisite file, contract, dependency, service, credential,
   and tool named by this prompt.
4. Run `[exact focused baseline test command]`.
5. Run `[exact additional baseline command required by this repository]`.

If a required prerequisite is unavailable, a named command does not exist, or
the relevant baseline is already failing, stop and report the exact blocker.
Do not modify code to conceal a pre-existing failure.

<!--
Repeat the phase template for every vertical product-capability milestone. Each
phase must end in an integrated, demonstrable state and an exact checkpoint.
-->

## Phase 1 — [Product-capability milestone]

Deliver [working, demonstrable end-to-end capability].

**Acceptance criteria:** [AC-01, AC-02]

**Phase checkpoint:** Demonstrate completion by [exact observable workflow] and
run `[exact phase-level command]`.

<!--
Repeat the task template for every task in this phase. Each task must remain
executable when copied alone into a fresh coding-agent conversation, so repeat
all applicable context, constraints, TDD rules, and verified commands.
-->

### Task 1.1 — [Imperative, outcome-oriented title]

Implement [specific observable outcome and why it is required].

Read `AGENTS.md` before editing. Follow all repository instructions and use
strict vertical TDD exactly as specified below.

Before editing, run `git status --short`, preserve pre-existing changes, verify
the prerequisite artifacts and tools listed below, and run
`[exact focused baseline test command]`. If the baseline fails or a prerequisite
is unavailable, stop and report the blocker without modifying code.

Test only observable behavior through public interfaces. Do not assert private
state, internal calls, or implementation structure. Mock only external
boundaries such as database queries, HTTP calls, file I/O, time, and service
clients; keep schemas, data classes, pure helpers, and deterministic standard
library behavior real. Never refactor while RED or implement a later behavior
during the current cycle.

Inspect these repository artifacts first:

- `path/to/module.py::Symbol` — [verified current responsibility and behavior]
- `path/to/test_file.py::TestClass` — [relevant existing coverage and test pattern]
- `path/to/example.py::ExampleSymbol` — [repository pattern to preserve]

Deliver:

- [Concrete required behavior or artifact]
- [Concrete boundary, edge case, or failure behavior]
- [Explicit exclusion]

Satisfy these acceptance criteria:

- **AC-01:** [Repeat the complete criterion statement]
- **AC-02:** [Repeat the complete criterion statement]

Use these prerequisite contracts:

- `path/to/dependency.py::Dependency` — [exact signature, schema, behavior, or migration state]
- Verify this contract with `[exact command or inspection]`.
- If it is absent or materially different, stop and report the mismatch. Do not
invent a parallel interface, fallback, compatibility shim, or alternate design.

Make only these changes:

- Create `path/to/new_file.py` to own [single responsibility].
- Modify `path/to/existing_file.py::Symbol` to [specific change].
- Add or modify `path/to/test_file.py::TestClass` to verify [public behavior].

Preserve:

- `path/to/preserved.py::PublicSymbol` — keep [signature and behavior] unchanged.
- Do not modify [specific file, subsystem, contract, or out-of-scope behavior].

Implement this resolved design:

- [Exact ownership and dependency direction]
- [Exact public interface, types, schemas, errors, and side effects]
- [Applicable repository constraints stated in full]

Expose and test this public contract:

<!--
Use the repository language and the contract form appropriate to the task:
function, class, component, command, endpoint, event, schema, or migration.
-->

```[language]
[Exact language-appropriate public signature, schema, route, command, event, or migration contract]
```

Implement these behaviors in order:

1. **[AC-01] [Tracer-bullet behavior]**
  - Given [concrete fixture, input, and starting state]
  - When [exact action through the public interface]
  - Then [observable result and representative assertion]
2. **[AC-02] [Next smallest behavior]**
  - Given [concrete fixture, input, and starting state]
  - When [exact action through the public interface]
  - Then [observable result and representative assertion]

Use this order because [explain how the tracer bullet proves the path and why
each later behavior is the next smallest useful vertical increment].

For each behavior, complete this cycle before starting the next:

1. **RED**
  - Write one test for the behavior through the public interface.
  - Run `[exact focused test command]`.
  - Confirm it fails for the expected behavioral reason. If it passes, verify
  whether the behavior already exists or the test is ineffective.
2. **GREEN**
  - Write only enough production code to pass the new test.
  - Run `[exact focused test command]` and confirm it passes.
  - Do not implement later behaviors during this step.
3. **REFACTOR**
  - Refactor only while tests are green.
  - Remove duplication, improve names and ownership, and simplify the changed
  code without changing behavior.
  - Run `[exact focused test command]` after each refactor step.
  - Verify the test still describes public behavior and would survive another
  internal refactor.
  - If a test fails after a behavior-preserving refactor because it asserted an
  implementation detail, rewrite the test instead of reverting the refactor.
  <!--
  Include these deslop steps only when `deslop` was verified as installed and
  supported by the repository.
  -->
  - Run `deslop --uncommitted-only --path [exact path edited in this TDD slice]`.
  - Run `git diff --unified=0` and compare changed line ranges with
    `.deslop/report.md`.
  - Fix only findings in lines changed by this TDD slice, rerun
    `[exact focused test command]` after each fix, and repeat until no
    changed-line findings remain.

<!--
Include the following section only for changes with no meaningful observable
behavior to test. Otherwise omit it.
-->

After all TDD cycles pass, make these non-TDD changes:

- [Exact mechanical, configuration, generated, or documentation change and why no meaningful behavior test applies]

After all behaviors are green:

1. Run `[exact task test command]`.
2. Run `[exact verified lint or quality command]`.
3. Run `[exact verified type-check or build command]`.
4. Run `[exact relevant regression command]`.

Before completing the task, classify every acceptance criterion owned by this
task using test or checkpoint evidence:

- **Implemented** — satisfied as written; cite the passing test or checkpoint.
- **Missing** — not satisfied; return to RED and complete it.
- **Blocked** — cannot be completed because a verified prerequisite or fixed
  contract is unavailable or contradictory; cite the exact blocker and stop.

Acceptance criteria cannot be classified as Deviated. Report implementation-detail
deviations separately, and only when they preserve every fixed outcome, required
behavior, public contract, constraint, exclusion, and completion condition.

Complete the task only when every owned `AC-*` criterion is Implemented, all
verification commands pass, preserved contracts remain unchanged, and no
out-of-scope files or behavior were modified. Report criterion evidence, changed
files, command results, and justified implementation-detail deviations.

<!-- Repeat the task and phase templates until all required behavior is covered. -->

## Execution-time conformance

After all phases, create and complete a final todo named
`Verify acceptance conformance`:

1. Run every phase checkpoint.
2. Run `[exact full test-suite command]`.
3. Run `[exact verified repository-wide lint or quality command]`.
4. Run `[exact verified repository-wide type-check or build command]`.
5. For every `AC-*` criterion in the Acceptance contract, inspect its
   ownership mapping and classify it using concrete test or checkpoint
   evidence:
   - **Implemented** — satisfied as written; cite the evidence.
   - **Missing** — not satisfied; return to the owning task and complete it
     through RED → GREEN → REFACTOR.
   - **Blocked** — cannot be completed because a verified prerequisite or fixed
     contract is unavailable or contradictory; cite the blocker and stop.
6. Repeat verification after completing every Missing criterion.
7. Finish only when every acceptance criterion is Implemented. Report each
   criterion's classification and evidence, changed files, command results, and
   any implementation-detail deviations.

Never classify an acceptance criterion as Deviated.

<!--
Before returning the generated prompt, verify:
- no bracketed placeholders or HTML comments remain;
- every emitted command was discovered in the repository and its tool is available;
- unsupported lint, type-check, build, quality, or deslop steps were removed;
- baseline preflight is explicit and preserves pre-existing changes;
- every phase is vertical and has an observable checkpoint;
- every task is bounded, independently executable, and contains its own context;
- every dependency is an exact artifact contract, never a task-number reference;
- every behavior has a concrete RED failure, public action, and observable assertion;
- every canonical requirement and acceptance criterion has one stable `AC-*` ID;
- every `AC-*` ID maps to an owning task behavior or phase checkpoint;
- every owning standalone task repeats the full criterion statement;
- execution-time conformance classifies criteria only as Implemented, Missing,
  or Blocked using concrete evidence; and
- the full implementation passes the execution-readiness check.
Rewrite the prompt until every check passes.
-->
