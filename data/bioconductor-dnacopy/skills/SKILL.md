---
name: bioconductor-dnacopy
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/DNAcopy.html
---

# bioconductor-dnacopy

## Overview

The `DNAcopy` package implements the Circular Binary Segmentation (CBS) algorithm to analyze DNA copy number data. It is primarily used for array Comparative Genomic Hybridization (array CGH) data to identify genomic regions where the copy number has changed. The workflow involves converting raw data into a Copy Number Array (CNA) object, smoothing outliers, and performing segmentation to find statistically significant change-points.

## Core Workflow

### 1. Data Preparation
Data must be formatted into a `CNA` object. You need the log-ratios (or other copy number metrics), chromosome identifiers, and map positions.

```r
library(DNAcopy)
# Example using internal 'coriell' dataset
data(coriell)

# Create CNA object
# Arguments: data (matrix/vector), chromosome, map position, data.type, sampleid
cna_obj <- CNA(cbind(coriell$Coriell.05296),
               coriell$Chromosome, 
               coriell$Position,
               data.type = "logratio", 
               sampleid = "c05296")
```

### 2. Smoothing Outliers
It is highly recommended to smooth single-point outliers before segmentation to prevent false change-points.

```r
smoothed_cna <- smooth.CNA(cna_obj)
```

### 3. Segmentation (CBS)
The `segment` function performs the actual change-point analysis.

```r
# Default segmentation
seg_results <- segment(smoothed_cna, verbose=1)

# Segmentation with 'undo' to remove non-significant splits
# 'sdundo' removes splits that are not a certain number of SDs apart
seg_results_refined <- segment(smoothed_cna, 
                               undo.splits = "sdundo", 
                               undo.SD = 3)
```

### 4. Visualization
`DNAcopy` provides several plot types to interpret results:

*   `plot.type="w"` (Whole genome): Plots data ordered by chromosome and position.
*   `plot.type="s"` (Sample): Plots by chromosome within a specific study/sample.
*   `plot.type="c"` (Chromosome): Plots a specific chromosome across multiple studies.
*   `plot.type="p"` (Plateau): Orders segments by their means to help determine thresholds for calling gains/losses.

```r
plot(seg_results, plot.type="w")
plot(seg_results, plot.type="s")
```

## Tips and Advanced Usage

*   **Subsetting:** Use `subset.CNA` or `subset.DNAcopy` to isolate specific chromosomes or samples without re-running the entire analysis.
*   **Performance:** For large datasets, the hybrid approach (default) is faster than full permutation. You can further tune performance by adjusting `nperm` (default 10,000) or using `getbdry` to pre-compute stopping boundaries.
*   **Calling Gains/Losses:** While the package finds change-points, the user typically defines thresholds (e.g., > 0.4 for gain, < -0.6 for loss) based on the "plateau" plot (`plot.type="p"`).
*   **Data Types:** While "logratio" is standard, the `CNA` function can handle other numeric copy number data.

## Reference documentation

- [DNAcopy: A Package for Analyzing DNA Copy Data](./references/DNAcopy.md)