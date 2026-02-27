---
name: bioconductor-summix
description: "Bioconductor-summix estimates, adjusts, and leverages genetic substructure in allele frequency summary data. Use when user asks to estimate ancestry mixture proportions, adjust allele frequencies to match a target population, or perform selection scans based on local ancestry deviations."
homepage: https://bioconductor.org/packages/release/bioc/html/Summix.html
---


# bioconductor-summix

name: bioconductor-summix
description: Estimate, adjust, and leverage genetic substructure in allele frequency (AF) summary data. Use this skill to (1) estimate ancestry mixture proportions (global or local) from summary statistics, (2) adjust allele frequencies to match a target population's substructure, or (3) perform selection scans based on local ancestry deviations.

# bioconductor-summix

## Overview

Summix is an R package designed to handle genetic substructure in summary-level data. It allows researchers to estimate the proportions of reference groups (ancestries) within an observed sample, adjust allele frequencies to harmonize datasets, and identify local genomic regions of selection. This is particularly useful for leveraging publicly available data (like gnomAD) as controls for diverse or admixed populations.

## Installation

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("Summix")
library(Summix)
```

## Core Workflow

### 1. Estimating Global Substructure (summix)
Use `summix()` to determine the mixture proportions of reference groups in your observed allele frequency data.

```R
# data: data frame with observed and reference AF columns
# reference: vector of column names for reference groups
# observed: column name for the observed group
results <- summix(data = ancestryData,
                  reference = c("ref_AF_afr", "ref_AF_eur", "ref_AF_eas"),
                  observed = "gnomad_AF_afr")

# Interpret goodness.of.fit:
# < 0.5: Good fit
# 0.5 - 1.5: Moderate fit (use caution)
# > 1.5: Poor fit (do not proceed with further Summix analysis)
```

### 2. Adjusting Allele Frequencies (adjAF)
Use `adjAF()` to transform observed allele frequencies to match a target ancestry profile (e.g., making an admixed sample look 100% African for a specific study).

```R
adjusted <- adjAF(data = ancestryData,
                  reference = c("ref_AF_afr", "ref_AF_eur"),
                  observed = "gnomad_AF_afr",
                  pi.target = c(1, 0),           # Target: 100% AFR, 0% EUR
                  pi.observed = c(0.81, 0.17),   # Proportions from summix()
                  N_reference = c(704, 741),     # Sample sizes of refs
                  N_observed = 20744,            # Sample size of observed
                  adj_method = 'average')

# Access adjusted frequencies
head(adjusted$adjusted.AF$adjustedAF)
# Check effective sample size
adjusted$effective.sample.size
```

### 3. Local Substructure and Selection Scans (summix_local)
Use `summix_local()` to estimate ancestry proportions across genomic windows and optionally identify regions under selection.

```R
# algorithm: "fastcatch" (dynamic windows, recommended) or "windows" (fixed)
# selection_scan: TRUE to calculate test statistics and p-values
local_results <- summix_local(data = ancestryData,
                              reference = c("ref_AF_afr", "ref_AF_eur"),
                              observed = "gnomad_AF_afr",
                              position_col = "POS",
                              algorithm = "fastcatch",
                              selection_scan = TRUE,
                              NSimRef = c(704, 741)) # Required for scan
```

## Key Parameters and Tips

- **Reference Selection**: Only include reference groups that are likely to contribute to the observed sample. `summix()` automatically removes groups with <1% global proportions unless `override_removeSmallRef = TRUE`.
- **Data Preparation**: Ensure the input data frame contains columns for both the observed allele frequencies and the reference allele frequencies for the same set of SNPs.
- **Filtering**: The `adjAF` function's `filter = TRUE` (default) removes SNPs with adjusted AF < -0.005 and rounds values between -0.005 and 0 to 0.
- **Rare Variants**: Note that AF adjustment accuracy is generally lower for rare variants (AF < 0.5%).

## Reference documentation

- [Summix](./references/Summix.md)