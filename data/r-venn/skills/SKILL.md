---
name: r-venn
description: The r-venn package generates customizable Venn diagrams for up to seven sets using various input formats like lists, dataframes, or Boolean expressions. Use when user asks to create Venn diagrams, visualize set intersections, or represent logical relationships using SOP notation in R.
homepage: https://cloud.r-project.org/web/packages/venn/index.html
---


# r-venn

## Overview
The `venn` package is a versatile R tool for drawing Venn diagrams for up to 7 sets. It supports various input types (counts, lists, dataframes, or Boolean expressions) and allows for extensive customization of shapes (ellipses vs. circles), colors, and labels. It can produce both base R and ggplot2-based graphics.

## Installation
Install the package from CRAN:
```R
install.packages("venn")
```

## Core Workflows

### 1. Basic Set Diagrams
Create empty or count-based diagrams by specifying the number of sets.
```R
library(venn)

# Simple 3-set diagram
venn(3)

# 4-set diagram with ellipses and custom styling
venn(4, ellipse = TRUE, lty = 5, col = "navyblue")

# 7-set "Adelaide" diagram
venn(7)
```

### 2. Working with Data Inputs
The `venn()` function automatically detects the input type.
```R
# From a list of vectors
set.seed(123)
x_list <- list(A = 1:20, B = 15:35, C = sample(10:40, 15))
venn(x_list, ilabels = "counts")

# From a dataframe (binary indicators)
x_df <- as.data.frame(matrix(sample(0:1, 150, replace = TRUE), ncol = 5))
venn(x_df, ilabels = "counts", zcolor = "style")
```

### 3. Boolean and SOP Notation
You can define specific intersections or unions using "Sum of Products" (SOP) notation or bitstrings.
```R
# Using bitstrings ("1" = present, "0" = absent, "-" = any)
venn("1--") # First set only

# Using SOP notation (requires snames)
venn("A + B~C", snames = "A, B, C, D")

# Multiple specific zones with custom colors
venn("1---- , ----1", zcolor = "red, blue")
```

### 4. ggplot2 Integration
To use ggplot2 graphics, set `ggplot = TRUE`. This requires the `ggplot2` and `ggpolypath` packages.
```R
venn(x_list, ggplot = TRUE, size = 1.5, linetype = "dashed")
```

## Key Parameters
- `snames`: Character string or vector for set names (e.g., `"A, B, C"`).
- `ilabels`: Set to `TRUE` for intersection labels or `"counts"` to show frequency.
- `zcolor`: Fill colors. Use `"style"` for a predefined palette or a vector of colors.
- `ellipse`: Logical; uses ellipses for 4 and 5-set diagrams to improve readability.
- `borders`: Logical; set to `FALSE` to hide set boundaries.
- `counts`: A numeric vector of counts for all possible intersections.

## Tips
- For 4 or 5 sets, `ellipse = TRUE` usually provides a more aesthetically pleasing and readable layout than the default circles.
- When using SOP notation, `~` represents "NOT" (e.g., `A~B` is A intersected with NOT B).
- Use `getZones()` and `getCentroid()` for advanced labeling of specific intersection areas.

## Reference documentation
- [README](./references/README.html.md)
- [Package Home Page](./references/home_page.md)