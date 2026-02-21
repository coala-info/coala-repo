---
name: perl-text-tabs-wrap
description: This skill provides methods for text transformation focusing on tab expansion and paragraph wrapping.
homepage: http://metacpan.org/pod/Text::Tabs+Wrap
---

# perl-text-tabs-wrap

## Overview
This skill provides methods for text transformation focusing on tab expansion and paragraph wrapping. It is particularly useful for preparing text for fixed-width displays, cleaning up mixed-tab/space indentation, and formatting long strings into readable blocks with custom lead strings for the first and subsequent lines.

## Core Usage Patterns

### Tab Expansion and Unexpansion
Use `expand` to convert tabs to spaces based on a tab stop (default is 8). Use `unexpand` to convert spaces back to tabs where possible.

```perl
use Text::Tabs;
$tabstop = 4; 
@lines = expand(@lines);   # Columns become spaces
@lines = unexpand(@lines); # Spaces become tabs
```

### Line Wrapping
The `wrap` function breaks long lines into shorter ones. It takes three primary arguments: the indentation for the first line, the indentation for subsequent lines, and the text to wrap.

```perl
use Text::Wrap;
$Text::Wrap::columns = 80; # Set target width
$initial_tab = "\t";       # First line prefix
$subsequent_tab = "";      # Following lines prefix

print wrap($initial_tab, $subsequent_tab, @text);
```

## Expert Tips
- **Column Width**: The default width is 76 columns. Always check `$Text::Wrap::columns` if your output environment (like a specific terminal size) differs.
- **Preserving Newlines**: `wrap()` will treat existing newlines as whitespace unless they are double newlines (paragraph breaks). To preserve specific formatting, process text line-by-line or paragraph-by-paragraph.
- **Lazy Loading**: Since these are standard Perl modules, they are highly efficient for stream processing large log files or documentation buffers.
- **Handling Tabs in Wrap**: It is best practice to run `expand()` on text before passing it to `wrap()` to ensure column calculations are accurate, as `wrap()` counts a tab character as a single column.

## Reference documentation
- [Text::Tabs and Text::Wrap Documentation](./references/metacpan_org_pod_Text__Tabs_Wrap.md)