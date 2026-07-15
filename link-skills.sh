#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC="$ROOT/skills"
AGENTS_SRC="$ROOT/AGENTS.md"

declare -A SKILL_TARGETS=(
  [cursor]="$HOME/.cursor/skills"
  [claude]="$HOME/.claude/skills"
  [pi]="$HOME/.pi/agent/skills"
  [agents]="$HOME/.agents/skills"
)

declare -A AGENT_TARGETS=(
  [cursor]="$HOME/.cursor/AGENTS.md"
  [claude]="$HOME/.claude/CLAUDE.md"
  [pi]="$HOME/.pi/agent/AGENTS.md"
  [agents]="$HOME/.agents/AGENTS.md"
)

abs_path() {
  if [[ -d "$1" ]]; then
    (cd "$1" && pwd)
  else
    echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
  fi
}

link_path() {
  local label="$1" src="$2" dest="$3"

  mkdir -p "$(dirname "$dest")"

  if [[ -L "$dest" ]]; then
    rm "$dest"
  elif [[ -e "$dest" ]]; then
    rm -rf "$dest"
  fi

  ln -s "$src" "$dest"
  echo "linked $label -> $src"
}

link_skill() {
  local harness="$1" target_dir="$2" skill="$3"
  link_path "$harness/$skill" "$(abs_path "$SKILLS_SRC/$skill")" "$target_dir/$skill"
}

link_agents() {
  local harness="$1" dest="$2"
  link_path "$harness/$(basename "$dest")" "$(abs_path "$AGENTS_SRC")" "$dest"
}

selected=()
if [[ $# -gt 0 ]]; then
  for harness in "$@"; do
    if [[ -z "${SKILL_TARGETS[$harness]+x}" ]]; then
      echo "unknown harness: $harness (expected: cursor, claude, pi, agents)" >&2
      exit 1
    fi
    selected+=("$harness")
  done
else
  selected=(cursor claude pi agents)
fi

if [[ -f "$AGENTS_SRC" ]]; then
  for harness in "${selected[@]}"; do
    link_agents "$harness" "${AGENT_TARGETS[$harness]}"
  done
else
  echo "skip agent instructions: $AGENTS_SRC not found" >&2
fi

if [[ ! -d "$SKILLS_SRC" ]]; then
  echo "no skills directory: $SKILLS_SRC" >&2
  exit 1
fi

shopt -s nullglob
skills=("$SKILLS_SRC"/*/)
shopt -u nullglob

if [[ ${#skills[@]} -eq 0 ]]; then
  echo "no skills found in $SKILLS_SRC" >&2
  exit 1
fi

for harness in "${selected[@]}"; do
  for skill_path in "${skills[@]}"; do
    [[ -f "$skill_path/SKILL.md" ]] || continue
    link_skill "$harness" "${SKILL_TARGETS[$harness]}" "$(basename "$skill_path")"
  done
done
