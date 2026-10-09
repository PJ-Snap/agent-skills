# Test Quality

Leave the PR with tests that protect retained and newly introduced behavior under
its effective contract. Remove obsolete tests, replace implementation-coupled
tests with behavioral coverage, and fill meaningful gaps. The parent workflow
owns production repairs, commits, pushes, and OpenSpec lifecycle actions. Keep
cleanup scoped to changed tests, tests of changed or removed behavior, and nearby
regression coverage.

## Establish meaningful coverage

Read repository testing rules, test configuration, fixtures, and CI commands.
Run affected tests before editing when feasible to distinguish existing failures.
Use the effective OpenSpec contract: baseline main specs plus only the PR's own
active or archived deltas. Main specs may already contain those deltas.

- **ADDED:** cover new behavior and scenarios.
- **MODIFIED:** cover the replacement contract and retain unaffected requirements
  and scenarios. Superseded behavior does not earn coverage.
- **REMOVED:** delete tests protecting only removed behavior and honor retained
  migration requirements. Test a specified negative public outcome, such as an
  endpoint's documented response, through that boundary. Absence of a private
  symbol, file, or source string does not need a replacement test.
- **RENAMED:** preserve unchanged behavioral coverage under the new requirement
  name. A requirement rename alone does not imply renaming implementation symbols.
  Apply any accompanying MODIFIED block.

For a repository without OpenSpec, use its documented contract and valid retained
regressions. Missing or conflicting intent is an explicit uncertainty; ask for
the missing contract and continue independent review. Valuable coverage remains
until intended behavior is clear. Specs establish required coverage, rather than
exhaustively listing every useful retained regression.

Maintain a concise map of requirement/scenario, observable outcome, actual test
evidence, and action: keep, remove, replace, add, or unresolved. Inspect test
bodies and exercised code; names and line coverage do not prove scenario coverage.

## Decide which tests protect behavior

Identify each test's observable behavior and a plausible defect it would detect.
Ask whether a behavior-preserving refactor would break it: helper renaming,
function extraction, internal-call rearrangement, or incidental text changes.
Replace implementation coupling while preserving the useful behavior it covered.

Common warning signs include source/AST matching, private-attribute assertions,
exact incidental error copy or SQL formatting, broad snapshots, mocking the unit
under test, internal call-order assertions, arbitrary call counts, expected values
computed by the same production logic, vacuous assertions, and duplicate happy
paths without distinct failure modes.

Use judgment: exact text, ordering, snapshots, and boundary call counts can be
correct when they prove a stable public format, protocol, error code, UI contract,
or specified side effect. Prefer typed errors and structured fields for diagnostics,
parsed structures for serialization, and returned values or state transitions
for workflows. Preserve distinct edge cases despite similar setup.

Delete tests exclusively protecting removed functionality, including new tests
that recreate it. Remove unused imports, fixtures, and helpers after checking
other callers. Preserve valid regressions; fix exposed production defects through
the existing behavior owner instead of weakening assertions or marking failures
skip/xfail to make CI pass.

## Fill behavioral gaps at the right layer

Reuse sound coverage before adding tests. Derive inputs and expected outcomes
from the effective scenarios, including error paths, boundaries, state transitions,
and isolation guarantees. Parameterize variations of one behavior. Test counts
and arbitrary coverage percentages do not establish correctness.

Choose the lowest layer that proves the outcome. Use unit tests for pure logic,
real integration tests for persistence, transactions, concurrency, and isolation,
and public-flow/UI tests for interaction contracts. Mocked database calls cannot
prove atomic admission or snapshot isolation. Manual checks do not replace
required automated coverage.

Follow the target repository's rules. For pytest projects, apply these defaults
where repository instructions do not prescribe a different convention: colocated
`tests/`, descriptive
`test_<who/what>_<expected_outcome>_<condition>` names, and related
`TestFunctionOrFeature` classes. Keep `# Arrange`, `# Act`, and `# Assert`
separators and control-flow-free test bodies. Assert one coherent behavior;
multiple assertions may establish that outcome, such as an error with no mutation.
Decorate async tests with `@pytest.mark.asyncio`, keep imports at module level,
annotate types explicitly, and use real schemas and types rather than loose
substitutes or `typing.Any`.

Keep the unit under test, pure helpers, deterministic standard-library code, and
fast deterministic collaborators real. Mock only boundaries such as HTTP, file
I/O, time, service clients, and database queries when the guarantee does not
require a real database. Patch the import location and prefer `monkeypatch` for
simple attributes and environment values. Keep fixture chains shallow, at most
two levels where repository rules require it. Include the repository-required
`# Why this test survives refactoring: <one sentence>` for a class or logical block.

Exercise existing public entrypoints and behavior owners. Any needed testability
refactor preserves behavior; a parallel production path or test-only API does
not repair poor test design.

## Validate the audit

Run changed tests and the affected feature/regression suite in the established
environment. In a uv/pytest project, use `uv run pytest <affected-paths> -q` when
that is its configured command. Check collection and unused fixtures after
deletions. Expand to configured CI checks when shared fixtures or cross-cutting
edits justify it, without suppressing quality gates.

For added or substantially rewritten tests, show the concrete behavioral defect
the assertion rejects. When practical, try a temporary local behavioral mutation
and restore only that mutation afterward. A new mutation-testing dependency is
unnecessary for this audit.

Review the final diff against the coverage map. Required scenarios have meaningful
automated evidence or explicit unresolved gaps. Unavailable infrastructure means
unverified coverage. Removal-only changes may add no tests; requirement renames
may retain tests unchanged. Include removals/replacements and their behavioral
reasons, coverage mapping, commands/results, and unresolved issues in the parent
workflow's final report.
