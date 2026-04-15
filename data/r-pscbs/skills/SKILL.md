---
name: r-pscbs
description: This tool performs parent-specific DNA copy-number segmentation on genomic data to identify total and allele-specific copy numbers. Use when user asks to perform genomic segmentation on paired tumor-normal data, identify loss of heterozygosity, or detect allelic imbalances.
homepage: https://cran.r-project.org/web/packages/pscbs/index.html
---

# r-pscbs

name: r-pscbs
description: Analysis of parent-specific DNA copy numbers (PSCBS) in R. Use this skill when performing genomic segmentation on paired tumor-normal data to identify total copy numbers (TCN) and allele-specific/parent-specific copy numbers (PSCN).

# r-pscbs

## Overview
The `pscbs` package implements the Parent-Specific Copy-Number Segmentation (Paired PSCBS) method. It allows for the identification of genomic segments with constant total copy numbers and constant allele-specific copy numbers. It is particularly effective for tumor-normal paired studies, enabling the detection of Loss of Heterozygosity (LOH) and allelic imbalances.

## Installation
To install the package from CRAN:
```R
# Required dependencies from Bioconductor
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("aroma.light", "DNAcopy"))

# Install pscbs
install.packages("PSCBS")
```

## Core Workflow

### 1. Data Preparation
The input should be a data frame containing:
- `chromosome`: Integer or character
- `x`: Genomic position (bp)
- `CT`: Total copy number (tumor/normal ratio)
- `betaT`: Tumor allele B fractions (BAF)
- `betaN`: Normal allele B fractions (BAF)

```R
library(PSCBS)
data <- exampleData("paired.chr01")

# Pre-processing: Drop outliers
data <- dropSegmentationOutliers(data)

# Optional: Identify chromosome arms/gaps to prevent segmenting across centromeres
gaps <- findLargeGaps(data, minLength = 1e+06)
knownSegments <- gapsToSegments(gaps)
```

### 2. Segmentation
The primary function is `segmentByPairedPSCBS()`.

```R
# Run segmentation
fit <- segmentByPairedPSCBS(data, knownSegments = knownSegments)

# View results
print(fit)
```

### 3. Extracting Results
Use `getSegments()` to retrieve the segmentation table.

```R
# simplify = TRUE returns a data.frame
segments <- getSegments(fit, simplify = TRUE)

# Key columns in output:
# tcnMean: Mean total copy number
# c1Mean: Mean of the minor allele
# c2Mean: Mean of the major allele
# dhMean: Mean dual-haplotype (allelic imbalance)
```

### 4. Visualization
```R
# Plot copy-number tracks (TCN and PSCN)
plotTracks(fit)
```

## Parallel Processing
`pscbs` supports the `future` framework for parallelizing segmentation across chromosomes.

```R
library(future)
plan(multisession) # Enable parallel processing
# Run segmentByPairedPSCBS as usual
plan(sequential)  # Revert to single-core
```

## Tips
- **TumorBoost**: For better BAF signals, consider normalizing tumor allele fractions using the `TumorBoost` method (often integrated or used prior to PSCBS).
- **Centromeres**: Always provide `knownSegments` if your data spans centromeres to avoid false segments connecting p and q arms.
- **Non-Paired Data**: While the package specializes in paired data, it also provides `segmentByCBS()` for total copy number segmentation of single samples.

## Reference documentation
- [CONDUCT.md](./references/CONDUCT.md)
- [CONTRIBUTING.md](./references/CONTRIBUTING.md)
- [NEWS.md](./references/NEWS.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)