---
name: bioconductor-magpie
description: The magpie package is a simulation-based tool for performing power analysis in MeRIP-Seq experiments. Use when user asks to estimate power, calculate false discovery rates, or determine optimal sample sizes and sequencing depths for methylated RNA immunoprecipitation sequencing studies.
homepage: https://bioconductor.org/packages/release/bioc/html/magpie.html
---

# bioconductor-magpie

## Overview

The `magpie` package is a simulation-based tool designed for power analysis in MeRIP-Seq (methylated RNA immunoprecipitation sequencing) experiments. It helps researchers determine the statistical rigor of their study design by estimating False Discovery Rate (FDR), power, and precision across various experimental scenarios, such as different sample sizes and sequencing depths.

## Installation

Install the package via BiocManager:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("magpie")
```

## Input Data Preparation

`magpie` requires paired Input and IP .BAM files for each replicate across experimental conditions (e.g., Control vs. Treatment).

1.  **BAM Files**: Organize files by condition. Ensure filenames are consistent (e.g., `Ctrl1.input.bam`, `Ctrl1.ip.bam`).
2.  **Annotation**: Provide a matching genome annotation in `.sqlite` format. Create this using `GenomicFeatures`:

```r
library(GenomicFeatures)
txdb <- makeTxDbFromUCSC(genome = "hg38", tablename = "knownGene")
saveDb(txdb, file = "hg38.sqlite")
```

## Power Calculation Workflows

### Quick Evaluation (Pre-calculated Data)
Use `quickPower()` to get results in seconds using parameters derived from published datasets (`GSE46705`, `GSE55575`, or `GSE94613`).

```r
library(magpie)
# Options: 'GSE46705', 'GSE55575', 'GSE94613'
power_results <- quickPower(dataset = "GSE46705")
```

### Custom Evaluation (User Data)
Use `powerEval()` to perform simulations on your own BAM files. This is computationally intensive.

```r
power_results <- powerEval(
    Input.file = c("C1.in.bam", "C2.in.bam", "T1.in.bam", "T2.in.bam"),
    IP.file = c("C1.ip.bam", "C2.ip.bam", "T1.ip.bam", "T2.ip.bam"),
    BamDir = "path/to/bams",
    annoDir = "path/to/annotation.sqlite",
    variable = rep(c("Ctrl", "Trt"), each = 2),
    bam_factor = 0.03, # Percentage of genome covered by input BAMs
    nsim = 10,         # Number of simulations
    N.reps = c(2, 3, 5), # Sample sizes to test
    depth_factor = c(1, 2), # Sequencing depth multipliers
    Test_method = "TRESS" # "TRESS" or "exomePeak2"
)
```

## Results Preservation and Visualization

### Saving Results
Export power measurements to Excel files for reporting.

```r
# Standard results
writeToxlsx(power_results, file = "power_analysis.xlsx")

# Results stratified by expression level
writeToxlsx_strata(power_results, file = "power_stratified.xlsx")
```

### Visualization
Generate line plots to visualize how power and FDR change with sample size and depth.

```r
# Plot specific metric (FDR, Power, Precision, FDC)
plotRes(power_results, depth_factor = 1, value_option = "Power")

# Plot all metrics in a 2x2 panel
plotAll(power_results, depth_factor = 1)

# Plot stratified results
plotAll_Strata(power_results)
```

## Reference documentation

- [magpie Package User's Guide](./references/magpie.md)