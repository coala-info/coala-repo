---
name: r-gap
description: The r-gap package provides a comprehensive suite of tools for genetic data analysis, including study design calculations and high-level visualization of genome-wide association study results. Use when user asks to calculate power or sample size for genetic studies, perform haplotype analysis, test for Hardy-Weinberg equilibrium, or generate Manhattan and Q-Q plots.
homepage: https://cloud.r-project.org/web/packages/gap/index.html
---


# r-gap

## Overview
The `gap` package is a comprehensive library for genetic data analysis. It provides functions for haplotype analysis, linkage disequilibrium, population genetics, and specifically excels in study design calculations (power/sample size) and high-level visualization of genome-wide association study (GWAS) results.

## Installation
To install the package from CRAN:
```r
install.packages("gap")
```

## Core Workflows

### Study Design and Power Analysis
The package provides specialized functions for calculating sample size and power across different study architectures.

*   **Population-based studies:** Use `pbsize(n, alpha, gamma, p, kp, theta)` for power or sample size.
*   **Family-based studies:** Use `fbsize(n, alpha, gamma, p, theta)` for trio-based designs.
*   **Case-cohort studies:** Use `ccsize(n, alpha, power, p1, p2, theta, pD, q)` where `power` can be a boolean to toggle between power and sample size calculation.
*   **Two-stage Case-Control:** Use `tscc()` to evaluate joint or replication-based analysis.
    ```r
    # Example: Two-stage design
    library(gap)
    tscc(model="multiplicative", GRR=1.5, p1=0.1, n1=400, n2=400, M=1e5, alpha.genome=0.05, pi.samples=0.2, pi.markers=0.1, K=0.1)
    ```

### Genetic Statistics
*   **Hardy-Weinberg Equilibrium:** `hwe(data)` or `hwe.hardy()` for testing.
*   **Linkage Disequilibrium:** `LD22()` for 2x2 tables or `LDkl()` for general allelic data.
*   **Haplotype Analysis:** `hap()` for EM-based haplotype frequency estimation.

### Visualization
`gap` is widely used for standard GWAS plots:
*   **Manhattan Plots:** `mhtplot(data)`
*   **Q-Q Plots:** `qqunif(pvalues)`
*   **Locus Zoom-like plots:** `asplot()`

### Interactive Design (Shiny)
The package includes a built-in Shiny application for interactive study design.
```r
# Launch the interactive design tool
gap::runshinygap()
```

## Tips and Best Practices
*   **Parameter Bounds:** When using design functions, ensure parameters like Prevalence (Kp) and Minor Allele Frequency (MAF) are within realistic biological ranges (e.g., MAF > 0.001).
*   **Disease Models:** In `tscc`, valid models include "multiplicative", "additive", "dominant", and "recessive".
*   **Data Formatting:** For visualization functions like `mhtplot`, ensure your data frame contains columns for Chromosome, Position, and P-value.

## Reference documentation
- [Shiny for Genetic Analysis Package (gap) Designs](./references/shinygap.Rmd)