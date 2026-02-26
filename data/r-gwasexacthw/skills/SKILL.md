---
name: r-gwasexacthw
description: This tool performs exact Hardy-Weinberg Equilibrium testing for SNP genotypes using Fisher's exact test. Use when user asks to calculate exact p-values for HWE, test genotype distributions in GWAS data, or handle HWE testing for rare alleles and small sample sizes.
homepage: https://cran.r-project.org/web/packages/gwasexacthw/index.html
---


# r-gwasexacthw

name: r-gwasexacthw
description: Exact Hardy-Weinberg Equilibrium (HWE) testing for SNP genotypes in Genome Wide Association Studies (GWAS). Use this skill when you need to calculate exact p-values for HWE using Fisher's exact test, particularly for large-scale genomic datasets where asymptotic approximations may be inaccurate.

## Overview

The `gwasexacthw` package provides a highly efficient implementation of the exact Hardy-Weinberg Equilibrium test. It is specifically designed to handle the genotype distributions typically encountered in GWAS, where one might have thousands to millions of SNPs. The package uses a recursive algorithm to calculate the exact p-value, which is more robust than the Chi-square test, especially when dealing with rare alleles or small sample sizes.

## Installation

To install the package from CRAN:

```R
install.packages("GWASExactHW")
```

## Main Functions

### HWExact()

This is the primary function used to calculate the exact p-value for HWE.

**Usage:**
```R
HWExact(genotype_counts)
```

**Arguments:**
- `genotype_counts`: A matrix or data frame where each row represents a SNP and columns represent the counts of the three genotypes. The columns must be in the order:
  1. Homozygote for the reference allele (AA)
  2. Heterozygote (AB)
  3. Homozygote for the alternative allele (BB)

**Returns:**
- A vector of p-values, one for each row in the input matrix.

## Workflows

### Basic HWE Testing

If you have a matrix of genotype counts:

```R
library(GWASExactHW)

# Example data: 3 SNPs with (AA, AB, BB) counts
geno_counts <- matrix(c(
  100, 50, 10,  # SNP 1
  50, 20, 80,   # SNP 2
  10, 5, 0      # SNP 3 (Rare alleles)
), ncol = 3, byrow = TRUE)

# Calculate p-values
p_values <- HWExact(geno_counts)

# View results
print(p_values)
```

### Processing GWAS Data

When working with large datasets (e.g., from `PLINK` or `GWASTools`), you typically extract the genotype counts first:

```R
# Assuming 'counts' is a dataframe with columns 'nAA', 'nAB', 'nBB'
results <- HWExact(as.matrix(counts[, c("nAA", "nAB", "nBB")]))

# Identify SNPs failing HWE (e.g., p < 1e-6)
failed_snps <- which(results < 1e-6)
```

## Tips

- **Input Order:** Ensure your columns are strictly ordered as (Major-Major, Major-Minor, Minor-Minor). The math depends on the middle column being the heterozygote count.
- **Performance:** The underlying implementation is written in C, making it suitable for millions of SNPs.
- **Missing Data:** Do not include missing genotypes (NAs) in the counts; the test is performed on the observed genotypes only.
- **Zero Counts:** The function handles zero counts for any genotype category correctly, which is a primary advantage over the Chi-square test.

## Reference documentation

- [GWASExactHW Home Page](./references/home_page.md)