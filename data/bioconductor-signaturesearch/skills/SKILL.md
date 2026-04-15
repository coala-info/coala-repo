---
name: bioconductor-signaturesearch
description: This tool performs gene expression signature searches and functional enrichment analysis to identify drug modes of action and repurposing candidates. Use when user asks to search gene expression signatures against LINCS or CMAP databases, perform target set enrichment analysis, or visualize drug-target networks.
homepage: https://bioconductor.org/packages/release/bioc/html/signatureSearch.html
---

# bioconductor-signaturesearch

name: bioconductor-signaturesearch
description: Perform Gene Expression Signature (GES) searches (GESS) and Functional Enrichment Analysis (FEA) to identify drug modes of action (MOA) and drug repurposing candidates. Use this skill when analyzing gene expression data against reference databases like LINCS or CMAP2, or when performing drug-target network visualizations.

# bioconductor-signaturesearch

## Overview
The `signatureSearch` package provides an integrated environment for searching gene expression signatures (GES) against large-scale perturbation databases (LINCS, CMAP) and interpreting the results through specialized functional enrichment analysis (FEA). It supports both set-based and correlation-based search algorithms and provides tools for drug-target network visualization.

## Core Workflow

### 1. Setup and Data Access
Access pre-built HDF5 databases via the `signatureSearchData` package or use custom databases.
```r
library(signatureSearch)
library(ExperimentHub)
eh <- ExperimentHub()
lincs <- eh[["EH3226"]] # Path to LINCS HDF5 file
```

### 2. Define Query (qSig)
Create a query object by providing gene sets (up/down regulated) or a quantitative expression matrix.
```r
# For set-based methods (CMAP, LINCS, Fisher)
query <- qSig(query = list(upset=c("gene1", "gene2"), downset=c("gene3", "gene4")), 
              gess_method="LINCS", refdb=lincs)

# For correlation-based methods (Cor)
query_mat <- matrix(rnorm(100), ncol=1)
rownames(query_mat) <- as.character(1:100)
query <- qSig(query = query_mat, gess_method="Cor", refdb=lincs)
```

### 3. Signature Search (GESS)
Execute the search using one of the five implemented algorithms:
- `gess_lincs()`: Weighted connectivity scores (recommended for LINCS).
- `gess_cmap()`: Original Connectivity Map algorithm.
- `gess_fisher()`: Fisher's exact test for gene set overlap.
- `gess_cor()`: Pearson, Spearman, or Kendall correlation.
- `gess_gcmap()`: Search query ranks against database sets.

```r
gess_res <- gess_lincs(query, sortby="NCS", tau=TRUE)
result(gess_res) # Extract results table
```

### 4. Functional Enrichment (FEA)
Interpret GESS hits by analyzing the targets of the top-ranked drugs.
- **TSEA (Target Set Enrichment Analysis):** Analyzes target proteins (supports duplications). Methods: `tsea_dup_hyperG`, `tsea_mGSEA`, `tsea_mabs`.
- **DSEA (Drug Set Enrichment Analysis):** Assigns functional categories directly to drugs. Methods: `dsea_hyperG`, `dsea_GSEA`.

```r
top_drugs <- unique(result(gess_res)$pert[1:10])
fea_res <- tsea_dup_hyperG(drugs=top_drugs, type="GO", ont="MF")
result(fea_res)
```

### 5. Visualization
Visualize drug-target interactions or compare results across FEA methods.
```r
# Drug-Target Network
dtnetplot(drugs = top_drugs, set = "GO:0032041", ont = "MF")

# Compare multiple FEA results
table_list <- list("HyperG" = result(fea_res), "mGSEA" = result(mgsea_res))
comp_fea_res(table_list, rank_stat="pvalue", Nshow=20)
```

## Key Functions and Parameters
- `build_custom_db()`: Create a custom HDF5 reference database from a matrix.
- `runWF()`: Automated end-to-end workflow from query to FEA report.
- `gmt2h5()`: Convert .gmt gene set files into a searchable HDF5 database.
- `workers`: Parameter in `gess_*` functions to enable parallel processing via `BiocParallel`.

## Reference documentation
- [signatureSearch: Environment for Gene Expression Searching Combined with Functional Enrichment Analysis](./references/signatureSearch.md)