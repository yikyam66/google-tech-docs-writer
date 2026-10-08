# google-tech-docs-writer

A portable skill based on Google's public technical-writing resources. The primary source is the [Google Developer Documentation Style Guide](https://developers.google.com/style). Targeted material from Google's [Technical Writing courses](https://developers.google.com/tech-writing) enters where it directly serves the same goal—for example, writing helpful error messages and illustration craft. The skill reviews, fixes, and drafts developer-facing technical documentation for voice, grammar, punctuation, accessibility, inclusive language, and formatting.

## What it does

Three skills share one rule set, and each skill folder is fully self-contained:

- `/devdoc-review` checks a document against the style rules and reports the findings as a structured checklist. It never edits anything.
- `/devdoc-fix` runs the same checks, proposes a diff, and applies changes only after you confirm.
- `/devdoc-draft` writes a new document from scratch, applying the rules as it composes.

A finding looks like this—taken from a real review of this README:

> **", etc."** — violates *Word list: etc. → list the actual examples*. Suggested fix: the examples are already enumerated; end the list at "and detailed HTML semantics".

That same review caught a 55-word opening sentence, three substantive parentheticals, and 21 spaced em dashes.

## Requirements

- A host that loads skills in `SKILL.md` format. Claude Code, ZCode, and Codex CLI are covered—see [Cross-tool support](#cross-tool-support) for the per-tool status.
- English documents. The rules are written for English technical prose—the skills decline documents in other languages rather than force-fitting English rules onto them.

## Install

The fastest way to install all three skills is the skills CLI (verified with Claude Code):

```
npx skills add yikyam66/google-tech-docs-writer
```

To install manually instead, clone this repository, then create one symlink per skill per host. Claude Code discovers a skill only when the `SKILL.md` file sits directly inside `~/.claude/skills/<name>/`, where `<name>` is the skill folder name, for example `devdoc-review`. From this repository's root, run:

```
ln -s "$(pwd)/devdoc-review" ~/.claude/skills/devdoc-review
ln -s "$(pwd)/devdoc-fix" ~/.claude/skills/devdoc-fix
ln -s "$(pwd)/devdoc-draft" ~/.claude/skills/devdoc-draft
```

ZCode doesn't scan `~/.claude/skills/`, so a Claude Code install is invisible to ZCode—each host needs its own set of symlinks. Create a parallel set in `~/.agents/skills/`:

```
ln -s "$(pwd)/devdoc-review" ~/.agents/skills/devdoc-review
ln -s "$(pwd)/devdoc-fix" ~/.agents/skills/devdoc-fix
ln -s "$(pwd)/devdoc-draft" ~/.agents/skills/devdoc-draft
```

Start a new session after installing—newly installed skills appear in the available-skills list only in a new session.

## Usage

For a step-by-step walkthrough, see [getting-started.md](getting-started.md) (Chinese translation: [getting-started.zh-CN.md](getting-started.zh-CN.md)). The three skills are:

- `/devdoc-review`—non-destructive. Reads a document, checks it against the style rules, and reports findings as a structured Markdown checklist (location, rule violated, suggested fix). Does not edit anything.
- `/devdoc-fix`—runs the same checks, then proposes a diff. Applies changes only after you confirm.
- `/devdoc-draft`—generates a new document in this style from scratch, for a user's target project. Gathers facts from the user's description and the target repo (anything unverifiable becomes an explicit `TODO:` placeholder—it never invents facts), proposes an outline for confirmation, drafts while applying the rules natively, self-checks the result against the same rules, and writes the file only after the user confirms the target path.

## What the rules cover

The full Google style guide runs to roughly 70 pages, and most of its rules rarely apply to any single document. This project encodes a curated, high-impact subset as four reference files:

| File | Covers |
|---|---|
| `core-rules.md` | Voice and tone, active voice, person, tense, inclusive language, accessibility, headings, lists, punctuation, numbers and units |
| `word-list.md` | Around 100 high-frequency terms—preferred form versus avoided form, with the reason for each |
| `code-and-commands.md` | Code in prose, placeholders, command-line syntax, UI labels |
| `error-messages.md` | Writing helpful error messages; loaded only when a document contains error-message text, error-code tables, or UI strings |

## Editing the rules

Edit the canonical copies in `references/`—never the copies inside `devdoc-*/references/`. After changing a rule, run the sync script from this repository's root before you test or commit:

```
./scripts/sync-references.sh
```

The script copies the four reference files into each skill folder. The copies are generated—don't hand-edit them. Each skill folder is fully self-contained (no path ever reaches outside its own folder), which is what makes folder-level symlinks and the skills-CLI install work; the design history behind that choice is in [DESIGN.md](DESIGN.md).

## Cross-tool support

The project targets the following tools:

| Tool | Mechanism | Status |
|---|---|---|
| Claude Code | `SKILL.md` + `references/*.md`, loaded on demand; symlink into `~/.claude/skills/<name>/` | native—built here |
| ZCode | Same skill format; discovered from `<project>/.zcode/skills/`, `<project>/.agents/skills/`, `~/.zcode/skills/`, or `~/.agents/skills/` (it does not scan `~/.claude/skills/`) | native—symlink into `~/.agents/skills/<name>/` |
| Codex CLI | Agent Skills: `.agents/skills/<name>/SKILL.md` + `references/`, same format as Claude Code | drop-in—see `adapters/codex-notes.md` |
| Trae IDE | `.trae/rules/`—a single self-contained Markdown file, no confirmed import mechanism | needs manual inlining or a small build step—see `adapters/trae-notes.md` |
| Any other tool | — | add a new note under `adapters/`; never duplicate rule content by hand—edit `references/` and re-run the sync script |

## Deferred rules (known gaps—deliberately not curated yet)

Rule areas that exist in the source material but aren't in the references: promotion means copying into the right reference file, one small commit—this list exists so "not included" means "considered and deferred", not "unknown".

| Area | Source | One-line rule |
|---|---|---|
| Dates and times | developers.google.com/style/dates-times | 12-hour clock with AM/PM; spell out dates; YYYY-MM-DD if numeric; no seasons |
| Ellipses | /style/ellipses | Avoid outside quotations; never in UI labels |
| Slashes | /style/slashes | Avoid except in code; no "and/or", no slash dates |
| Possessives | /style/possessives | Avoid possessives of product/code names—rewrite |
| Quotation marks | /style/quotation-marks | Straight double quotes; periods inside unless literal strings; singles only in code/nesting |
| Pluralization | /style/pluralization | No 's on abbreviations (APIs); units singular with numbers; no optional "(s)" |
| Capitalization detail | /style/capitalization | All-caps/camel only for official names and code; avoid needless caps |
| Dash grades | /style/dashes | Google avoids en dashes; prefer colons/lists over dash-separated item descriptions |
| Prepositions | /style/prepositions | Ending sentences with one is fine; include clarifying, omit needless |
| Footnotes | /style/footnotes | Avoid; cross-references or notes instead |
| Math notation | /style/mathematical-notation | HTML entities for symbols; italic variables; decimals over fractions |
| Phone numbers | /style/phone-numbers | Reserved 800-555-01xx example range; "+country code" for international |
| Trademarks | /style/trademarks | Owner's guidelines; modifier only with a noun; never verb/possessive |
| HTML semantics | /style/semantic-tagging | Elements for meaning, not appearance; em/strong for emphasis |
| Anchor targets | /style/headings-targets | Stable lowercase-hyphenated IDs; preserve old anchors on rename |
| Illustration craft | /tech-writing/two/illustrations | Caption first (states the takeaway); one paragraph of info per diagram; big picture before subsystems |

## Status

Latest eval iteration (2026-10-08; four evals, one run each with and without the skill, on `claude-sonnet-5`): 100% pass rate with the skill versus 29% without. Iteration 1 scored 96.4% versus 34.3%, and its findings drove the skill-description tightening and two assertion revisions. The eval suite (prompts, fixtures, and graded with/without runs) is maintained in the author's workspace.

The review/fix loop has been exercised twice on real documents—once on an external project, once on this README—and caught non-inclusive terms, time-anchored language, wordy constructions, punctuation problems, and a missing entry in this README's own structure list. `devdoc-draft` drafted this project's getting-started guide, language gate included. The description-trigger evaluation is reasoned but not yet measured against a live CLI. The Codex CLI and Trae IDE adapters are documented but unverified against a live install.
