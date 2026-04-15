---
name: bioconductor-plw
description: This tool performs differential expression analysis for Affymetrix and multiple-probe microarrays using the Probe level Locally moderated Weighted median-t method. Use when user asks to perform probe-level empirical Bayes analysis, handle array-to-array correlations, or apply the Locally Moderated Weighted-t method on probe-set summaries and two-color cDNA data.
homepage: https://bioconductor.org/packages/3.5/bioc/html/plw.html
---

# bioconductor-plw

name: bioconductor-plw
description: Differential expression analysis for Affymetrix and multiple-probe microarrays using the Probe level Locally moderated Weighted median-t (PLW) method. Use this skill to perform probe-level empirical Bayes analysis, handle array-to-array correlations, and apply the Locally Moderated Weighted-t (LMW) method on probe-set summaries or two-color cDNA data.

# bioconductor-plw

## Overview

The `plw` package implements the Probe level Locally moderated Weighted median-t (PLW) method for finding differentially expressed genes. Unlike standard methods that summarize probes into probe-sets before analysis, PLW performs inference on individual perfect-match (PM) probes and then summarizes the results. This approach accounts for the dependency between variability and intensity levels using an empirical Bayes model and handles array-to-array correlations via a global covariance matrix.

## Core Workflows

### 1. Data Preparation
`plw` typically works with `AffyBatch` objects from the `affy` package.

```R
library(plw)
# Load example data or read CEL files
data(AffySpikeU95Subset) 
# To read your own data:
# raw_data <- ReadAffy()
```

### 2. Defining Design and Contrasts
Analysis requires a design matrix (representing experimental groups) and a contrast matrix (defining the specific comparison).

```R
# Example: 2 groups, 3 replicates each
group <- factor(rep(c("control", "treatment"), each = 3))
design <- model.matrix(~group - 1)
colnames(design) <- c("control", "treatment")

# Contrast: treatment - control
contrast <- matrix(c(-1, 1), 1, 2)
```

### 3. Running PLW (Probe-Level)
The `plw` function performs the core analysis on the `AffyBatch` object.

```R
plwFit <- plw(AffyBatchObject, design = design, contrast = contrast)
# epsilon: convergence threshold (default 1e-05)
```

### 4. Running LMW (Probe-Set or Two-Color Level)
Use `lmw` for data that is already summarized (like RMA expression indexes) or for two-color cDNA arrays.

```R
# For summarized data (ExpressionSet)
# meanX is the mean intensity used for the scale-parameter function
lmwFit <- lmw(exprs(eset), design = design, contrast = contrast, meanX = rowMeans(exprs(eset)))
```

## Analyzing and Visualizing Results

### Ranking Genes
Extract the top differentially expressed genes based on the median-t statistic.

```R
# Top 20 genes
topRankSummary(plwFit, nGenes = 20)

# Specific genes by ID
topRankSummary(plwFit, genes = c("1708_at", "36202_at"))

# Genes by specific rank range
topRankSummary(plwFit, genesOfRank = 11:20)
```

### Visualization
- `plotSummaryT(fit, ...)`: Plots t-statistics for individual PM probes within probe-sets.
- `plotSummaryLog2FC(fit, ...)`: Plots log2 fold-change values for individual probes.
- `varHistPlot(fit)`: Compares the fitted distribution for log(s²) with observed data to check model fit.
- `scaleParameterPlot(fit)`: Visualizes the fitted curve for the scale parameter (ν) against mean intensity.

## Tips for Success
- **Memory**: PLW operates at the probe level; for very large Affymetrix chips, ensure sufficient RAM is available.
- **Convergence**: If `plw` fails to converge, check the `Convergence status` in the fit object and consider adjusting `epsilon`.
- **Two-Color Data**: When using `lmw` on two-color data, ensure you provide the `meanX` argument (usually the average of A-values) to correctly model the intensity-dependent variance.

## Reference documentation
- [HowTo plw](./references/HowToPLW.md)