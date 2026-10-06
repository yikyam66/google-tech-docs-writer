---
name: devdoc-review
description: Review a document against the Google Developer Documentation Style Guide (voice, active voice, inclusive language, accessibility, headings, lists, punctuation, numbers, code formatting). Use when the user asks to check, review, critique, or proofread a draft for writing style or clarity — including error-message strings, error-code tables, and UI strings, standalone or inside a document — or invokes /devdoc-review. Read-only — produces a report, never edits the file. English-language rules only; skip documents in other languages.
---

# devdoc-review

Check a document against the curated Google Developer Documentation Style Guide rules and report findings. This mode never edits the target file.

## Steps

1. Identify the target document(s) from the user's request (a file path, a pasted draft, or "this file" meaning the one currently open/discussed).
2. Language gate first: check what language the document is in (its first paragraph is usually enough). These rules are written for English technical prose — if the target document is in another language, say so and skip the review right away, before reading any rule files, rather than force-fitting English rules onto it.
3. Read the reference rules before scanning anything — these live in this skill's own `references/` folder, right next to this file:
   - `references/core-rules.md` — voice/tone, active voice, person, tense, inclusive language, accessibility, headings, lists, punctuation, numbers/units.
   - `references/word-list.md` — specific terms to flag.
   - `references/code-and-commands.md` — only if the document contains code blocks, commands, placeholders, or UI instructions.
   - `references/error-messages.md` — only if the document contains error-message text, error-code tables, or UI strings.
4. Read the target document in full before reporting anything — don't flag from a partial read.
5. Check the document against each category in `core-rules.md` and against the `word-list.md` table. Only report a rule as violated where it actually applies — don't force-fit a rule that doesn't apply to this document's content or audience.
6. For every finding, capture: the location (quote the exact offending phrase, or give a line number if the file is line-addressable), which rule it violates (name it, e.g. "Active voice", "Inclusive language — blacklist/whitelist"), and a concrete suggested fix (not just "fix this"). A suggested fix may only use wording, identifiers, and placeholders already present in the document or supplied by the user — never invent new ones; if the right fix needs information the document doesn't contain, say what's missing instead of making it up.
7. Output a single Markdown report, grouped by category, most-impactful issues first within each group. Use this shape:

   ```markdown
   # Style review: <document name>

   ## Voice and tone
   - **"<quoted phrase>"** — violates *<rule name>*. Suggested fix: <specific rewrite>.

   ## Active voice
   ...

   ## Inclusive language
   ...

   (omit any category with zero findings — don't print empty headers)

   ---
   Reviewed against: core-rules.md, word-list.md[, code-and-commands.md]
   ```

8. If the document is clean on every category you checked, say so plainly — don't invent findings to look thorough.
9. Stay in scope: this skill checks *style*, not factual accuracy, code correctness, or whether the content matches the actual project. If you notice something outside that scope (stale references, broken paths, content gaps), you can mention it briefly under a separate "Out of scope" note, but don't let it dominate the report.
10. Do not edit the file. If the user then asks to apply fixes, point them to `/devdoc-fix` rather than silently switching modes. If they ask for a brand-new document to be written (not a review of an existing one), say that's outside this skill's scope — that's a drafting task, not a review.
