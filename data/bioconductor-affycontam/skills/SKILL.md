---
name: bioconductor-affycontam
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/affyContam.html
---

# bioconductor-affycontam

name: bioconductor-affycontam
description: Structured corruption of Affymetrix CEL-level data for quality assessment. Use this skill to evaluate microarray quality metrics by injecting artificial defects (circular or rectangular) into AffyBatch objects.

## Overview

The `affyContam` package is a specialized tool for Bioconductor used to simulate quality problems in Affymetrix microarray data. By introducing "in silico" artifacts—such as regions of low intensity, high intensity, or increased variance—analysts can test the sensitivity and robustness of various quality control (QC) metrics and outlier detection algorithms.

## Core Workflows

### Loading Data
The package typically operates on `AffyBatch` objects. You can use the `Dilution` dataset from `affydata` for testing.

```r
library(affydata)
library(affyContam)
data(Dilution)
```

### Injecting Circular Defects
Use `setCircRegion` to create a circular area of contamination on a specific chip.

```r
# Create a circular defect on the first chip
# Default: center=c(150, 150), rad=75
dilc <- setCircRegion(Dilution, chip=1)

# Visualize the defect
image(dilc[,1])
```

### Injecting Rectangular Defects
Use `setRectRegion` to create rectangular artifacts by specifying index ranges for x and y coordinates.

```r
# Create a rectangular defect
dilr <- setRectRegion(Dilution, chip=1, xinds=100:200, yinds=100:400, vals=10)
image(dilr[,1])
```

### Customizing Contamination
Both `setCircRegion` and `setRectRegion` allow for fine-grained control over the "corrupted" values:

*   **vals**: A constant value to assign to the pixels in the region.
*   **valgen**: A function (like `rnorm`) to generate random values for the region.
*   **Retrieving data**: Use `getCircRegion` or `getRectRegion` to extract the original values before modifying them (useful for scaling variance).

```r
# Example: Increase variance in a region by a factor of 3
orig_vals <- getCircRegion(Dilution, chip=1, center=c(150, 500), rad=100)
dil_var <- setCircRegion(Dilution, chip=1, center=c(150, 500), rad=100, vals=orig_vals * 3)
```

## Advanced Usage: Sensitivity Analysis
A common workflow involves:
1.  Calculating "ground truth" expression values (e.g., using `rma`).
2.  Contaminating one or more chips in the `AffyBatch`.
3.  Re-running the analysis (e.g., `rma`, `lmFit`).
4.  Comparing the results (t-statistics or fold changes) between the original, contaminated, and "repaired" (outlier-removed) datasets.

## Tips
*   **Visualization**: Always use `image()` on the modified `AffyBatch` to verify the location and intensity of the injected artifact.
*   **Outlier Detection**: This package is frequently used in conjunction with `affyMvout` or `mdqc` to see if those packages successfully flag the contaminated chips as outliers.
*   **CDF Requirement**: The functions require the appropriate CDF package for the microarray platform to be installed to map coordinates to indices.

## Reference documentation
- [affyContam: structured corruption of CEL-level data](./references/affyContam.md)