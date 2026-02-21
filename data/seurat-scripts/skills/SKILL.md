---
name: seurat-scripts
description: The `seurat-scripts` package provides a suite of R-based command-line wrappers for the Seurat single-cell analysis ecosystem.
homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts
---

# seurat-scripts

## Overview
The `seurat-scripts` package provides a suite of R-based command-line wrappers for the Seurat single-cell analysis ecosystem. It allows users to execute discrete steps of a single-cell analysis pipeline—from raw count matrices to clustered visualizations—using standard shell commands. This skill enables the construction of modular bioinformatics pipelines where each Seurat function is treated as a standalone executable, facilitating reproducibility and integration into larger computational environments.

## Core CLI Workflows

### 1. Data Ingestion and QC
Start by reading 10X Genomics output and applying quality filters to remove low-quality cells.

*   **Read 10X Data**:
    `seurat-read-10x.R -d <data_dir> -o raw_counts.rds`
*   **Filter Cells**:
    `seurat-filter-cells.R -i raw_counts.rds -s nGene,nUMI -l <min_genes>,<min_umi> -o filtered_cells.rds`

### 2. Normalization and Feature Selection
Prepare the data for downstream analysis by scaling and identifying highly variable features.

*   **Normalize**:
    `seurat-normalise-data.R -i filtered_cells.rds -n LogNormalize -s 10000 -o norm_data.rds`
*   **Find Variable Genes**:
    `seurat-find-variable-genes.R -i norm_data.rds -o var_genes.rds -t variable_genes.txt`
*   **Scale Data**:
    `seurat-scale-data.R -i var_genes.rds -v nUMI,percent.mito -o scaled_data.rds`

### 3. Dimensionality Reduction and Clustering
Execute PCA, followed by non-linear reductions and graph-based clustering.

*   **Run PCA**:
    `seurat-run-pca.R -i scaled_data.rds -p 50 -o pca_results.rds`
*   **Find Neighbors & Clusters**:
    `seurat-find-neighbours.R -i pca_results.rds -d 1:20 -o neighbors.rds`
    `seurat-find-clusters.r -i neighbors.rds -r 0.5 -o clusters.rds -t cluster_assignments.txt`
*   **Run t-SNE/UMAP**:
    `seurat-run-tsne.r -i clusters.rds -d 1:20 -o tsne_results.rds`
    `seurat-run-umap.R -i clusters.rds -d 1:20 -o final_object.rds`

### 4. Visualization and Export
Generate plots and convert objects for use in other environments (e.g., Python/Scanpy).

*   **Dimension Plot**:
    `seurat-dim-plot.r -i final_object.rds -r umap -f ident -o umap_plot.png`
*   **Format Conversion**:
    `seurat-convert.R -i final_object.rds -o output.h5ad` (Supports Seurat, AnnData, Loom, and SCE)

## Expert Tips and Best Practices

*   **Help Documentation**: Every script supports the `--help` flag. Use it to discover specific parameters for different Seurat versions, as argument names can vary between Seurat 3.x and 4.x.
*   **RDS Interoperability**: The primary exchange format between these scripts is the `.rds` file. Ensure you maintain a consistent naming convention for these intermediate files to track pipeline progress.
*   **Memory Management**: For large datasets, use the `-b` (block size) parameter in `seurat-scale-data.R` to prevent memory overflow during scaling.
*   **Integration**: When performing multi-sample integration, use `seurat-find-transfer-anchors.R` to project references onto queries or find integration anchors between datasets.
*   **Assay Specification**: If working with multi-modal data (e.g., CITE-seq), always specify the assay using the `-a` flag in normalization and scaling steps to ensure you are operating on the correct data slot (RNA vs. ADT).

## Reference documentation
- [Seurat-scripts GitHub Repository](./references/github_com_ebi-gene-expression-group_r-seurat-scripts.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_seurat-scripts_overview.md)