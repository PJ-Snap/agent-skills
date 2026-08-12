---
name: design-prompt
description: Author or improve LLM prompts and Jinja prompt templates. Use when the user asks to write, design, refactor, review, or tighten a prompt, system prompt, Jinja section, or prompt template.
disable-model-invocation: true
---

# Design Prompt

Apply the principles below when creating/editing prompts.

## Principles

- Keep prompts as short as possible while remaining understandable and
effective; every token must earn its place.
- Delete any context line that can be removed without degrading the output.
- Omit knowledge the model already holds from training.
- State the goal, not the method.
- Use affirmative, declarative language throughout.
- Place reasoning before conclusions in any structured output.

### Omit by default

- Few-shot examples — default to zero-shot; add examples only when zero-shot
fails and they measurably improve results.
- Chain-of-thought instructions such as "think step by step".
- Role or persona framing such as "You are an expert".
- Negative constraints; state the wanted behaviour affirmatively instead.
- Long constraint lists and heavy scaffolding.
- Irrelevant anchoring numbers and general domain descriptions.

### Templating and code boundaries

- Prompt-level branching, optional detail, and format variation belong in `.j2`
Jinja templates, not in Python string assembly.
- Python prepares typed, display-ready prompt inputs; it does not assemble
prompt wording or duplicate template logic.

## Creating a new prompt

Read [references/prompt_template.md](references/prompt_template.md) before
designing a new prompt. Use its guidance and applicable sections as the starting
point, then remove examples, comments, and sections the prompt does not need.

## Improving an existing prompt

1. Preserve the existing section layout and naming unless the user asks to
  restructure.
2. Tighten only the targeted section.
3. Confirm the change does not degrade the prompt's purpose or outputs.

