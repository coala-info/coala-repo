---
name: bioconductor-promise
description: PROMISE identifies genomic features associated with a specific pattern across multiple phenotypic endpoints using a projection-based statistical procedure. Use when user asks to identify genes or gene sets associated with multiple phenotypes, perform integrative genomic analysis across different endpoint types, or calculate permutation-based p-values for multi-endpoint associations.
homepage: https://bioconductor.org/packages/release/bioc/html/PROMISE.html
---

# bioconductor-promise

## Overview

PROMISE (PROjection onto the Most Interesting Statistical Evidence) is a statistical procedure designed to identify genomic features associated with a specific pattern across multiple phenotypic endpoints. Instead of testing endpoints individually, PROMISE uses biological knowledge to define a "most interesting" vector of association statistics and projects observed statistics onto this vector. It supports various endpoint types (continuous, discrete, survival) and offers fast permutation-based p-value calculation using negative binomial sampling.

## Data Preparation

The package requires data to be formatted into standard Bioconductor structures:

1.  **ExpressionSet**: Must contain `exprs` (genomic features) and `phenoData` (phenotypic endpoints). Ensure array IDs match between the two.
2.  **GeneSetCollection**: (Optional) Required only if performing Gene Set Enrichment Analysis (GSEA). Feature IDs in the gene sets must match the row names of the ExpressionSet.

## Defining the Association Pattern

The association pattern is a data frame that defines how each endpoint should relate to the genomic features. It requires three columns:

*   **stat.func**: The function to calculate the individual association statistic (e.g., `spearman.rstat` for continuous/rank data, `jung.rstat` for survival data).
*   **stat.coef**: A numeric value (typically 1 or -1) indicating the expected direction of association.
*   **endpt.vars**: The column name(s) in the `phenoData` of the ExpressionSet corresponding to the endpoint.

Example pattern definition:
```r
phPatt <- data.frame(
  stat.func = c("spearman.rstat", "spearman.rstat", "jung.rstat"),
  stat.coef = c(1, -1, 1),
  endpt.vars = c("drugLevel", "residualDisease", "obsTime,obsCensor")
)
```

## Running PROMISE

Use the `PROMISE` function to execute the analysis.

### Key Arguments
*   `exprSet`: The input ExpressionSet.
*   `geneSet`: A GeneSetCollection or NULL.
*   `promise.pattern`: The pattern data frame defined above.
*   `proj0`: Set to `TRUE` if no prior biological knowledge of the endpoint direction is available (performs projection to point 0).
*   `nbperm`: Set to `TRUE` to use fast negative binomial sampling for permutations.
*   `nperms`: Number of permutations for p-value calculation.

### Basic Workflow
```r
library(PROMISE)

# Perform analysis
results <- PROMISE(
  exprSet = sampExprSet,
  geneSet = sampGeneSet,
  promise.pattern = phPatt,
  strat.var = NULL,
  proj0 = FALSE,
  nbperm = TRUE,
  nperms = 100
)

# Extract gene-level results
gene_results <- results$generes

# Extract gene set-level results (if geneSet was provided)
set_results <- results$setres
```

## Interpreting Results

The output contains statistics and permutation p-values for each individual endpoint and the combined PROMISE statistic:

*   **Individual Stats**: Columns ending in `.stat` (e.g., `drugLevel.stat`) show the association for that specific endpoint.
*   **PROMISE Stat**: The `PROMISE.stat` column represents the multi-endpoint combined evidence.
*   **P-values**: Columns ending in `.perm.p` provide the permutation-based significance.
*   **nperms**: If using `nbperm=TRUE`, this column shows how many permutations were actually performed for that specific feature before reaching the significance threshold.

## Tips for Success

*   **Survival Data**: When using `jung.rstat`, provide the time and censoring variables as a single string separated by a comma in the `endpt.vars` column.
*   **Stratification**: Use the `strat.var` argument to account for confounding factors (e.g., treatment arms or clinical sites) during the permutation process.
*   **Seed**: Always set a `seed` within the `PROMISE` function call to ensure reproducibility of permutation p-values.

## Reference documentation

- [An Introduction to PROMISE](./references/PROMISE.md)