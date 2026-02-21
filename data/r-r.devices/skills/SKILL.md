---
name: r-r.devices
description: "Functions for creating plots and image files in a unified way     regardless of output format (EPS, PDF, PNG, SVG, TIFF, WMF, etc.). Default     device options as well as scales and aspect ratios are controlled in a uniform     way across all device types. Switching output format requires minimal changes     in code. This package is ideal for large-scale batch processing, because it     will never leave open graphics devices or incomplete image files behind, even on     errors or user interrupts.</p>"
homepage: https://cloud.r-project.org/web/packages/R.devices/index.html
---

# r-r.devices

name: r-r.devices
description: Unified handling of R graphics devices for creating plots and image files (PDF, PNG, SVG, etc.). Use when you need to generate plots in multiple formats, ensure graphics devices are properly closed (even on errors), manage consistent aspect ratios/scales across device types, or automate batch processing of figures.

## Overview

The `R.devices` package provides a unified interface for creating plots and image files in R. It abstracts away the differences between various graphics devices (like `pdf()`, `png()`, `svg()`), allowing you to switch output formats with minimal code changes. Its core strength is "atomic" file creation: it ensures that image files are only created if the plotting code completes successfully, and it automatically handles closing devices to prevent resource leaks.

## Installation

```R
install.packages("R.devices")
```

## Core Functions

### devEval() and toNNN()
The primary way to create figures is using `devEval()` or its format-specific wrappers (`toPDF()`, `toPNG()`, etc.). These functions take a name and a block of code to execute.

```R
library(R.devices)

# Using the generic devEval
devEval("pdf", name="MyPlot", aspectRatio=0.6, {
  curve(dnorm, from=-5, to=+5)
})

# Using the convenient wrapper
toPNG("MyPlot", aspectRatio=0.6, scale=2, {
  plot(1:10)
})
```

### Supported Formats
Available wrappers include: `toBMP()`, `toEPS()`, `toPDF()`, `toPNG()`, `toSVG()`, `toTIFF()`, `toWMF()`, and `toFavicon()`.

### Managing Options
Use `devOptions()` to set global defaults for all devices or specific settings for one type.

```R
# View current PDF options
devOptions("pdf")

# Set global output directory and separator
devOptions("*", path="figures/results", sep="_")

# Set specific default width for PNGs
devOptions("png", width=1024)

# Reset to defaults
devOptions("pdf", reset=TRUE)
```

## Key Workflows

### Creating Multiple Formats Simultaneously
You can pass a vector of device types to `devEval()` to generate the same plot in multiple formats at once.

```R
devEval(c("pdf", "png", "svg"), name="MultiFormatPlot", {
  hist(rnorm(100))
})
```

### Using Tags for Filenames
Instead of manually constructing strings, use the `tags` argument to append metadata to filenames (e.g., `PlotName,tag1,tag2.png`).

```R
for (s in c(1, 2)) {
  toPNG("Experiment", tags=c("results", paste0("scale", s)), scale=s, {
    plot(runif(10))
  })
}
# Creates: Experiment,results,scale1.png and Experiment,results,scale2.png
```

### Robust Batch Processing
`R.devices` is ideal for batch scripts because it uses temporary files. If a plot fails halfway through, no corrupted or incomplete file is left in the destination folder.

```R
# This will NOT create a file because the code errors
toPDF("FailingPlot", {
  plot(1:10)
  stop("Intentional error")
})
```

## Tips and Best Practices

- **Aspect Ratio**: Use `aspectRatio` (height/width) to maintain visual consistency across different output formats (e.g., 0.6 for a golden-ratio-like feel).
- **Scaling**: Use `scale` to increase the resolution/size of a plot without changing the relative proportions of text and points.
- **Avoid dev.off()**: When using `devEval()` or `toNNN()`, do not call `dev.off()`. The package handles device closure automatically.
- **Path Management**: Set `devOptions("*", path="my/folder")` at the start of a script to keep your working directory clean.

## Reference documentation

- [R.devices overview](./references/R.devices-overview.md)