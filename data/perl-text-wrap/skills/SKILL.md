---
name: perl-text-wrap
description: This tool formats text into paragraphs by wrapping lines at word boundaries with customizable indentation and column widths. Use when user asks to wrap text at specific widths, format paragraphs with first-line or hanging indents, or process text for fixed-width displays.
homepage: http://metacpan.org/pod/Text::Wrap
metadata:
  docker_image: "quay.io/biocontainers/perl-text-wrap:2021.0814--pl5321hdfd78af_0"
---

# perl-text-wrap

## Overview

The `perl-text-wrap` skill provides a mechanism for intelligent paragraph formatting. Unlike basic text cutters, it breaks lines at word boundaries and allows for independent control over the indentation of the first line versus subsequent lines. It is highly effective for preparing text for fixed-width displays, such as terminal outputs or legacy system imports, and correctly handles Unicode combining characters to ensure visual alignment.

## Usage Patterns

Since `Text::Wrap` is a Perl module, it is most commonly invoked from the command line using Perl one-liners to process STDIN or files.

### Basic Paragraph Wrapping
Wrap text at the default 76-column width with no indentation:
```bash
perl -MText::Wrap -e 'print wrap("", "", <>)' input.txt
```

### Formatting with Indentation
To create a "book-style" paragraph where the first line is tabbed and subsequent lines are flush left:
```bash
perl -MText::Wrap -e 'print wrap("\t", "", <>)' input.txt
```

To create a "hanging indent" (common for bibliographies or lists):
```bash
perl -MText::Wrap -e 'print wrap("", "    ", <>)' input.txt
```

### Adjusting Column Width
Set a custom line length (e.g., 50 characters). Note that the module wraps at `$columns - 1`:
```bash
perl -MText::Wrap -e '$Text::Wrap::columns=50; print wrap("", "", <>)' input.txt
```

### Multi-Paragraph Processing
Use `fill()` instead of `wrap()` to process multiple paragraphs. `fill()` looks for whitespace after a newline to identify paragraph breaks and collapses internal whitespace:
```bash
perl -MText::Wrap -e 'print fill("  ", "", <>)' input.txt
```

### Handling Long Words
Control how the tool behaves when a single word is longer than the allowed column width using the `$huge` variable:
- `wrap` (default): Breaks the word.
- `overflow`: Keeps the long word intact, exceeding the column limit.
- `die`: Aborts execution.

Example for overflow:
```bash
perl -MText::Wrap -e '$Text::Wrap::huge="overflow"; print wrap("", "", <>)' input.txt
```

## Expert Tips

- **Tab Handling**: By default, the tool expands tabs to spaces on input and "unexpands" them back to tabs on output. To disable the conversion of spaces back to tabs, set `$Text::Wrap::unexpand = 0`.
- **Custom Break Points**: You can change what characters constitute a word break by modifying `$Text::Wrap::break`. For example, to break at colons as well as spaces, use `[\s:]`.
- **Custom Separators**: If you need to output lines separated by something other than a newline (like a pipe or a HTML break), set `$Text::Wrap::separator`.

## Reference documentation
- [Text::Wrap - line wrapping to form simple paragraphs](./references/metacpan_org_pod_Text__Wrap.md)