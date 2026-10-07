# Error messages (v1)

Curated from Google's "Writing Helpful Error Messages" course (developers.google.com/tech-writing/error-messages). Apply when the document contains error-message text, error-code tables, or UI strings — whether inline as examples or as a dedicated list.

## Every message answers two questions

- What went wrong, and how does the user fix it. A message that answers only one of the two is incomplete.
- Don't fail into vagueness: "Server error" that swallows the root cause is worse than no message.

## Identify the cause

- Name the specific resource involved: "The directory `logs/` is not writable", not "Operation failed".
- State the requirement that must hold, and explain or link how to satisfy it.
- For invalid input, name the exact field and quantify the problem: "appears 3 times, only one allowed".

## Show the invalid input and the requirement

- The best messages show both halves: "Bid $5 is below the $8 minimum." Either half alone is insufficient.
- State exact constraint values: "Attachment is 14 MB; the limit is 10 MB", never just "file too large".
- For permission errors, name who has access and how to get it: "Only users in `group-x` have access."

## Make it actionable

- Pair the cause with the specific fix step: "…click **Update app**."
- Multiple fixes: list each as a separate action item ("raise the quota" / "switch to another region").
- Provide at least one example of a valid value: "e.g." avoided in prose aside, show it: "Use a format like `robin@example.com`."
- Show incorrect vs. correct code side by side when the fix is syntactic.

## Be concise, not cryptic

- Compress wordy validation errors: "The SiteID `<SiteID>` you have entered is invalid" → "Invalid SiteID `<SiteID>`".
- Don't over-compress into riddles: bare "Unsupported." fails the two-questions test.

## Tone

- Positive framing: "Enter a name", not "You didn't enter a name".
- Don't blame the user: "The specified printer is offline", not "You specified an offline printer".
- Skip over-apology: no "sorry", no "please" in the message body.
- No humor — frustrated users aren't receptive, and jokes misfire across cultures.

## Consistency and formatting

- The same problem produces the identical message everywhere in a product; never vary wording for stylistic variety.
- Place the message as close to the error as possible (e.g. a marker under the offending field).
- Never rely on color alone; pair color with a text cue or symbol.
- Long explanation? Brief message first, link or progressive disclosure for the details.

## Back-end additions

- Include a lookup error code in the message: "Error 409: You already own this bucket."
- Emit a stable error identifier for log parsing; keep it constant even if the message text changes.
