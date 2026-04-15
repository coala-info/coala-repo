---
name: bioconductor-maqcsubset
description: This package provides a curated subset of Affymetrix microarray data from the MicroArray Quality Control initiative for benchmarking and titration analysis. Use when user asks to access MAQC reference datasets, perform titration analysis using proboscis plots, or compare differential expression consistency across different test sites.
homepage: https://bioconductor.org/packages/release/data/experiment/html/MAQCsubset.html
---

# bioconductor-maqcsubset

## Overview

The `MAQCsubset` package provides a curated subset of the MicroArray Quality Control (MAQC) initiative data. It specifically contains excerpts from GEO dataset GSE5350, focusing on Affymetrix platform data across multiple test sites. The data is structured to allow researchers to compare 100% Stratagene Universal Human RNA (Sample A), 100% Ambion Human Brain RNA (Sample B), and their mixtures (Sample C: 75%A/25%B; Sample D: 25%A/75%B).

## Data Access

The primary dataset is an `ExpressionSet` object containing 54,675 features across 24 samples.

```r
library(MAQCsubset)
data(afxsubRMAES)

# Inspect the ExpressionSet
afxsubRMAES

# View sample metadata (site, sample type, replicates)
pd <- pData(afxsubRMAES)
table(pd$site, pd$samp)
```

### Sample Groups
- **A**: 100% Stratagene Universal Human RNA
- **B**: 100% Ambion Human Brain RNA
- **C**: 0.75A + 0.25B
- **D**: 0.25A + 0.75B

## Titration Analysis (Proboscis Plots)

A "proboscis plot" evaluates the consistency of differential expression across titration levels. A gene is considered to have a Self-Consistent Monotone Titration (SCMT) if:
1. It is differentially expressed between A and B.
2. The direction of change in the mixtures (C vs D) matches the direction in the pure samples (A vs B).

### Workflow for SCMT Analysis

1. **Identify DE Genes**: Use t-tests to find genes differentially expressed between A and B at a specific p-value threshold (e.g., 0.001).
2. **Check Consistency**: For genes up-regulated in A vs B, check if they are also up-regulated in C vs D.
3. **Calculate Proportions**: Plot the proportion of genes exhibiting SCMT against the intensity ratios (A/B or B/A).

### Implementation Example

The package allows for site-specific analysis to compare performance across different laboratories:

```r
# Note: The 'proboscis' function is often defined by the user 
# based on the logic in the package vignette to process the ExpressionSet.

# Example logic for site 1
NN1 = proboscis(afxsubRMAES, site=1)
NN2 = proboscis(afxsubRMAES, site=2)
NN3 = proboscis(afxsubRMAES, site=3)

# Visualization
plot(NN1, lwd=2, xlim=c(-3,3), xlab="A-B", ylab="P(SCMT|A-B)")
lines(NN2[[1]], NN2[[2]], col="green", lwd=2)
lines(NN3[[1]], NN3[[2]], col="blue", lwd=2)
legend("bottomleft", legend=c("site 1", "site 2", "site 3"), 
       col=c("black", "green", "blue"), lty=1, lwd=2)
```

## Key Functions and Objects

- `afxsubRMAES`: The main `ExpressionSet` object containing RMA-normalized Affymetrix data.
- `pData(afxsubRMAES)`: Accesses the phenotype data, including `site` (1, 2, or 3) and `samp` (A, B, C, or D).
- `genefilter::rowttests`: Recommended for performing the underlying differential expression tests required for titration analysis.

## Reference documentation

- [Exploring the MAQC data with Bioconductor](./references/maqcNotes.md)