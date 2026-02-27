---
name: bioconductor-convert
description: This tool converts microarray data objects between Biobase, limma, and marray formats. Use when user asks to transform R objects between RGList, MAList, marrayRaw, marrayNorm, and ExpressionSet classes for Bioconductor workflows.
homepage: https://bioconductor.org/packages/release/bioc/html/convert.html
---


# bioconductor-convert

name: bioconductor-convert
description: Conversion between microarray data classes (Biobase, limma, and marray). Use this skill when you need to transform R objects between RGList, MAList, marrayRaw, marrayNorm, and ExpressionSet formats for Bioconductor workflows.

# bioconductor-convert

## Overview

The `convert` package is a utility for interoperability between major Bioconductor microarray analysis frameworks. It allows seamless transition between `limma` (RGList, MAList), `marray` (marrayRaw, marrayNorm), and `Biobase` (ExpressionSet) object classes. This is essential when a user wants to perform preprocessing in one package (e.g., `marray`) and downstream statistical analysis in another (e.g., `limma`).

## Core Workflow

The package relies on the `as()` function from the R `methods` package. The syntax follows the pattern: `as(object, "TargetClass")`.

### Supported Conversions

| Source Class | Target Class | Context |
| :--- | :--- | :--- |
| `marrayRaw` | `RGList` | Two-color raw intensities |
| `RGList` | `marrayRaw` | Two-color raw intensities |
| `marrayNorm` | `MAList` | Two-color normalized data (M/A values) |
| `MAList` | `marrayNorm` | Two-color normalized data (M/A values) |
| `MAList` | `ExpressionSet` | Log-ratios for clustering/classification |
| `marrayNorm` | `ExpressionSet` | Log-ratios for clustering/classification |

## Usage Examples

### Converting from marray to limma
If you have a normalized object `mnorm` created using the `marray` package and wish to use `limma` for linear modeling:

```r
library(convert)
# Convert marrayNorm to MAList
ma_list <- as(mnorm, "MAList")

# Now use limma functions
fit <- lmFit(ma_list, design)
```

### Converting to ExpressionSet for Downstream Analysis
To move from two-channel normalized data to a standard `ExpressionSet` (often used for heatmaps or machine learning):

```r
# From limma
eset_from_limma <- as(ma_list, "ExpressionSet")

# From marray
eset_from_marray <- as(mnorm, "ExpressionSet")
```

## Tips and Best Practices

1. **Load the Library**: Ensure `library(convert)` is called. While `as()` is a base R method, the specific coercion methods for these classes are defined within the `convert` package.
2. **Data Integrity**: Converting to `ExpressionSet` typically extracts the M-values (log-ratios). Note that `ExpressionSet` is a single-intensity-style container, so the original red/green foreground/background detail from an `RGList` or `marrayRaw` is usually condensed during the transition to normalized classes.
3. **Class Checking**: Use `class(object)` before and after conversion to verify the transformation was successful.

## Reference documentation

- [Converting Between Microarray Data Classes](./references/convert.md)