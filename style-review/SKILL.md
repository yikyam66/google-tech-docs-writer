---
name: style-review
description: Review a document against the Google Developer Documentation Style Guide (voice, active voice, inclusive language, accessibility, headings, lists, punctuation, numbers, code formatting). Use when the user asks to check, review, critique, or proofread a draft for writing style or clarity, or invokes /style-review. Read-only — produces a report, never edits the file.
---

# Style review

Check a document against the curated Google Developer Documentation Style Guide rules and report findings. This mode never edits the target file.

## Steps

1. Identify the target document(s) from the user's request (a file path, a pasted draft, or "this file" meaning the one currently open/discussed).
2. Read the reference rules before scanning anything:
   - `../references/core-rules.md` — voice/tone, active voice, person, tense, inclusive language, accessibility, headings, lists, punctuation, numbers/units.
   - `../references/word-list.md` — specific terms to flag.
   - `../references/code-and-commands.md` — only if the document contains code blocks, commands, placeholders, or UI instructions.
3. Read the target document in full before reporting anything — don't flag from a partial read.
4. Check the document against each category in `core-rules.md` and against the `word-list.md` table. Only report a rule as violated where it actually applies — don't force-fit a rule that doesn't apply to this document's content or audience.
5. For every finding, capture: the location (quote the exact offending phrase, or give a line number if the file is line-addressable), which rule it violates (name it, e.g. "Active voice", "Inclusive language — blacklist/whitelist"), and a concrete suggested fix (not just "fix this").
6. Output a single Markdown report, grouped by category, most-impactful issues first within each group. Use this shape:

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

7. If the document is clean on every category you checked, say so plainly — don't invent findings to look thorough.
8. Do not edit the file. If the user then asks to apply fixes, point them to `/style-fix` rather than silently switching modes.
