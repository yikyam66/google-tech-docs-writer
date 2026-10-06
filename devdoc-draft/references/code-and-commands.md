# Code and commands (v1)

The part of the guide specific to developer-facing docs: code in prose, placeholders, and command-line syntax.

## Code in text

- Anything that is code — method names, variables, file names, class names, HTTP status codes, literal strings, flags — gets code font (backticks in Markdown).
- Don't add extra styling (bold, italics) on top of code font for emphasis.
- A code term used as a regular English word (not referring to the literal identifier) is not put in code font.

## Placeholders

- A placeholder a reader must replace with their own value is italicized (or wrapped in angle brackets in a command, e.g. `<PROJECT_ID>`), not left looking like literal text.
- Explain every placeholder near its first use: what it represents, and any constraints (format, allowed characters).
- Don't mix the placeholder convention (angle brackets vs. italics vs. UPPER_SNAKE_CASE) within the same document — pick one and keep it consistent.

## Command-line syntax

- Square brackets `[ ]` mark optional arguments; no brackets for required ones.
- A pipe `|` inside brackets separates mutually exclusive choices: `[--format=json|yaml]`.
- Ellipsis `...` after an argument means it can repeat: `FILE...`.
- Show the command exactly as a reader would type it — don't include a `$` shell prompt prefix inside the code block unless showing output alongside it, and don't include the output in the same block as the command unless clearly separated.

## UI elements and interaction

- Name of a UI element (button, menu item, field label) matches the actual on-screen text, in bold: click **Save**.
- Chained menu selections use `>`: "Click **File > New > Document**."
- Don't describe keyboard shortcuts as the primary method unless the UI has no visible equivalent.
- Don't use directional language ("the button on the right", "above") — UI layout varies by viewport and changes over time.
