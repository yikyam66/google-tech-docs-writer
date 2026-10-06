#!/usr/bin/env bash
# Copies the canonical references/*.md files into each self-contained skill
# folder (devdoc-review/references/, devdoc-fix/references/, ...).
#
# Why this exists: each skill folder must be fully self-contained (no `..`
# path traversal in SKILL.md) because some hosts don't resolve the
# ~/.claude/skills/<name> symlink before computing relative paths, so a
# skill reaching outside its own directory silently breaks. See the
# project README's "Lessons learned" section.
#
# Usage: run this after editing anything under references/, before testing
# or committing.
set -euo pipefail
cd "$(dirname "$0")/.."

SKILLS=(devdoc-review devdoc-fix devdoc-draft)

for skill in "${SKILLS[@]}"; do
  mkdir -p "$skill/references"
  cp references/core-rules.md references/word-list.md references/code-and-commands.md references/error-messages.md "$skill/references/"
  echo "synced references/ -> $skill/references/"
done
