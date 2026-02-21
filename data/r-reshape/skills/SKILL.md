---
name: r-reshape
description: "Flexibly restructure and aggregate data using    just two functions: melt and cast.</p>"
homepage: https://cloud.r-project.org/web/packages/reshape/index.html
---

# r-reshape

## Overview
The `reshape` package provides a powerful framework for data manipulation in R based on two main operations: **melting** (converting data into a long format) and **casting** (aggregating and reshaping data into a desired output format). It replaces complex base R functions like `tapply`, `by`, and `aggregate` with a more intuitive syntax.

Note: While `reshape2` and `tidyr` are modern successors, this skill focuses specifically on the original `reshape` package (v0.8.10).

## Installation
To install the package from CRAN:
```r
install.packages("reshape")
library(reshape)
```

## Core Workflow

### 1. Melting Data (Wide to Long)
The `melt` function takes data in a "wide" format and stacks it into a "long" format where each row represents a single observation of a variable.

```r
# id.vars: variables that identify the unit of measurement
# measure.vars: variables that represent the measured values
data_long <- melt(data, id.vars = c("id", "time"), measure.vars = c("temp", "height"))
```
*   **Result**: A data frame with the ID variables plus two new columns: `variable` and `value`.
*   **Arrays/Matrices**: `melt` can also handle arrays, converting them into a data frame where dimensions become identifying columns.

### 2. Casting Data (Long to Wide/Aggregated)
The `cast` function takes melted data and reshapes it based on a formula.

**Formula Syntax**: `rowvar1 + rowvar2 ~ colvar1 + colvar2`
*   Variables on the left side form the rows.
*   Variables on the right side form the columns.

```r
# Reshape to wide format
cast(data_long, id + time ~ variable)

# Aggregate data (e.g., mean of variables per ID)
cast(data_long, id ~ variable, mean)

# Create a 3D array
cast(data_long, id ~ time ~ variable)
```

## Advanced Features

### Margins
You can add row and column totals (grand totals or subsets) by using the `margins` argument.
```r
# Add all possible margins
cast(data_long, id ~ variable, mean, margins = TRUE)

# Add specific margins
cast(data_long, id ~ variable, mean, margins = c("id"))
```

### Handling Missing Values
Use `na.rm = TRUE` within the `cast` function to remove missing values during aggregation.

### Special Functions
*   **subset**: You can subset the data within the cast call: `cast(data_long, id ~ variable, subset = variable == "temp")`.
*   **_result_**: A special variable name used when multiple aggregation functions are applied.

## Tips for Success
*   **Column Names**: Unlike newer packages, `reshape` 0.8.x does not automatically convert column names to valid R names. Use backticks (`` ` ``) if your names contain spaces or special characters.
*   **Aggregation**: If the combination of variables in the formula does not uniquely identify a single value, `cast` will default to `length` (counting observations) unless an aggregation function (like `sum` or `mean`) is provided.
*   **Visualization**: Always `melt` your data before passing it to `ggplot2`, as it expects the long format produced by `reshape`.

## Reference documentation
- [Reshape Home Page](./references/home_page.md)