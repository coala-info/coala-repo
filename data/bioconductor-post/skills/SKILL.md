---
name: bioconductor-post
description: The POST package performs gene-set analysis by projecting high-dimensional genomic data onto orthogonal space to test associations with clinical endpoints. Use when user asks to perform gene-set analysis, test associations between gene sets and binary or continuous outcomes using GLMs, or conduct survival analysis using Cox proportional hazards models.
homepage: https://bioconductor.org/packages/3.8/bioc/html/POST.html
---


# bioconductor-post

## Overview

The `POST` package implements the Projection onto Orthogonal Space Test, a robust method for gene-set analysis. It reduces high-dimensional genomic data within a gene set into a smaller number of representative eigenvectors (projections) and tests their association with a clinical endpoint using generalized linear models (GLM) or Cox proportional hazards models. This approach is particularly effective for capturing complex associations while maintaining statistical power through bootstrapping.

## Core Workflow

### 1. Data Preparation
The package requires data to be structured in standard Bioconductor formats:
*   **Expression Data**: An `ExpressionSet` object containing the genomic features (rows) and samples (columns).
*   **Phenotype Data**: Clinical variables must be stored in the `phenoData` slot of the `ExpressionSet`.
*   **Gene Sets**: A `GeneSetCollection` object (from the `GSEABase` package) defining the groups of features to be tested.

```r
library(POST)
library(Biobase)
library(GSEABase)

# Load example data
data(sampExprSet)
data(sampGeneSet)
```

### 2. Testing Binary or Continuous Endpoints (POSTglm)
Use `POSTglm` for logistic regression (binary outcomes) or linear regression (continuous outcomes).

```r
# Example: Logistic regression for a binary 'Group' variable
results_glm <- POSTglm(
  exprSet = sampExprSet,
  geneSet = sampGeneSet,
  model = Group ~ 1,           # Formula for the phenotype
  family = binomial("logit"),  # Use gaussian() for continuous
  lamda = 0.95,                # Variance explained threshold for eigenvectors
  nboots = 100,                # Number of bootstrap iterations
  seed = 13                    # For reproducibility
)

# View results
print(results_glm)
```

### 3. Testing Survival Endpoints (POSTcoxph)
Use `POSTcoxph` for time-to-event data using the Cox proportional hazards framework.

```r
# Example: Survival analysis
results_cox <- POSTcoxph(
  exprSet = sampExprSet,
  geneSet = sampGeneSet,
  model = "Surv(time, censor) ~ ", # Survival formula string
  lamda = 0.95,
  nboots = 100,
  seed = 13
)

# View results
print(results_cox)
```

## Interpreting Results

The output is a matrix where each row represents a gene set with the following columns:
*   **GeneSet**: Name of the gene set.
*   **Nprobe**: Number of genomic features (probes/genes) in the set.
*   **Nproj**: Number of eigenvectors (projections) used to explain the variance (controlled by `lamda`).
*   **Stat**: The calculated POST statistic (sum of squared z-statistics).
*   **p.value**: The bootstrap-derived p-value for the association.

## Key Parameters
*   **lamda**: A value between 0 and 1. It determines how many eigenvectors are retained based on the proportion of total variance explained. A higher `lamda` includes more components.
*   **nboots**: The number of bootstrap samples. For publication-quality p-values, higher values (e.g., 1000+) are recommended, though 100 is sufficient for initial screening.
*   **model**: In `POSTglm`, this is a standard R formula. In `POSTcoxph`, this is a string representing the right-hand side of the survival formula.

## Reference documentation
- [POST: Projection onto Orthogonal Space Test](./references/POST.md)