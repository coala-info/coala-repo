---
name: perl-string-escape
description: This tool provides functions for escaping, unescaping, quoting, and truncating strings using various backslash and word-boundary conventions. Use when user asks to backslash escape control characters, unquote strings, truncate text with elision, or convert between lists and space-separated quoted strings.
homepage: http://metacpan.org/pod/String::Escape
metadata:
  docker_image: "quay.io/biocontainers/perl-string-escape:2010.002--pl526_0"
---

# perl-string-escape

## Overview
The `perl-string-escape` skill provides a robust interface for common string transformation tasks that go beyond Perl's built-in functions. It excels at "printable" conversions (making control characters visible as backslash sequences), "unprintable" conversions (restoring original characters), and intelligent quoting that only wraps strings containing spaces or punctuation. It also includes a flexible elision tool for truncating text while respecting word boundaries.

## Usage Patterns

### Backslash Escaping and Unescaping
Use these functions to toggle between raw binary/control data and human-readable backslash sequences.

```perl
use String::Escape qw( backslash unbackslash qqbackslash );

# Convert tabs/newlines to literal \t and \n
my $escaped = backslash("Data\twith\nnewlines");

# Convert backslash sequences back to raw characters
my $raw = unbackslash($escaped);

# Escape and wrap in double quotes simultaneously
my $quoted_escaped = qqbackslash("Secret\tData");
```

### Intelligent Quoting
Manage quotes for shell-like arguments or CSV-style data.

*   `quote($val)`: Always adds double quotes.
*   `quote_non_words($val)`: Only adds quotes if the string contains spaces or special characters.
*   `unquote($val)`: Removes surrounding double quotes if present.

### String Elision (Truncation)
Truncate long strings to a specific length while optionally preserving word integrity.

```perl
use String::Escape qw( elide );

# Basic truncation to 20 chars (includes '...')
print elide($long_string, 20);

# Truncate to 20 chars, but don't break words (strictness = 10)
print elide($long_string, 20, 10);

# Hard truncation at exactly 20 chars (strictness = 0)
print elide($long_string, 20, 0);
```

### List and Hash Processing
Convert between Perl arrays and space-separated, quoted strings.

```perl
use String::Escape qw( list2string string2list );

my @args = ('file name.txt', 'simple_word', 'another phrase');
my $string = list2string(@args); 
# Result: "file name.txt" simple_word "another phrase"

my @parsed = string2list($string);
```

### The escape() Dispatcher
For dynamic workflows where the transformation type is determined at runtime.

```perl
use String::Escape qw( escape );

# Apply multiple transformations in order (e.g., lowercase then quote)
my $result = escape('lowercase quote', "Hello World");

# Apply to a list of values
my @processed = escape('printable', @raw_data);
```

## Expert Tips
*   **Legacy vs. Modern**: Prefer `backslash()` over `printable()`. The `backslash` family supports standard hex (`\xHH`) and octal escapes, whereas the legacy `printable` functions use a non-standard format.
*   **Custom Escapes**: You can register your own functions into the `escape()` dispatcher using `String::Escape::add('my_rule', \&my_func)`.
*   **Context Awareness**: The `escape()` function is context-sensitive. In scalar context, it returns one string; in list context, it processes and returns an array.

## Reference documentation
- [String::Escape - Backslash escapes, quoted phrase, word elision, etc.](./references/metacpan_org_pod_String__Escape.md)