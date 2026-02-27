---
name: bioconductor-connectivitymap
description: This package provides access to the Broad Institute's Connectivity Map (cmap02) data for functional connection analysis in R. Use when user asks to access gene expression perturbation ranks, filter drug-response instances by cell line or concentration, or identify functional connections between small molecules and disease signatures.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ConnectivityMap.html
---


# bioconductor-connectivitymap

name: bioconductor-connectivitymap
description: Access and utilize the Broad Institute's Connectivity Map (cmap02) data within R. Use this skill when a user needs to perform pattern-matching or functional connection analysis between drugs, genes, and diseases using the reference catalogue of gene-expression profiles (7000+ profiles, 1300+ small molecules).

# bioconductor-connectivitymap

## Overview
The `ConnectivityMap` package provides a standardized R interface to the Broad Institute's Connectivity Map (version 02). It contains two primary data objects: a rank matrix of gene expression perturbations and a metadata table describing the experimental "instances" (cell lines, drug concentrations, durations, etc.). This resource is used to identify functional connections between small molecules sharing mechanisms of action or to connect disease signatures to potential therapeutic compounds.

## Data Objects
The package provides two main datasets that must be loaded using the `data()` function:

- `rankMatrix`: A matrix of 22,283 rows (Affymetrix probe IDs) by 6,100 columns (perturbation instances). Values represent the rank of gene expression change.
- `instances`: A data frame containing metadata for the 6,100 instances, including `instance_id`, `cmap_name` (drug name), `cell2` (cell line), `concentration..M.`, and `duration..h.`.

## Typical Workflow

### 1. Loading the Data
```r
library(ConnectivityMap)
data(rankMatrix)
data(instances)
```

### 2. Filtering Instances
Users often want to focus on specific cell lines or specific drugs. Use the `instances` metadata to identify relevant column names for the `rankMatrix`.

```r
# View available cell lines
table(instances$cell2)

# Identify instances for a specific cell line (e.g., MCF7)
mcf7_instances <- rownames(subset(instances, cell2 == "MCF7"))

# Subset the rank matrix
matrix_mcf7 <- rankMatrix[, mcf7_instances]
```

### 3. Analyzing Perturbations
The `rankMatrix` contains ranks. A low rank (e.g., 1) indicates the gene was highly up-regulated in that instance, while a high rank (e.g., 22283) indicates it was highly down-regulated.

```r
# Find the rank of a specific probe in a specific instance
# Example: Probe "200000_s_at" in the first instance
rank_val <- rankMatrix["200000_s_at", 1]
```

## Usage Tips
- **Probe IDs**: The data uses Affymetrix probe IDs. If starting with Gene Symbols, use a mapping package like `org.Hs.eg.db` or `hgu133plus2.db` to convert symbols to probe IDs before querying the `rankMatrix`.
- **Column Names**: The column names of `rankMatrix` correspond to the row names of the `instances` data frame.
- **Metadata Quirks**: Note that some column names in `instances` contain double dots, such as `concentration..M.` and `duration..h.`.

## Reference documentation
- [ConnectivityMap Reference Manual](./references/reference_manual.md)