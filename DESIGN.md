# Design notes

Design history and maintainer rationale for this project—why the rules are duplicated rather than shared, and how new content gets classified. The README covers what the project does and how to use it; this file covers why it is built the way it is.

## Why the rules are duplicated, not shared

v1 had one shared `references/` folder one level above the skill folders, with each `SKILL.md` pointing at it via `../references/...`. Real-world testing—another agent session, installed via the usual `~/.claude/skills/devdoc-review` symlink—showed this breaks: some hosts resolve a relative `../` path against the *symlink's apparent location* rather than the symlink's real target, so `../references/` pointed at a directory that doesn't exist and the read failed. The fix is structural, not a workaround: every skill folder now carries its own copy of the rules and never uses `..` to reach outside itself. The small duplication cost is paid once per rule change via `scripts/sync-references.sh`.

## Routing before skills

Skill names follow `devdoc-<verb>`: a skill is a *verb the user performs* (review, fix, draft). Error-message writing is a *noun*—a subject area—so it enters as routing (trigger words in each SKILL.md description) plus one gated reference file (`error-messages.md`), not as a fourth skill `devdoc-errors`. Rule of thumb for any future content: classify first—user-facing verb → skill candidate; rule set → reference file; low-frequency/edge → the deferred list—then name. Each change lands as its own commit so it can be reverted independently.
