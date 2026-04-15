---
name: perl-text-balanced
description: This tool extracts balanced substrings, nested brackets, and tagged text from strings while handling Perl-specific syntax. Use when user asks to extract nested parentheses, parse delimited quotes, identify Perl code blocks, or handle tagged XML-style structures.
homepage: https://metacpan.org/pod/Text::Balanced
metadata:
  docker_image: "quay.io/biocontainers/perl-text-balanced:2.07--pl5321hdfd78af_0"
---

# perl-text-balanced

## Overview
Text::Balanced provides a suite of functions to identify and extract substrings bounded by specific delimiters. It is specifically designed to handle nested structures—such as nested parentheses or tags—and understands Perl-specific syntax like quote-like operators and variable names. It operates based on the current match position (`pos`) of a string, making it ideal for building lexers or incremental parsers.

## Core Extraction Functions

### Extract Brackets and Quotes
*   **extract_bracketed($text, $delims)**: Extract substrings enclosed in `()`, `[]`, `{}`, or `<>`. It correctly handles nested brackets of the same type.
*   **extract_delimited($text, $delims)**: Extract substrings starting and ending with the same delimiter (e.g., single or double quotes). It handles escaped delimiters within the string.
*   **extract_quotelike($text)**: Specifically designed to extract Perl quote-like operations (e.g., `q//`, `qq//`, `s///`, `tr///`).

### Extract Tags and Code
*   **extract_tagged($text, $start, $end)**: Extract text between a start tag and an end tag. By default, it handles XML-style tags.
*   **extract_codeblock($text, $delims)**: Extract a block of Perl code, typically starting with a brace `{`.
*   **extract_variable($text)**: Extract a Perl variable name, including prefixes like `$`, `@`, `%`, or `*`.

### Advanced Extraction
*   **extract_multiple($text, [ $sub_refs ])**: Apply a sequence of different extraction functions or regular expressions to a string until no more can be extracted.

## Contextual Behavior
The behavior of these functions changes significantly depending on the calling context:

*   **List Context**: Returns a list: `($extracted, $remainder, $prefix)`.
    *   `$extracted`: The text found (including delimiters).
    *   `$remainder`: The rest of the string after the extracted part.
    *   `$prefix`: Any skipped whitespace or text before the match.
    *   **Note**: The original input string is NOT modified.
*   **Scalar Context**: Returns only the `$extracted` string.
    *   **Note**: The extracted part and any prefix are physically removed from the original input string variable.

## Best Practices and Tips

### Handling Prefixes
By default, functions skip leading whitespace (`\s*`). To skip a different pattern, provide it as the third argument. If your prefix needs to match across multiple lines, use the `(?s)` modifier:
```perl
# Skip everything up to an H1 tag, including newlines
($extracted, $remainder) = extract_tagged($text, "H1", "/H1", '(?s).*?(?=<H1>)');
```

### Performance Optimization
If you are extracting the same tags repeatedly in a loop, use `gen_extract_tagged` to create a pre-compiled, optimized anonymous subroutine:
```perl
my $extract_div = gen_extract_tagged('<div>', '</div>');
while (my $div = $extract_div->($html)) {
    # Process $div
}
```

### Anchoring Logic
These functions do not search the entire string for the first occurrence. They attempt to match immediately at the current `pos()` of the string (or the start of the string if `pos` is not set). This is equivalent to using the `\G` anchor in regular expressions.

## Reference documentation
- [Text::Balanced - Extract delimited text sequences from strings.](./references/metacpan_org_pod_Text__Balanced.md)