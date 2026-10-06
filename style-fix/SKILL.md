---
name: style-fix
description: Fix a document's style issues against the Google Developer Documentation Style Guide (voice, active voice, inclusive language, accessibility, headings, lists, punctuation, numbers, code formatting). Use when the user asks to fix, correct, or clean up a draft per style guidelines, or invokes /style-fix. Proposes changes as a diff/preview and applies them only after the user confirms.
---

# Style fix

Run the same checks as `style-review`, then propose concrete edits. Never write changes to the file before the user has seen and approved them.

## Steps

1. Run the full `style-review` process first (see `../style-review/SKILL.md`) to build the findings list — same reference files (`../references/core-rules.md`, `../references/word-list.md`, and `../references/code-and-commands.md` when relevant), same read-the-whole-document-first discipline.
2. For each finding, draft the exact replacement text. Keep edits minimal and local — fix the flagged issue, don't rewrite surrounding text that wasn't flagged, and don't introduce new content, restructure sections, or change meaning.
3. Present the proposed changes as a diff/preview before touching the file: for each finding, show `- <original>` / `+ <proposed>` (or a before/after pair if the environment has no diff rendering). Group by the same categories used in `style-review`.
4. Ask for confirmation before applying anything. Accept either "apply all" or a subset ("just fix the inclusive-language ones").
5. Only after confirmation, apply the approved edits to the file (using whatever file-edit mechanism the host tool provides — e.g. the `Edit` tool in Claude Code/Codex).
6. After applying, summarize what changed in one or two sentences — don't restate the whole diff again.
7. If a finding is ambiguous or the "fix" would require a judgment call the user should make (e.g. renaming a concept, restructuring a paragraph), leave it out of the auto-fix batch and call it out separately as something to decide, rather than guessing.
