---
name: bioconductor-iseq
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/iSeq.html
---

# bioconductor-iseq

name: bioconductor-iseq
description: Bayesian hierarchical modeling of ChIP-seq data using Hidden Ising Models. Use this skill to analyze ChIP-seq data (with or without controls/replicates) by building dynamic signal profiles, modeling tag counts with Poisson-Gamma distributions, and calling enriched regions (peaks) based on posterior probabilities.

## Overview
The `iSeq` package provides a three-step workflow for ChIP-seq peak calling:
1. **Data Aggregation**: Merging sequence tags into non-overlapping dynamic bins using `mergetag`.
2. **Statistical Modeling**: Applying Hidden Ising Models (via `iSeq1` for fully Bayesian or `iSeq2` for high-order models) to estimate the probability of enrichment for each bin.
3. **Peak Calling**: Merging enriched bins into regions and calculating peak statistics using `peakreg`.

## Typical Workflow

### 1. Data Preparation
Load the library and prepare tag data. Tags should be in a data frame with columns: `chr`, `position` (5' start), and `strand`. It is recommended to use the tag middle position.

```r
library(iSeq)
# Example: Adjusting 25bp tags to middle position
chip[,2] <- chip[,2] + 12
mock[,2] <- mock[,2] + 12
```

### 2. Build Dynamic Signal Profiles
Use `mergetag` to create bins. The bin size varies based on local tag density.
- `maxlen`: Maximum bin size (e.g., 80).
- `minlen`: Minimum bin size (e.g., 10).
- `ntagcut`: Threshold for triggering bin size change (adjust based on sequencing depth).

```r
tagct <- mergetag(chip=chip, control=mock, maxlen=80, minlen=10, ntagcut=10)
# tagct columns: chr, gstart, gend, adjct, ipct1, ipct2, conct1, conct2
```

### 3. Model Fitting
Choose between `iSeq1` (standard 1D Ising model) or `iSeq2` (fixed interaction parameter).

**Using iSeq1 (Fully Bayesian):**
```r
set.seed(777)
res1 <- iSeq1(Y=tagct[tagct$chr=="chr22", 1:4], gap=200, burnin=200, sampling=1000)
# Check convergence
plot(res1$lambda1, type="l")
```

**Using iSeq2 (High-order/Fixed k):**
Use `iSeq2` if data is noisy or `iSeq1` fails to reach the super-paramagnetic phase.
```r
res2 <- iSeq2(Y=tagct[tagct$chr=="chr22", 1:4], winsize=2, k=1.0, burnin=100, sampling=500)
```

### 4. Calling Enriched Regions
Use `peakreg` to merge bins into peaks based on a posterior probability (pp) or FDR cutoff.
- `method="ppcut"`: Uses a direct probability threshold (e.g., 0.5).
- `method="fdrcut"`: Uses a False Discovery Rate threshold (e.g., 0.05).

```r
# Call peaks using 0.5 posterior probability cutoff
reg <- peakreg(chrpos=tagct[tagct$chr=="chr22", 1:3], 
               count=(tagct$ipct1 - tagct$conct1), 
               pp=res1$pp, cutoff=0.5, method="ppcut", maxgap=200)

# Results include: peakpos (exact binding site), meanpp, and sym (symmetry/bimodality)
```

## Tips and Interpretation
- **Symmetry (sym)**: Values range from 0 to 0.5. A value of 0.5 indicates perfect symmetry between forward and reverse tags, a hallmark of true binding sites.
- **Convergence**: Always check trace plots for `lambda0`, `lambda1`, and `kappa`. If a trend is visible, increase `burnin` and `sampling`.
- **No Enriched Regions**: If `lambda1` is very small (close to the prior mean) or all posterior probabilities are near zero, the chromosome likely lacks significant binding sites.
- **Parallelization**: For large datasets, use `snowfall` to run `iSeq1` or `iSeq2` across chromosomes in parallel.

## Reference documentation
- [iSeq: Bayesian Hierarchical Modeling of ChIP-seq Data Through Hidden Ising Models](./references/iSeq.md)