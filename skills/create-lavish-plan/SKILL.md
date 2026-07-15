---
name: create-lavish-plan
description: Develop a feature idea into a planning-ready canonical HTML plan through a rigorous interview, then create and review it with Lavish. Use when the user wants to define a feature, write requirements, create a plan, or resolve a capability before implementation planning.
---

Act as the user's specification partner. Turn their idea into a canonical plan that a separate planning agent can use without reconstructing missing decisions.

## Objective and completion standard

The canonical plan is ready only when it passes the convergence test: two engineers or agents reading it independently may choose different implementation details, but should converge on the same architecture, contracts, behavior, and user outcome.

## Phase 1: Discovery

1. Restate the idea as a problem and desired outcome. Get the user's confirmation before continuing.
2. Ask exactly one focused question per turn: the unresolved question with the greatest effect on scope, architecture, contracts, or user behavior.
3. Lead with a recommended answer and concise rationale. Ask the user to confirm, reject, or refine it.
4. Resolve the consequences of each answer, not merely the stated preference.
5. Challenge ambiguity, assumptions, contradictions, missing constraints, edge cases, and failure modes. Probe shallow answers.
6. Inspect the codebase for facts available there; do not ask the user to supply discoverable information.
7. Continuously track decisions, assumptions, open questions, and risks. Revisit conflicts as they appear.
8. Continue until every material decision is resolved or explicitly bounded and the design passes the convergence test.

Do not produce implementation tasks or prescribe files, classes, methods, or code-level steps unless they are non-negotiable architectural constraints.

## Phase 2: Create and review the canonical plan

### Plan invariants

The canonical plan must give an implementation-planning agent enough information to determine:

- the intended outcome and scope, including explicit exclusions;
- the required observable behavior, including relevant edge cases and failures;
- applicable contracts and non-negotiable constraints;
- verifiable completion conditions; and
- residual assumptions, risks, and intentionally deferred decisions.

Preserve all material decisions. State residual uncertainty explicitly; never invent certainty.

### Create the artifact

1. Derive a short kebab-case `<title>` from the plan title. `.lavish/<title>-plan.html` is the canonical plan.
2. Run `npx -y lavish-axi playbook` to discover available playbooks and their `use_when` triggers.
3. Always run `npx -y lavish-axi playbook plan` and `npx -y lavish-axi design`.
4. Open every other playbook whose `use_when` trigger matches the plan being produced.
5. Write the complete plan directly to the canonical HTML file, applying each opened playbook's structure, design rules, and pitfalls. Do not copy playbook guidance verbatim into the artifact. Do not create an intermediate Markdown plan or maintain a parallel source.



### Review loop

1. Open the artifact with `npx -y lavish-axi .lavish/<title>-plan.html`.
2. Run `npx -y lavish-axi poll .lavish/<title>-plan.html --agent-reply "The converged plan is ready for visual review. Review the outcome, flows, constraints, interfaces, and acceptance criteria."` and wait for review feedback.
3. Apply accepted feedback directly to the canonical HTML file.
4. Reopen and poll against the same file until the user ends the Lavish review or explicitly asks to stop it.

