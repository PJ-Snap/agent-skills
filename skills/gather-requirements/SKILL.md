---
name: gather-requirements
description: >-
  Gathers product and feature requirements through an exploration interview,
  asking questions that resolve uncertainties that could materially change the
  product or its architecture, then writes a destination brief. Use when the
  user invokes gather-requirements, wants to gather requirements, run a
  requirements interview, write a product brief, or capture who a feature
  serves, essential capabilities, and concrete workflows before design or
  planning. Not for open-ended explore without a brief, and not for
  implementation planning.
---

Enter gather-requirements. Think deeply, visualize freely, and follow the
conversation wherever it goes. Be a thought partner through the interview: no
fixed steps or required sequence. Read and diagnose freely. Produce the
destination brief when it is ready; leave implementation to later discovery.

## The stance

- Be curious, not procedural. Let questions emerge from the conversation rather
than marching through a checklist.
- Open threads instead of forcing a funnel. Surface interesting directions,
tensions, and alternatives, then follow what matters to the user.
- Reframe the problem when a different framing exposes better possibilities.
- Challenge assumptions, including the user's and your own.
- Ground exploration in repository evidence when relevant.
- Visualize experience, flows, and boundaries whenever a diagram makes the
thinking clearer.
- Stay patient on implementation route. Keep asking until uncertainties that
could materially change the product or its architecture are resolved or
captured as constraints.

## The interview

Ask questions that resolve uncertainties that could materially change the
product or its architecture. A question is material when a different answer
would change who it serves, the problem, the successful experience, an
essential capability or constraint, or a workflow that delivers value.

Probe architecture only far enough to learn those constraints. Record them as
capabilities and constraints, not as a chosen design.

- Restate emerging understanding when confirmation would prevent exploring the
wrong problem.
- Ask focused questions with the greatest effect on the product or its
architecture. Give the user room to answer rather than stacking an
interrogation.
- Lead with a recommendation and brief rationale when evidence supports one.
Use neutral options when the choice is preference-dependent.
- Resolve the consequences of answers. Probe ambiguity, contradictions, hidden
assumptions, edge cases, and failure behavior rather than merely recording a
preference.
- Follow valuable tangents while retaining material unresolved questions.
- Track decisions, assumptions, exclusions, and open questions quietly; surface
them when useful.
- Separate destination from replaceable implementation detail. Explore
boundaries and constraints when they shape the outcome; leave files, classes,
and functions to later discovery.

## Readiness

The brief is ready when two readers of the interview would share:

- who it serves, the problem, and what a successful experience enables;
- the essential capabilities and constraints;
- one or two workflows that show how someone gets value.

If an unresolved question would materially change the product or its
architecture, surface that question and keep interviewing when the user wants
to. The user may stop with uncertainty; state that uncertainty as a constraint
or open question rather than inventing a destination or a route.

## Output

When the interview has resolved those material uncertainties, or the user
asks to capture it, produce one standalone brief:

- Who it serves, the problem it solves and what a successful experience enables.
- Essential capabilities and constraints that defines the product/feature.
- One or two short, concrete workflows showing how someone gets value. (descriptive and a mermaid diagram)
- Aim for a brief that leaves the reader clear about the destination and free to discover the route.

Prefer one workflow. Add a second only when it shows a different kind of value.
Pair each workflow with a short mermaid flowchart or sequence diagram of the
same experience: actors, actions, and outcomes. Keep implementation structure out
of the prose and the diagram.

Capture leftover route-level choices as constraints any eventual solution
should satisfy.

## Guardrails

- Treat repository evidence as authoritative for current-state facts.
- Distinguish user requirements from inferred assumptions.
- Challenge contradictions and risky premises directly.
- Keep the brief at destination level: who, problem, success, capabilities,
constraints, and value workflows.
- This skill produces the interview and the brief only.
