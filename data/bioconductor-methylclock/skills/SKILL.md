---
name: bioconductor-methylclock
description: This tool estimates chronological and gestational DNA methylation age and calculates age acceleration using various epigenetic clocks. Use when user asks to estimate biological age from Illumina methylation arrays, calculate gestational age at birth from placental or cord blood data, or determine age acceleration as a biomarker for health outcomes.
homepage: https://bioconductor.org/packages/release/bioc/html/methylclock.html
---

# bioconductor-methylclock

name: bioconductor-methylclock
description: Estimation of chronological and gestational DNA methylation (DNAm) age using various epigenetic clocks. Use this skill when you need to calculate biological age, gestational age at birth, or age acceleration from Illumina methylation arrays (27K, 450K, EPIC) or placental data.

# bioconductor-methylclock

## Overview

The `methylclock` package provides a unified interface for estimating DNA methylation (DNAm) age using a wide variety of established epigenetic clocks. It supports both chronological age estimation (for children and adults) and gestational age estimation (for cord blood and placenta). A key feature is the ability to calculate "age acceleration"—the difference between DNAm age and actual chronological age—which is often used as a biomarker for health outcomes and disease risk.

## Core Workflows

### 1. Data Preparation

The package accepts several input formats for methylation data (`x`):
- **Matrix/Data Frame**: CpGs in rows, samples in columns. CpG names must be in the first column or rownames.
- **ExpressionSet**: Standard Bioconductor container.
- **GenomicRatioSet**: Output from the `minfi` package.

```r
library(methylclock)
library(methylclockData)

# Example: Loading test data
my_data <- get_TestDataset() 

# Check which clocks can be estimated based on available CpGs
checkClocks(my_data)   # For chronological clocks
checkClocksGA(my_data) # For gestational clocks
```

### 2. Estimating Chronological DNAm Age

The `DNAmAge` function is the primary tool for adult and pediatric age estimation.

```r
# Basic estimation (returns a tibble with multiple clocks)
age_estimates <- DNAmAge(my_data)

# Advanced: Include chronological age to calculate acceleration
# 'age' should be a numeric vector matching the columns in my_data
results <- DNAmAge(my_data, age = chronological_age_vector, cell.count = TRUE)

# Specific clocks: "Horvath", "Hannum", "Levine", "BNN", "skinHorvath", "PedBE", "Wu", "TL", "BLUP", "EN"
results_subset <- DNAmAge(my_data, clocks = c("Horvath", "Levine"))
```

**Key Output Columns:**
- `ageAcc`: Difference (DNAmAge - Age).
- `ageAcc2`: Residuals from regressing DNAmAge on Age (IEAA).
- `ageAcc3`: Residuals adjusted for cell counts (EEAA).

### 3. Estimating Gestational DNAm Age

Use `DNAmGA` for cord blood or placental samples.

```r
# Estimate gestational age (in weeks)
ga_results <- DNAmGA(my_data)

# Clocks included: "Knight", "Bohlin", "Mayne", "EPIC", "Lee" (RPC, CPC, Refined RPC)
```

### 4. Cell Count Estimation

By default, `DNAmAge` estimates cell counts to calculate adjusted age acceleration. You can specify the reference panel using `cell.count.reference`:
- `"blood gse35069"` (Default)
- `"andrews and bakulski cord blood"`
- `"saliva gse48472"`
- `"combined cord blood"`

### 5. Visualization

```r
# Plot correlation between DNAm age and chronological age
plotDNAmAge(results$Horvath, chronological_age_vector, tit = "Horvath Clock")

# Plot correlation between different clocks
plotCorClocks(results)
```

## Technical Tips

- **Missing Data**: The package requires complete cases. It uses KNN imputation by default. For large 450K/EPIC datasets, use `fastImp = TRUE` to use median imputation instead.
- **Normalization**: If your data is not yet normalized, you can set `normalize = TRUE` in `DNAmAge` to use Horvath's robust BMIQ implementation (requires `BiocParallel`).
- **Thresholds**: By default, a clock returns `NA` if < 80% of its required CpGs are present. Adjust this using the `min.perc` argument (e.g., `min.perc = 0.5`).
- **Multi-threading Error**: If you encounter an error with `preprocessCore` during cell count estimation, reinstall it with threading disabled:
  `BiocManager::install("preprocessCore", configure.args = "--disable-threading", force = TRUE)`

## Reference documentation

- [Chronological and gestational DNAm age estimation using different methylation-based clocks](./references/methylclock.Rmd)
- [Chronological and gestational DNAm age estimation using different methylation-based clocks (Markdown)](./references/methylclock.md)