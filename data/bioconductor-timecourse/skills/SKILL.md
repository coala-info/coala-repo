---
name: bioconductor-timecourse
description: This tool analyzes replicated microarray time course data using multivariate empirical Bayes statistics to identify genes with significant temporal profiles. Use when user asks to identify genes with significant changes over time, compare temporal profiles between two or more biological conditions, or visualize longitudinal gene expression patterns.
homepage: https://bioconductor.org/packages/release/bioc/html/timecourse.html
---

# bioconductor-timecourse

name: bioconductor-timecourse
description: Analysis of replicated microarray time course data using multivariate empirical Bayes statistics. Use this skill to identify genes with significant temporal profiles in longitudinal one-sample, two-sample (paired or independent), and multi-sample experiments.

## Overview

The `timecourse` package provides specialized statistical methods (MB-statistics and Hotelling $T^2$) for identifying genes of interest in longitudinal microarray experiments. Unlike standard F-tests, these methods incorporate replicate variances and correlations between time points while borrowing information across genes (moderation) to improve reliability in small-sample settings.

## Core Workflows

### 1. Data Preparation
The package accepts `matrix`, `ExpressionSet`, `MAList`, or `marrayNorm` objects containing log2 expression values.
*   **Default Column Order**: Functions expect columns to be grouped by Condition -> Replicate -> Time.
*   **Sample Sizes**: You must provide a `reps` or `size` vector/matrix indicating the number of replicates per gene.

### 2. Longitudinal One-Sample Problem
Used to find genes that change significantly over time within a single biological condition.

```R
library(timecourse)
data(fruitfly) # Example dataset

# Define parameters
num_time_points <- 12
reps_per_gene <- rep(3, nrow(fruitfly)) # 3 replicates for each gene

# Calculate statistics
# Returns an MArrayTC object
out <- mb.long(fruitfly, times=num_time_points, reps=reps_per_gene)

# View top genes
# MArrayTC objects contain 'prop', 'con', 'tmp', 'back', and 'M' (MB-statistic)
# Ranking is typically done by the MB-statistic
```

### 3. Longitudinal Two-Sample Problem
Used to find genes with different temporal profiles between two conditions (e.g., Wild Type vs. Mutant).

*   **Paired**: Same biological subjects measured across conditions.
*   **Independent**: Different subjects in each condition.

```R
# trt: vector of condition assignments
# assay: vector of replicate assignments
# size: matrix where columns are sample sizes for each condition
MB.2D <- mb.long(M2, method="2", times=5, reps=size, condition.grp=trt, rep.grp=assay)
```

### 4. Longitudinal Multi-Sample Problem
Used for experiments with three or more biological conditions using MANOVA-style empirical Bayes.

```R
# D: number of biological conditions
MB.multi <- mb.MANOVA(M, times=5, D=3, size=size, rep.grp=assay, condition.grp=trt)
```

## Visualization

Use `plotProfile()` to visualize the temporal expression of specific genes. You can identify genes by their rank or their specific ID.

```R
# Plot the top-ranked gene
plotProfile(out, rank=1, gnames=rownames(fruitfly), type="b")

# Plot a specific gene by ID
plotProfile(out, gid="141404_at", gnames=rownames(fruitfly), type="b")
```

## Key Considerations

*   **Ranking**: In one- and two-sample problems with varying sample sizes across genes, always use the **MB-statistic** for ranking. If sample sizes are equal, MB and Hotelling $T^2$ provide identical rankings.
*   **Missing Data**: The current version does not allow missing time points within a series, but it does allow missing replicates for a subset of genes (represented as `NA` in the matrix).
*   **Robustness**: Use `type="robust"` in `mb.long` or `mb.MANOVA` to reduce the influence of outliers, provided you have at least 3 replicates.
*   **Moderation**: The `prior.df` argument controls the amount of information borrowed across genes. Check the distribution of gene-specific variances to determine if more moderation is needed.

## Reference documentation

- [The timecourse Package](./references/timecourse.md)