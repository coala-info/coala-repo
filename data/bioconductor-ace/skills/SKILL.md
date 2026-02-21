---
name: bioconductor-ace
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ACE.html
---

# bioconductor-ace

## Overview

The `ACE` package provides tools for absolute copy number estimation. It scales segmented copy number data (typically from the `QDNAseq` package) to fit integer copy numbers by testing various cellularity (tumor cell percentage) and ploidy models. It helps researchers determine the percentage of tumor cells in a sample and provides adjusted segment values for downstream analysis, such as linking mutations to absolute copy numbers.

## Core Workflow

### 1. Initial Processing with runACE
The `runACE` function is the primary entry point for batch processing. It can take BAM files or segmented RDS files.

```r
library(ACE)
userpath <- "path/to/data"

# Process BAM files (requires QDNAseq dependencies)
runACE(userpath, filetype='bam', binsizes = c(100, 1000), ploidies = c(2,4))

# Process existing segmented QDNAseq objects
runACE(userpath, filetype='rds', ploidies = c(2))
```

### 2. Model Selection and Fitting
ACE generates multiple potential fits. The "best fit" (lowest error) is not always the biological truth. Users should examine the `summary_likelyfits` output.

*   **Best Fit:** Lowest relative error.
*   **Last Minimum:** Often the fit at the highest cellularity, which is frequently the most likely biological model.
*   **Penalty:** Use the `penalty` argument (e.g., `0.5`) in `runACE` or `singlemodel` to penalize models with very low cellularity, which helps reduce false positives in noisy data.

### 3. Examining Single Samples
Use `singlemodel` and `singleplot` to fine-tune a specific sample if the batch run didn't produce a satisfactory result.

```r
data("copyNumbersSegmented")
# Calculate models for a specific sample in a QDNAseq object
model <- singlemodel(copyNumbersSegmented, QDNAseqobjectsample = 2, ploidy = 3)

# Plot a specific fit
singleplot(copyNumbersSegmented, QDNAseqobjectsample = 2, cellularity = 0.46, ploidy = 3)
```

### 4. Advanced Fitting with squaremodel
If the standard (median segment) is on a subclonal or non-diploid segment, use `squaremodel` to search across a range of ploidies and cellularities simultaneously.

```r
# Generate a 2D error matrix (ploidy vs cellularity)
sqmodel <- squaremodel(copyNumbersSegmented, index = 2, penalty = 0.5, penploidy = 0.5)
# View the "Sky on fire" plot
sqmodel$matrixplot
```

## Data Extraction and Integration

### Adjusted Segments
To get a dataframe of segments scaled to absolute copy numbers:
```r
# template can be created via objectsampletotemplate()
segments <- getadjustedsegments(template, cellularity = 0.38, ploidy = 2)
```

### Linking Variants
To calculate the number of mutant copies for specific mutations:
```r
# variantdf requires Chromosome, Position, and Frequency (0-100)
linkvariants(variantdf, segmentdf, cellularity = 0.38)
```

### Genomic Locations
To look up the absolute copy number of a specific gene or coordinate:
```r
analyzegenomiclocations(segmentdf, Chromosome = 1, Position = 26365569)
```

## Tips for Success
*   **Bin Size:** Use larger bin sizes (500kb or 1000kb) for more robust segmentation and faster processing.
*   **Sex Chromosomes:** Use the `sgc` (single germline copy) argument for male samples: `sgc = c("X", "Y")`.
*   **Standard:** If the median segment isn't the main ploidy, manually set the `standard` argument to the value of a known diploid (or target ploidy) segment.
*   **Error Methods:** While "RMSE" is default, "MAE" (Mean Absolute Error) can be used in `singlemodel` for a less quadratic penalty on outliers.

## Reference documentation
- [ACE vignette](./references/ACE_vignette.md)
- [ACE vignette Rmd](./references/ACE_vignette.Rmd)