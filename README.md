# dev-docs-style

A portable skill based on Google's public technical-writing resources. The primary source is the [Google Developer Documentation Style Guide](https://developers.google.com/style). Targeted material from Google's [Technical Writing courses](https://developers.google.com/tech-writing) enters where it directly serves the same goal—for example, writing helpful error messages and illustration craft. The skill reviews, fixes, and drafts developer-facing technical documentation for voice, grammar, punctuation, accessibility, inclusive language, and formatting.

## Why this exists

The full Google style guide runs to roughly 70 pages, and the Technical Writing courses add more on top of that. Most of it rarely applies to any single document. This project encodes a curated, high-impact subset as a reusable skill, drawing from whichever Google resource covers a given concern best—the style guide for prose conventions, the Technical Writing courses for subject areas like error-message writing. Niche rules—math notation, footnotes, phone numbers, trademarks, and detailed HTML semantics—are deliberately left out of v1. They can be added later if they turn out to matter in practice. See the "Deferred" table below for what's been considered and left out, with its source for each.

## Structure

```
dev-docs-style/
├── README.md
├── references/                 # canonical/master copy—edit rules here
│   ├── core-rules.md           # voice/tone, active voice, person, tense, inclusive language,
│   │                           # accessibility basics, headings, lists, core punctuation, numbers & units
│   ├── word-list.md            # curated high-frequency terminology (preferred vs. avoided terms)
│   ├── code-and-commands.md    # code-in-text, placeholders, command-line syntax
│   └── error-messages.md       # writing helpful error messages (course-curated; read only when a
│                               # document contains error-message text, error-code tables, or UI strings)
├── scripts/
│   └── sync-references.sh      # copies references/*.md into each skill's own references/ copy
├── devdoc-review/
│   ├── SKILL.md                 # read-only: reports violations as a structured Markdown checklist
│   └── references/              # synced copy—generated, don't hand-edit (run sync-references.sh)
├── devdoc-fix/
│   ├── SKILL.md                 # same checks, but proposes a diff/preview, applies only after confirmation
│   └── references/              # synced copy—generated, don't hand-edit
├── devdoc-draft/
│   ├── SKILL.md                 # generates a new document from scratch: facts from user + repo, outline first,
│   │                           # drafts applying the rules natively, self-checks, writes after path confirmation
│   └── references/              # synced copy—generated, don't hand-edit
└── adapters/
    ├── codex-notes.md           # how to reuse this in Codex CLI (near drop-in)
    └── trae-notes.md            # how to port this to Trae IDE (manual inlining required)
```

Each skill folder (`devdoc-review/`, `devdoc-fix/`, `devdoc-draft/`) is **fully self-contained**—its own `SKILL.md` plus its own `references/` copy, no path ever reaches outside the folder. `references/` at the project root is the canonical copy for editing; after changing a rule there, run `scripts/sync-references.sh` to push it into every skill folder.

### Lessons learned (why it's duplicated, not shared)

v1 had one shared `references/` folder one level above the skill folders, with each `SKILL.md` pointing at it via `../references/...`. Real-world testing—another agent session, installed via the usual `~/.claude/skills/devdoc-review` symlink—showed this breaks: some hosts resolve a relative `../` path against the *symlink's apparent location* rather than the symlink's real target, so `../references/` pointed at a directory that doesn't exist and the read failed. The fix is structural, not a workaround: every skill folder now carries its own copy of the rules and never uses `..` to reach outside itself. The small duplication cost is paid once per rule change via `scripts/sync-references.sh`.

### Lessons learned (routing before skills)

Skill names follow `devdoc-<verb>`: a skill is a *verb the user performs* (review, fix, draft). Error-message writing is a *noun*—a subject area—so it enters as routing (trigger words in each SKILL.md description) plus one gated reference file (`error-messages.md`), not as a fourth skill `devdoc-errors`. Rule of thumb for any future content: classify first (user-facing verb → skill candidate; rule set → reference file; low-frequency/edge → the deferred list), then name. Each change lands as its own commit so it can be reverted independently.

## Cross-tool support

| Tool | Mechanism | Status |
|---|---|---|
| Claude Code | `SKILL.md` + `references/*.md`, loaded on demand; symlink into `~/.claude/skills/<name>/` | native—built here |
| ZCode | Same skill format; discovered from `<project>/.zcode/skills/`, `<project>/.agents/skills/`, `~/.zcode/skills/`, or `~/.agents/skills/` (it does not scan `~/.claude/skills/`) | native—symlink into `~/.agents/skills/<name>/`, see root README |
| Codex CLI | Agent Skills: `.agents/skills/<name>/SKILL.md` + `references/`, same format as Claude Code | drop-in—see `adapters/codex-notes.md` |
| Trae IDE | `.trae/rules/`—a single self-contained Markdown file, no confirmed import mechanism | needs manual inlining or a small build step—see `adapters/trae-notes.md` |
| Any other tool | — | add a new note under `adapters/`; never duplicate rule content by hand, edit `references/` and re-run the sync script |

## Modes

For a user-facing walkthrough of all three modes, see [getting-started.md](../getting-started.md).

- **`/devdoc-review`**—non-destructive. Reads a document, checks it against the style rules, and reports findings as a structured Markdown checklist (location, rule violated, suggested fix). Does not edit anything.
- **`/devdoc-fix`**—runs the same checks, then proposes a diff. Applies changes only after the user confirms.
- **`/devdoc-draft`**—generates a new document in this style from scratch, for a user's target project. Gathers facts from the user's description and the target repo (anything unverifiable becomes an explicit `TODO:` placeholder—it never invents facts), proposes an outline for confirmation, drafts while applying the rules natively, self-checks the result against the same rules, and writes the file only after the user confirms the target path.

## Deferred (known gaps—deliberately not curated yet)

Rule areas that exist in the source material but aren't in the references. Promotion = copy into the right reference file, one small commit—this list exists so "not included" means "considered and deferred", not "unknown".

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

v2. The review/fix loop is tested once on a real project and works well in practice (caught real issues: non-inclusive terms, time-anchored language, passive voice, heading problems, missing alt-text-equivalent for diagrams, etc.). Error-message rules are validated with simulated fresh-session tests (routing 4/4, gating and report shape verified). The v2 rule expansion (procedures, paragraphs, tables, notices, terminology/definitions, grammar essentials, claims; API/sample-code/filename/example rules; ~100-entry grouped word list) passed the same simulated regression tests but is not yet validated on a live project. `devdoc-draft` is built but not yet exercised on a real project. Rules are English-only by design—skip non-English documents rather than force-fitting them. The Codex/Trae adapters are still unverified against a live install.
