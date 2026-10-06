# Curated word list (v1)

A short, high-frequency subset of the full Google style-guide word list. Only flag these when they actually appear — don't force a rewrite just to use a "preferred" synonym if the original is already clear.

| Avoid | Prefer | Why |
|---|---|---|
| blacklist / whitelist | denylist / allowlist / blocklist | non-inclusive metaphor |
| master / slave | primary / replica (or parent / replica) | non-inclusive metaphor |
| e-mail | email | outdated spelling |
| i.e. / e.g. | "that is" / "for example" | Latin abbreviations hurt translation and scanning |
| etc. | (list the actual examples, or "including") | vague, implies an undefined remainder |
| currently / as of this writing / now / soon / eventually | (state the current behavior directly, drop the time anchor) | dates the document; breaks "timeless documentation" |
| simply / just / easily | (omit, or state the step plainly) | what's easy for the writer may not be for the reader |
| access (as a verb) | view / edit / find / open | vaguer, less concrete action word |
| enable (meaning "make possible") | "lets you" | "enable" should describe turning a feature on, not general capability |
| deprecate | (don't confuse with "removed" / "deleted" / "shut down" — deprecate means "no longer recommended", not gone) | precision — these are not synonyms |
| should (in prescriptive instructions) | "must" (required) / "we recommend" (recommended) / "can" (optional) | "should" is ambiguous between required and merely advisable |
| data (as a plural) | data (singular/uncountable: "the data is...") | matches Google's house style |
| crazy / insane / sane-check | baffling / unusual / sanity-check → "confirm completeness and clarity" | ableist language |
| hit (a key/button) | click / press | more literal, less violent metaphor |
| guys | folks / everyone / team | gender-neutral address |
| man-hours | person-hours | gender-neutral |
| first-class citizen | (name the actual property: "higher-order", "nested", etc.) | imprecise metaphor, hard to translate |
| cripple(s) / crippled | slows down / disables / breaks | ableist metaphor |
| sanity check | completeness/clarity check | ableist phrasing |
| dummy variable/value | placeholder variable/value | ableist phrasing |

If a disallowed term appears verbatim in code, an API name, a CLI flag, or other content you cannot change, format it as code and keep using the preferred term in the surrounding prose rather than silently rewriting the literal value.
