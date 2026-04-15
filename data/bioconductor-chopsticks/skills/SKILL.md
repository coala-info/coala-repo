---
name: bioconductor-chopsticks
description: The chopsticks package provides high-performance classes and methods for large-scale SNP association studies using memory-efficient genotype storage. Use when user asks to perform single SNP association testing, calculate linkage disequilibrium, conduct quality control on genotype data, or visualize results with QQ plots.
homepage: https://bioconductor.org/packages/release/bioc/html/chopsticks.html
---

# bioconductor-chopsticks

## Overview
The `chopsticks` package (an evolution of `snpMatrix`) provides high-performance S4 classes and methods for large-scale SNP association studies. It stores genotype calls as single bytes, allowing genome-wide data to be processed in memory. It supports population-based studies with quantitative or qualitative phenotypes, controlling for covariates and stratification.

## Core Data Classes
- **snp.matrix**: A specialized matrix where rows are subjects and columns are SNPs. Genotypes are stored in a memory-efficient byte format.
- **snp.support**: A data frame containing SNP metadata (chromosome, position, alleles). Row names must match `snp.matrix` column names.
- **subject.support**: A data frame containing subject metadata (phenotypes, strata, covariates). Row names must match `snp.matrix` row names.

## Essential Workflows

### 1. Data Inspection and Quality Control
Use `summary()` and `row.summary()` to identify poorly performing SNPs or samples.

```r
library(chopsticks)

# Summarize SNPs (Call rate, MAF, HWE)
snpsum <- summary(snps.10)
hist(snpsum$MAF)
hist(snpsum$z.HWE) # Z-score for Hardy-Weinberg Equilibrium

# Summarize Samples (Call rate, Heterozygosity)
sample.qc <- row.summary(snps.10)
plot(sample.qc)

# Filter samples/SNPs
use.samples <- sample.qc$Heterozygosity > 0
snps.clean <- snps.10[use.samples, ]
```

### 2. Single SNP Association Testing
The `single.snp.tests()` function is the fastest method for Cochran-Armitage (1 df) and Pearsonian (2 df) tests.

```r
# Basic association test (cc = case-control status)
tests <- single.snp.tests(cc, data = subject.support, snp.data = snps.10)

# Stratified test to control for population structure
tests.strat <- single.snp.tests(cc, stratum, data = subject.support, snp.data = snps.10)

# Extract p-values
p1 <- pchisq(tests.strat$chi2.1df, df = 1, lower.tail = FALSE)
```

### 3. Visualizing Results
Use Quantile-Quantile (QQ) plots to check for over-dispersion (inflation).

```r
# QQ plot for 1 df tests
qq.chisq(tests.strat$chi2.1df, df = 1)

# Manhattan-style plot using hexbin for large data
library(hexbin)
plot(hexbin(snp.support$position, -log10(p1), xbin = 50))
```

### 4. Linkage Disequilibrium (LD) and Effect Size
Calculate LD between SNPs and estimate odds ratios using logistic regression.

```r
# Calculate LD (D') for a subset of SNPs
ld.matrix <- ld.snp(snps.subset)
plot(ld.matrix)

# Estimate effect size (Odds Ratio) for a specific SNP
top.snp <- as.numeric(snps.10[, "rs870041"])
model <- glm(cc ~ top.snp + stratum, family = "binomial", data = subject.support)
summary(model)
exp(coef(model)["top.snp"]) # Odds Ratio
```

### 5. Multi-locus and Flexible Testing
Use `snp.rhs.tests` for testing groups of SNPs (tags) or complex models.

```r
# Test blocks of SNPs (e.g., defined in a list 'blocks')
mtests <- snp.rhs.tests(cc ~ stratum, family = "binomial", 
                        data = subject.support, 
                        snp.data = snps.use, 
                        tests = blocks)

# Calculate p-values for multi-df tests
pm <- pchisq(mtests$Chi.squared, mtests$Df, lower.tail = FALSE)
```

## Tips for Efficiency
- **Memory**: Always subset the `snp.matrix` using logical or integer vectors to keep memory usage low.
- **Ordering**: Ensure row names of support data frames match the row/column names of the `snp.matrix` before analysis.
- **Missingness**: `single.snp.tests` handles missing data automatically, but `glm` on extracted numeric vectors may require explicit handling of `NA` values.

## Reference documentation
- [snpMatrix vignette](./references/chopsticks-vignette.md)