---
name: monocle3-cli
description: The `monocle3-cli` tool provides a set of command-line wrappers for the Monocle3 R package.
homepage: https://github.com/ebi-gene-expression-group/monocle-scripts
---

# monocle3-cli

## Overview

The `monocle3-cli` tool provides a set of command-line wrappers for the Monocle3 R package. It is designed to bridge the gap between R-based single-cell analysis and language-agnostic workflow environments. Use this skill to execute the standard Monocle3 workflow—from object creation and preprocessing to dimensionality reduction and trajectory learning—directly through a terminal or shell script.

## Core Workflow and Commands

The tool follows a sequential subcommand structure where the output of one step typically serves as the input for the next.

### 1. Object Creation
Initialize a Monocle 3 object (CellDataSet/cds3) from raw expression data.
```bash
monocle3 create --expression-matrix matrix.mtx \
    --cell-metadata cells.tsv \
    --gene-annotation genes.tsv \
    output.cds3
```
*   **Tip**: Use `--introspective` to print summary information about the created object to verify dimensions and metadata.
*   **Formats**: Supports TSV, CSV, RDS, and MTX.

### 2. Preprocessing
Perform normalization, scaling, and initial dimension reduction (PCA/LSI).
```bash
monocle3 preprocess --method PCA --num-dim 50 input.cds3 preprocessed.cds3
```
*   **Scaling**: By default, genes are scaled. Use `--no-scaling` to skip this if your data is already normalized.
*   **Residuals**: Use `--residual-model-formula-str` to regress out batch effects or technical noise (e.g., `"~batch + pct_mito"`).

### 3. Dimensionality Reduction
Reduce data to a lower-dimensional space, typically for visualization or trajectory learning.
```bash
monocle3 reduceDim --reduction-method UMAP --preprocess-method PCA input.cds3 reduced.cds3
```
*   **Performance**: Use `--cores` to parallelize the UMAP/tSNE calculation.

### 4. Partitioning and Clustering
Group cells into partitions and clusters.
```bash
monocle3 partition --reduction-method UMAP --resolution 1e-3 input.cds3 partitioned.cds3
```
*   **Granularity**: Adjust `--resolution` for Louvain clustering; higher values result in more clusters.
*   **Partitions**: The `--partition-qval` (default 0.05) determines how strictly cells are separated into disjoint trajectories.

### 5. Trajectory Learning
Learn the principal graph (trajectory) through the cell partitions.
```bash
monocle3 learnGraph input.cds3 trajectory.cds3
```

## Expert Tips and Best Practices

*   **Intermediate Files**: The CLI currently uses R objects (`.cds3`) as intermediate formats. Ensure you maintain consistent file naming conventions (e.g., `sample_preprocessed.cds3`, `sample_reduced.cds3`) to track your pipeline progress.
*   **Memory Management**: Single-cell datasets can be large. When working with MTX files in the `create` step, ensure your environment has sufficient RAM, as the CLI may convert sparse matrices during processing.
*   **Input Validation**: If `monocle3 create` fails with an MTX file, verify that your cell metadata and gene annotation row names exactly match the column and row names of the expression matrix.
*   **Visual Verification**: Use `monocle3 plotCells` after `reduceDim` or `learnGraph` to generate visualizations and ensure the dimensionality reduction or trajectory looks biologically plausible before proceeding to differential expression.

## Reference documentation
- [Monocle Scripts GitHub Repository](./references/github_com_ebi-gene-expression-group_monocle-scripts.md)
- [Monocle3-cli Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_monocle3-cli_overview.md)