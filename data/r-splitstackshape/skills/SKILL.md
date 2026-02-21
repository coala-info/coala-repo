---
name: r-splitstackshape
description: "Online data collection tools like Google Forms often export     multiple-response questions with data concatenated in cells. The     concat.split (cSplit) family of functions splits such data into separate      cells. The package also includes functions to stack groups of columns and      to reshape wide data, even when the data are \"unbalanced\"&mdash;something      which reshape (from base R) does not handle, and which melt and dcast from      reshape2 do not easily handle.</p>"
homepage: https://cloud.r-project.org/web/packages/splitstackshape/index.html
---

# r-splitstackshape

## Overview
The `splitstackshape` package provides highly efficient functions for data manipulation tasks that are often cumbersome in base R or `tidyverse`. Its primary strengths are splitting concatenated strings into rows or columns, reshaping "unbalanced" wide data into long format, and expanding datasets based on frequency counts. It is built on `data.table` for high performance.

## Installation
```r
install.packages("splitstackshape")
library(splitstackshape)
```

## Core Functions

### Splitting Concatenated Data
The `cSplit` function is the workhorse for data where multiple responses are stored in a single cell (e.g., "A, B, C").

*   **Split to Long Format**: Useful for normalization.
    ```r
    # Splits 'col_name' by comma and stacks into rows
    cSplit(data, "col_name", sep = ",", direction = "long")
    ```
*   **Split to Wide Format**: Splits into multiple new columns.
    ```r
    # Creates col_name_1, col_name_2, etc.
    cSplit(data, "col_name", sep = ",", direction = "wide")
    ```

### Reshaping Unbalanced Data
Base R's `reshape` requires balanced stubs. `Reshape` handles cases where some groups have more variables than others.
```r
# Reshape wide data where stubs might not match perfectly
Reshape(data, v.names = c("varA", "varB"), idvar = "ID", sep = "_")
```

### Expanding Rows
`expandRows` replicates rows based on a numeric value in a column or a constant.
```r
# If a row has 'count' = 3, it becomes 3 identical rows
expandRows(data, "count")
```

### Stratified Sampling
`stratified` takes a random sample from a dataset ensuring group representation.
```r
# Sample 10% from each group defined by "Group_Col"
stratified(data, group = "Group_Col", size = 0.1)
```

### Stacking Column Groups
`Stacked` is an alternative to `melt` that keeps groups of variables together without forcing everything into a single value column.
```r
# Stacks sets of columns (e.g., multiple time points for different measures)
Stacked(data, var.stubs = c("grade", "score"), sep = "_")
```

## Workflows & Tips

1.  **Google Forms Data**: Use `cSplit(df, "MultipleChoiceCol", sep = ", ", direction = "long")` to immediately turn a comma-separated response column into a format ready for `ggplot2` or `table()`.
2.  **Performance**: `cSplit` returns a `data.table` by default. If you require a `data.frame`, wrap the result in `as.data.frame()`.
3.  **ID Generation**: If your data lacks a unique ID before splitting, use `getanID(data, "grouping_var")` to create a secondary ID to maintain traceability.
4.  **List Columns**: Use `listCol_l` (long) or `listCol_w` (wide) to handle columns that are actual R `list` objects within a data frame.

## Reference documentation
- [splitstackshape README](./references/README.md)