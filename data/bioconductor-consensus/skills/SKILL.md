---
name: bioconductor-consensus
description: This tool fits and visualizes row-linear models to evaluate the performance of multiple measurement platforms or laboratory protocols without a gold standard. Use when user asks to compare the sensitivity, precision, and dynamic range of different genomic technologies, fit consensus models to multi-platform data, or identify discordant genes across measurement conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/consensus.html
---

# bioconductor-consensus

name: bioconductor-consensus
description: Fitting and visualizing row-linear models for interlaboratory testing (ASTM E691) in a genomic context. Use this skill to compare the sensitivity, precision, and dynamic range of different measurement platforms (e.g., Microarray vs. RNA-Seq) or laboratory protocols using matched samples.

# bioconductor-consensus

## Overview

The `consensus` package implements row-linear models to evaluate the performance of multiple measurement platforms without requiring a "gold standard." It treats all measurements as estimates and uses an empirical approach to characterize the advantages and disadvantages of each technology. It is particularly useful for multi-platform genomic studies where the same samples are measured across different conditions.

## Core Workflow

### 1. Data Preparation
Data must be organized into a set of matrices (one per platform/condition).
- **Requirement**: All matrices must have identical dimensions, row names (loci/genes), and column names (samples).
- **Structure**: Rows = Loci, Columns = Samples.

```r
library(consensus)
library(RColorBrewer)

# Example: list of matrices (U133A, Huex, Agilent, RNASeq)
# Ensure names and dimensions match across all list elements
data_list <- list(U133A, Huex, Agilent, RNASeq)
platform_names <- c("U133A", "Huex", "Agilent", "RNA-Seq")
```

### 2. Creating a MultiMeasure Object
The `MultiMeasure` object is the required input for fitting models.

```r
tcga_mm <- MultiMeasure(names = platform_names, data = data_list)
```

### 3. Fitting the Model
The `fitConsensus` function fits a row-linear model for every locus. The model decomposes measurements into:
- **Average ($a_i$):** The dynamic range/intercept of platform $i$.
- **Sensitivity ($b_i$):** The slope (response to changes in expression).
- **Precision ($d_i$):** The residual scatter (lower values indicate higher precision).

```r
fit <- fitConsensus(tcga_mm)
```

### 4. Visualization and Interpretation

#### Visualizing a Single Locus
To see how specific genes (e.g., "TP53") behave across platforms:
```r
plotOneFit(tcga_mm, "TP53", brewer.pal(n = 4, name = "Dark2"))
```

#### Marginal Distributions
Compare the global performance of platforms across all loci:
```r
# Compare dynamic ranges
plotMarginals(fit, "average", brewer.pal(n = 4, name = "Dark2"))

# Compare sensitivity (higher is generally better)
plotMarginals(fit, "sensitivity", brewer.pal(n = 4, name = "Dark2"))

# Compare precision (log scale; lower values = higher precision)
plotMarginals(fit, "precision", brewer.pal(n = 4, name = "Dark2"))
```

#### Identifying Discordance
Identify loci where platforms disagree most significantly:
```r
# Plot heatmap of the 15 most discordant genes regarding sensitivity
plotMostDiscordant(fit, "sensitivity", 15)
```

## Tips for Analysis
- **Sensitivity ($b_i$):** A sensitivity near 0 indicates a platform is not responding to changes in the underlying sample concentration for that specific locus.
- **Precision ($d_i$):** If one platform shows significantly higher $d_i$ values in `plotMarginals`, it suggests lower technical reproducibility compared to the others.
- **Platform Trade-offs:** Use these plots to identify if a platform's high sensitivity comes at the cost of lower precision.

## Reference documentation
- [consensus](./references/consensus.md)