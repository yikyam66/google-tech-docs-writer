# Porting to Codex CLI

Codex's "Agent Skills" format is effectively the same open standard as Claude Code's: a directory with `SKILL.md` (frontmatter = `name` + `description` only), optional `references/`/`scripts`/`assets`, discovered from `.agents/skills/` (walking up from cwd), `~/.agents/skills/`, or `/etc/codex/skills/`.

## Steps to install

1. Copy (or symlink) each skill folder — `devdoc-review/`, `devdoc-fix/` — individually into one of Codex's skill search paths, e.g.:
   - Project-local: `<repo>/.agents/skills/devdoc-review/`, `<repo>/.agents/skills/devdoc-fix/`
   - Global: `~/.agents/skills/devdoc-review/`, `~/.agents/skills/devdoc-fix/`
2. Each skill folder is self-contained (its own `SKILL.md` + its own `references/` copy, no `..` paths), so this is a plain directory copy — no path rewriting needed regardless of how Codex resolves symlinks.
3. Codex loads only `name` + `description` up front and the rest on trigger (same progressive-disclosure model), so there's no extra "registration" step beyond the files being present.

## Caveats

- Not yet verified against a live Codex installation — this is based on documented behavior, not a tested install. Confirm `name`/`description` field limits and trigger matching behave the same before relying on it.
- Codex's custom-prompt mechanism (`~/.codex/prompts/*.md`) is deprecated in favor of Agent Skills — don't use that path for this.
- If you update the rules, edit `dev-docs-style/references/` and run `dev-docs-style/scripts/sync-references.sh` before re-copying into Codex's skill paths — don't hand-edit the copies inside `devdoc-review/references/` or `devdoc-fix/references/`.
