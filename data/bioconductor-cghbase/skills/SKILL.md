---
name: bioconductor-cghbase
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/CGHbase.html
---

# bioconductor-cghbase

name: bioconductor-cghbase
description: Base functions and classes for arrayCGH (Comparative Genomic Hybridization) data analysis. Use when Claude needs to handle, manipulate, or visualize aCGH data using Bioconductor's infrastructure classes (cghRaw, cghSeg, cghCall, cghRegions).

## Overview

The `CGHbase` package provides the fundamental S4 classes and methods used by the arrayCGH analysis ecosystem in Bioconductor (notably `CGHcall` and `CGHregions`). It extends the `eSet` class to store copy number data, segmentation results, and calling probabilities alongside genomic coordinates (Chromosome, Start, End).

## Core Classes

- **cghRaw**: Stores raw or normalized log2 ratios. Requires a `copynumber` matrix.
- **cghSeg**: Stores segmented data. Requires `copynumber` and `segmented` matrices.
- **cghCall**: Stores called data. Requires `copynumber`, `segmented`, `calls`, and probability matrices (`probloss`, `probnorm`, `probgain`).
- **cghRegions**: Stores dimension-reduced region data.

## Essential Workflows

### 1. Data Import and Object Creation
To convert a data frame or text file into a `cghRaw` object, use `make_cghRaw`. The input must have columns for Name, Chromosome, Start, and End, followed by sample log2 ratios.

```r
library(CGHbase)
data(Wilting) # Example dataset
cgh_data <- make_cghRaw(Wilting)
```

### 2. Accessing Data
Use specific accessor functions rather than direct slot access:
- **Genomic Positions**: `chromosomes(obj)`, `bpstart(obj)`, `bpend(obj)`.
- **Assay Data**: `copynumber(obj)`, `segmented(obj)`, `calls(obj)`.
- **Probabilities (cghCall only)**: `probloss(obj)`, `probnorm(obj)`, `probgain(obj)`, `probamp(obj)`.
- **Regions**: `avedist(obj)` (average L1-distance), `nclone(obj)` (number of clones per region).

### 3. Visualization
The package provides specialized plotting methods for each class:
- **Profile Plots**: `plot(obj[, sample_index])` displays log2 ratios and segments ordered by position.
- **Frequency Plots**: `frequencyPlotCalls(cghCall_obj)` or `frequencyPlot(cghRegions_obj)` shows the frequency of gains and losses across the genome.
- **Summary Plots**: `summaryPlot(cghCall_obj)` shows average probabilities of aberrations.

```r
# Plot the first sample of a segmented object
plot(segmented_data[, 1])

# Plot only chromosome 1 for the first sample
plot(segmented_data[chromosomes(segmented_data) == 1, 1])
```

## Tips for Efficient Usage
- **Subsetting**: Objects can be subsetted like standard matrices: `object[features, samples]`.
- **Memory Management**: When plotting large datasets, use the `dotres` argument (e.g., `plot(obj, dotres=10)`) to plot every n-th probe, which significantly speeds up rendering.
- **Genome Builds**: When using frequency or summary plots, specify the `build` argument (e.g., `build='GRCh37'`) to ensure correct centromere positioning.

## Reference documentation
- [CGHbase: Base functions and classes for arrayCGH data analysis.](./references/reference_manual.md)