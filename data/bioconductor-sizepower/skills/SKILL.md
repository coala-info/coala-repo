---
name: bioconductor-sizepower
description: The bioconductor-sizepower package calculates sample sizes and statistical power for planning microarray experiments. Use when user asks to determine the required number of samples, calculate power for randomized or matched-pair designs, or estimate false positive rates in high-dimensional gene expression studies.
homepage: https://bioconductor.org/packages/release/bioc/html/sizepower.html
---


# bioconductor-sizepower

## Overview

The `sizepower` package is designed for the planning stage of microarray experiments. It helps researchers balance the trade-off between resource use and statistical precision by calculating sample sizes and power levels. It specifically accounts for the high-dimensional nature of microarrays by using the expected number of false positives ($E(R_0)$) and the total number of non-differentially expressed genes ($G_0$) to determine the type I error rate per gene.

## Core Concepts

- **$E(R_0)$**: The expected number of false positives (genes falsely declared differentially expressed).
- **$G_0$**: The number of genes that are not differentially expressed (often approximated by the total number of genes $G$).
- **$\alpha_0$**: The type I error probability for a single gene, calculated as $E(R_0) / G_0$.
- **$\sigma_d$**: The standard deviation of the difference in expression between treatment and control. For many designs, $\sigma_d = \sqrt{2\sigma^2}$, where $\sigma^2$ is the ANOVA error variance.

## Workflows and Functions

### 1. Completely Randomized Treatment-Control Designs
Used when samples are independent and divided into two groups (treatment vs. control).

```r
library(sizepower)

# Calculate Sample Size (n per group)
# ER0: expected false positives, G0: non-DE genes, power: desired power, 
# absMu1: difference in means, sigmad: SD of difference
sampleSize.randomized(ER0=1, G0=2000, power=0.9, absMu1=1, sigmad=0.566)

# Calculate Power for a given n
power.randomized(ER0=1, G0=2000, absMu1=1, sigmad=0.566, n=8)
```

### 2. Matched-Pairs Designs
Used when samples are correlated (e.g., tissue and normal fat from the same patient).

```r
# Calculate Sample Size (number of pairs)
sampleSize.matched(ER0=1, G0=2000, power=0.9, absMu1=1, sigmad=0.495)

# Calculate Power for a given n (pairs)
power.matched(ER0=1, G0=2000, absMu1=1, sigmad=0.495, n=6)
```

### 3. Multiple-Treatment and Randomized Block Designs
Used for designs with $T > 2$ treatments where one treatment has an "isolated effect" (differs from the others).

```r
# Calculate Power
# numTrt: number of treatments, sigma: ANOVA error SD
power.multi(ER0=1, G0=2000, numTrt=5, absMu1=1, sigma=0.4, n=6)
```

## Usage Tips

- **Estimating $\sigma$**: Use pilot data or previous studies. In an ANOVA context, $\sigma$ is the square root of the Mean Square Error (MSE).
- **Approximating $G_0$**: If the true number of non-differentially expressed genes is unknown, use the total number of genes on the chip ($G$).
- **Statistical Distance ($d$)**: The functions return $d = |\mu_1| / \sigma_d$, representing the effect size in units of standard deviation.
- **Non-centrality Parameter ($\psi_1$)**: Power functions return `psi1`, which is the non-centrality parameter for the chi-square distribution used in the calculation.

## Reference documentation

- [Sample Size and Power Calculation in Microarray Studies](./references/sizepower.md)