---
name: r-tidyr
description: The r-tidyr package provides tools for reshaping and tidying R data frames into a consistent structure where each variable is a column and each observation is a row. Use when user asks to pivot data between long and wide formats, rectangle nested list-columns, split or combine character columns, or manage missing values.
homepage: https://cloud.r-project.org/web/packages/tidyr/index.html
---

# r-tidyr

name: r-tidyr
description: Tools for creating tidy data where each column is a variable, each row is an observation, and each cell is a single value. Use this skill when you need to reshape data (pivoting), handle nested list-columns (nesting/rectangling), split or combine character columns, or manage missing values in R data frames.

## Overview

The `tidyr` package is a core member of the tidyverse designed to help you "tidy" messy data. Tidy data is easier to manipulate, model, and visualize because it follows a consistent structure. The package focuses on four main goals:
1. **Pivoting**: Converting between long and wide formats.
2. **Rectangling**: Turning deeply nested lists into tidy tibbles.
3. **Nesting**: Creating list-columns that bundle related data.
4. **Splitting/Combining**: Breaking up or merging character columns.

## Installation

To install the stable version from CRAN:

```r
install.packages("tidyr")
```

To use the package in a session:

```r
library(tidyr)
```

## Core Workflows

### 1. Pivoting Data
Use pivoting to change the layout of a dataset without changing the underlying values.

*   **`pivot_longer()`**: Makes datasets "longer" by increasing rows and decreasing columns. Use when column headers are actually values of a variable.
    ```r
    # Example: Moving week columns into a single 'week' variable
    df |> pivot_longer(
      cols = starts_with("wk"),
      names_to = "week",
      values_to = "rank",
      values_drop_na = TRUE
    )
    ```
*   **`pivot_wider()`**: Makes datasets "wider" by increasing columns and decreasing rows. Use for creating summary tables or when an observation is spread across multiple rows.
    ```r
    # Example: Turning 'station' values into individual columns
    df |> pivot_wider(
      names_from = station,
      values_from = seen,
      values_fill = 0
    )
    ```

### 2. Rectangling and Nested Data
Rectangling is the process of turning nested lists (often from JSON/API) into rectangular data frames.

*   **`unnest_longer()`**: Takes each element of a list-column and makes a new row.
*   **`unnest_wider()`**: Takes each element of a list-column and makes a new column.
*   **`hoist()`**: Selectively pulls specific components out of a nested list-column into their own top-level columns.
    ```r
    # Example: Pulling specific fields from a nested 'user' list
    users |> hoist(user, 
      login = "login", 
      followers = "followers"
    )
    ```
*   **`nest()`**: The opposite of unnesting; it bundles columns into a list-column of data frames, often used for per-group modeling.
    ```r
    # Nesting data by group
    nested_df <- df |> nest(data = !Species)
    ```

### 3. Character Columns
*   **`separate_wider_delim()`**: Splits a single character column into multiple columns based on a delimiter.
*   **`unite()`**: Combines multiple columns into a single character column.

### 4. Missing Values
*   **`drop_na()`**: Drops rows containing `NA` in specified columns.
*   **`replace_na()`**: Replaces `NA` with specific values.
*   **`fill()`**: Fills in missing values using the previous or next value (useful for data entry shortcuts).
*   **`complete()`**: Turns implicit missing values into explicit `NA`s by completing all combinations of specified variables.

## Programming with tidyr

When using `tidyr` inside functions or packages, follow these patterns to handle "Tidy Selection":

*   **Indirection (Embracing)**: Use `{{ }}` to pass user-supplied columns.
    ```r
    my_function <- function(data, col) {
      data |> drop_na({{ col }})
    }
    ```
*   **Character Vectors**: Use `all_of()` or `any_of()` when column names are stored as strings in a vector.
    ```r
    cols_to_fix <- c("x", "y")
    df |> fill(all_of(cols_to_fix))
    ```
*   **R CMD Check**: To avoid "undefined global variable" notes in packages, prefer `all_of()` or `any_of()` for fixed column names.

## Reference documentation

- [In packages](./references/in-packages.Rmd)
- [Nested data](./references/nest.Rmd)
- [Pivoting](./references/pivot.Rmd)
- [Programming with tidyr](./references/programming.Rmd)
- [Rectangling](./references/rectangle.Rmd)
- [Tidy data](./references/tidy-data.Rmd)