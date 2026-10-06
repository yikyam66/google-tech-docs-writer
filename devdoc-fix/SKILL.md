---
name: devdoc-fix
description: Fix a document's style issues against the Google Developer Documentation Style Guide (voice, active voice, inclusive language, accessibility, headings, lists, punctuation, numbers, code formatting). Use when the user asks to fix, correct, or clean up a draft per style guidelines — including error-message strings, error-code tables, and UI strings, standalone or inside a document — or invokes /devdoc-fix. Proposes changes as a diff/preview and applies them only after the user confirms. English-language rules only; skip documents in other languages.
---

# devdoc-fix

Check a document against the curated Google Developer Documentation Style Guide rules, then propose concrete edits. Never write changes to the file before the user has seen and approved them.

## Steps

1. Identify the target document(s) from the user's request.
2. Language gate first: check what language the document is in (its first paragraph is usually enough). These rules are written for English technical prose — if the target document is in another language, say so and skip it right away, before reading any rule files, rather than force-fitting English rules onto it.
3. Read the reference rules before scanning anything — these live in this skill's own `references/` folder, right next to this file:
   - `references/core-rules.md` — voice/tone, active voice, person, tense, inclusive language, accessibility, headings, lists, punctuation, numbers/units.
   - `references/word-list.md` — specific terms to flag.
   - `references/code-and-commands.md` — only if the document contains code blocks, commands, placeholders, or UI instructions.
   - `references/error-messages.md` — only if the document contains error-message text, error-code tables, or UI strings.
4. Read the target document in full before reporting anything — don't flag from a partial read.
5. Build a findings list: for each violation, capture the location (quote the exact phrase, or a line number), which rule it violates, and a concrete suggested fix. Only flag a rule where it actually applies — don't force-fit one that doesn't fit this document's content or audience.
6. For each finding, draft the exact replacement text. Keep edits minimal and local — fix the flagged issue, don't rewrite surrounding text that wasn't flagged, and don't introduce new content, restructure sections, or change meaning. A replacement may only use wording, identifiers, and placeholders already present in the document or supplied by the user — never invent new ones; if a proper fix needs information the document doesn't contain, leave the finding for the user to decide and note what's missing.
7. Present the proposed changes as a diff/preview before touching the file: for each finding, show `- <original>` / `+ <proposed>` (or a before/after pair if the environment has no diff rendering), grouped by the same categories a review would use (voice and tone, active voice, inclusive language, accessibility, headings, lists, punctuation, numbers and units, code and commands).
8. Ask for confirmation before applying anything. Accept either "apply all" or a subset ("just fix the inclusive-language ones").
9. Only after confirmation, apply the approved edits to the file (using whatever file-edit mechanism the host tool provides — e.g. the `Edit` tool in Claude Code/Codex).
10. After applying, summarize what changed in one or two sentences — don't restate the whole diff again.
11. If a finding is ambiguous or the "fix" would require a judgment call the user should make (e.g. renaming a concept, restructuring a paragraph), leave it out of the auto-fix batch and call it out separately as something to decide, rather than guessing.
12. Stay in scope: this skill fixes *style*, not factual accuracy, code correctness, or content gaps. If the user actually wants a brand-new document written (not fixes to an existing one), say that's outside this skill's scope — that's a drafting task.
