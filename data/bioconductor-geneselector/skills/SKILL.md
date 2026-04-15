---
name: bioconductor-geneselector
description: This tool performs stability-based gene selection and rank aggregation for microarray data using various statistical criteria and resampling techniques. Use when user asks to assess the stability of gene rankings, perform differential expression analysis with multiple statistical tests, or aggregate multiple gene lists into a single robust ranking.
homepage: https://bioconductor.org/packages/3.6/bioc/html/GeneSelector.html
---

# bioconductor-geneselector

name: bioconductor-geneselector
description: Stability-based gene selection and rank aggregation for microarray data. Use this skill when you need to assess the variability of gene rankings, perform differential expression analysis using multiple statistical criteria (t-tests, SAM, Wilcoxon, etc.), or aggregate multiple gene lists into a single robust ranking.

## Overview

The `GeneSelector` package provides tools to evaluate the stability of gene rankings obtained from differential expression analyses. It addresses two types of variability:
1. **Data variability**: How much the ranking changes when the dataset is slightly altered (resampling, jackknife, bootstrap).
2. **Methodological variability**: How much the ranking changes when different statistical tests are used.

The package implements 14 different ranking procedures and several rank aggregation methods (Markov Chain models, simple averaging) to produce more reliable candidate gene sets.

## Core Workflow

### 1. Initial Ranking
Perform an initial ranking using one of the many `Ranking*` functions. These return a `GeneRanking` object.

```R
library(GeneSelector)
data(toydata)
y <- as.numeric(toydata[1,])
x <- as.matrix(toydata[-1,])

# Example: Ordinary t-statistic
ordT <- RankingTstat(x, y, type="unpaired")
toplist(ordT)
```

### 2. Assessing Stability (Data Perturbation)
To see how stable a ranking is, generate altered datasets and repeat the ranking.

```R
# Generate a Jackknife (Leave-one-out) matrix
loo <- GenerateFoldMatrix(y = y, k = 1)

# Repeat the ranking process across all folds
loor_ordT <- RepeatRanking(ordT, loo)

# Visualize stability
plot(loor_ordT, col="blue", pch=".")

# Quantify stability (Overlap or Distance measures)
stab <- GetStabilityOverlap(loor_ordT, scheme = "original", decay="linear")
summary(stab, measure = "intersection", position = 10)
```

### 3. Comparing Multiple Methods
Use different statistical criteria to see if the same genes are consistently selected.

```R
# Run multiple ranking methods
baldi <- RankingBaldiLong(x, y, type="unpaired")
sam <- RankingSam(x, y, type="unpaired")
wilcox <- RankingWilcoxon(x, y, type="unpaired")

# Merge results for comparison
merged <- MergeMethods(list(ordT, baldi, sam, wilcox))

# Visualize similarities with a heatmap
HeatmapRankings(merged, ind=1:40)
```

### 4. Rank Aggregation
Combine multiple rankings into one robust list.

```R
# Simple average of ranks
aggMean <- AggregateSimple(merged, measure = "mean")

# Markov Chain aggregation (more sophisticated)
aggMC <- AggregateMC(merged, type = "MCT", maxrank = 100)

# GeneSelector: Find genes consistently below a rank threshold (e.g., top 50)
finalSel <- GeneSelector(list(ordT, baldi, sam, wilcox), threshold="user", maxrank=50)
show(finalSel)
```

## Available Ranking Methods

| Method | Function |
| :--- | :--- |
| Fold Change | `RankingFC` |
| t-statistic (Ordinary / Welch) | `RankingTstat`, `RankingWelchT` |
| Bayesian t-statistics | `RankingBaldiLong`, `RankingFoxDimmic` |
| Shrinkage / Limma | `RankingShrinkageT`, `RankingLimma` |
| SAM / EBAM | `RankingSam`, `RankingEbam` |
| Wilcoxon | `RankingWilcoxon`, `RankingWilcEbam` |
| Permutation | `RankingPermutation` |

## Tips for Success
- **Weighting**: Use `decay="linear"` in stability measures to prioritize stability at the top of the list, which is usually the only part of biological interest.
- **GeneSelector Function**: This is a "consensus" filter. It selects genes that appear in the top `maxrank` across *all* provided methods.
- **Visualization**: Use `plot(GeneSelectorObject, which = i)` to see a "GeneInfoScreen" for a specific gene, showing its rank across all applied methods.

## Reference documentation
- [GeneSelector](./references/GeneSelector.md)