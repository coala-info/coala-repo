---
name: r-stringr
description: "A consistent, simple and easy to use set of wrappers around     the fantastic 'stringi' package. All function and argument names (and     positions) are consistent, all functions deal with \"NA\"'s and zero     length vectors in the same way, and the output from one function is     easy to feed into the input of another.</p>"
homepage: https://cloud.r-project.org/web/packages/stringr/index.html
---

# r-stringr

name: r-stringr
description: Comprehensive string manipulation in R using the stringr package. Use this skill when you need to perform consistent, simple, and robust string operations such as detecting patterns, extracting substrings, replacing text, or managing whitespace. It is particularly useful for data cleaning, text mining, and transitioning from base R string functions (grep, sub, etc.) to a more consistent API.

# r-stringr

## Overview
The `stringr` package provides a cohesive set of functions designed to make working with strings as easy as possible. It is built on top of `stringi` but provides a much simpler interface. All functions in `stringr` start with `str_` and take a character vector as the first argument, making them highly compatible with the pipe operator (`%>%` or `|>`).

## Installation
To install the stable version from CRAN:
```r
install.packages("stringr")
library(stringr)
```

## Core Workflows

### 1. Pattern Matching
Most `stringr` functions use regular expressions by default.

- **Detect**: `str_detect(string, pattern)` returns a logical vector.
- **Subset**: `str_subset(string, pattern)` returns only the elements that match.
- **Count**: `str_count(string, pattern)` returns the number of matches per string.
- **Extract**: `str_extract(string, pattern)` gets the first match; `str_extract_all()` gets all matches.
- **Match**: `str_match(string, pattern)` returns a matrix with capture groups.
- **Replace**: `str_replace(string, pattern, replacement)` replaces the first match; `str_replace_all()` replaces all.
- **Split**: `str_split(string, pattern)` splits strings into a list of vectors.

### 2. Subsetting and Mutating
- **Substrings**: `str_sub(string, start, end)` extracts or replaces parts of a string. Use negative indices to count from the right (e.g., `-1` is the last character).
- **Length**: `str_length(string)` returns the number of code points (safer than `nchar()` for factors).
- **Duplication**: `str_dup(string, times)` repeats strings.
- **Flattening**: `str_flatten(string, collapse = "")` collapses a vector into a single string.

### 3. Whitespace Management
- **Trim**: `str_trim(string)` removes leading/trailing whitespace.
- **Squish**: `str_squish(string)` removes leading/trailing whitespace and reduces internal multiple spaces to one.
- **Pad**: `str_pad(string, width, side = "left", pad = " ")` adds characters to reach a fixed width.
- **Wrap**: `str_wrap(string, width)` formats long text into paragraphs.

### 4. Locale Sensitivity
Functions like `str_to_lower()`, `str_to_upper()`, `str_sort()`, and `str_order()` accept a `locale` argument. This is critical for languages with unique rules (e.g., Turkish "i", Dutch "ij", or Lithuanian sorting).

### 5. Pattern Engines
You can wrap your pattern in helper functions to change how it is interpreted:
- `regex(pattern, ignore_case = TRUE, multiline = TRUE, comments = TRUE)`: The default engine.
- `fixed(pattern)`: Exact byte-for-byte match (faster, but ignores human-language rules).
- `coll(pattern, locale = "en")`: Uses standard collation rules (best for case-insensitive non-English text).
- `boundary("word")`: Matches boundaries (character, line, sentence, or word).

## Tips for Success
- **Consistency**: Always put the `string` first and the `pattern` second.
- **NA Handling**: `stringr` functions consistently return `NA` when the input is `NA`.
- **Vectorization**: All functions are vectorized over the string and often over the pattern/replacement arguments.
- **Regex Escaping**: Remember that R strings require double backslashes for regex escapes (e.g., `"\\d"` for a digit).

## Reference documentation
- [From base R](./references/from-base.Rmd)
- [Locale sensitive functions](./references/locale-sensitive.Rmd)
- [Regular expressions](./references/regular-expressions.Rmd)
- [Introduction to stringr](./references/stringr.Rmd)