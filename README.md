# dev-docs-style

A portable style-guide skill based on the [Google Developer Documentation Style Guide](https://developers.google.com/style). It reviews (and optionally fixes) technical documentation for voice, grammar, punctuation, accessibility, inclusive language, and formatting.

## Why this exists

The full Google style guide runs to roughly 70 pages. Most of it rarely applies to any single document. This project encodes a curated, high-impact subset as a reusable skill. Niche rules (math notation, footnotes, phone numbers, trademarks, detailed HTML semantics, etc.) are deliberately left out of v1 — they can be added later if they turn out to matter in practice.

## Structure

```
dev-docs-style/
├── README.md
├── references/                 # canonical/master copy — edit rules here
│   ├── core-rules.md           # voice/tone, active voice, person, tense, inclusive language,
│   │                           # accessibility basics, headings, lists, core punctuation, numbers & units
│   ├── word-list.md            # curated high-frequency terminology (preferred vs. avoided terms)
│   └── code-and-commands.md    # code-in-text, placeholders, command-line syntax
├── scripts/
│   └── sync-references.sh      # copies references/*.md into each skill's own references/ copy
├── devdoc-review/
│   ├── SKILL.md                 # read-only: reports violations as a structured Markdown checklist
│   └── references/              # synced copy — generated, don't hand-edit (run sync-references.sh)
├── devdoc-fix/
│   ├── SKILL.md                 # same checks, but proposes a diff/preview, applies only after confirmation
│   └── references/              # synced copy — generated, don't hand-edit
├── devdoc-draft/
│   ├── SKILL.md                 # generates a new document from scratch: facts from user + repo, outline first,
│   │                           # drafts applying the rules natively, self-checks, writes after path confirmation
│   └── references/              # synced copy — generated, don't hand-edit
└── adapters/
    ├── codex-notes.md           # how to reuse this in Codex CLI (near drop-in)
    └── trae-notes.md            # how to port this to Trae IDE (manual inlining required)
```

Each skill folder (`devdoc-review/`, `devdoc-fix/`) is **fully self-contained** — its own `SKILL.md` plus its own `references/` copy, no path ever reaches outside the folder. `references/` at the project root is the canonical copy for editing; after changing a rule there, run `scripts/sync-references.sh` to push it into every skill folder.

### Lessons learned (why it's duplicated, not shared)

v1 had one shared `references/` folder one level above the skill folders, with each `SKILL.md` pointing at it via `../references/...`. Real-world testing (another agent session, installed via the usual `~/.claude/skills/devdoc-review` symlink) showed this breaks: some hosts resolve a relative `../` path against the *symlink's apparent location* rather than the symlink's real target, so `../references/` pointed at a directory that doesn't exist and the read failed. The fix is structural, not a workaround: every skill folder now carries its own copy of the rules and never uses `..` to reach outside itself. The small duplication cost is paid once per rule change via `scripts/sync-references.sh`.

## Cross-tool support

| Tool | Mechanism | Status |
|---|---|---|
| Claude Code | `SKILL.md` + `references/*.md`, loaded on demand | native — built here |
| Codex CLI | Agent Skills: `.agents/skills/<name>/SKILL.md` + `references/`, same format as Claude Code | drop-in — see `adapters/codex-notes.md` |
| Trae IDE | `.trae/rules/` — a single self-contained Markdown file, no confirmed import mechanism | needs manual inlining or a small build step — see `adapters/trae-notes.md` |
| Any other tool | — | add a new note under `adapters/`; never duplicate rule content by hand, edit `references/` and re-run the sync script |

## Modes

- **`/devdoc-review`** — non-destructive. Reads a document, checks it against the style rules, and reports findings as a structured Markdown checklist (location, rule violated, suggested fix). Does not edit anything.
- **`/devdoc-fix`** — runs the same checks, then proposes a diff. Applies changes only after the user confirms.
- **`/devdoc-draft`** — generates a new document in this style from scratch, for a user's target project. Gathers facts from the user's description and the target repo (anything unverifiable becomes an explicit `TODO:` placeholder — it never invents facts), proposes an outline for confirmation, drafts while applying the rules natively, self-checks the result against the same rules, and writes the file only after the user confirms the target path.

## Status

v1. The review/fix loop is tested once on a real project and works well in practice (caught real issues: non-inclusive terms, time-anchored language, passive voice, heading problems, missing alt-text-equivalent for diagrams, etc.). `devdoc-draft` is built (facts-from-repo, outline-first, self-check design) but not yet validated on a real project. Rules are English-only by design — skip non-English documents rather than force-fitting them. The Codex/Trae adapters are still unverified against a live install.
