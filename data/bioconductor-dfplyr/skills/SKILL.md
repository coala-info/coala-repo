---
name: bioconductor-dfplyr
description: DFplyr provides a dplyr-compatible interface for performing data manipulation directly on Bioconductor S4Vectors DataFrame objects. Use when user asks to manipulate DataFrame objects using dplyr verbs, preserve S4-specific column types like GRanges during data wrangling, or perform joins and grouped operations on Bioconductor metadata containers.
homepage: https://bioconductor.org/packages/release/bioc/html/DFplyr.html
---

# bioconductor-dfplyr

name: bioconductor-dfplyr
description: Use when working with Bioconductor S4Vectors DataFrame objects and needing to perform data manipulation using dplyr-like syntax (mutate, select, filter, etc.) without converting to tibbles. This skill is essential for preserving S4-specific column types (e.g., GRanges, IRanges, NumericList) and row names that are typically lost or difficult to manage when converting between DataFrame and tibble/data.frame.

# bioconductor-dfplyr

## Overview

DFplyr provides a dplyr-compatible backend for S4Vectors DataFrame objects. It allows users to apply familiar data manipulation verbs directly to Bioconductor-specific data structures. This is particularly useful in bioinformatics workflows where SummarizedExperiment objects or other S4 containers store metadata in DataFrames that include complex S4 columns and meaningful row names.

## Installation and Loading

Install the package via BiocManager:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("DFplyr")
library(DFplyr)
library(S4Vectors)
```

## Core Workflows

### Basic Data Manipulation
Use standard dplyr verbs on DataFrame objects. The output remains a DataFrame.

*   **mutate()**: Create or modify columns. It supports S4-specific functions like `seqnames()`, `start()`, or `lengths()`.
*   **select()**: Pick columns by name or position.
*   **filter()**: Subset rows based on logical conditions.
*   **arrange()**: Reorder rows.
*   **slice()**: Select rows by position.
*   **pull()**: Extract a single column as a vector or S4 object.

### Handling S4 Columns
DFplyr allows operations on complex columns without breaking their S4 structure:

```r
# Example: Extracting info from a GRanges column within a DataFrame
mutate(df, 
       chr = GenomeInfoDb::seqnames(gr_col), 
       width = BiocGenerics::width(gr_col))
```

### Grouped Operations
Grouped operations are supported even though DataFrame does not natively store groups. DFplyr manages this metadata:

```r
df %>%
  group_by(category_col) %>%
  tally()
```

### Renaming Columns
Due to namespace conflicts with S4Vectors, use `rename2()` for dplyr-style renaming (`new_name = old_name`) using non-standard evaluation.

### Scoped Verbs and Tidyselect
*   **Scoped variants**: `mutate_if()`, `mutate_at()`, and `select_at()` are supported.
*   **Tidyselect**: When using `_at` variants, wrap selection helpers in `vars()` (e.g., `mutate_at(df, vars(starts_with("score")), ~ . * 2)`).

### Joins
Perform joins directly on DataFrames while attempting to preserve row names and grouping:
*   `left_join(df1, df2)`
*   `right_join(df1, df2)`
*   `inner_join(df1, df2)`
*   `full_join(df1, df2)`

## Tips for Success
*   **Row Names**: DFplyr attempts to preserve row names in operations like `select()`, `filter()`, and `arrange()`. However, row names may be dropped if the operation makes them ambiguous (e.g., `distinct()`).
*   **S4 Compatibility**: Ensure that any S4 columns used in `mutate()` have appropriate methods defined for the operations being performed.
*   **Piping**: DFplyr is designed to work seamlessly with the magrittr pipe (`%>%`) or the native R pipe (`|>`).

## Reference documentation
- [Example Usage](./references/example_usage.Rmd)
- [Example Usage](./references/example_usage.md)