---
name: perl-string-util
description: The perl-string-util tool provides a collection of functions for common string processing tasks such as whitespace management, content validation, and data sanitization. Use when user asks to trim whitespace, collapse internal spaces, validate string content, perform safe equality comparisons, or sanitize strings for HTML and filenames.
homepage: http://metacpan.org/pod/String::Util
metadata:
  docker_image: "quay.io/biocontainers/perl-string-util:1.26--pl5.22.0_0"
---

# perl-string-util

## Overview

The `perl-string-util` skill leverages the `String::Util` module to simplify repetitive string handling tasks. It is designed to replace manual regex-based cleaning with named functions that handle edge cases—such as `undef` values or strings containing only whitespace—more gracefully than standard Perl built-ins. It is particularly effective for data sanitization, preparing strings for web output, and performing safe equality comparisons.

## Usage Patterns

### Importing Functions
Functions are not exported by default. You must specify them or use the `:all` tag.

```perl
use String::Util qw(:all);
# Or specific functions
use String::Util qw(trim hascontent collapse);
```

### Whitespace Management
*   **`trim($string)`**: Removes leading and trailing whitespace. Use `ltrim` or `rtrim` for specific sides.
*   **`collapse($string)`**: Reduces all internal whitespace to single spaces and trims the ends. Ideal for normalizing multi-line text into a single line.
*   **`nospace($string)`**: Removes *all* whitespace characters, including those between words.
*   **`crunchlines($string)`**: Compacts multiple consecutive newlines into a single newline.

### Content Validation
Standard Perl truthiness can be tricky (e.g., the string "0" is false). Use these for clearer logic:
*   **`hascontent($scalar)`**: Returns true if the string is defined and contains non-whitespace characters.
*   **`nocontent($scalar)`**: The inverse of `hascontent`.

### Safe Comparisons
*   **`eqq($a, $b)`**: Returns true if both are equal or if both are `undef`. This avoids "unitialized value" warnings.
*   **`neqq($a, $b)`**: Returns true if the values are different (handling `undef` safely).

### Formatting and Escaping
*   **`htmlesc($string)`**: Prepares a string for HTML output. Unlike some other modules, it converts `undef` to an empty string rather than leaving it undefined.
*   **`jsquote($string)`**: Escapes single quotes and wraps the string in single quotes for JavaScript.
*   **`unquote($string)`**: Removes surrounding quotes (single or double) only if they match. Use `unquote($str, braces => 1)` to also handle `[]`, `{}`, and `()`.

### Data Sanitization
*   **`sanitize($string, $separator)`**: Replaces all non-alphanumeric characters with a separator (default is `_`). Useful for generating clean filenames or URL slugs.

## CLI One-Liner Examples

You can use these utilities directly from the command line for quick file processing:

**Trim every line in a file:**
```bash
perl -MString::Util=trim -ne 'print trim($_) . "\n"' input.txt
```

**Sanitize strings for filenames:**
```bash
echo "My Document (2023)!" | perl -MString::Util=sanitize -ne 'print sanitize($_)'
# Output: My_Document__2023__
```

**Filter lines that actually have content (ignoring whitespace-only lines):**
```bash
perl -MString::Util=hascontent -ne 'print if hascontent($_)' input.txt
```

## Reference documentation
- [String::Util - String processing utility functions](./references/metacpan_org_pod_String__Util.md)
- [perl-string-util - bioconda overview](./references/anaconda_org_channels_bioconda_packages_perl-string-util_overview.md)