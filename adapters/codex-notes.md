# Porting to Codex CLI

Codex's "Agent Skills" format is effectively the same open standard as Claude Code's: a directory with `SKILL.md` (frontmatter = `name` + `description` only), optional `references/`/`scripts`/`assets`, discovered from `.agents/skills/` (walking up from cwd), `~/.agents/skills/`, or `/etc/codex/skills/`.

## Steps to install

1. Copy (or symlink) this whole `dev-docs-style/` directory — `references/`, `style-review/`, `style-fix/` — into one of Codex's skill search paths, e.g.:
   - Project-local: `<repo>/.agents/skills/dev-docs-style/`
   - Global: `~/.agents/skills/dev-docs-style/`
2. No path rewriting needed: the relative references (`../references/core-rules.md` etc.) resolve the same way they do under Claude Code, because the directory structure is identical.
3. Codex loads only `name` + `description` up front and the rest on trigger (same progressive-disclosure model), so there's no extra "registration" step beyond the file being present.

## Caveats

- Not yet verified against a live Codex installation — this is based on documented behavior, not a tested install. Confirm `name`/`description` field limits and trigger matching behave the same before relying on it.
- Codex's custom-prompt mechanism (`~/.codex/prompts/*.md`) is deprecated in favor of Agent Skills — don't use that path for this.
