---
name: bioconductor-ichip
description: This tool performs Bayesian modeling of ChIP-chip data from multiple platforms using Ising models to account for spatial dependency between genomic probes. Use when user asks to calculate enrichment statistics, apply first-order or second-order Ising models to detect enriched genomic regions, or generate BED files for visualization.
homepage: https://bioconductor.org/packages/release/bioc/html/iChip.html
---


# bioconductor-ichip

name: bioconductor-ichip
description: Bayesian modeling of ChIP-chip data from multiple platforms (Agilent, Affymetrix, NimbleGen) using Ising models. Use this skill to calculate enrichment statistics (limma t-statistics), apply first-order or second-order Ising models to detect enriched genomic regions, and generate BED files for visualization.

# bioconductor-ichip

## Overview

The `iChip` package implements Bayesian hierarchical models to analyze ChIP-chip data. It uses Ising models to account for spatial dependency between genomic probes. The package is platform-independent and works with various genomic resolutions. It primarily provides two modeling approaches: `iChip1` (first-order Ising model) and `iChip2` (second-order Ising model).

## Typical Workflow

### 1. Data Preparation
Data must be normalized (e.g., quantile or loess) before using `iChip`. The input data frame must be sorted by chromosome and then by genomic position.

```r
library(iChip)
# Sort data
mydata = mydata[order(mydata$chr, mydata$position), ]
```

### 2. Calculate Enrichment Statistics
The package suggests using empirical Bayes t-statistics. The `lmtstat` function is a wrapper for this calculation.

*   **For independent samples (e.g., quantile normalized):**
    `stats = lmtstat(IP_data, Control_data)`
*   **For paired samples (e.g., loess normalized log2 ratios):**
    `stats = lmtstat(log2ratio_matrix)`

### 3. Running the Ising Models

#### Second-Order Ising Model (iChip2)
Recommended for a balance between sensitivity and FDR.
```r
# Y must be a matrix/df with: Col 1 = Chromosome, Col 2 = Enrichment Statistic
Y = cbind(mydata$chr, stats)
res2 = iChip2(Y=Y, burnin=2000, sampling=10000, winsize=2, sdcut=2, beta=1.25)
```
*   `winsize`: 2 is standard for second-order.
*   `beta`: Smoothing parameter. Increasing `beta` makes the criterion for enrichment more stringent.

#### First-Order Ising Model (iChip1)
```r
res1 = iChip1(enrich=stats, burnin=2000, sampling=10000, sdcut=2, beta0=3)
```

### 4. Quality Control and Convergence
Check MCMC convergence by plotting parameters. Parameters should fluctuate around a stable mode.
```r
par(mfrow=c(2,2))
plot(res2$mu0, type="l"); plot(res2$mu1, type="l")
# Check posterior probabilities (should be dichotomized at 0 and 1)
hist(res2$pp)
```

### 5. Calling Enriched Regions
Use `enrichreg` to identify specific genomic intervals based on posterior probability (pp) or False Discovery Rate (FDR).

```r
# Using Posterior Probability cutoff
regs = enrichreg(pos=mydata[,1:2], enrich=stats, pp=res2$pp, cutoff=0.9, method="ppcut", maxgap=500)

# Using FDR cutoff
regs_fdr = enrichreg(pos=mydata[,1:2], enrich=stats, pp=res2$pp, cutoff=0.01, method="fdrcut", maxgap=500)
```

### 6. Exporting Results
Create BED files for UCSC Genome Browser or motif analysis:
```r
bed = data.frame(chr=paste0("chr", regs$chr), regs$gstart, regs$gend)
```

## Tips and Troubleshooting

*   **No Enriched Regions:** If the warning "all probes are in the same state" appears, or if all posterior probabilities are 1 (or 0), it usually indicates no enrichment was found in the noise.
*   **Beta Selection:** For high-resolution data (e.g., 35bp), `beta` values of 2–4 are often appropriate. For low-resolution promoter arrays, `beta` values around 1.0–1.25 are common.
*   **Phase Transition:** If posterior probabilities are not dichotomized (not clustered at 0 and 1), increase the `beta` value to reach the "super-paramagnetic" phase.
*   **Large Datasets:** For millions of probes, use parallel computation (e.g., via `snowfall`) to process chromosomes independently.

## Reference documentation
- [iChip](./references/iChip.md)