---
name: r-rematch2
description: "Wrappers on 'regexpr' and 'gregexpr' to return the match     results in tidy data frames.</p>"
homepage: https://cloud.r-project.org/web/packages/rematch2/index.html
---

# r-rematch2

## Overview

`rematch2` is a lightweight wrapper around R's base `regexpr` and `gregexpr` functions. Its primary value is transforming the often-cumbersome nested list structures of base R regex results into tidy `tibbles`.

Key features:
- Returns results as `tibbles`.
- Automatically handles named capture groups as column names.
- Supports both first-match (`re_match`) and all-matches (`re_match_all`) workflows.
- Provides match positions (start/end) via `re_exec` and `re_exec_all`.

## Installation

```r
install.packages("rematch2")
```

## Core Functions

### 1. Basic Matching (`re_match`)
Use `re_match` to extract the first occurrence of a pattern in each element of a character vector.

```r
library(rematch2)

dates <- c("2023-10-01", "2023-12-25", "invalid")
# Use named capture groups for automatic column naming
pattern <- "(?<year>\\d{4})-(?<month>\\d{2})-(?<day>\\d{2})"

result <- re_match(text = dates, pattern = pattern)
# result is a tibble with columns: year, month, day, .text, .match
```

### 2. Global Matching (`re_match_all`)
Use `re_match_all` when a single string might contain multiple matches. The resulting tibble contains list-columns for the capture groups.

```r
text <- "Contact: user1@example.com, user2@test.org"
email_rx <- "(?<user>[^@]+)@(?<domain>[^, ]+)"

result <- re_match_all(text, email_rx)
# Access specific matches
result$user[[1]] # returns c("user1", "user2")
```

### 3. Match Positions (`re_exec` and `re_exec_all`)
These functions return "match records" containing the matched text, start position, and end position.

```r
pos <- re_exec(text = "  Ben Franklin", pattern = "(?<first>\\w+) (?<last>\\w+)")

# Access components using $ on the column
pos$first$match # "Ben"
pos$first$start # 3
pos$first$end   # 5
```

## Workflows and Tips

- **Argument Order**: Unlike the original `rematch` package, `rematch2` uses `text` as the first argument and `pattern` as the second.
- **Column Order**: The `.match` column (the full match) is the last column in the resulting tibble, while capture groups appear first.
- **Missing Values**: If a pattern does not match, the row will contain `NA` for capture groups and `.match`, but will retain the original `.text`.
- **List-Columns**: When using `_all` functions, remember that the output columns are lists. Use `purrr::map` or `tidyr::unnest` to process them further.
- **PCRE**: `rematch2` uses Perl-compatible regular expressions (PCRE) by default, which is required for named capture groups `(?<name>...)`.

## Reference documentation

- [rematch2 README](./references/README.md)