# Agent Skills

Reusable workflows for coding agents, installable with the [skills CLI](https://github.com/vercel-labs/skills).

## Install

Install Node.js and npm, then run this command from the project where you want to use the skills:

```sh
npx skills add PJ-Snap/agent-skills
```

Choose the skills and target agents when prompted. Installation defaults to the current project; add `--global` to use the skills across projects.

Install all skills globally for Codex, Claude Code, and Cursor:

```sh
npx skills add PJ-Snap/agent-skills --skill '*' --agent codex claude-code cursor --global --yes
```

Install selected skills for one agent:

```sh
npx skills add PJ-Snap/agent-skills --skill create-skill prompt-writing --agent codex
```

`create-skill` requires `prompt-writing`, so install both when selecting skills individually. Other workflows may require tools or service access described in their `SKILL.md` files.

List available skills without installing:

```sh
npx skills add PJ-Snap/agent-skills --list
```

Add `--copy` if your environment does not support symlinks. See the [CLI documentation](https://github.com/vercel-labs/skills#options) for more options and supported agents.

## Available skills

| Skill | Purpose |
| --- | --- |
| [create-skill](skills/create-skill/SKILL.md) | Create, improve, and evaluate agent skills. |
| [openspec-shape](skills/openspec-shape/SKILL.md) | Interview users and write a product or feature brief. |
| [make-pr-merge-ready](skills/make-pr-merge-ready/SKILL.md) | Resolve PR feedback and merge blockers, leaving the merge to the user. |
| [openspec-scope](skills/openspec-scope/SKILL.md) | Select the next reviewable increment and prepare an OpenSpec proposal handoff. |
| [prompt-writing](skills/prompt-writing/SKILL.md) | Write or improve LLM prompts and Jinja prompt templates. |

## Install from a local checkout

From this repository's root:

```sh
npx skills add . --skill '*' --agent codex --global
```

Each skill lives in `skills/<name>/SKILL.md` with supporting files alongside it. The CLI discovers this layout directly; no package manifest or custom linking script is required.
