```markdown
<task>
<!-- A single clear statement of what the model should accomplish. State the
goal, not the method — let the reasoning model determine its own approach.
Placed first for primacy attention — the model knows what to attend to
when processing the context that follows. Omit this section for
conversational use where the goal is stated directly in <input>. Include
it for fixed-purpose prompts (API system prompts, agentic tools, batch
processing) where the objective is static across requests and belongs in
the cached prefix. -->

Example:
Classify the submitted support ticket by product line and severity using the
definitions in <context>.
</task>

<context>
<!-- Domain-specific knowledge the model cannot produce on its own — proprietary
rules, internal definitions, retrieved documents, data beyond training cutoff.
Every token here must earn its place: if you can delete it without degrading
the output, delete it. -->

Example:
Internal terminology:
- "BRD" — Business Requirements Document, the source-of-truth spec owned by
  the PM. All feature scoping references the BRD, not Jira tickets.
- "Green lane" — a fast-track approval path that skips the Architecture
  Review Board (ARB). Only eligible for changes scoped to a single service
  with no schema migrations.
- "Paved road" — the endorsed stack and deployment pattern (TypeScript,
  internal API gateway, Terraform modules). Deviations require an ARB waiver.
- "SRF" — Service Readiness Framework, a pre-launch checklist covering
  observability, runbooks, load test results, and rollback procedures. A
  service cannot go GA without a signed-off SRF.

Team structure:
- Platform Engineering owns the paved road tooling and the API gateway.
- Product squads own their services end-to-end (build, deploy, on-call).
- The Data Platform team owns the event bus and all downstream consumers.
</context>

<instructions>
<!-- Optional. Only include when the task requires a specific stepwise procedure
that the model should follow in order. Omit for open-ended reasoning tasks where
the model should determine its own approach. Start each step with an active verb
(e.g. Parse, Match, Draft, Escalate). Use affirmative framing — state what TO do,
never what NOT to do. -->

Example:
1. Parse the submitted support ticket and classify it by product line.
2. Match the issue against known outages on the internal status page.
3. Draft a customer reply citing the ETA if a match is found.
4. Escalate to the owning squad's on-call with a summary if no match is found.

</instructions>

<constraints>
<!-- Specific boundary conditions the output must satisfy — scope
limits, success criteria, hard requirements. Keep these few and high-value;
advanced reasoning models perform worse under heavy constraint scaffolding
(constraints that help mid-tier models become "handcuffs" on advanced ones).
Use declarative language: state what must be true about the output, not
imperative steps for how to achieve it. "The proposal must stay within the
existing AWS infrastructure" rather than "Check whether the proposal uses
AWS before responding." This aligns with the reasoning model principle of
stating the goal, not the method.
Frame affirmatively: state what the output should satisfy, not what it
should avoid. "Cite only peer-reviewed sources" rather than "Do not use
Wikipedia" — naming forbidden content primes the model toward it.
Order constraints from hardest to easiest — models allocate more attention
to earlier constraints, and hard-to-easy ordering can improve adherence.  -->

Example:
- The solution must use only services available in our current AWS region
  (eu-west-1).
- All cost estimates must be monthly, not annualized.
- Cite the specific BRD section number when referencing a requirement.
</constraints>

<output_format>
<!-- Keep this loose. Avoid rigid JSON schemas or strict structural mandates — they
degrade reasoning quality. If you need structured output, always place the
reasoning/analysis field BEFORE the answer/conclusion field. Prefer natural
language or lightly guided formats.
Field naming matters: choose descriptive, unambiguous names. -->

Example:
Provide your analysis as flowing prose. End with a clearly labeled
"Conclusion:" section summarizing your key findings and any forecasts.

Example 2 (when structured output is required):
{
  "reasoning": "your step-by-step analysis here",
  "classification": "green_lane | arb_required",
  "summary": "one-sentence justification"
}
</output_format>

<input>
<!-- Dynamic, per-request content goes last. This is the variable part that
changes every call — runtime data injected into the
prompt. Placed last for recency attention and to maximise cache hits on
the static prefix above. -->

Example:
Ticket ID: SUP-40221
Submitted: 2026-03-04T09:17Z
Customer: Acme Corp (Enterprise tier)
Product: Data Add-ons
Description: "Event ingestion pipeline returning 503 errors intermittently
since 08:45 UTC. Affects ~30% of requests. No recent deployment on our side."

Status page snapshot (retrieved 2026-03-04T09:20Z):
- [ONGOING] Data Add-ons — elevated error rates on event ingestion (eu-west-1).
  Started 08:42 UTC. ETA for resolution: 10:30 UTC.
</input>

<!-- What NOT to include

- **Few-shot examples** — Default to zero-shot. Reasoning models often don't need examples and can be actively misled by them. Few-shot can introduce distraction, majority label bias, and recency bias. Only add examples if zero-shot fails, and verify they actually improve results.
- **Chain-of-thought instructions** ("think step by step") — Redundant for reasoning models; they reason internally. Adding explicit CoT wastes tokens and can interfere.
- **Role or persona prompts** ("You are an expert...") — Effects are unpredictable and largely unproven for reasoning models. A clear task in `<input>` is more reliable.
- **Negative constraints** ("Do not hallucinate", "Never make up data") — Naming the forbidden behavior primes it. State affirmatively what the model *should* do instead.
- **Highly detailed constraint lists** — Advanced reasoning models perform worse with heavy scaffolding. Trust the model's capability and keep instructions lean.
- **Irrelevant anchoring numbers** — Numeric values in context that aren't directly task-relevant can systematically shift outputs.
- **General domain descriptions** — If the model already knows it from training, it's wasting tokens and competing with content that matters.
-->

```

