---
name: bioconductor-ccmap
description: This tool predicts drugs and drug combinations that reverse a specific disease gene expression signature. Use when user asks to identify potential therapeutic candidates, perform connectivity mapping, or find synergistic drug pairs from differential expression results.
homepage: https://bioconductor.org/packages/release/bioc/html/ccmap.html
---


# bioconductor-ccmap

name: bioconductor-ccmap
description: Predict drugs and drug combinations that reverse a disease gene expression signature using the ccmap package. Use when performing connectivity mapping to identify potential therapeutic candidates or synergistic drug pairs from differential expression results.

## Overview
The `ccmap` package (Combination Connectivity Mapping) is designed to find drugs and drug combinations that are predicted to reverse a specific gene expression signature (e.g., a disease state). It compares a user-provided list of up-regulated and down-regulated genes against reference drug-induced expression profiles (like those from the Connectivity Map project). The core strength of this package is its ability to predict the effect of drug combinations, not just single agents.

## Installation
To use `ccmap`, ensure the package and its data dependency are installed:
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ccmap")
BiocManager::install("ccdata") # Required reference data
```

## Core Workflow

### 1. Prepare Input Data
The package requires two character vectors: one for up-regulated genes and one for down-regulated genes. These should be provided as Gene Symbols (e.g., HGNC symbols).

```r
up_genes <- c("GZMB", "PRF1", "GNLY", "STAT1")
down_genes <- c("CD3D", "CD3E", "CD3G", "LCK")
```

### 2. Single Drug Connectivity Mapping
Use the `ccmap` function to find single drugs that are predicted to reverse the signature. A negative score indicates that the drug tends to down-regulate the user's up-regulated genes and vice versa.

```r
library(ccmap)
# By default, it uses the data from the ccdata package
results <- ccmap(up_genes, down_genes)

# View top candidates
head(results)
```

### 3. Drug Combination Mapping
The `query_combined` function predicts the effect of drug pairs. This is computationally more intensive but identifies potential synergies.

```r
# Query combinations
comb_results <- query_combined(up_genes, down_genes)

# View top combinations
head(comb_results)
```

## Key Functions and Parameters

- `ccmap(up, down, ref, n_genes = 500, ...)`:
    - `up`/`down`: Vectors of gene symbols.
    - `ref`: The reference data. If omitted, it defaults to the `cmap_es` data from `ccdata`.
    - `n_genes`: Number of top/bottom genes from the reference to consider.
- `query_combined(up, down, ref, ...)`: Similar to `ccmap` but evaluates pairs of drugs.
- `get_drug_names(ids)`: Utility to convert internal IDs to drug names.
- `get_disease_names(ids)`: Utility to convert internal IDs to disease names.

## Interpreting Results
The output is typically a data frame containing:
- `drug`: The name or ID of the drug/combination.
- `sum_z`: The connectivity score. A more negative value suggests a stronger "reversal" of the input signature (potential therapeutic effect).
- `p_val`: Statistical significance of the connectivity.

## Tips
- **Gene Symbols**: Ensure your input genes are converted to the same nomenclature used in the reference data (usually Gene Symbols).
- **Data Source**: While `ccmap` defaults to CMap data, you can provide custom reference matrices if they follow the expected format (ranked expression profiles).
- **Memory**: `query_combined` can be memory-intensive; ensure you have sufficient RAM when running on large reference sets.

## Reference documentation
- [ccmap Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/ccmap.html)