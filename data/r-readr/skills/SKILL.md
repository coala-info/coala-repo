---
name: r-readr
description: "The goal of 'readr' is to provide a fast and friendly way to     read rectangular data (like 'csv', 'tsv', and 'fwf').  It is designed     to flexibly parse many types of data found in the wild, while still     cleanly failing when data unexpectedly changes.</p>"
homepage: https://cloud.r-project.org/web/packages/readr/index.html
---

# r-readr

## Overview
The `readr` package is part of the tidyverse and provides a fast, consistent way to read rectangular data from delimited files. It replaces base R's `read.table` family with functions that are significantly faster, produce tibbles, and do not automatically convert strings to factors.

## Installation
```r
install.packages("readr")
# Or install the whole tidyverse
install.packages("tidyverse")
```

## Main Functions

### Rectangular Parsers
- `read_csv()`: Comma-separated values (CSV) files.
- `read_csv2()`: Semicolon-separated files (common in countries using `,` as a decimal mark).
- `read_tsv()`: Tab-separated values (TSV) files.
- `read_fwf()`: Fixed-width files.
- `read_log()`: Apache-style log files.
- `read_delim()`: General delimited files (specify `delim` argument).

### Vector Parsers
Use `parse_*()` functions to convert character vectors into specific types:
- `parse_integer()`, `parse_double()`, `parse_logical()`
- `parse_number()`: Flexible parser that ignores non-numeric prefixes/suffixes (e.g., "$1,000").
- `parse_date()`, `parse_time()`, `parse_datetime()`: Convert strings to temporal objects using format strings (e.g., `"%d/%m/%Y"`).
- `parse_factor()`: Converts to factors and warns if unexpected levels are found.

## Workflows

### Handling Column Types
By default, `readr` guesses column types by inspecting 1,000 rows (evenly spaced).
- **Increase guessing range**: Use `guess_max = Inf` to check all rows if the file has "excitement" (data changes) late in the file.
- **Manual Specification**: Use the `col_types` argument for reliability and speed.
  ```r
  # Using a list of column objects
  read_csv("data.csv", col_types = list(
    id = col_integer(),
    date = col_date(format = "%Y-%m-%d"),
    value = col_double(),
    category = col_factor(levels = c("A", "B"))
  ))

  # Using compact string abbreviations (d=double, i=integer, c=character, _=skip)
  read_csv("data.csv", col_types = "dic_")
  ```

### Internationalization (Locales)
Use `locale()` to handle data from different regions:
- **Decimals and Grouping**: `locale(decimal_mark = ",", grouping_mark = ".")`
- **Encoding**: `locale(encoding = "latin1")`
- **Dates**: `locale(date_names = "fr")` for French month/day names.
- **Timezones**: `locale(tz = "America/New_York")`

### Troubleshooting Imports
If a file has parsing errors:
1. Run `problems(df)` on the resulting object to see exactly where parsing failed.
2. Use `spec(df)` to see the guessed column types.
3. Use `stop_for_problems(df)` in scripts to ensure data integrity by throwing an error if parsing fails.

## Tips
- **Speed**: `readr` is typically 10x faster than base R.
- **Tibbles**: Output is always a tibble; it does not munge column names or use row names.
- **Writing Data**: Use `write_csv()`, `write_tsv()`, etc., to save data. These functions always encode in UTF-8 and format dates in ISO8601.

## Reference documentation
- [Column type](./references/column-types.Rmd)
- [Locales](./references/locales.Rmd)
- [Introduction to readr](./references/readr.Rmd)