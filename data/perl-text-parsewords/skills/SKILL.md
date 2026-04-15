---
name: perl-text-parsewords
description: The Text::ParseWords module tokenizes strings into discrete elements while correctly handling nested quotes and escape characters. Use when user asks to parse shell-like command strings, tokenize text with complex quote handling, or split strings into arrays while preserving or removing delimiters.
homepage: http://metacpan.org/pod/Text::ParseWords
metadata:
  docker_image: "quay.io/biocontainers/perl-text-parsewords:3.31--pl5321hdfd78af_0"
---

# perl-text-parsewords

## Overview
The `Text::ParseWords` module provides a robust way to tokenize strings by handling nested quotes and escape characters similarly to a Unix shell. While often used within Perl scripts, it is a standard tool for correctly decomposing complex strings into discrete elements without manually writing fragile regular expressions for quote handling.

## Core Functions and Usage

### 1. Basic Tokenization (`parse_line`)
Use `parse_line($delimiter, $keep, $line)` to split a single string.
- `$delimiter`: A regular expression string (e.g., `'\s+'` for whitespace or `','` for CSV).
- `$keep`: 
    - `0` (False): Removes quotes and backslashes (Bourne shell behavior).
    - `1` (True): Keeps quotes and backslashes in the resulting tokens.
    - `"delimiters"`: Keeps the delimiters themselves as separate tokens in the array.

### 2. Processing Multiple Lines (`quotewords`)
Use `quotewords($delimiter, $keep, @lines)` to process an array of strings and return one flattened list of all tokens found across all lines.

### 3. Preserving Line Structure (`nested_quotewords`)
Use `nested_quotewords($delimiter, $keep, @lines)` when you need to maintain the relationship between lines and tokens. It returns a list of arrays (one array per input line).

### 4. Shell-Compatible Parsing (`shellwords`)
Use `shellwords(@lines)` as a shortcut for `quotewords('\s+', 0, @lines)`. This is the most common method for parsing strings that look like command-line inputs.

## Expert Tips and Best Practices

- **Handling CSV**: While `Text::ParseWords` can handle simple CSV parsing using `parse_line(',', 0, $line)`, for production-grade CSV handling with multi-line fields, use `Text::CSV` instead.
- **Regex Delimiters**: The delimiter is treated as a regex. To split on a literal pipe, use `'\\|'`.
- **Backslash Escaping**: When `$keep` is false, a backslash will escape the next character (e.g., `\"` becomes `"` and `\ ` becomes a literal space).
- **Performance**: If you are only processing a single string, call `parse_line` directly. The `quotewords` functions are wrappers around `parse_line` and add overhead for single-string inputs.

## Examples

### Parsing a Shell Command String
```perl
use Text::ParseWords;
my $command = 'cp -r "My Documents" /backup/\"important\"';
my @args = shellwords($command);
# Result: ('cp', '-r', 'My Documents', '/backup/"important"')
```

### Keeping Delimiters for Reassembly
```perl
use Text::ParseWords;
my $line = 'field1, "field 2", field3';
my @bits = parse_line(',', 'delimiters', $line);
# Result: ('field1', ',', ' "field 2"', ',', ' field3')
```

## Reference documentation
- [Text::ParseWords - parse text into an array of tokens or array of arrays](./references/metacpan_org_pod_Text__ParseWords.md)