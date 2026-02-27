---
name: bioconductor-tress
description: bioconductor-tress is an R package for analyzing MeRIP-seq data to identify m6A methylation sites and detect differential methylation across experimental conditions. Use when user asks to call m6A peaks from BAM files, perform differential methylation analysis, or visualize read depth and methylation levels for specific genomic regions.
homepage: https://bioconductor.org/packages/release/bioc/html/TRESS.html
---


# bioconductor-tress

## Overview

TRESS (Toolbox for mRNA epigenetics sequencing analysis) is an R package designed for the analysis of MeRIP-seq data. It provides a robust statistical framework for identifying m6A methylation sites and detecting differential methylation across different experimental conditions. TRESS utilizes a hierarchical negative binomial model to account for variability in read counts and offers specialized functions for both single-replicate and multi-replicate experimental designs.

## Core Workflows

### 1. Peak Calling (m6A Detection)

For identifying m6A peaks from BAM files, use the wrapper function `TRESS_peak`.

```r
library(TRESS)

# Define file paths
IP_files <- c("ip_rep1.bam", "ip_rep2.bam")
Input_files <- c("input_rep1.bam", "input_rep2.bam")
anno_sqlite <- "path/to/annotation.sqlite"

# Run peak calling
# This handles binning, candidate calling, and model fitting
TRESS_peak(
  IP.file = IP_files,
  Input.file = Input_files,
  Path_To_AnnoSqlite = anno_sqlite,
  InputDir = "path/to/bams",
  OutputDir = "path/to/results",
  experiment_name = "my_experiment",
  filetype = "bam"
)
```

### 2. Differential Methylation Analysis (DMR)

For comparing methylation between conditions (e.g., Wild Type vs. Knockout), follow the fit-then-test workflow.

```r
# 1. Fit the model
# 'variable' is a dataframe with sample metadata
# 'model' is a formula (e.g., ~1 + condition)
DMR_fit <- TRESS_DMRfit(
  IP.file = IP_files,
  Input.file = Input_files,
  Path_To_AnnoSqlite = anno_sqlite,
  variable = design_df,
  model = ~1 + condition,
  InputDir = "path/to/bams",
  experimentName = "DMR_study"
)

# 2. Perform hypothesis testing
# 'contrast' specifies the comparison (e.g., c(0, 1) for the second coefficient)
DMR_results <- TRESS_DMRtest(DMR = DMR_fit, contrast = c(0, 1))
```

## Key Functions and Parameters

### Data Preparation
- `DivideBins()`: Divides the genome into equal-sized bins (default 50bp) and counts reads.
- `CallCandidates()`: Identifies potential methylation regions by merging significant bins.

### Peak Calling Details
- `CallPeaks.multiRep()`: Used for multiple replicates; ranks peaks using a Wald test and a custom `rScore`.
- `CallPeaks.oneRep()`: Used when only one replicate is available; relies on binomial tests.
- `WhichThreshold`: Determines the criterion for significance. Options: `"pval"`, `"fdr"`, `"lfc"`, `"pval_lfc"`, or `"fdr_lfc"` (default).

### Differential Analysis Details
- `TRESS_DMRfit()`: The primary engine for DMR modeling.
- `CoefName()`: Helper to see the names of coefficients in the design matrix to construct the correct `contrast` vector.
- `DMRInfer()`: Allows choosing the null model for p-value calculation: `"standN"` (Standard Normal), `"2mix"` (2-component mixture), or `"trunN"` (Truncated Normal).

### Visualization
- `ShowOnePeak()`: Plots the IP/Input read depth and estimated methylation levels for a specific genomic region.

## Tips for Success

- **Annotation**: TRESS requires a `.sqlite` file for genome annotation. You can typically generate this from a GTF/GFF file using `GenomicFeatures::makeTxDbFromGFF()`.
- **Size Factors**: TRESS automatically estimates size factors for library normalization. If you have pre-calculated factors, you can pass them to the lower-level `CallPeaks.paramEsti` or `CallDMRs.paramEsti` functions.
- **Filtering**: Use `filterRegions()` to remove candidate DMRs with low coefficient of variation (CV) in methylation ratios to increase statistical power.
- **Memory**: For large genomes, ensure sufficient RAM is available during the `DivideBins` step, as it processes the entire transcriptome.

## Reference documentation
- [TRESS Reference Manual](./references/reference_manual.md)