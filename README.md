# dev-docs-style

A portable style-guide skill based on the [Google Developer Documentation Style Guide](https://developers.google.com/style). It reviews (and optionally fixes) technical documentation for voice, grammar, punctuation, accessibility, inclusive language, and formatting.

## Why this exists

The full Google style guide runs to roughly 70 pages. Most of it rarely applies to any single document. This project encodes a curated, high-impact subset as a reusable skill. Niche rules (math notation, footnotes, phone numbers, trademarks, detailed HTML semantics, etc.) are deliberately left out of v1 — they can be added later if they turn out to matter in practice.

## Structure

```
dev-docs-style/
├── README.md
├── references/              # single source of truth — tool-agnostic plain Markdown
│   ├── core-rules.md        # voice/tone, active voice, person, tense, inclusive language,
│   │                        # accessibility basics, headings, lists, core punctuation, numbers & units
│   ├── word-list.md         # curated high-frequency terminology (preferred vs. avoided terms)
│   └── code-and-commands.md # code-in-text, placeholders, command-line syntax
├── style-review/
│   └── SKILL.md             # read-only: reports violations as a structured Markdown checklist
├── style-fix/
│   └── SKILL.md             # same checks, but proposes a diff/preview, applies only after confirmation
└── adapters/
    ├── codex-notes.md        # how to reuse this in Codex CLI (near drop-in)
    └── trae-notes.md         # how to port this to Trae IDE (manual inlining required)
```

Every tool adapter (`style-review/SKILL.md`, `style-fix/SKILL.md`, and anything under `adapters/`) is a thin pointer into `references/`. The actual rules live in exactly one place, so updating a rule never means updating it three times.

## Cross-tool support

| Tool | Mechanism | Status |
|---|---|---|
| Claude Code | `SKILL.md` + `references/*.md`, loaded on demand | native — built here |
| Codex CLI | Agent Skills: `.agents/skills/<name>/SKILL.md` + `references/`, same format as Claude Code | drop-in — see `adapters/codex-notes.md` |
| Trae IDE | `.trae/rules/` — a single self-contained Markdown file, no confirmed import mechanism | needs manual inlining or a small build step — see `adapters/trae-notes.md` |
| Any other tool | — | add a new note under `adapters/`; never duplicate `references/` content |

## Modes

- **`/style-review`** — non-destructive. Reads a document, checks it against `references/`, and reports findings as a structured Markdown checklist (location, rule violated, suggested fix). Does not edit anything.
- **`/style-fix`** — runs the same checks, then proposes a diff. Applies changes only after the user confirms.

## Status

v1 draft — curated core rules only, Claude Code is the primary target. Scope, wording, and the Trae/Codex adapters will be refined as this gets used.
