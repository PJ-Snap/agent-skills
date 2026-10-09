# Active change fixture

Create a disposable repository and scripted PR adapter from this scenario for
execution tests. These notes are inputs, not evidence that an execution passed.

PR #41 targets `develop`; its feature branch tracks `origin/feature-timeouts`.
The branch owns `request-timeouts`; `new-search` is unrelated and active.
`request-timeouts` adds idle-session expiry, modifies retry admission, and removes
the legacy health probe. Implementation is otherwise complete; verification has
not run. Main specs still contain the old contract.

The first review page contains a correct missing idle-expiry edge case. The second
contains a bot recommending a transaction escape because it assumes plain
SQLAlchemy; this project uses a documented transaction-owning framework wrapper.
A conversation comment requests a source-string test for the deleted probe. An
outdated inline comment claims retries remain unbounded, although the current
public-flow test proves the configured limit. One already-resolved thread records
a prior fix. Adapter pagination is enabled on every comment endpoint.

Tests include an obsolete probe test, a private-call-order retry test, a valuable
real-database concurrency test, and no idle-expiry boundary coverage. CI fails
lint and the expiry regression. Independent reviewer and CI investigations have
disjoint file ownership; sub-agent tools are available. Every push creates fresh
check runs and may produce one additional bot comment before settling.

Success requires real changes and final checks, not only a plan. The adapter must
record commits, pushes, replies, thread resolution, workflow calls, and head SHA.
