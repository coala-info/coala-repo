---
name: r-upsetr
description: This tool creates scalable UpSet plots to visualize complex set intersections as an alternative to Venn diagrams. Use when user asks to visualize intersecting sets, analyze attributes across intersections, or create matrix-based visualizations of set metadata.
homepage: https://cloud.r-project.org/web/packages/UpSetR/index.html
---


# r-upsetr

name: r-upsetr
description: Create scalable UpSet plots for visualizing intersecting sets as an alternative to Venn and Euler diagrams. Use this skill when you need to visualize complex set intersections, analyze attributes across intersections, or incorporate set-level metadata into a matrix-based visualization.

# r-upsetr

## Overview
UpSetR is an R package used to visualize intersections of sets in a matrix layout. It is more scalable than Venn diagrams, allowing for the visualization of many sets and their intersections while providing tools to explore attributes of the elements within those intersections.

## Installation
```R
install.packages("UpSetR")
library(UpSetR)
```

## Core Workflow

### 1. Data Preparation
UpSetR requires data where sets are represented as binary columns (1 for presence, 0 for absence).

*   **From List**: Convert a list of vectors to the required format.
    ```R
    listInput <- list(set1 = c(1,2,3), set2 = c(2,3,4))
    data <- fromList(listInput)
    ```
*   **From Expression**: Use set intersection counts directly.
    ```R
    expressionInput <- c("set1" = 5, "set2" = 10, "set1&set2" = 3)
    data <- fromExpression(expressionInput)
    ```

### 2. Basic Plotting
The `upset()` function is the primary entry point.
```R
# Plot the 6 largest sets
upset(data, nsets = 6, order.by = "freq")

# Plot specific sets in a specific order
upset(data, sets = c("SetA", "SetB", "SetC"), keep.order = TRUE)
```

### 3. Customizing the Layout
*   **Ordering**: Use `order.by = c("freq", "degree")` to sort intersections by size or number of sets involved.
*   **Scaling**: Use `text.scale` to adjust labels: `text.scale = c(intersection_title, intersection_ticks, set_title, set_ticks, set_names, bar_numbers)`.
*   **Ratios**: Adjust the matrix vs. bar plot size with `mb.ratio = c(0.5, 0.5)`.

### 4. Queries and Highlighting
Highlight specific subsets of data using the `queries` parameter.
*   **intersects**: Highlight specific set combinations.
*   **elements**: Highlight elements based on attribute values.
```R
upset(data, queries = list(
  list(query = intersects, params = list("Drama", "Action"), color = "red", active = TRUE),
  list(query = elements, params = list("AvgRating", 3.5, 4.5), color = "blue", active = FALSE)
))
```

### 5. Attribute and Metadata Plots
*   **Boxplots**: Show attribute distributions across intersections using `boxplot.summary = c("AttributeName")`.
*   **Attribute Plots**: Add histograms or scatter plots above the matrix using `attribute.plots`.
*   **Set Metadata**: Add side-plots (heatmaps, bar charts, or text) describing the sets themselves using `set.metadata`.

## Tips and Best Practices
*   **Empty Intersections**: Use `empty.intersections = "on"` to see combinations with no shared elements.
*   **Coloring**: If `main.bar.color` is not black, elements in attribute plots may default to gray unless specified.
*   **Custom Plots**: When creating custom attribute plots, use `aes_string()` and `scale_color_identity()` to ensure UpSetR colors map correctly.

## Reference documentation
- [Attribute Plots](./references/attribute.plots.Rmd)
- [Basic Usage](./references/basic.usage.Rmd)
- [Querying the Data](./references/queries.Rmd)
- [Incorporating Set Metadata](./references/set.metadata.plots.Rmd)