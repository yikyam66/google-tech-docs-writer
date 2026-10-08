# Get started with the devdoc skills

This guide is for developers who install and use the devdoc skills in Claude Code or ZCode. The devdoc skills are the three skills in the `google-tech-docs-writer` project: `devdoc-review`, `devdoc-fix`, and `devdoc-draft`. This guide covers installation, everyday use of the three skills, and how to update the style rules. It doesn't cover the style rules themselves.

## Overview

The `google-tech-docs-writer` project packages a curated subset of the [Google Developer Documentation Style Guide](https://developers.google.com/style) as reusable skills. The full guide runs to roughly 70 pages, and most of its rules apply to a narrow set of documents. This project encodes the high-impact rules for everyday technical prose.

The project provides three skills, and each skill folder is self-contained:

- `/devdoc-review` checks a document against the style rules and reports the findings as a structured checklist. It doesn't edit anything.
- `/devdoc-fix` runs the same checks, proposes a diff, and applies changes only after you confirm.
- `/devdoc-draft` writes a new document from scratch, applying the rules as it composes.

The rules are written for English technical prose. The skills decline documents in other languages rather than force-fitting English rules onto them.

## Install the skills

The fastest way to install all three skills is the skills CLI (verified with Claude Code):

```
npx skills add yikyam66/google-tech-docs-writer
```

To install manually instead, clone this repository. Claude Code and ZCode discover skills in different directories, and each host needs its own symlink to the same skill folder. You create symlinks instead of copies, so a rule change in the repository reaches every host.

Claude Code discovers a skill only when the `SKILL.md` file sits directly inside `~/.claude/skills/<name>/`, where `<name>` is the skill folder name, for example `devdoc-review`. From the repository root, create one symlink per skill:

```
ln -s "$(pwd)/devdoc-review" ~/.claude/skills/devdoc-review
ln -s "$(pwd)/devdoc-fix" ~/.claude/skills/devdoc-fix
ln -s "$(pwd)/devdoc-draft" ~/.claude/skills/devdoc-draft
```

ZCode doesn't scan `~/.claude/skills/`, so a Claude Code install is invisible to ZCode. The commands here use the user-level `~/.agents/skills/` directory. Create a parallel set of symlinks:

```
ln -s "$(pwd)/devdoc-review" ~/.agents/skills/devdoc-review
ln -s "$(pwd)/devdoc-fix" ~/.agents/skills/devdoc-fix
ln -s "$(pwd)/devdoc-draft" ~/.agents/skills/devdoc-draft
```

Start a new session after you install the skills. Newly installed skills appear in the available-skills list only in a new session.

## Review or fix an existing document

Use `/devdoc-review` when you want a report of the problems, and `/devdoc-fix` when you want proposed edits.

The review skill reads a document, checks it against the style rules, and reports each finding with the location, the violated rule, and a suggested fix. It doesn't edit anything. Findings cite the rule name, for example "Active voice", so you can look up the rule in the reference files.

The fix skill runs the same checks, then proposes a diff. It applies changes only after you confirm.

## Draft a new document

Use `/devdoc-draft` to write a new document in the house style. Describe what the document is for and who reads it, and point the skill at the target repository.

The skill follows these steps:

1. It gathers facts from your description and the target repository.
2. It proposes an outline and waits for your confirmation.
3. It drafts the document, applying the rules as it writes.
4. It self-checks the draft against the same rules and fixes what it finds.
5. It writes the file only after you confirm the target path.

Anything the skill can't verify becomes an explicit `TODO:` placeholder in the draft. It never invents facts, numbers, or quotes.

The rules apply to English documents only. If you request a document in another language, the skill declines before reading any rule files rather than force-fitting English rules onto your document.

## Update the style rules

Edit the rule files in the top-level `references/` folder only. This folder holds the canonical copies of four files: `core-rules.md`, `word-list.md`, `code-and-commands.md`, and `error-messages.md`.

Each skill folder carries its own copy of these files. Some hosts resolve a relative path against the symlink's apparent location rather than its real target. A skill that reaches outside its own folder with `../` breaks on those hosts, so the copies remove that dependency.

After you edit a rule, run the sync script from the `google-tech-docs-writer` folder before you test or commit the change:

```
./scripts/sync-references.sh
```

The script copies the four reference files into each skill folder. Don't edit the copies by hand—the sync script overwrites them.

## Port to another tool

The project documents two ports under `adapters/`: `codex-notes.md` for Codex CLI, and `trae-notes.md` for Trae IDE, which has no confirmed import mechanism and needs manual inlining. Both adapters are unverified against a live install.

Whichever tool you target, don't duplicate rule content by hand. Edit the files in `references/` and re-run the sync script.
