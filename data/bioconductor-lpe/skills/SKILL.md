---
name: bioconductor-lpe
description: This tool performs statistical analysis of microarray data with small numbers of replicates using the Local Pooled Error test. Use when user asks to perform differential expression analysis on limited replicates, estimate baseline error distributions, calculate z-statistics for gene expression, or apply False Discovery Rate correction.
homepage: https://bioconductor.org/packages/release/bioc/html/LPE.html
---

# bioconductor-lpe

name: bioconductor-lpe
description: Statistical analysis of microarray data with small numbers of replicates (2-3) using the Local Pooled Error (LPE) test. Use this skill to perform differential expression analysis when sample sizes are limited, including data normalization, baseline error distribution estimation, z-statistic calculation, and False Discovery Rate (FDR) correction.

# bioconductor-lpe

## Overview

The `LPE` package implements the Local Pooled Error test, specifically designed for microarray experiments with very few replicates (typically 2-3). It improves statistical power by pooling error estimates across genes with similar expression intensities, rather than relying on gene-specific variance which is unstable at low sample sizes. The workflow typically involves data normalization, calculating a baseline error distribution for each condition, and then performing the LPE test to identify differentially expressed genes.

## Core Workflow

### 1. Data Preparation and Normalization
Load the library and prepare your expression matrix. While LPE provides a `preprocess` function, you can use other methods like RMA or MAS5.

```R
library(LPE)

# Example using built-in dataset 'Ley'
data(Ley)
# Use a subset for testing
ley_subset <- Ley[1:1000, ]

# Preprocess (IQR normalization, thresholding, log2 transformation)
# columns 2:7 contain the expression data
ley_norm <- ley_subset
ley_norm[, 2:7] <- preprocess(ley_subset[, 2:7], data.type = "MAS5")

# Remove control spots if necessary (e.g., Affymetrix 'AFFX' prefixes)
ley_final <- ley_norm[substring(ley_norm$ID, 1, 4) != "AFFX", ]
```

### 2. Estimating Baseline Error
You must calculate the baseline error distribution for each experimental condition separately.

```R
# Condition 1 (e.g., columns 2, 3, 4)
var_cond1 <- baseOlig.error(ley_final[, 2:4], q = 0.01)

# Condition 2 (e.g., columns 5, 6, 7)
var_cond2 <- baseOlig.error(ley_final[, 5:7], q = 0.01)
```

### 3. Performing the LPE Test
The `lpe` function compares the two conditions using the baseline distributions calculated above.

```R
lpe_results <- lpe(ley_final[, 5:7], # Condition 2 data
                   ley_final[, 2:4], # Condition 1 data
                   var_cond2,        # Condition 2 error
                   var_cond1,        # Condition 1 error
                   probe.set.name = ley_final$ID)
```

### 4. FDR Correction
Apply False Discovery Rate (FDR) adjustment to the results. LPE supports several methods: "BH" (Benjamini-Hochberg), "BY", "Bonferroni", and "resamp" (Rank-invariant resampling).

```R
# Benjamini-Hochberg adjustment
fdr_bh <- fdr.adjust(lpe_results, adjp = "BH")

# Resampling-based FDR (Recommended for small samples, but slower)
# Returns a table of target FDR vs critical z-values
fdr_resamp <- fdr.adjust(lpe_results, adjp = "resamp", iterations = 250)
```

## Key Functions

- `preprocess`: Performs IQR normalization, thresholding (min value 1.0), and log2 transformation.
- `baseOlig.error`: Calculates the A vs M (average vs difference) error distribution used as a baseline.
- `lpe`: The core function that calculates z-statistics based on the pooled error model.
- `fdr.adjust`: Adjusts p-values or provides critical z-values for multiple testing correction.

## Interpretation Tips

- **Z-statistics**: Higher absolute z-statistics indicate more significant differential expression.
- **Resampling FDR**: When using `adjp="resamp"`, look at the `z.critical` column. If the target FDR is 0.05 and the corresponding `z.critical` is 1.77, any gene with `abs(z.stats) > 1.77` is considered significant at that threshold.
- **Replicates**: LPE is specifically optimized for 2 or 3 replicates. For paired data, consider the `LPEP` library; for more than two conditions, consider the `HEM` library.

## Reference documentation

- [LPE](./references/LPE.md)