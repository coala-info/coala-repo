---
name: bioconductor-snpstats
description: This tool provides high-performance analysis and memory-efficient storage for large-scale SNP association studies. Use when user asks to import PLINK or pedfiles, perform quality control filtering, conduct single-SNP or GLM-based association tests, or handle genotype imputation and population structure analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/snpStats.html
---

# bioconductor-snpstats

name: bioconductor-snpstats
description: Expert guidance for the Bioconductor R package snpStats. Use this skill when performing large-scale SNP association studies, including data import (PLINK, pedfiles), quality control (HWE, call rates), association testing (single SNP, GLMs, multi-locus), imputation, Fst calculation, and Principal Component Analysis (PCA) for population structure.

# bioconductor-snpstats

## Overview
The `snpStats` package is a high-performance Bioconductor tool designed for the analysis of large-scale SNP datasets. It uses a memory-efficient `SnpMatrix` class (storing genotypes in 1 byte per call) to handle hundreds of thousands of SNPs and subjects. It supports both certain genotype calls and uncertain (imputed) data.

## Core Workflows

### 1. Data Import
`snpStats` supports several common formats. The result is typically a list containing a `genotypes` (SnpMatrix), `fam` (subject data), and `map` (SNP data).

*   **PLINK Binary Files:**
    ```r
    # Provide the stub or individual .bed, .bim, .fam files
    data <- read.plink("mydata") 
    snps <- data$genotypes
    ```
*   **Pedfiles (Text):**
    ```r
    data <- read.pedfile("data.ped", snps="data.info")
    ```
*   **Long Format (e.g., from imputation or custom pipelines):**
    ```r
    data <- read.long("data.txt", fields=c(snp=1, sample=2, genotype=3, confidence=4))
    ```

### 2. Quality Control
Use `col.summary` for SNP-level metrics and `row.summary` for subject-level metrics.

```r
snpsum <- col.summary(snps)
# Filter by MAF, Call Rate, and Hardy-Weinberg Equilibrium
use_snps <- with(snpsum, MAF > 0.01 & Call.rate > 0.95 & abs(z.HWE) < 4)
snps_clean <- snps[, use_snps]

samplesum <- row.summary(snps)
# Filter by subject call rate or heterozygosity outliers
use_samples <- with(samplesum, Call.rate > 0.95 & Heterozygosity > 0)
snps_final <- snps_clean[use_samples, ]
```

### 3. Association Testing
The package provides highly optimized score tests.

*   **Single SNP Tests:**
    ```r
    # cc is case/control status; stratum is for population stratification
    results <- single.snp.tests(cc, stratum, data=subject_support, snp.data=snps_final)
    p_vals <- p.value(results, df=1)
    ```
*   **GLM-based Tests (Flexible Covariates):**
    ```r
    # Use snp.rhs.tests for SNPs as predictors
    tests <- snp.rhs.tests(cc ~ age + sex + strata(stratum), family="binomial", 
                           data=subject_support, snp.data=snps_final)
    ```

### 4. Imputation and Meta-analysis
`snpStats` can calculate imputation rules from a reference panel and apply them to a target dataset without explicitly storing the imputed genotypes.

```r
# 1. Calculate rules
rules <- snp.imputation(present_snps, missing_snps, pos_present, pos_missing)
# 2. Test imputed SNPs directly
imp_tests <- single.snp.tests(cc, stratum, data=subject_support, 
                              snp.data=target_snps, rules=rules)
# 3. Meta-analysis (pooling score tests)
pooled <- pool(study1_results, study2_results)
```

### 5. Population Structure (PCA)
To handle population stratification, use `xxt` to calculate the relationship matrix.

```r
# Calculate X*X' matrix
xxmat <- xxt(snps, correct.for.missing=FALSE)
# Eigenvalue decomposition
evv <- eigen(xxmat, symmetric=TRUE)
pcs <- evv$vectors[, 1:5] # First 5 Principal Components
```

### 6. Linkage Disequilibrium (LD)
Calculate D' or R-squared between pairs of SNPs.

```r
ld_matrix <- ld(snps, depth=100, stats=c("D.prime", "R.squared"))
# Plotting LD
image(ld_matrix$R.squared, lwd=0)
```

## Reference documentation
- [snpStats Main Vignette](./references/snpStats-vignette.md)
- [Data Input Guide](./references/data-input-vignette.md)
- [Imputation and Meta-analysis](./references/imputation-vignette.md)
- [Linkage Disequilibrium (LD)](./references/ld-vignette.md)
- [Principal Components Analysis (PCA)](./references/pca-vignette.md)
- [Fst Calculation](./references/Fst-vignette.md)
- [Family-based TDT Tests](./references/tdt-vignette.md)
- [Differences from snpMatrix](./references/differences.md)