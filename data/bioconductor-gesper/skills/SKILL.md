---
name: bioconductor-gesper
description: This tool deconvolutes off-target confounded phenotypes from RNAi screens using regularized linear regression to estimate gene-specific phenotypes. Use when user asks to estimate gene-specific phenotypes from siRNA-specific phenotypes, account for predicted seed-based off-targets, or perform concordance analysis between different RNAi screens.
homepage: https://bioconductor.org/packages/3.8/bioc/html/gespeR.html
---


# bioconductor-gesper

name: bioconductor-gesper
description: Deconvolution of off-target confounded phenotypes from RNA interference (RNAi) screens using regularized linear regression. Use this skill to estimate gene-specific phenotypes (GSPs) from siRNA-specific phenotypes (SSPs) by accounting for siRNA-to-gene target relations (e.g., predicted seed-based off-targets).

# bioconductor-gesper

## Overview

The `gespeR` package addresses the challenge of off-target effects in RNAi screens. It uses a regularized linear regression model (Elastic Net) to deconvolute observed siRNA-specific phenotypes (SSPs) into individual gene-specific phenotypes (GSPs). This allows for more accurate identification of true genetic hits by considering both intended targets and predicted off-targets (typically via 3' UTR binding).

## Core Workflow

### 1. Data Preparation
Load the library and prepare phenotype and target relation objects.

```r
library(gespeR)

# Load siRNA-specific phenotypes (SSP)
# Expects a file with siRNA IDs and scores
pheno <- Phenotypes(system.file("extdata", "Phenotypes_screen_A.txt", package="gespeR"),
                    type = "SSP",
                    col.id = 1,
                    col.score = 2)

# Load siRNA-to-gene target relations (TR)
# TR objects represent the strength of knockdown for each siRNA on each gene
tr <- TargetRelations(system.file("extdata", "TR_screen_A.rds", package="gespeR"))
```

### 2. Memory Management for Large Screens
For genome-wide datasets, target relations can be offloaded from RAM to disk.

```r
# Unload values to a temporary file to save memory
tr <- unloadValues(tr, writeValues = TRUE, path = "temp_tr.rds")

# Reload when ready for computation
tr <- loadValues(tr)
```

### 3. Estimating Gene-Specific Phenotypes (GSPs)
Use the `gespeR` function to fit the model. Cross-validation (`mode = "cv"`) is recommended to find the optimal regularization parameter ($\lambda$).

```r
res <- gespeR(phenotypes = pheno,
              target.relations = tr,
              mode = "cv",
              alpha = 0.5, # Elastic net mixing parameter (0=ridge, 1=lasso)
              ncores = 1)
```

### 4. Extracting and Visualizing Results
Extract the deconvoluted GSP scores and compare them to the original SSPs.

```r
# Get GSP scores
gsp_scores <- gsp(res)
head(scores(res))

# Get original SSP scores
ssp_scores <- ssp(res)

# Plot distributions
plot(res)
```

### 5. Concordance Analysis
Compare the consistency of results across different screens or between SSP and GSP levels.

```r
# Calculate concordance between multiple gespeR result objects
conc <- concordance(list(res1, res2))
plot(conc)
```

## Key Functions
- `Phenotypes()`: Constructor for phenotype objects (SSP or GSP).
- `TargetRelations()`: Constructor for siRNA-to-gene mapping and knockdown strengths.
- `gespeR()`: Main function for GSP estimation using Elastic Net.
- `gsp()` / `ssp()`: Extract gene-specific or siRNA-specific phenotype data frames.
- `concordance()`: Evaluates rank-based consistency (e.g., RBO, Jaccard) between phenotype lists.

## Tips
- **Alpha Parameter**: An `alpha` of 0.5 is a good starting point to balance sparsity (Lasso) and the grouping of correlated predictors (Ridge).
- **Target Relations**: The quality of GSP estimation depends heavily on the accuracy of the `TargetRelations` input (e.g., TargetScan predictions).
- **Missing Values**: GSP scores for genes not targeted by any siRNA in the model will return `NA`.

## Reference documentation
- [Estimating Gene-Specific Phenotypes with gespeR](./references/gespeR.md)