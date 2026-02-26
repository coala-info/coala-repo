---
name: r-reshape2
description: This tool flexibly restructures and aggregates data in R by transforming it between wide and long formats. Use when user asks to melt data into long format, cast data into wide data frames or arrays, or aggregate data for visualization and analysis.
homepage: https://cloud.r-project.org/web/packages/reshape/index.html
---


# r-reshape2

name: r-reshape2
description: Flexibly restructure and aggregate data in R using the reshape2 package. Use this skill when you need to transform data between wide and long formats, specifically using the melt and cast (dcast/acast) paradigms. It is particularly useful for preparing data for visualization (like ggplot2) or performing group-wise aggregations.

# r-reshape2

## Overview
The `reshape2` package is a focused, high-performance reboot of the original `reshape` package. It revolves around two main steps:
1.  **Melt**: Converting "wide" data into "long" format where each row represents a single observation of a variable.
2.  **Cast**: Taking "long" data and reshaping it into a "wide" data frame (`dcast`) or an array/matrix (`acast`), often while performing aggregation.

Note: `reshape2` is currently in a "superseded" state. While highly stable and performant, `tidyr` is the modern alternative recommended for new projects.

## Installation
To install the package from CRAN:
```r
install.packages("reshape2")
```

## Core Functions

### Melting Data (Wide to Long)
Use `melt()` to collapse multiple columns into key-value pairs.

```r
library(reshape2)

# For Data Frames
# id.vars: columns to keep fixed
# measure.vars: columns to stack (if omitted, all other columns are used)
long_df <- melt(data, id.vars = c("id1", "id2"), variable.name = "variable", value.name = "value")
```

### Casting Data (Long to Wide/Aggregate)
Use `dcast()` for data frame output and `acast()` for vector/matrix/array output. The formula follows the pattern: `row_vars ~ col_vars`.

```r
# Reshape to wide format
wide_df <- dcast(long_df, id1 + id2 ~ variable)

# Aggregate while casting
# Example: Mean of values for each id1 across variables
agg_df <- dcast(long_df, id1 ~ variable, fun.aggregate = mean, na.rm = TRUE)

# Create a matrix/array
my_matrix <- acast(long_df, id1 ~ variable)
```

## Workflows and Tips

### The Reshape Pipeline
The most common workflow is to `melt` data into a standard long format, which makes it trivial to:
1.  Apply transformations to the `value` column.
2.  Pass the data to `ggplot2` (which prefers long data).
3.  `cast` the data into a specific summary table.

### Handling Margins
You can add row/column totals (grand totals) using the `margins` argument in cast functions:
```r
dcast(long_df, id1 ~ variable, fun.aggregate = sum, margins = TRUE)
```

### Naming Conventions
-   In `reshape2`, `melt` names columns `Var1`, `Var2`, etc., for arrays, or uses `variable` and `value` for data frames by default.
-   Always specify `variable.name` and `value.name` in `melt()` to keep code readable.

## Reference documentation
- [README](./references/README.md)