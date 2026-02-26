---
name: r-dplyr
description: The dplyr package provides a grammar for fast and consistent data manipulation of data frame-like objects in R. Use when user asks to filter rows, select or rename columns, create new variables, group and summarize data, or join multiple datasets together.
homepage: https://cloud.r-project.org/web/packages/dplyr/index.html
---


# r-dplyr

## Overview

`dplyr` is a fast, consistent tool for working with data frame-like objects. It provides a "grammar" of data manipulation based on a set of verbs that solve the most common data manipulation challenges. It is a core component of the tidyverse.

## Installation

To install the stable version from CRAN:

```r
install.packages("dplyr")
```

## Core Verbs

All dplyr verbs work similarly: the first argument is a data frame, subsequent arguments describe what to do with the data, and the result is a new data frame.

### Row Operations
- `filter()`: Choose rows based on column values (e.g., `filter(df, x > 1 & y == "A")`).
- `slice()`: Choose rows based on location (e.g., `slice(df, 1:10)`).
- `arrange()`: Reorder rows (e.g., `arrange(df, desc(date))`).

### Column Operations
- `select()`: Pick variables by name or position. Supports helpers like `starts_with()`, `ends_with()`, and `contains()`.
- `rename()`: Change the name of columns (`rename(df, new_name = old_name)`).
- `mutate()`: Create new columns or transform existing ones.
- `relocate()`: Change column order.

### Groups and Summaries
- `group_by()`: Group data by one or more variables.
- `summarise()`: Reduce multiple values down to a single summary (e.g., `mean()`, `n()`, `sd()`).
- `ungroup()`: Remove grouping metadata.

## Common Workflows

### The Pipe Operator
Use the native R pipe `|>` (or `%>%` from magrittr) to chain operations:

```r
starwars |>
  filter(species == "Droid") |>
  group_by(homeworld) |>
  summarise(mean_height = mean(height, na.rm = TRUE))
```

### Column-wise Operations with `across()`
Apply the same transformation to multiple columns:

```r
# Calculate mean for all numeric columns
df |> summarise(across(where(is.numeric), mean))

# Transform specific columns
df |> mutate(across(c(x, y), as.character))
```

### Joins (Two-Table Verbs)
- `left_join(x, y)`: Keep all rows from x, add matching columns from y.
- `inner_join(x, y)`: Keep only rows that match in both x and y.
- `full_join(x, y)`: Keep all rows from both x and y.
- `semi_join(x, y)`: Keep rows in x that have a match in y.
- `anti_join(x, y)`: Keep rows in x that do NOT have a match in y.

### Row-wise Operations
Use `rowwise()` for computations that should happen per row rather than per column (e.g., computing a mean across several columns for each observation):

```r
df |> 
  rowwise() |> 
  mutate(row_mean = mean(c_across(w:z)))
```

## Programming with dplyr (Tidy Evaluation)

When writing functions that wrap dplyr verbs, use "embracing" (`{{ }}`) for data-variables and `.data[[ ]]` for character strings.

```r
# Embracing for bare column names
my_summary <- function(data, var) {
  data |> summarise(mean = mean({{ var }}))
}

# .data pronoun for strings
my_count <- function(data, col_string) {
  data |> count(.data[[col_string]])
}
```

## Reference documentation

- [dplyr <-> base R](./references/base.Rmd)
- [Column-wise operations](./references/colwise.Rmd)
- [Introduction to dplyr](./references/dplyr.Rmd)
- [Grouped data](./references/grouping.Rmd)
- [Using dplyr in packages](./references/in-packages.Rmd)
- [Programming with dplyr](./references/programming.Rmd)
- [Recoding columns and replacing values](./references/recoding-replacing.Rmd)
- [Row-wise operations](./references/rowwise.Rmd)
- [Two-table verbs](./references/two-table.Rmd)