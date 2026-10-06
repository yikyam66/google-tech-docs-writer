---
name: devdoc-draft
description: Draft a brand-new English technical document from scratch (README, API reference, architecture doc, how-to, contributing guide) in the house style of the Google Developer Documentation Style Guide. Use whenever the user asks to write, draft, or create documentation for a project or product — "write a README for this project", "we need an architecture doc covering X", "draft a how-to for Y" — even if they don't name a document type. Not for reviewing an existing draft (that's devdoc-review) or fixing one (that's devdoc-fix). English-language rules only; declines documents in other languages.
---

# devdoc-draft

Write a new technical document from scratch, applying the curated Google Developer Documentation Style Guide rules while composing — not checking after the fact. Facts come from the user and the target project; style comes from the reference rules.

## Steps

1. Identify what to draft from the user's request: document type (README, API reference, architecture doc, how-to, ...), audience, and the points it must cover. If the request is vague ("write docs for this"), ask what the document is for and who reads it before drafting.
2. Language gate first: confirm what language the requested document should be in (from the request; ask if unclear). These rules are written for English technical prose — if the requested document is in another language, say so and decline right away, before reading any rule files, rather than force-fitting English rules onto it.
3. Read the reference rules before writing anything — they live in this skill's own `references/` folder, right next to this file:
   - `references/core-rules.md` — voice/tone, active voice, person, tense, inclusive language, accessibility, headings, lists, punctuation, numbers/units.
   - `references/word-list.md` — preferred terminology to use from the first word, not to patch in later.
   - `references/code-and-commands.md` — if the document will contain code blocks, commands, placeholders, or UI instructions.
   - `references/error-messages.md` — if the document will contain error messages, error-code tables, or UI strings (apply the rules while composing them, not just formatting them).
4. Redirect guard: if the user actually wants an *existing* document reviewed or fixed, don't draft a replacement — point them to `/devdoc-review` or `/devdoc-fix` instead.
5. Gather facts before writing:
   - Use everything the user provided: what the project is, who it's for, what must be documented.
   - If the target project is reachable (a repo in the working directory, or paths the user gave), explore it to verify: what the product actually does, real install/run steps, real command and flag names, real dependency names. A README whose commands don't run is worse than no README.
   - Fact discipline: write only what the user provided or what you verified in the project. Never invent features, numbers, benchmarks, or quotes. Anything you couldn't verify becomes an explicit `TODO:` placeholder in the draft — never silently glossed over.
   - Verify literal identifiers against the source when possible: command names, flags, file names, UI labels. Follow `code-and-commands.md` for placeholders (one consistent convention per document) and command syntax (shown as the reader would type it, no `$` prompt prefix).
6. Propose an outline before drafting the full text: the heading structure with a line on what each section will cover, plus any open questions about audience or scope. Wait for confirmation. Keep it proportional — a short README needs a few bullets in chat, a long architecture doc deserves a fuller outline. Task-based sections get imperative headings ("Install the CLI"); conceptual sections get noun phrases ("Architecture overview").
7. After the outline is confirmed, draft the full document, applying the rules natively as you write:
   - Second person, active voice, present tense, conversational but not jokey. No "simply"/"just"/"easy", no hedging boilerplate, no time anchors ("currently", "soon").
   - Preferred terms from `word-list.md` from the start: denylist/allowlist, "for example" not "e.g.", no "etc.", no "should" in prescriptive instructions.
   - Sentence-case headings, exactly one `h1`, no skipped heading levels; lists introduced by a complete sentence ending in a colon; Oxford comma; number and unit rules from `core-rules.md`.
   - Code formatting per `code-and-commands.md`: backticks for identifiers and commands, bold UI labels matching the actual on-screen text.
   - Draft the requested document, not a documentation suite — don't add sections the user didn't ask for.
8. Self-check before delivering: re-read the finished draft against `core-rules.md` and `word-list.md` (plus `code-and-commands.md` if applicable) and fix every violation you find. Mention briefly what the self-check caught. This is a built-in review pass using the same reference files — not a switch to another skill.
9. Confirm the target path with the user before writing the file. If the path already exists, show what's there and ask whether to replace it or write elsewhere — never overwrite an existing file without explicit confirmation.
10. After writing, summarize what you produced in one or two sentences and list the remaining `TODO:` placeholders the user must fill in. If they want an independent second pass, `/devdoc-review` works on the saved file.
11. Stay in scope: this skill drafts new documents in the house style. It does not verify factual claims you couldn't check (those stay as placeholders), and it does not edit existing documents — that's `/devdoc-fix`.
