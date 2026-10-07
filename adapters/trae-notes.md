# Porting to Trae IDE

Trae doesn't have a packaged skill system — its equivalent is `.trae/rules/` (project-scoped) or `~/.trae/user_rules.md` (global), a single self-contained Markdown file per rule set, read directly by the agent. No confirmed mechanism for one rules file to `@import`/include another file by relative path, so this adapter can't just point at `references/` the way the Claude Code and Codex versions do.

## Options

1. **Manual inline (v1 — do this first)**: concatenate `references/core-rules.md` + `word-list.md` + `code-and-commands.md` plus a short "how to use this" preamble (adapted from `devdoc-review/SKILL.md` and `devdoc-fix/SKILL.md`) into one file, saved as `.trae/rules/dev-docs-style.md` (project) or `~/.trae/user_rules.md` (global). Update by hand whenever the canonical `references/` changes — acceptable at this project's current size.
2. **Small build script (later, if `references/` starts changing often)**: a short script that concatenates the `references/*.md` files plus a fixed preamble into `.trae/rules/dev-docs-style.md`, run manually after edits. Not built yet — not worth the overhead until rule changes become frequent enough that manual re-sync gets error-prone.

## Caveats

- Trae's rules files don't appear to support a "review-only vs. fix" mode switch the way two separate Claude Code/Codex skills do — the single rules file will need to tell the agent to ask the user which mode they want, or default to review-only and require an explicit ask to apply fixes.
- Unconfirmed: whether Trae supports per-file "Application Mode" (Always On vs. Agent Requested) for finer control over when this rule set loads. Check the current Trae docs before relying on it.
