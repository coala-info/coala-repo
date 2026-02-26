---
name: bioconductor-beadarray
description: This package provides tools for the analysis of Illumina BeadArray data from raw bead-level or summarized formats. Use when user asks to import Illumina array data, perform quality control, visualize spatial artifacts, summarize bead-level intensities, or normalize expression and SNP array data.
homepage: https://bioconductor.org/packages/release/bioc/html/beadarray.html
---


# bioconductor-beadarray

name: bioconductor-beadarray
description: Analysis of Illumina BeadArray data, including bead-level (raw TIFFs/text) and bead-summary (BeadStudio/GenomeStudio) formats. Use this skill when processing Illumina expression or SNP arrays, performing quality control, normalization, and differential expression analysis using the beadarray R package.

# bioconductor-beadarray

## Overview
The `beadarray` package is a comprehensive solution for the analysis of Illumina's BeadArray technology. It handles the transition from raw bead-level data to summarized gene-level intensities. It is particularly strong at identifying spatial artifacts on arrays and providing robust summarization methods that account for the unique replicated nature of beads on Illumina platforms.

## Core Workflows

### 1. Data Import
The package supports two main entry points depending on the data stage:

**Bead-level data (Raw):**
Requires the raw `.txt` or `.tif` files and a targets file.
```r
library(beadarray)
# Read bead-level data
beadLevelData <- readIllumina(dir = ".", useImages = FALSE)
```

**Summary-level data (GenomeStudio output):**
```r
# Read BeadStudio/GenomeStudio summary files
summaryData <- readBeadSummaryData(dataFile = "Sample_Table.txt", 
                                   qcFile = "Control_Gene_Profile.txt")
```

### 2. Quality Control
`beadarray` provides specialized plotting functions to identify problematic arrays or spatial biases.

```r
# Boxplot of intensities
boxplot(beadLevelData)

# Image plots to identify spatial artifacts (for bead-level)
imageplot(beadLevelData, array = 1)

# Calculate outlier statistics
outlierStats <- calculateOutlierStats(beadLevelData)
```

### 3. Summarization
Converting bead-level data to a `ExpressionSetIllumina` object (summary level). This step involves log-transforming and removing outliers.

```r
# Default summarization (log2 transform and outlier removal)
ExpressionSetIllumina <- summarize(beadLevelData)
```

### 4. Normalization
Once data is at the summary level, standard or Illumina-specific normalization can be applied.

```r
# Quantile normalization
data.norm <- normaliseIllumina(ExpressionSetIllumina, method = "quantile")

# NEQC normalization (requires control probes)
data.neqc <- normaliseIllumina(ExpressionSetIllumina, method = "neqc")
```

### 5. Differential Expression
The package integrates well with `limma` for linear modeling.

```r
library(limma)
design <- model.matrix(~condition)
fit <- lmFit(exprs(data.norm), design)
fit <- eBayes(fit)
topTable(fit)
```

## Key Functions Reference
- `readIllumina()`: Primary function for bead-level data import.
- `readBeadSummaryData()`: Imports data exported from GenomeStudio.
- `summarize()`: Aggregates bead-level replicates into single values per probe.
- `normaliseIllumina()`: Supports 'none', 'scale', 'quantile', and 'neqc' methods.
- `imageplot()`: Visualizes the physical layout of the array to spot artifacts.
- `calculateDetection()`: Calculates detection p-values for summary data.

## Tips for Success
- **Memory Management**: Bead-level objects can be very large. Use `useImages = FALSE` in `readIllumina()` unless you specifically need to perform image processing.
- **Annotation**: Use the `illuminaXXXX.db` packages (where XXXX is the platform, e.g., `Humanv4`) in conjunction with `beadarray` for up-to-date gene mapping.
- **Control Probes**: When using `readBeadSummaryData`, ensure the `Control Gene Profile` is included to enable advanced normalization like `neqc`.

## Reference documentation
- [beadarray Main Documentation](https://bioconductor.org/packages/release/bioc/html/beadarray.html)