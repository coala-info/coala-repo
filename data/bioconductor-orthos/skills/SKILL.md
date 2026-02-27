---
name: bioconductor-orthos
description: This tool decomposes RNA-seq differential expression contrasts into specific and non-specific components using variational autoencoders to isolate direct molecular signatures. Use when user asks to decompose gene expression changes, isolate treatment-specific effects from systemic responses, or query differential expression results against a database of public experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/orthos.html
---


# bioconductor-orthos

name: bioconductor-orthos
description: Expert guidance for using the Bioconductor package 'orthos' to decompose RNA-seq differential expression contrasts into specific and non-specific components and query them against a large database of public experiments. Use this skill when analyzing treatment effects (knockouts, drugs, etc.) to isolate direct molecular signatures from systemic/secondary responses.

## Overview

The `orthos` package uses conditional variational autoencoders (cVAEs) trained on the ARCHS4 database to disentangle gene expression changes. It splits a contrast (Log2 Fold Change) into:
1.  **Non-specific (Decoded):** Effects observed across many different treatments (e.g., stress response, toxicity, metabolic shifts).
2.  **Specific (Residual):** Effects unique to the perturbation, often representing the direct mechanism of action.

## Typical Workflow

### 1. Data Preparation
`orthos` requires raw counts and works with Human or Mouse data. It automatically maps gene identifiers (Symbols, Ensembl, Entrez).

```r
library(orthos)
# Example: counts matrix 'M' with columns 'Ctrl', 'Treat'
# Genes in rows, samples in columns
```

### 2. Contrast Decomposition
Use `decomposeVar()` to perform the decomposition. This function downloads the necessary models via `ExperimentHub`.

```r
# Mode 1: Provide raw counts and indices
dec_res <- decomposeVar(M = counts_matrix, 
                        treatm = c(2), # Index of treatment column
                        cntr = c(1),   # Index of control column
                        organism = "Human")

# The output is a SummarizedExperiment with 4 assays:
# - INPUT_CONTRASTS: Original LFC
# - DECODED_CONTRASTS: Non-specific component
# - RESIDUAL_CONTRASTS: Specific component
# - CONTEXT: Log2 CPM of the background
```

### 3. Querying the Database
Query the `orthosData` database (containing >100k public contrasts) to find experiments with similar signatures.

```r
# Use mode = "ANALYSIS" for full results
query_res <- queryWithContrasts(dec_res, 
                                organism = "Human", 
                                mode = "ANALYSIS")

# Access top hits for the specific (residual) component
query_res$TopHits$RESIDUAL_CONTRASTS[[1]]
```

### 4. Visualization
Visualize the decomposition and query results.

```r
# Violin plots of correlation distributions
plotQueryResultsViolin(query_res)

# Manhattan/Density plots
plotQueryResultsManh(query_res)
```

## Key Functions

- `decomposeVar()`: The main entry point for splitting LFCs into specific and non-specific parts.
- `queryWithContrasts()`: Compares your results against the ARCHS4-derived contrast database.
- `loadContrastDatabase()`: Directly access the HDF5-backed database of public contrasts for custom meta-analysis.
- `plotQueryResultsViolin()` / `plotQueryResultsManh()`: Standardized plotting for query outputs.

## Tips for Success

- **Input Completeness:** Do not filter genes before calling `decomposeVar()`. The model performs best when provided with the full set of features (it will internally subset to the ~20,000 "orthos-sanctioned" genes).
- **Context Matters:** The decomposition is context-specific. The same contrast might yield different specific/non-specific components if evaluated against a different expression background (e.g., different cell lines).
- **Interpreting Residuals:** High correlation in the `RESIDUAL_CONTRASTS` query usually indicates a shared molecular mechanism, whereas correlation in `DECODED_CONTRASTS` indicates similar secondary/systemic effects.
- **Parallelization:** For large queries, use `BiocParallel` parameters: `queryWithContrasts(..., BPPARAM = BiocParallel::MulticoreParam(workers = 4))`.

## Reference documentation

- [An introduction to contrast decomposition and querying using orthos](./references/orthosIntro.md)