---
name: scmap-cli
description: The `scmap-cli` toolset provides a command-line interface for the `scmap` Bioconductor package, enabling the projection of single-cell RNA-seq data across different experiments.
homepage: https://github.com/ebi-gene-expression-group/scmap-cli
---

# scmap-cli

## Overview

The `scmap-cli` toolset provides a command-line interface for the `scmap` Bioconductor package, enabling the projection of single-cell RNA-seq data across different experiments. This skill should be used to automate workflows that map "query" cells to "reference" clusters or individual cells without requiring direct R programming. The tool operates primarily on serialized R objects (`.rds` files) containing `SingleCellExperiment` (SCE) objects.

## Core Workflow

The standard `scmap` pipeline follows a linear progression: Preprocessing -> Feature Selection -> Indexing -> Projection.

### 1. Preprocessing
Before analysis, the SCE object must be normalized and "un-sparsed."
```bash
scmap-preprocess-sce.R --input-object input.rds --output-sce-object preprocessed.rds
```

### 2. Feature Selection
Identify the most informative genes (features) for the projection.
```bash
scmap-select-features.R \
  --input-object-file preprocessed.rds \
  --n-features 500 \
  --output-object-file features.rds \
  --output-plot-file selection_plot.png
```
*   **Tip**: Always generate the plot to verify the relationship between dropout rate and median expression.

### 3. Indexing (Reference Dataset)
You must create an index for your reference dataset. You can index by **Cluster** (centroids) or by **Cell** (approximate nearest neighbors).

**Cluster Indexing:**
```bash
scmap-index-cluster.R \
  --input-object-file features.rds \
  --cluster-col cell_type1 \
  --output-object-file cluster_index.rds
```

**Cell Indexing:**
```bash
scmap-index-cell.R \
  --input-object-file features.rds \
  --number-chunks 10 \
  --output-object-file cell_index.rds
```

### 4. Projection (Query Dataset)
Map your query dataset against the created index.

**Projecting to Clusters:**
```bash
scmap-scmap-cluster.R \
  -i cluster_index.rds \
  -p query.rds \
  --threshold 0.7 \
  --output-text-file results.csv
```

**Projecting to Cells:**
```bash
scmap-scmap-cell.R \
  -i cell_index.rds \
  -p query.rds \
  --number-nearest-neighbours 10 \
  --closest-cells-text-file neighbors.csv
```

## Best Practices and Expert Tips

- **Memory Management**: Use the `--remove-mat` flag during indexing steps (`scmap-index-cluster.R` or `scmap-index-cell.R`) to remove the raw expression matrix from the output index object. This significantly reduces file size and memory usage during projection.
- **Reproducibility**: When using `scmap-cell`, the underlying k-means clustering involves randomness. Ensure consistent results by setting a seed if the environment allows, or note that small variations may occur between runs.
- **Threshold Tuning**: In `scmap-cluster`, the `--threshold` parameter (default 0.7) determines the similarity required to assign a cell to a cluster. If too many cells are labeled "unassigned," consider lowering this threshold.
- **Standardizing Output**: Use `scmap_get_std_output.R` to convert tool-specific outputs into a unified format suitable for downstream multi-tool pipelines.
  ```bash
  scmap_get_std_output.R \
    --predictions-file results.csv \
    --tool scmap-cluster \
    --output-table final_results.tsv
  ```
- **Input Validation**: Ensure your query and reference datasets use the same gene identifiers (e.g., Gene Symbols or Ensembl IDs). `scmap` matches features by row names.

## Reference documentation
- [scmap-cli GitHub Repository](./references/github_com_ebi-gene-expression-group_scmap-cli.md)
- [scmap-cli Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scmap-cli_overview.md)