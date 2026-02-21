---
name: r-solarius
description: Skill for using the CRAN R package r-solarius.
homepage: https://cran.r-project.org/web/packages/solarius/index.html
---

# r-solarius

name: r-solarius
description: Interface to SOLAR (Sequential Oligogenic Linkage Analysis Routines) for performing genetic analysis including variance component estimation, heritability calculation, and linkage/association mapping in R. Use this skill when a user needs to perform quantitative genetic analysis on pedigree data, estimate polygenic parameters, or conduct genome-wide association studies (GWAS) using the SOLAR backend.

## Overview
The `solarius` package provides an R interface to the SOLAR software. It automates the creation of necessary files (pedigree, phenotypes), manages the execution of SOLAR commands, and parses the results back into R objects. It is particularly useful for variance component models, heritability estimation, and identifying genetic correlations between traits.

## Installation
To install the package from CRAN:
```r
install.packages("solarius")
```
Note: This package requires the SOLAR software to be installed on the system.

## Main Functions and Workflows

### 1. Polygenic Analysis (Heritability)
The core function `solarPolygenic` estimates heritability and variance components.
```r
# Basic polygenic model
mod <- solarPolygenic(trait ~ age + sex, data = my_data)

# Access results
summary(mod)
mod$vcf # Variance components
```

### 2. Association Analysis
Use `solarAssoc` to perform genome-wide association studies or candidate gene analysis.
```r
# Association mapping
out <- solarAssoc(trait ~ age + sex, data = my_data, snpdata = my_genotypes)

# View top hits
summary(out)
```

### 3. Multipoint Linkage Analysis
Use `solarMultipoint` for linkage mapping.
```r
# Linkage analysis
out <- solarMultipoint(trait ~ age + sex, data = my_data, mibddir = "/path/to/mibd")
```

### 4. Bivariate Models
To estimate genetic correlation between two traits:
```r
# Bivariate polygenic model
mod <- solarPolygenic(cbind(trait1, trait2) ~ 1, data = my_data)
```

## Tips for Success
- **Pedigree Data**: Ensure your data frame contains standard SOLAR columns: `ID`, `FA` (Father), `MO` (Mother), and `SEX`.
- **SOLAR Path**: If SOLAR is not in your system PATH, specify it using `options(solar.path = "/path/to/solar")`.
- **Parallel Computing**: Many functions support parallel execution via the `cores` argument (e.g., `solarAssoc(..., cores = 4)`).
- **Transformations**: Use the `polygenicSettings` argument to pass specific SOLAR commands like `invnorm` for inverse normal transformations.

## Reference documentation
None