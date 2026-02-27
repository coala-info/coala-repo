---
name: bioconductor-oscope
description: Oscope identifies co-oscillating genes and reconstructs cyclic cell orders from unsynchronized single-cell RNA-seq data. Use when user asks to identify oscillatory genes, cluster genes by oscillation frequency using paired-sine models, or reconstruct the temporal order of cells in unsynchronized experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/Oscope.html
---


# bioconductor-oscope

name: bioconductor-oscope
description: Statistical pipeline for identifying oscillatory genes in unsynchronized single-cell RNA-seq (scRNA-seq) experiments. Use this skill to perform normalization, pre-processing, candidate oscillator screening via paired-sine models, K-medoids clustering of gene groups, and reconstruction of cyclic cell orders (base cycles).

# bioconductor-oscope

## Overview

Oscope is designed to identify groups of co-oscillating genes in unsynchronized scRNA-seq data. Unlike traditional time-series analysis, Oscope does not require synchronized cells; instead, it leverages the fact that unsynchronized cells represent different states in a cycle. It identifies candidate oscillators, clusters them by frequency, and reconstructs the temporal order of cells for each cluster.

## Typical Workflow

### 1. Data Preparation and Normalization
Oscope requires a G x S matrix (genes by samples) of expression estimates (e.g., RSEM or Cufflinks counts).

```R
library(Oscope)
data(OscopeExampleData)

# Median normalization (similar to DESeq)
Sizes <- MedianNorm(OscopeExampleData)
DataNorm <- GetNormalizedMat(OscopeExampleData, Sizes)

# Alternative: Quantile normalization
# Sizes <- QuantileNorm(OscopeExampleData, .75)
```

### 2. Pre-processing (Mean-Variance Filtering)
Focus on high-mean, high-variance genes to reduce technical noise.

```R
# Identify genes with high mean (>100 by default) and high variance
MV <- CalcMV(Data = OscopeExampleData, Sizes = Sizes)
DataSubset <- DataNorm[MV$GeneToUse, ]
```

### 3. Rescaling for Paired-Sine Model
Oscope requires input values to be rescaled between -1 and 1.

```R
# Rescales data and handles outliers via quantile imputation (default 5th/95th)
DataInput <- NormForSine(DataSubset)
```

### 4. Screening Candidate Oscillators
The paired-sine model identifies gene pairs oscillating with the same frequency but potentially different phases.

```R
# Run paired-sine model (can be parallelized)
SineRes <- OscopeSine(DataInput, parallel = TRUE)

# SineRes contains:
# $SimiMat: Sine scores (higher = more likely co-oscillating)
# $DiffMat: Dissimilarity estimates
# $ShiftMat: Estimated phase shifts
```

### 5. Clustering and Filtering
Cluster genes into groups with similar frequencies using K-medoids.

```R
# Cluster top 5% of genes (by minimal distance)
KMRes <- OscopeKM(SineRes, maxK = 10)

# Flag clusters that lack significant oscillation or phase shifts (e.g., linear correlation)
ToRM <- FlagCluster(SineRes, KMRes, DataInput)
KMResUse <- KMRes[-ToRM$FlagID]
```

### 6. Reconstructing Cell Order
Recover the cyclic order (base cycle) for each gene cluster.

```R
# Reconstruct order using Extended Nearest Insertion (ENI)
ENIRes <- OscopeENI(KMRes = KMResUse, Data = DataInput, NCThre = 1000)

# Access recovered order for a specific cluster
cluster2_order <- ENIRes[["cluster2"]]
DataOrdered <- DataNorm[, cluster2_order]
```

## Tips and Interpretation

- **Parallelization**: `OscopeSine` and `OscopeENI` support `parallel = TRUE`. Configure cores via the `parallelParam` argument.
- **Linear vs. Oscillatory**: Always use `FlagCluster`. It identifies groups that appear correlated but lack the phase diversity required to define a true cycle.
- **Downstream Analysis**: Once the cell order is recovered, you can apply standard time-series methods (like FFT) to the reordered data to find weaker oscillators that were not in the initial high-variance subset.
- **Visualization**: Plot expression against the recovered order to verify the sinusoidal pattern.

## Reference documentation

- [Oscope: a statistical pipeline for identifying oscillatory genes in unsynchronized single cell RNA-seq experiments](./references/Oscope_vignette.md)