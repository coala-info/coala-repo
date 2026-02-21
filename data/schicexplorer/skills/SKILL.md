---
name: schicexplorer
description: scHiCExplorer is a specialized suite of tools designed to handle the unique computational challenges of single-cell Hi-C data, particularly its extreme sparsity.
homepage: https://github.com/joachimwolff/scHiCExplorer
---

# schicexplorer

## Overview

scHiCExplorer is a specialized suite of tools designed to handle the unique computational challenges of single-cell Hi-C data, particularly its extreme sparsity. It provides a complete pipeline from raw data processing to biological interpretation. The toolset utilizes the `.scool` format—a multi-resolution HDF5-based format that stores interaction matrices for many cells in a single file—and the `.mcool` format for multi-resolution data. Use this skill to guide the execution of command-line operations for cell clustering, matrix normalization, and comparative analysis of single-cell chromatin architecture.

## Core CLI Workflows

### 1. Data Preparation and Demultiplexing
The first step usually involves assigning raw reads to individual cells based on barcodes.
- **scHicDemultiplex**: Separates fastq files into cell-specific files.
  - *Tip*: Ensure you have a clear mapping of forward and reverse barcodes.
- **scHicConvert**: Converts various interaction formats into the standard `.scool` format.

### 2. Matrix Manipulation and Correction
Single-cell matrices are often too sparse for direct analysis and require binning or normalization.
- **scHicMergeMatrixBins**: Merges bins to increase the signal-to-noise ratio at the cost of resolution.
- **scHicCorrectMatrices**: Applies normalization (like KR or ICE) to individual cell matrices within a `.scool` file to account for biases.
- **scHicNormalize**: Adjusts matrices to a specific value (e.g., total number of reads) to make cells comparable.

### 3. Clustering and Analysis
Identifying cell types or states based on chromatin folding.
- **scHicCluster**: The primary tool for grouping cells.
  - **MinHash**: Use the MinHash algorithm for approximate k-nearest neighbor graphs. This is significantly faster and more memory-efficient for large, sparse scHiC datasets than exact methods.
- **scHicCorrelate**: Computes the correlation between cell matrices to assess similarity.
- **scHicConsensusMatrices**: Creates an aggregate "consensus" matrix for a cluster of cells to improve visualization and downstream analysis.

### 4. Visualization
- **scHicPlotCluster**: Generates scatter plots (UMAP or t-SNE) showing the relationship between cells based on their interaction profiles.
- **scHicPlotConsensusMatrices**: Visualizes the interaction heatmaps of aggregated cell clusters.

## Expert Tips and Best Practices

- **Memory Management**: When working with thousands of cells, use the `MinHash` option in `scHicCluster` to avoid memory exhaustion.
- **Sparsity Handling**: Avoid high-resolution analysis (e.g., 10kb) on raw single-cell matrices unless you have extremely high sequencing depth per cell. Start with 100kb or 500kb bins to identify clusters.
- **File Formats**: Always prefer `.scool` for storage. It is the native format for the suite and allows for efficient parallel access to cell-level data.
- **Troubleshooting**: If you encounter `TypeError: unhashable type: 'csr_matrix'`, ensure your input `.scool` file is not corrupted and that all cells share the same bin size and chromosome layout.
- **Deprecation Note**: In newer Python environments, be aware that `np.float` is deprecated; if scripts fail, they may need patching to use `float` or `np.float64`.

## Reference documentation
- [scHiCExplorer GitHub Repository](./references/github_com_joachimwolff_scHiCExplorer.md)
- [scHiCExplorer Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_schicexplorer_overview.md)
- [scHiCExplorer Known Issues](./references/github_com_joachimwolff_scHiCExplorer_issues.md)