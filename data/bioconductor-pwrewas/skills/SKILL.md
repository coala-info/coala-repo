---
name: bioconductor-pwrewas
description: This tool performs power analysis and sample size estimation for Epigenome-Wide Association Studies using simulation-based approaches. Use when user asks to estimate required sample sizes, calculate statistical power for DNA methylation studies, or simulate differential methylation across various tissue types.
homepage: https://bioconductor.org/packages/3.10/bioc/html/pwrEWAS.html
---

# bioconductor-pwrewas

name: bioconductor-pwrewas
description: Power evaluation for Epigenome-Wide Association Studies (EWAS). Use this skill to estimate the sample size required to detect differences in DNA methylation (DNAm) between two groups (e.g., case vs. control) using Illumina Methylation BeadChip technology. It supports power estimation based on tissue-type specific distributions, effect sizes (targetDelta or deltaSD), and various differential methylation methods.

## Overview
pwrEWAS is a simulation-based tool for power analysis in EWAS. It uses a semi-parametric approach, drawing DNAm data from beta-distributions with parameters estimated from real-world datasets (e.g., Blood, PBMC, Saliva, Sperm, etc.). It helps researchers determine the trade-off between sample size, effect size, and statistical power while controlling for the False Discovery Rate (FDR).

## Core Workflow

### 1. Installation and Loading
```R
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("pwrEWAS")
library(pwrEWAS)
```

### 2. Running Power Estimation
The primary function is `pwrEWAS()`. You must specify effect size using either `targetDelta` (maximal difference) or `deltaSD` (standard deviation of differences).

```R
results <- pwrEWAS(
  minTotSampleSize = 20,
  maxTotSampleSize = 100,
  SampleSizeSteps = 20,
  NcntPer = 0.5,           # 50% control, 50% case
  targetDelta = c(0.1, 0.2), # Target max difference in DNAm
  J = 10000,               # Number of CpGs tested
  targetDmCpGs = 100,      # Expected number of DM CpGs
  tissueType = "Blood adult",
  DMmethod = "limma",      # Options: "limma", "t-test", "wilcoxon"
  core = 4,                # Parallel processing
  sims = 50                # Number of simulations
)
```

### 3. Key Input Parameters
- **tissueType**: Choose from "Adult (PBMC)", "Saliva", "Sperm", "Blood adult", "Blood cord", "Liver", "Placenta", "Frontal cortex", "Upper GI", or "Colon".
- **targetDelta**: A vector of targeted maximal differences in methylation (e.g., 0.1 for 10%).
- **NcntPer**: Percentage of total sample size belonging to the control group.
- **detectionLimit**: Differences below this value are not considered "meaningful" (default 0.01).
- **J**: Total number of CpGs simulated. Note: High values increase RAM usage.

### 4. Interpreting Results
The output object contains:
- `meanPower`: A matrix of average power for each sample size and effect size.
- `metric`: A list containing matrices for `marTypeI` (Type I error), `FDR` (False Discovery Rate), `FDC` (False Discovery Cost), and `probTP` (probability of identifying at least one true positive).
- `powerArray`: Full set of power estimates for all simulations.

### 5. Visualization
pwrEWAS provides built-in plotting functions:
```R
# Plot power curves
pwrEWAS_powerPlot(results$powerArray, sd = FALSE)

# Plot distribution of simulated differences
pwrEWAS_deltaDensity(results$deltaArray, detectionLimit = 0.01, sd = FALSE)
```

## Tips for Efficiency
- **Parallelization**: Use the `core` argument to speed up simulations. The ideal number of cores is a factor of (`#sampleSizes * #effectSizes`).
- **Memory Management**: If R crashes, reduce `J` (number of CpGs) or the number of `sims`.
- **Reproducibility**: Always run `set.seed()` before `pwrEWAS()` to ensure consistent simulation results.

## Reference documentation
- [The pwrEWAS User's Guide](./references/pwrEWAS.md)