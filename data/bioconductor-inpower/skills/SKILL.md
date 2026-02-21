---
name: bioconductor-inpower
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/INPower.html
---

# bioconductor-inpower

name: bioconductor-inpower
description: Estimate the number of susceptibility loci and effect size distributions for complex traits based on existing GWAS discoveries. Use this skill when analyzing GWAS results to predict the power and expected discoveries of future studies, including one-stage and multi-stage designs.

## Overview

The `INPower` package provides a framework for predicting the success of future genome-wide association studies (GWAS). By using the Minor Allele Frequencies (MAF), effect sizes (beta), and statistical power of currently known susceptibility SNPs, it estimates the total number of underlying loci and their effect size distribution. This allows researchers to project the expected number of new discoveries and the percentage of genetic variance explained (GVE) across different future sample sizes.

## Core Workflow

### 1. Data Preparation

The package requires a data frame or matrix containing information on known susceptibility SNPs. Each row represents a SNP, and columns must include:
- **MAF**: Minor Allele Frequency.
- **Beta**: Effect size (log-odds ratio for binary traits or linear coefficient for continuous traits).
- **Power**: The power to detect that specific SNP in the study where it was discovered.

```r
library(INPower)
# Example: Loading internal sample data
datafile <- system.file("sampleData", "data.rda", package="INPower")
load(datafile)

# Extract required vectors
MAFs <- data[, "MAF"]
betas <- data[, "Beta"]
pow <- data[, "Power"]
```

### 2. Running the Power Analysis

The primary function is `INPower()`. It handles both continuous and binary outcomes and can model one-stage or multi-stage study designs.

#### One-Stage Design (Continuous Outcome)
```r
results <- INPower(
  MAFs = MAFs, 
  betas = betas, 
  pow = pow, 
  span = 0.5,                # Smoothing parameter for effect size distribution
  binary.outcome = FALSE,    # FALSE for continuous traits (e.g., height)
  sample.size = seq(25000, 125000, by=25000), 
  signif.lvl = 1e-7,         # Genome-wide significance threshold
  tgv = 0.8,                 # Total genetic variance (heritability)
  k = seq(25, 125, by=25)    # Probability of detecting at least k loci
)
```

#### Two-Stage Design
To model a two-stage study, use the `multi.stage.option` argument.
```r
multi_stage <- list(al = 5e-5, pi = 0.3) # al: stage 1 alpha; pi: fraction of sample in stage 1
results_2stage <- INPower(
  MAFs, betas, pow, 
  multi.stage.option = multi_stage,
  sample.size = seq(25000, 125000, by=25000),
  signif.lvl = 1e-7, 
  tgv = 0.8
)
```

### 3. Interpreting Results

The function returns a list with several key components:

- **$esdist.summary$t.n.loci**: The estimated total number of susceptibility loci for the trait.
- **$esdist.summary$gve**: The percentage of total genetic variance explained by the currently known SNPs.
- **$future.study.summary$e.discov**: A table showing the expected number of discoveries for each provided `sample.size`.
- **$future.study.summary$e.gve**: The expected percentage of genetic variance explained in future studies.
- **$future.study.summary$prob.k**: The probability of detecting at least `k` loci for each sample size.

## Tips and Best Practices

- **Heritability (tgv)**: If `tgv` is provided, GVE is expressed as a percentage of total genetic variance. If omitted, GVE is expressed as a percentage of the total variance of the outcome.
- **Binary Outcomes**: Set `binary.outcome = TRUE` for case-control studies. Ensure effect sizes (betas) are on the log-odds scale.
- **Span Parameter**: The `span` argument controls the smoothing of the effect size distribution. A value of 0.5 is a common starting point, but it may need adjustment if the distribution fit appears poor.
- **Significance Level**: Ensure the `signif.lvl` matches the intended threshold for the future study (typically `5e-8` or `1e-7`).

## Reference documentation

- [INPower Package](./references/vignette.md)