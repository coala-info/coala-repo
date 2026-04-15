---
name: r-phewas
description: The r-phewas package provides a pipeline for conducting Phenome-Wide Association Studies by mapping ICD codes to phecodes and performing statistical association tests. Use when user asks to convert ICD-9 or ICD-10 codes into phecodes, run phenome-wide regression analyses, or generate PheWAS Manhattan plots.
homepage: https://cran.r-project.org/web/packages/phewas/index.html
---

# r-phewas

## Overview
The `phewas` package provides a comprehensive pipeline for Phenome-Wide Association Studies. It facilitates the translation of Electronic Health Record (EHR) data—specifically ICD-9 and ICD-10 diagnosis codes—into clinically meaningful "phecodes." The package includes tools for data preparation, statistical association testing (using logistic or linear regression), and high-quality visualization of phenome-wide results.

## Installation
To install the stable version from CRAN:
```R
install.packages("PheWAS")
```

To install the development version from GitHub:
```R
# install.packages("devtools")
devtools::install_github("PheWAS/PheWAS")
```

## Core Workflow

### 1. Data Preparation
The primary task is converting raw ICD codes into phecodes.
```R
library(PheWAS)
# Convert ICD codes to phecodes
# id_icd_count: data frame with columns 'id', 'icd9' (or 'icd10'), and optionally 'count'
phenotypes <- createPhenotypes(id_icd_count, aggregate.fun=sum, min.code.count=2)
```

### 2. Running the Analysis
The `phewas` function automates the regression models across all phenotypes.
```R
# phenotypes: output from createPhenotypes
# genotypes: data frame with 'id' and the predictor variable (e.g., SNP)
# covariates: data frame with 'id' and adjustment variables (e.g., age, sex, PCs)
results <- phewas(phenotypes = phenotypes, 
                  genotypes = genotypes, 
                  covariates = covariates, 
                  significance.threshold = c("bonferroni"))
```

### 3. Visualization
Generate a Manhattan plot specifically styled for PheWAS results, grouped by clinical categories.
```R
phewasManhattan(results, title="PheWAS Results: SNP rs12345")
```

## Key Functions
- `createPhenotypes()`: Maps ICD-9/ICD-10 codes to phecodes and creates a wide phenotype matrix.
- `phewas()`: Performs the association tests. It supports multiple cores via the `cores` parameter.
- `phewasManhattan()`: Creates a ggplot2-based Manhattan plot.
- `addPhecodeInfo()`: Adds descriptions and categories to phecode results for better interpretability.

## Tips for Success
- **Code Counts**: Use `min.code.count=2` in `createPhenotypes` to increase the specificity of phenotype definitions, as a single ICD code instance is often noisy in EHR data.
- **Exclusions**: The package automatically handles "exclusion criteria" (e.g., if a patient has a code for Type 2 Diabetes, they are excluded from the control group for Type 1 Diabetes) when using the default phecode maps.
- **Parallelization**: For large phenomes, set `cores` in the `phewas()` function to utilize multi-core processing.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)