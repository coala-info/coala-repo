---
name: r-gdtools
description: gdtools provides utilities for computing font metrics and managing fonts within the R environment. Use when user asks to calculate text string dimensions, register Google or Liberation fonts, check font availability, or manage font dependencies for R graphics and HTML outputs.
homepage: https://cloud.r-project.org/web/packages/gdtools/index.html
---


# r-gdtools

## Overview

`gdtools` provides tools for computing font metrics and managing fonts in R. It allows for precise text measurement using Cairo and FreeType, font discovery via `systemfonts`, and easy integration of Google Fonts or bundled Liberation fonts into R graphics and HTML-based outputs.

## Installation

Install the released version from CRAN:

```r
install.packages("gdtools")
```

## Font Metrics

Use `strings_sizes()` to calculate the width, ascent, and descent of text strings in inches. This is essential for layout calculations like column widths or text wrapping.

```r
library(gdtools)

# Basic measurement
metrics <- strings_sizes(c("Hello", "World"), fontsize = 12)

# Vectorized arguments for different styles
strings_sizes(
  c("Normal", "Bold", "Italic"),
  fontsize = 12,
  bold = c(FALSE, TRUE, FALSE),
  italic = c(FALSE, FALSE, TRUE)
)
```

## Font Management

### Automated Setup
`font_set_auto()` detects the best available system fonts and falls back to Liberation fonts if necessary. It returns a `font_set` object containing font names and HTML dependencies.

```r
fonts <- font_set_auto()
# Access specific roles
fonts$sans
fonts$serif
```

### Google Fonts
You can download, cache, and register Google Fonts for use in R sessions or web-based outputs.

```r
# Register a Google Font with systemfonts
register_gfont(family = "Open Sans")

# Create an htmlDependency for Shiny/R Markdown
dep <- gfontHtmlDependency(family = "Open Sans")
```

### Liberation Fonts
`gdtools` bundles Liberation Sans, Serif, and Mono. These are useful for cross-platform consistency or offline environments.

```r
# Register all Liberation fonts and get dependencies
lib_fonts <- font_set_liberation()

# Register individual variants
register_liberationsans()
```

## Font Availability

Check if specific fonts are available on the system to avoid silent fallbacks during rendering.

```r
# Check for a specific family
font_family_exists("Arial")

# List all system fonts
sys_fonts()
```

## Integration with HTML Outputs

When using fonts in `ggiraph`, `Shiny`, or `R Markdown`, you must ensure the browser can access the fonts.

1. Use `font_set()` to define the font mapping.
2. Pass `fonts$dependencies` to the HTML toolset or `ggiraph` widget.

```r
fonts <- font_set(sans = font_google("Roboto"))
# Use fonts$dependencies in your UI or widget call
```

## Reference documentation

- [gdtools: Font Metrics and Font Management Utilities for R Graphics](./references/home_page.md)