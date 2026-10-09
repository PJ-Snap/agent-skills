---
name: create-skill
description: Create, improve, evaluate, and tune activation of Agent Skills. Use when turning a repeatable workflow or domain expertise into a SKILL.md package, refining an existing skill from execution feedback, testing skill output quality, or fixing missed and unwanted skill triggers.
compatibility: Requires the prompt-writing skill for authoring instructions and evaluation prompts.
---

# Create Skill

Create the smallest skill that measurably improves a capable agent's work.
Fewer, better instructions often outperform exhaustive rules.

## Establish the capability

Use successful tasks, user corrections, project artifacts, and authoritative
documentation to identify the knowledge or execution capability the agent lacks.
Capture the intended requests, inputs, observable success, important boundaries,
and target environment. Ask only about gaps that materially change the skill.

Choose a coherent unit of work. Improve an existing owner when its scope already
fits. Resolve the destination from the user's request and repository conventions;
the format itself prescribes no installation directory. For updates, snapshot the
current package outside the working tree before editing.

Establish representative evaluation cases before drafting. Evidence that the
baseline already succeeds is a reason to narrow the skill or reconsider its value.

## Author the package

Use **prompt-writing** skill for rules on language and prose for skills.
Resolve it through the available skill catalog and read its prompt template before
writing. An unavailable dependency is a concrete blocker to authoring.

Write a concise description that connects user intent to the capability. Make
implicit but relevant requests discoverable; distinguish adjacent workflows when
confusion is plausible. Detailed execution guidance belongs in the body.

Give the body the outcome, non-obvious context, decision criteria, and necessary
validation. Describe reusable procedures rather than the answer to one example.
Keep flexible tasks outcome-led; specify exact sequences where deviation causes
a concrete failure. Offer one useful default with conditions for alternatives.

Keep essential gotchas visible before the agent can encounter them. Move
conditional detail into focused references, linked with explicit loading
conditions. Add templates when the output contract matters, examples when tests
demonstrate their value, and scripts when deterministic or repeated work warrants
them. Each resource has one clear responsibility.

Read [packaging](references/packaging.md) when creating the folder or changing
metadata, resources, dependencies, or script interfaces. Use the target client's
documentation for client-specific features.

## Validate and improve

Check format, resource links, and any executable helpers first. Then evaluate
**output quality** and **activation** separately:

- Read [output evaluation](references/evaluation.md) for creation or behavioral
  changes. Compare actual artifacts and execution traces against a controlled
  baseline in fresh contexts.
- Read [description optimization](references/descriptions.md) for a new
  description or activation problem. Observe skill loading through the real
  client with the body fixed.

Change the smallest instruction, resource, or scope decision supported by the
evidence. Remove instructions that add cost without improving outcomes. Rerun
affected cases and retained critical behaviors; expand coverage for demonstrated
gaps. Stop when acceptance is met, improvement plateaus, or the available budget
or environment prevents further measurement.

Keep evaluation outputs outside the installable package. Retain reusable cases
and fixtures in `evals/`. Preserve the user's requested scope and existing action
permissions throughout authoring and testing.

## Deliver

Report the package path, what the evidence supports, the quality and activation
results separately, and remaining limitations. Distinguish observed passes,
failures, and untested claims. A structurally valid draft can be delivered while
runtime evaluation remains pending. Installing, publishing, and unrelated
configuration changes follow the user's requested scope.
