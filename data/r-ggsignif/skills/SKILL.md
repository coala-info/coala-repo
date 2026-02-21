---
name: r-ggsignif
description: "Enrich your 'ggplots' with group-wise comparisons.     This package provides an easy way to indicate if two groups are     significantly different. Commonly this is shown by a bracket on top     connecting the groups of interest which itself is annotated with the     level of significance (NS, *, **, ***).  The package provides a single     layer (geom_signif()) that takes the groups for comparison and the     test (t.test(), wilcox.text() etc.) as arguments and adds the     annotation to the plot.</p>"
homepage: https://cloud.r-project.org/web/packages/ggsignif/index.html
---

# r-ggsignif

name: r-ggsignif
description: Add significance brackets and annotations to ggplot2 plots. Use this skill when you need to visualize statistical comparisons (p-values or custom labels) between groups in an R ggplot2 workflow, especially for boxplots, bar charts, or violin plots.

# r-ggsignif

## Overview
The `ggsignif` package provides a simple way to indicate if two groups in a `ggplot2` visualization are significantly different. It adds a `geom_signif()` layer that draws brackets connecting groups and annotates them with significance levels (e.g., NS, *, **, ***) or custom text. It can either calculate p-values automatically using standard tests (t.test, wilcox.test) or display user-defined annotations.

## Installation
```R
install.packages("ggsignif")
```

## Core Function: geom_signif()
The primary interface is `geom_signif()`. It can be used in two modes: automatic calculation or manual positioning.

### 1. Automatic Comparison
Pass a list of character vectors to the `comparisons` argument. The function will calculate the significance (default is `wilcox.test`) and draw the bracket.

```R
library(ggplot2)
library(ggsignif)

ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  geom_boxplot() +
  geom_signif(
    comparisons = list(c("versicolor", "virginica")),
    map_signif_level = TRUE
  )
```

### 2. Manual Annotation and Positioning
Use this mode for complex layouts (like dodged bars) or when you already have the statistical results.

```R
ggplot(df, aes(x = Group, y = Value)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_signif(
    y_position = c(10.5, 12.0), 
    xmin = c(0.8, 1.8), 
    xmax = c(1.2, 2.2),
    annotation = c("**", "NS"), 
    tip_length = 0
  )
```

## Key Arguments
- `comparisons`: A list of vectors (e.g., `list(c("Group1", "Group2"))`) indicating which groups to compare.
- `test`: The name of the statistical test to use (default: `"wilcox.test"`). Can also be `"t.test"`.
- `test.args`: Additional arguments passed to the test function (e.g., `list(var.equal = TRUE)`).
- `map_signif_level`: Boolean or named numeric vector. If `TRUE`, it maps p-values to stars (`***` < 0.001, `**` < 0.01, `*` < 0.05).
- `y_position`: Numeric vector specifying the height of the brackets.
- `xmin`, `xmax`: Numeric vectors specifying the horizontal start and end points of the brackets.
- `annotation`: Character vector of custom labels to display.
- `tip_length`: The length of the vertical "tips" at the end of the brackets (set to 0 for a flat line).
- `vjust`: Vertical justification of the text relative to the bracket.

## Workflows and Tips
- **Dodged Plots**: When using `position = "dodge"`, `ggplot2` changes the visual location of bars without updating the underlying data coordinates. You **must** use manual positioning (`xmin`, `xmax`, `y_position`) to align brackets with dodged elements.
- **Multiple Comparisons**: You can provide multiple pairs in the `comparisons` list. Use `step_increase` to automatically offset the height of overlapping brackets.
- **Custom Significance Levels**: You can pass a custom mapping to `map_signif_level`, e.g., `c("***"=0.001, "**"=0.01, "*"=0.05, "n.s."=1)`.
- **Non-numeric X-axis**: If your x-axis is discrete, `xmin` and `xmax` still refer to the numeric indices (1, 2, 3...) of the levels.

## Reference documentation
- [Introduction to 'ggsignif' package](./references/intro.Rmd)