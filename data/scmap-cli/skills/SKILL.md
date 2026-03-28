---
name: scmap-cli
description: scmap-cli projects single-cell RNA-seq datasets across different experiments to perform automated cell-type annotation. Use when user asks to preprocess single-cell data, select informative features, index reference datasets by cluster or cell, and map query cells to a reference for annotation.
homepage: https://github.com/ebi-gene-expression-group/scmap-cli
---


# scmap-cli

## Overview

The `scmap-cli` toolset provides a command-line interface for the `scmap` Bioconductor package, enabling the projection of single-cell RNA-seq datasets across different experiments or technologies. It is particularly useful for automated cell-type annotation by mapping "query" cells to a well-characterized "reference" dataset. The workflow typically involves preprocessing data into the SingleCellExperiment format, selecting highly informative genes, indexing the reference (either by cluster centroids or individual cells), and finally performing the projection.

## Core Workflow and Commands

### 1. Data Preparation
Before indexing or projection, the input SingleCellExperiment (`.rds`) object must be normalized and transformed.

```bash
scmap-preprocess-sce.R \
    --input-object <input.rds> \
    --output-sce-object <processed.rds>
```

### 2. Feature Selection
Identify the most informative genes to use for the projection. This reduces noise and improves mapping accuracy.

```bash
scmap-select-features.R \
    --input-object-file <processed.rds> \
    --n-features 500 \
    --output-object-file <selected_features.rds> \
    --output-plot-file <feature_plot.png>
```

### 3. Reference Indexing
You can index a reference dataset in two ways: by cluster (faster, uses centroids) or by cell (more granular, uses k-nearest neighbors).

**Cluster-based Indexing:**
```bash
scmap-index-cluster.R \
    --input-object-file <selected_features.rds> \
    --cluster-col <metadata_column_name> \
    --output-object-file <cluster_index.rds>
```

**Cell-based Indexing:**
```bash
scmap-index-cell.R \
    --input-object-file <selected_features.rds> \
    --number-chunks 10 \
    --number-clusters 100 \
    --output-object-file <cell_index.rds>
```

### 4. Projection and Mapping
Map your query dataset against the generated index.

**Mapping to Clusters:**
```bash
scmap-scmap-cluster.R \
    -i <cluster_index.rds> \
    -p <query_processed.rds> \
    --threshold 0.7 \
    --output-text-file <results.csv>
```

**Mapping to Cells:**
```bash
scmap-scmap-cell.R \
    -i <cell_index.rds> \
    -p <query_processed.rds> \
    --number-nearest-neighbours 10 \
    --output-object-file <projection_output.rds> \
    --closest-cells-text-file <neighbors.csv>
```

### 5. Standardizing Output
Convert tool-specific outputs into a standardized table for downstream analysis.

```bash
scmap_get_std_output.R \
    --predictions-file <results.csv> \
    --output-table <final_annotation.txt> \
    --tool <scmap-cell|scmap-cluster> \
    --include-scores TRUE
```

## Expert Tips and Best Practices

- **Threshold Tuning**: The `--threshold` parameter in `scmap-cluster` (default 0.7) determines the minimum cosine similarity required for an assignment. If too many cells are labeled "unassigned," consider lowering the threshold slightly, but be wary of false positives.
- **Feature Consistency**: Ensure that the gene identifiers (e.g., Gene Symbols or Ensembl IDs) used in the query dataset match those used to build the reference index.
- **Memory Management**: For very large reference datasets, use `scmap-index-cell.R` with the `--remove-mat` flag set to `TRUE` to reduce the size of the resulting index object by removing the raw expression matrix.
- **Visualization**: Always generate the `--output-plot-file` during feature selection to verify that the selected genes follow the expected dropout-vs-intensity curve.



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/scmap-index-cluster.R | Index clustering information for scmap |
| /usr/local/bin/scmap-preprocess-sce.R | Preprocesses a SingleCellExperiment object for scmap. |
| /usr/local/bin/scmap_get_std_output.R | Get standard output from scmap predictions |
| scmap-index-cell.R | Index cell data for scmap |
| scmap-scmap-cell.R | Annotates cells of a projection dataset using labels of a reference dataset. |
| scmap-scmap-cluster.R | Assigns cell types to cells in a SingleCellExperiment object using pre-computed cluster assignments. |
| scmap-select-features.R | Selects features based on expression and dropout distributions. |

## Reference documentation
- [scmap-scripts README](./references/github_com_ebi-gene-expression-group_scmap-cli_blob_develop_README.md)
- [Post-install test examples](./references/github_com_ebi-gene-expression-group_scmap-cli_blob_develop_scmap-cli-post-install-tests.sh.md)