---
name: r-ggthemes
description: "Some extra themes, geoms, and scales for 'ggplot2'.     Provides 'ggplot2' themes and scales that replicate the look of plots     by Edward Tufte, Stephen Few, 'Fivethirtyeight', 'The Economist', 'Stata',     'Excel', and 'The Wall Street Journal', among others.     Provides 'geoms' for Tufte's box plot and range frame.</p>"
homepage: https://cloud.r-project.org/web/packages/ggthemes/index.html
---

# r-ggthemes

## Overview
The `ggthemes` package extends `ggplot2` by providing a collection of themes and scales that emulate famous data visualizations and legacy software styles. It is particularly useful for creating publication-quality graphics or accessible charts (e.g., colorblind-safe scales).

## Installation
To install the stable version from CRAN:
```r
install.packages("ggthemes")
```

## Core Workflows

### Applying Themes and Scales
Most themes in `ggthemes` have corresponding color or fill scales. For the best visual consistency, use them together.

```r
library(ggplot2)
library(ggthemes)

# Example plot
p <- ggplot(mtcars, aes(x = wt, y = mpg, colour = factor(gear))) +
  geom_point() +
  labs(title = "Fuel Economy", colour = "Gears")

# The Economist style
p + theme_economist() + scale_colour_economist()

# Wall Street Journal style
p + theme_wsj() + scale_colour_wsj()

# Solarized (Dark)
p + theme_solarized(light = FALSE) + scale_colour_solarized()
```

### Popular Themes
- `theme_fivethirtyeight()`: Mimics the clean, data-journalism style of FiveThirtyEight.
- `theme_tufte()`: A minimalist theme based on Edward Tufte’s "data-ink ratio" principles.
- `theme_few()`: Based on Stephen Few’s "Practical Rules for Visual Communication."
- `theme_excel_new()`: Replicates the look of modern MS Excel charts.
- `theme_clean()`: A simple, white-background theme with a thin frame.

### Specialized Scales
- `scale_colour_colorblind()`: Provides a color palette accessible to people with color vision deficiencies.
- `scale_colour_tableau()`: Uses the high-quality color palettes from Tableau software.
- `scale_colour_gdocs()`: Uses the default colors from Google Docs/Sheets.

### Unique Geoms
- `geom_tufteboxplot()`: A minimalist boxplot that uses whitespace to indicate the median and quartiles.
- `geom_rangeframe()`: Adds axis lines (range frames) that only extend to the range of the data, following Tufte's guidelines.

## Tips for Usage
- **Base Size**: Most themes accept a `base_size` argument to scale text elements globally (e.g., `theme_wsj(base_size = 10)`).
- **Foundation**: `theme_foundation()` is available for users wishing to create their own consistent theme sets.
- **Compatibility**: Since these are standard ggplot2 components, they can be further customized using the `theme()` function after the `ggthemes` function is called.

## Reference documentation
- [README](./references/README.md)