---
name: r-tibble
description: The r-tibble tool provides specialized guidance for creating, manipulating, and displaying modern R data frames that prioritize stricter subsetting and enhanced printing. Use when user asks to create tibbles from scratch or row-wise, convert existing data structures using as_tibble, manage column display and number formatting, or understand behavioral differences between tibbles and base R data frames.
homepage: https://cloud.r-project.org/web/packages/tibble/index.html
---

# r-tibble

name: r-tibble
description: Specialized guidance for using the 'tibble' R package to create, manipulate, and display modern data frames. Use this skill when you need to: (1) Create tibbles using tibble() or tribble(), (2) Coerce existing data frames or lists using as_tibble(), (3) Understand the differences between tibbles and base R data frames (subsetting, recycling, and printing), (4) Customize column display and number formatting using num() or pillar options, and (5) Implement custom tibble subclasses or column types.

## Overview

The `tibble` package provides a modern reimagining of the data frame. Tibbles are "lazy" and "surly": they do less (no partial matching, no changing input types) and complain more (clearer error messages), which makes them more reliable for data analysis. They are a core component of the tidyverse.

## Installation

```R
install.packages("tibble")
library(tibble)
```

## Core Workflows

### 1. Creating Tibbles
- **From scratch**: Use `tibble()` for column-wise construction. It supports lazy evaluation (referencing previous columns).
  ```R
  tibble(x = 1:5, y = x ^ 2, z = "constant")
  ```
- **Row-wise**: Use `tribble()` (transposed tibble) for readable manual data entry.
  ```R
  tribble(
    ~name, ~val,
    "A",   10,
    "B",   20
  )
  ```
- **Coercion**: Use `as_tibble()` to convert data frames, lists, or matrices. It is significantly faster than `as.data.frame()`.

### 2. Subsetting and Extraction
Tibbles are stricter than base R data frames to prevent common bugs:
- `[` always returns a tibble. It never "drops" to a vector unless `drop = TRUE` is explicitly passed.
- `[[` and `$` always extract a single column.
- **No partial matching**: `df$a` will not find column `abc`; it returns `NULL` and issues a warning.
- **Row names**: Tibbles do not support row names. Use `column_to_rownames()` or `rownames_to_column()` if conversion is necessary.

### 3. Controlling Display
Tibbles provide a refined print method showing the first 10 rows and only the columns that fit the screen.
- **Global Options**:
  - `options(pillar.print_max = n)`: Number of rows to trigger abbreviated printing.
  - `options(pillar.sigfig = n)`: Number of significant digits (default is 3).
- **Per-column Formatting**: Use `num()` to wrap numeric vectors with specific display rules (notation, digits, labels) that persist through transformations.
  ```R
  tibble(x = num(c(1, 1.2345), digits = 2, label = "$"))
  ```

### 4. Recycling Rules
Tibbles only recycle vectors of length 1. Attempting to recycle vectors of other lengths (e.g., a vector of length 2 into a tibble of length 4) will result in an error.

## Reference documentation

- [Comparing display with data frames](./references/digits.Rmd)
- [Extending tibble](./references/extending.Rmd)
- [Column formats](./references/formats.Rmd)
- [Invariants: Comparing behavior with data frames](./references/invariants.Rmd)
- [Controlling display of numbers](./references/numbers.Rmd)
- [Tibbles Overview](./references/tibble.Rmd)
- [Column types and abbreviations](./references/types.Rmd)