---
name: bioconductor-bioccasestudies
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/bioc/html/BiocCaseStudies.html
---

# bioconductor-bioccasestudies

name: bioconductor-bioccasestudies
description: Support for the Bioconductor Case Studies monograph. Use this skill to manage package dependencies for the case studies, format R output for publication, use predefined color schemes for biological data visualization, and perform resampling analysis on ExpressionSet objects (specifically the ALL dataset).

## Overview

The `BiocCaseStudies` package provides infrastructure, data, and utility functions to support the "Bioconductor Case Studies" monograph. It is primarily used to ensure environment consistency, provide standardized formatting for show methods, and offer specific visualization tools used throughout the case studies.

## Package Management and Setup

Before running case study code, ensure all required dependencies are present:

```r
library(BiocCaseStudies)

# Check for missing or outdated packages required by the case studies
# Returns a character vector of packages to install
pkgs <- packages2install()

# Install missing dependencies using BiocManager
if(length(pkgs) > 0) {
  BiocManager::install(pkgs)
}

# Verify all required packages are available
requiredPackages(load = FALSE)
```

## Output Formatting and Visualization

### Text Formatting
Use `fixedWidthCat` to ensure R object output fits within specific character widths, which is useful for generating reports or console displays with strict margin requirements.

```r
long_string <- paste(rep(letters, 10), collapse="")
fixedWidthCat(long_string, width = 60)
```

### Standardized Colors
The package defines specific color constants to maintain visual consistency across different plots (e.g., histograms, barplots):
- Light colors: `lcol1`, `lcol2`, `lcol3`
- Dark colors: `dcol1`, `dcol2`, `dcol3`

### Session Reporting
To generate LaTeX-formatted session information and references for a report:
```r
mySessionInfo(ref = TRUE)
```

## Resampling Analysis

The `resample` function is designed to evaluate the stability of differential expression results by repeatedly sampling subsets of an `ExpressionSet` (typically from the `ALL` package).

```r
# Example workflow for resampling
# x: An ExpressionSet object
# selfun: A function that calculates the number of DE genes
resample(x, selfun, groupsize = c(6, 12, 18), nrep = 25)
```

## Reference documentation

- [BiocCaseStudies Reference Manual](./references/reference_manual.md)