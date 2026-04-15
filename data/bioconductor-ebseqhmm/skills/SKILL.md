---
name: bioconductor-ebseqhmm
description: EBSeqHMM performs differential expression analysis for ordered RNA-seq data using an empirical Bayesian autoregressive Hidden Markov Model. Use when user asks to identify expression paths across time points or spatial conditions, perform FDR-controlled detection of differentially expressed genes or isoforms, and cluster features by their most likely expression profiles.
homepage: https://bioconductor.org/packages/3.8/bioc/html/EBSeqHMM.html
---

# bioconductor-ebseqhmm

## Overview

EBSeqHMM is an empirical Bayesian approach designed for ordered RNA-seq data. It uses an autoregressive Hidden Markov Model (HMM) to account for dependencies between adjacent conditions. It classifies genes or isoforms into "expression paths" (e.g., "Up-Up-Down-Down") and provides posterior probabilities for each path, allowing for FDR-controlled detection of differentially expressed features.

## Workflow and Usage

### 1. Data Preparation
Input data must be a matrix of non-normalized expression estimates (e.g., from RSEM).

```r
library(EBSeqHMM)
library(EBSeq)

# Data: Genes/Isoforms as rows, Samples as columns
# Conditions: Factor with levels in the correct chronological/spatial order
CondVector <- rep(paste0("t", 1:5), each = 3)
Conditions <- factor(CondVector, levels = c("t1", "t2", "t3", "t4", "t5"))

# Library size normalization
Sizes <- MedianNorm(Data)
```

### 2. Gene-Level Analysis
Run the HMM test to estimate parameters and posterior probabilities.

```r
# UpdateRd: Number of Baum-Welch iterations (use >5 in practice)
EBOut <- EBSeqHMMTest(Data = GeneData, 
                      sizeFactors = Sizes, 
                      Conditions = Conditions, 
                      UpdateRd = 10)

# Identify DE genes (FDR < 0.05)
# DE genes are those where PP(Constant Path) < FDR
GeneDE <- GetDECalls(EBOut, FDR = 0.05)
```

### 3. Isoform-Level Analysis
Isoform analysis requires an `Ng` vector to account for estimation uncertainty based on the number of isoforms per gene.

```r
# Get uncertainty groups (Ig)
NgList <- GetNg(IsoformNames, IsosGeneNames)
IsoNgTrun <- NgList$IsoformNgTrun

# Run HMM with NgVector
IsoOut <- EBSeqHMMTest(Data = IsoData,
                       NgVector = IsoNgTrun,
                       sizeFactors = Sizes,
                       Conditions = Conditions,
                       UpdateRd = 10)

IsoDE <- GetDECalls(IsoOut, FDR = 0.05)
```

### 4. Path Clustering and Visualization
Group features by their most likely expression proﬁle.

```r
# Get confident assignments (default cutoff PP > 0.5)
# OnlyDynamic = TRUE filters for paths that change at every transition
ConfCalls <- GetConfidentCalls(EBOut, FDR = 0.05, cutoff = 0.5, OnlyDynamic = TRUE)

# Access specific clusters
PathCluster <- ConfCalls$EachPath[["Up-Up-Down-Down"]]

# Visualization
NormMat <- GetNormalizedMat(GeneData, Sizes)
PlotExp(NormMat, Conditions, Name = "Gene_1")
```

### 5. Diagnostics
Check the fit of the Beta prior assumptions.

```r
par(mfrow = c(2, 2))
QQP(EBOut, GeneLevel = TRUE)
DenNHist(EBOut, GeneLevel = TRUE)
```

## Tips and Best Practices
- **Condition Ordering**: Ensure the `levels` of your `Conditions` factor are explicitly set in the order of the experiment; otherwise, R defaults to alphabetical order.
- **Path Definitions**: A "Dynamic" path changes at every step. A "Sporadic" path contains at least one "EE" (Equally Expressed) transition. Use `GetAllPaths(EBOut, OnlyDynamic = FALSE)` to see all 81 possible paths for a 5-condition study.
- **Convergence**: If results seem unstable, increase `UpdateRd` in `EBSeqHMMTest`.
- **FDR Control**: The package controls FDR by thresholding the posterior probability of the "EE-EE-EE..." (constant) path.

## Reference documentation
- [EBSeqHMM: An R package for identifying gene-expression changes in ordered RNA-seq experiments](./references/EBSeqHMM_vignette.md)