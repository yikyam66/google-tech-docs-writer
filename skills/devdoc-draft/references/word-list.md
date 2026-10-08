# Curated word list (v2)

A high-frequency subset of the full Google style-guide word list (~600 entries), grouped by type. Only flag these when they actually appear — don't force a rewrite just to use a "preferred" synonym if the original is already clear.

## Wordiness — prefer the short, direct form

| Avoid | Prefer | Why |
|---|---|---|
| etc. / and so on / and so forth | (list the actual examples, or "including") | vague, implies an undefined remainder |
| simply / just / easily | (omit, or state the step plainly) | what's easy for the writer may not be for the reader |
| very / really | (delete) | intensifiers weaken the claim |
| in order to | to | wordy |
| utilize | use | wordier, no added meaning |
| leverage (as a verb) | use / build on | corporate filler |
| functionality | features / capabilities | vague abstraction |
| performant | fast / efficient | not standard English |
| actionable (for content) | useful / that you can act on | jargon |
| at this point in time | now | wordy |
| is able to / are able to | can | wordy |
| in the event that | if | wordy |
| prior to | before | wordy |
| subsequent to | after | wordy |
| due to the fact that | because | wordy |
| whether or not | whether | "or not" is implied |
| for instance | for example | matches house style |
| copy and paste | copy | pasting is implied |
| access (as a verb) | view / edit / find / open | vaguer, less concrete action word |
| wish | want / need | vague intent |

## Verb, noun, and compound-form distinctions

Keep verbs open ("sign in") and nouns/adjectives closed or hyphenated ("sign-in") — most entries below follow this pattern.

| Avoid | Prefer | Why |
|---|---|---|
| login (as a verb) | sign in (verb) / sign-in (noun, adj) | verb/noun confusion; "sign in" preferred over "log in" |
| log in to (noun sense) | login only as noun/adj; prefer sign-in family | consistency |
| setup (as a verb) | set up (verb) / setup (noun, adj) | verb/noun distinction |
| startup (as a verb) | start up (verb) / startup (noun) | verb/noun distinction |
| timeout (as a verb) | time out (verb) / timeout (noun, adj) | verb/noun distinction |
| failover (as a verb) | fail over (verb) / failover (noun) | verb/noun distinction |
| plug-in (as a verb) / plugin (verb) | plug in (verb) / plugin (noun) / plug-in (adj) | three-form distinction |
| back-end / back end | backend (one word) | house spelling |
| front-end / front end | frontend (one word) | house spelling |
| third-party (as a noun) | third party (noun) / third-party (adj) | verb form doesn't exist; noun is open |
| data flow (as a noun) | dataflow (noun) / data flow (verb phrase) | house spelling |
| hardcoded | hardcoded (adj) / hardcode (verb) — keep forms distinct | consistency |
| life-cycle / life cycle | lifecycle | one word in house style |
| timeframe | period / schedule / deadline | vague; prefer the concrete noun |
| auto-scaling | autoscaling | one word |
| on-premise / on prem | on-premises | correctness |
| datacenter | data center | two words in house style |
| filesystem | file system | two words in house style |
| Internet / Web (capitalized) | internet / web (lowercase) | no caps for common nouns |
| wifi / WiFi | Wi-Fi | official spelling |
| canary (as a verb) | canary (noun, define on first use); never "canarying" | jargon verb |
| e-mail | email | outdated spelling |
| ecommerce / e-commerce | ecommerce | house spelling |
| health care | healthcare | one word |

## Inclusive language

| Avoid | Prefer | Why |
|---|---|---|
| blacklist / whitelist | denylist / allowlist / blocklist | non-inclusive metaphor |
| master / slave | primary / replica (or parent / replica) | non-inclusive metaphor |
| graylist | provisional list / pending list | non-inclusive family |
| grandfathered | legacy / exempt / made an exception | exclusionary metaphor |
| guys | folks / everyone / team | gender-neutral address |
| man-hours | person-hours | gender-neutral |
| manpower | staff / workforce / personnel | gender-neutral |
| manned | crewed / uncrewed (as applicable) | gender-neutral |
| crazy / insane | baffling / unexpected / complicated | ableist language |
| sanity check / sane-check | completeness check / validity check | ableist phrasing |
| cripple(d) | slows down / disables / breaks | ableist metaphor |
| lame (for a feature) | name the actual deficiency precisely | ableist metaphor |
| dumb down | clarify / simplify | ableist metaphor |
| dummy variable / dummy value | placeholder variable / sample value | ableist phrasing |
| hit (a key/button) | click / press | violent metaphor |
| kill / abort / terminate (a process) | stop / exit / cancel / end | violent metaphor |
| hang / hung (software) | stops responding / stopped responding | accurate, non-violent |
| wheelchair-bound / confined to a wheelchair | uses a wheelchair | person-first, accurate |
| suffers from / victim of (a condition) | has / lives with | neutral, not pitiful |
| the disabled / the blind | disabled people / blind people | avoid collective "the + adjective" |
| normal (for nondisabled people) | nondisabled / person without a disability | "normal" frames disability as abnormal |
| elderly / seniors | older adults | neutral, respectful |
| sexy (for software) | name the property (fast, convenient) | unprofessional framing |
| whitehat / blackhat | ethical hacker / malicious attacker, or the precise compliance term | color-coded morality metaphor |

## Developer jargon and slang

| Avoid | Prefer | Why |
|---|---|---|
| foo / bar / baz (in real examples) | meaningful names | examples teach naming habits |
| spin up | create / start | slang |
| lift and shift | name the migration precisely | idiom, untranslatable |
| shift left | move to an earlier phase | idiom, untranslatable |
| pets versus cattle | persistent vs dynamic (define if kept) | idiom |
| out of the box | by default / without additional configuration | idiom |
| single pane of glass | unified view (or name the actual benefit) | idiom |
| blast radius | scope of impact / affected components | jargon |
| ninja / guru / rockstar / sherpa | expert / teacher | title inflation, cultural baggage |
| tribal knowledge | documented knowledge | exclusionary framing |
| war room | incident-management team | violent metaphor |
| jank / janky | laggy / slow / unresponsive | slang |
| mom test | beginner user test | gendered idiom |
| first-class citizen | name the actual property ("higher-order", "nested") | imprecise metaphor, hard to translate |
| TL;DR | To summarize / (delete) | internet slang |
| RTFM | (never) | hostile |

## Abbreviations, spelling, and grammar

| Avoid | Prefer | Why |
|---|---|---|
| i.e. | that is | Latin abbreviations hurt translation and scanning |
| e.g. | for example | same |
| aka | also known as | same |
| vs. | versus | same |
| k8s | Kubernetes | numeronym saves nothing readers need saved |
| NA (meaning not applicable) | N/A | standard form |
| PII, DDoS, MITM, and similar (unexplained) | spell out on first use | not universally known |
| currently / as of this writing / now / soon / eventually / latest | (state the current behavior directly, drop the time anchor) | dates the document; breaks "timeless documentation" |
| enable (meaning "make possible") | "lets you" | "enable" should describe turning a feature on |
| deprecate (confused with removed) | reserve "deprecate" for "no longer recommended"; say "removed" only when gone | precision — not synonyms |
| should (in prescriptive instructions) | "must" (required) / "we recommend" (advisable) / "can" (optional) | "should" is ambiguous |
| data (as a plural) | data (singular/uncountable: "the data is...") | matches house style |
| may (for possibility) | might (possibility) / can (ability) | "may" reads as permission |
| shall | must / (rephrase) | ambiguous legalese |
| is comprised of | comprises / consists of | "is comprised of" is illogical |
| less (with count nouns) | fewer ("fewer instances", "less data") | count vs mass nouns |
| agnostic (for software) | platform-independent | jargon |
| native (for people) | (don't use for people); for software prefer built-in | dated, othering |
| user (when you mean the reader) | you | address the reader directly; "user" only for end users of the reader's software |

If a disallowed term appears verbatim in code, an API name, a CLI flag, or other content you cannot change, format it as code and keep using the preferred term in the surrounding prose rather than silently rewriting the literal value.
