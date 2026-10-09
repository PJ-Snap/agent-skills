# Packaging

## Format

The folder contains `SKILL.md`: YAML frontmatter followed by Markdown.

| Field | Contract |
| --- | --- |
| `name` | 1–64 lowercase alphanumeric characters and hyphens; matches the folder; single internal hyphens only. |
| `description` | 1–1024 characters describing the capability and relevant user intent. |
| `compatibility` | Optional, 1–500 characters for actual environment requirements. |
| `license` | Optional license identifier or bundled license reference. |
| `metadata` | Optional mapping of string keys to string values. |
| `allowed-tools` | Experimental, client-dependent space-separated tool names. |

Keep `SKILL.md` below the recommended 500 lines and 5,000 tokens; these are
ceilings, not targets. Validate the standard frontmatter with `skills-ref validate
<skill-directory>` from the official reference implementation. Check body quality
and resource integrity separately.

## Resources and client behavior

Use `references/` for conditional knowledge, `assets/` for output resources, and
`scripts/` for executable helpers. Link resources directly from `SKILL.md` with
their loading conditions. Resolve execution paths against the skill root,
independently of the task's working directory. Verify local links and commands.

Choose the user's established destination. Confirm discovery in the target client
before interpreting a missed trigger. Check name collisions and precedence when
the expected version fails to load. Invocation controls and UI metadata are
client extensions; add them only for an actual target requirement. Tool metadata
describes capabilities within the environment's permission system.

## Script interfaces

Reuse existing tools when they own the behavior. Bundle helpers for demonstrated
repetition or fragile mechanics. Declare runtime prerequisites and reproducible
dependencies; use inline dependency metadata when supported.

Accept explicit flags, environment variables, or stdin and provide concise
`--help`. Return machine-readable data on stdout, diagnostics on stderr, and
meaningful failure codes. Errors identify the invalid input and expected contract.
Make repeated execution predictable; expose a preview for consequential mutations.
Keep output bounded or write large artifacts to a requested file. Exercise valid
inputs, relevant edge cases, and failure paths before shipping a helper.

## Sources

All nine documentation pages in the [index](https://agentskills.io/llms.txt) and
sitemap were reviewed on 2026-10-09. This package synthesizes their guidance with
`prompt-writing`; the linked specifications remain authoritative.

- [Overview](https://agentskills.io/home), [specification](https://agentskills.io/specification), and [client showcase](https://agentskills.io/clients).
- [Quickstart](https://agentskills.io/skill-creation/quickstart) and [best practices](https://agentskills.io/skill-creation/best-practices).
- [Description optimization](https://agentskills.io/skill-creation/optimizing-descriptions) and [output evaluation](https://agentskills.io/skill-creation/evaluating-skills).
- [Script interfaces](https://agentskills.io/skill-creation/using-scripts) and [client integration](https://agentskills.io/client-implementation/adding-skills-support).
