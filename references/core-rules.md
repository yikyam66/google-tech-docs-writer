# Core rules (v1)

Condensed from the Google Developer Documentation Style Guide (developers.google.com/style). Each rule gives the actionable check plus a do/don't example where the source guide provides one. Cite the specific rule name when reporting a violation (e.g. "Active voice", "Inclusive language") so the reader can look it up.

## Voice and tone

- Conversational and friendly, not jokey or stiff. Avoid slang, internet abbreviations (tl;dr, ymmv), culture-specific references, and metaphors/idioms.
- Don't use "please" in instructions: "To view the document, click **View**." not "Please click View."
- Avoid filler like "simply", "just", "it's easy" — what's easy for the writer may not be for the reader.
- Avoid hedging boilerplate ("please note", "at this time") and exclamation points in reference/conceptual docs.

## Active voice

- The subject of the sentence should be the thing performing the action.
  - Do: "Send a query to the service. The server sends an acknowledgment."
  - Don't: "The service is queried, and an acknowledgment is sent."
- Passive voice is acceptable only when the actor is genuinely irrelevant or you're deliberately emphasizing the object.

## Second person and point of view

- Address the reader as "you", not "we"/"our", except when referring to the authoring org itself ("Our support team can help you").
- Use imperative mood for instructions: "Click **Submit**." (the "you" is implied).
- Describe software/system behavior in third person, not second person.

## Present tense

- Use present tense for anything that describes general, timeless behavior: "The server sends an acknowledgment" not "will send".
- Future tense is fine only for things that genuinely happen later in a sequence: "The file will be archived the next time the backup process runs."
- Don't describe hypothetical behavior with "would" — say what happens, not what would happen.

## Inclusive language

- No gendered defaults: singular "they", not "he/she"; "person-hours" not "man-hours".
- Replace ableist or violent idioms: "baffling" not "crazy", "doesn't respond" not "hangs", "click" not "hit".
- Replace non-inclusive pairs: blacklist/whitelist → denylist/allowlist/blocklist; master/slave → primary/replica (or parent/replica). If the term appears literally in code/API output that can't be changed, format it as code and still use the preferred term in prose around it.
- Avoid subjective, judgment-laden words like "simple", "easy", "obviously", "just" — they can read as condescending and are often untrue for some readers.
- Diversify example names, genders, ages, and regions. Use "older adults" not "elderly"/"seniors".

## Accessibility basics

- Keep sentences short (rule of thumb: under ~26 words) and avoid double negatives.
- Every image needs alt text; purely decorative images get empty alt (`alt=""`). Never convey essential information through an image alone.
- Link text must make sense out of context — never "click here"; state what the link leads to.
- Heading levels must be sequential (don't skip from h2 to h4) and headings must be unique and descriptive.
- Text/background contrast should be at least 4.5:1. Never use color alone to convey meaning.

## Headings

- Sentence case everywhere (capitalize only the first word, proper nouns, and the word after a colon). No trailing period.
- Task-based headings use the imperative: "Create an instance." Conceptual headings use a noun phrase: "Migration to Google Cloud."
- Exactly one `h1` per page; never skip a heading level; never leave a heading with no content under it.
- Don't put inline code, links, or numbering inside a heading.

## Lists

- Use a numbered list for sequential/ordered steps, a bulleted list for unordered options, and a description list for term+definition pairs.
- Introduce every list with a complete sentence ending in a colon: "Use the Submit button for any of the following purposes:" not "Use the Submit button to:".
- Keep list items grammatically parallel (same structure across items).
- Capitalize the first word of each item (unless case is semantically significant, e.g. code). Add end punctuation only to items that are full sentences / contain a verb.
- Don't end a list with "etc." or "and so on"; don't write a list with only one item.

## Punctuation essentials

- **Oxford comma**: always use it in a series of three or more ("zones, regions, and multi-regions").
- **Colons**: what precedes the colon must be a complete sentence; the word after the colon is normally lowercase.
- **Em dash**: no spaces around it, used for a break in thought; don't substitute a hyphen or en dash.
- **Hyphens**: hyphenate compound modifiers before a noun ("well-designed app"); don't hyphenate after a linking verb ("the app is well designed") unless the compound is conventionally hyphenated (cloud-based).
- **Periods**: every complete sentence ends with one, except list items that aren't full sentences and headings/titles. Period goes inside closing quotation marks.
- **Semicolons**: avoid by default; acceptable only to join two very tightly related independent clauses, before a conjunctive adverb ("therefore"), or to separate complex list items that already contain commas.
- Avoid parentheses for anything important — readers skip over them. Prefer a dash, comma, or a separate sentence instead.

## Numbers and units

- Spell out zero through nine in running text; use numerals for 10 and up — except version numbers, measurements (memory/disk/etc.), prices, and step numbers, which are always numerals regardless of size.
- Percentages: numeral + "%" ("40%"); spell both out only if the number starts a sentence.
- Put a non-breaking space between a number and its unit ("64 GB"), except for currency, percentages, and angles.
- Number ranges use a hyphen ("2012-2016"); unit ranges repeat the unit and use "to", not a hyphen ("-40°C to 85°C").
- Distinguish decimal units (kB, MB, GB — base 1000) from binary units (KiB, MiB, GiB — base 1024); never mix the two systems for the same quantity.
