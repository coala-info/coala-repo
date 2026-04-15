---
name: r-scales
description: The scales package provides infrastructure for mapping data values to visual aesthetics, including label formatting, break calculation, and data transformation. Use when user asks to format axis labels, calculate scale breaks, transform data ranges, or manipulate colors for visualizations.
homepage: https://cloud.r-project.org/web/packages/scales/index.html
---

# r-scales

## Overview
The `scales` package provides the internal scaling infrastructure used by `ggplot2`. It is essential for controlling how data values are mapped to visual properties (aesthetics) and how those mappings are represented by guides (axes and legends). It offers a suite of tools for label formatting, break calculation, and data transformation.

## Installation
To install the package from CRAN:
```r
install.packages("scales")
library(scales)
```

## Core Workflows

### 1. Label Formatting
Label functions (prefixed with `label_`) return functions used in the `labels` argument of ggplot2 scales.

*   **Numbers & Currency:**
    *   `label_number()`: Force decimal display, control `accuracy`, `big.mark`, and `prefix/suffix`.
    *   `label_comma()`: Shorthand for `label_number(big.mark = ",")`.
    *   `label_currency()`: Formats as currency (e.g., `$1,200`). Use `prefix` for different symbols.
*   **Percentages & Probabilities:**
    *   `label_percent()`: Multiplies by 100 and adds `%`.
    *   `label_pvalue()`: Formats p-values with mathematical signs (e.g., `< 0.001`).
*   **Dates & Times:**
    *   `label_date()`: Uses standard POSIX format strings (e.g., `"%Y-%m"`).
    *   `label_date_short()`: Automatically creates concise labels based on the time scale.
*   **Scientific & Log:**
    *   `label_scientific()`: Standard scientific notation.
    *   `label_log()`: Formats as powers (e.g., $10^3$).

### 2. Break Calculation
Break functions (prefixed with `breaks_`) determine where ticks appear on axes.

*   `breaks_extended()`: The default algorithm for numeric axes.
*   `breaks_log()`: Specifically for log-transformed scales.
*   `breaks_pretty()`: Generates "nice" breaks for dates and numeric data.
*   `breaks_width()`: Sets breaks at fixed intervals (e.g., `breaks_width("1 month")`).

### 3. Data Transformation
Transformations (prefixed with `transform_`) handle non-linear mappings.

*   **Common:** `transform_log()`, `transform_log10()`, `transform_sqrt()`, `transform_reverse()`.
*   **Specialized:** `transform_asinh()` (inverse hyperbolic sine), `transform_boxcox()`, `transform_pseudo_log()` (handles zeros/negatives better than pure log).
*   **Composition:** Use `transform_compose("log10", "reverse")` to combine effects.

### 4. Color Manipulation
*   `alpha()`: Modify transparency of a color vector.
*   `muted()`: Reduce the chroma/luminance of a color.
*   `col_numeric()`, `col_bin()`, `col_quantile()`: Map continuous data to color palettes for use in Leaflet or other engines.
*   `show_col()`: A utility to quickly visualize a vector of colors.

### 5. Rescaling and Out-of-Bounds (OOB)
*   `rescale()`: Linearly map a vector to a new range (default 0 to 1).
*   `oob_squish()`: Change values outside limits to the nearest limit (useful for keeping points on the edge of a plot).
*   `oob_censor()`: Change values outside limits to `NA`.

## Common Patterns

### Formatting ggplot2 Axes
```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_y_continuous(labels = label_comma()) +
  scale_x_continuous(labels = label_number(suffix = " L"))
```

### Customizing Currency
```r
# Format as Euros with space separator
label_currency(prefix = "€", big.mark = " ")(c(100, 1000, 10000))
```

### Handling Log Scales with Better Labels
```r
ggplot(msleep, aes(bodywt, brainwt)) +
  geom_point() +
  scale_x_log10(breaks = breaks_log(), labels = label_log())
```

## Tips
*   **Heuristics:** `label_number_auto()` is a smart default that switches between decimal and scientific notation based on the data range.
*   **Composition:** Use `compose_label()` to chain multiple label formatters together.
*   **Palette Recommendations:** Use `pal_viridis()` or `pal_brewer()` for accessible, perceptually uniform color mappings.

## Reference documentation
- [Package ‘scales’](./references/reference_manual.md)