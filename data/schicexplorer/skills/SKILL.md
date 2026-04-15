---
name: schicexplorer
description: scHiCExplorer is a comprehensive suite of tools for processing, normalizing, and analyzing single-cell Hi-C data using the scool format. Use when user asks to demultiplex raw reads, manage scool matrices, perform quality control, normalize contact frequencies, cluster cells based on chromatin structure, or visualize cluster-specific profiles.
homepage: https://github.com/joachimwolff/scHiCExplorer
metadata:
  docker_image: "quay.io/biocontainers/schicexplorer:7--py_0"
---

# schicexplorer

## Overview

The scHiCExplorer is a specialized suite of tools designed to handle the unique challenges of single-cell Hi-C data, which is typically characterized by high sparsity. It provides a complete pipeline from raw fastq demultiplexing to the identification of cell-specific chromatin structures. The toolset centers around the `.scool` format—a single-cell extension of the 4DN-standard `.cool` format—allowing for efficient storage and manipulation of thousands of individual cell matrices within a single file.

## Core Workflows and CLI Patterns

### 1. Data Preparation and Demultiplexing
If starting from raw reads, use `scHicDemultiplex` to assign reads to individual cells based on barcodes.

```bash
scHicDemultiplex --fastq R1.fastq.gz R2.fastq.gz --barcodes barcodes.txt --outputFolder demultiplexed/
```

### 2. Matrix Management
Convert individual cell matrices into a unified `.scool` file for streamlined analysis.

```bash
# Merge individual cool files into one scool file
scHicMergeToSCool --matrices cell1.cool cell2.cool cell3.cool --outFileName experiment.scool
```

### 3. Quality Control
Assess the library complexity and contact distributions across all cells in a dataset.

```bash
scHicQualityControl --matrices experiment.scool --outFileName qc_report.pdf --binsize 100000
```

### 4. Normalization and Correction
Address biases in contact frequencies. Note that for single-cell data, normalization often involves scaling to a target number of contacts.

```bash
scHicNormalize --matrices experiment.scool --method total_contacts --targetValue 100000 --outFileName normalized.scool
```

### 5. Clustering and Dimensionality Reduction
This is a critical step for identifying cell types or states based on 3D genome organization.

*   **Standard Clustering**: Uses k-nearest neighbor graphs.
*   **MinHash**: Efficient for very large datasets.
*   **SVL (Short vs Long)**: Clusters based on the ratio of short-range vs long-range contacts.

```bash
# Cluster cells into 5 groups
scHicCluster --matrices experiment.scool --numberOfClusters 5 --outFileName clusters.txt --method spectral
```

### 6. Visualization
Generate cluster-specific profiles or consensus matrices to see the "average" architecture of a cell population.

```bash
scHicPlotClusterProfiles --matrices experiment.scool --clusters clusters.txt --outFileName profiles.png
```

## Expert Tips

*   **Sparsity Handling**: When clustering, if the data is extremely sparse, prefer `scHicClusterMinHash` or increase the bin size using `scHicMergeMatrixBins` to aggregate signal.
*   **Memory Efficiency**: Use the `.scool` format whenever possible. It is significantly more performant than handling thousands of individual `.cool` or `.mcool` files.
*   **Bulk Comparison**: Use `scHicCreateBulkMatrix` to aggregate all cells (or a specific cluster) into a single bulk-like Hi-C matrix for comparison with standard Hi-C datasets.
*   **Resolution Selection**: For single-cell analysis, 100kb to 500kb resolutions are standard. Attempting 10kb or 5kb often results in matrices too sparse for meaningful clustering without massive cell numbers.



## Subcommands

| Command | Description |
|---------|-------------|
| scHicCluster | Uses kmeans or spectral clustering to associate each cell to a cluster and therefore to its cell cycle. The clustering can be run on the raw data, on a kNN computed via the exact euclidean distance or via PCA. Please consider also the other clustering and dimension reduction approaches of the scHicExplorer suite. They can give you better results, can be faster or less memory demanding. |
| scHicConsensusMatrices | scHicConsensusMatrices creates based on the clustered samples one consensus matrix for each cluster. The consensus matrices are normalized to an equal read coverage level and are stored all in one scool matrix. |
| scHicMergeMatrixBins | Merges bins from a Hi-C matrix. For example, using a matrix containing 5kb bins, a matrix of 50kb bins can be derived using --numBins 10. |
| scHicPlotConsensusMatrices | Plot consensus matrices from scool files. |
| schicexplorer_scHicCorrectMatrices | Correct each matrix of the given scool matrix with KR correction. |
| schicexplorer_scHicCorrelate | Computes pairwise correlations between Hi-C matrices data. The correlation is computed taking the values from each pair of matrices and discarding values that are zero in both matrices.Parameters that strongly affect correlations are bin size of the Hi-C matrices and the considered range. The smaller the bin size of the matrices, the finer differences you score. The --range parameter should be selected at a meaningful genomic scale according to, for example, the mean size of the TADs in the organism you work with. |
| schicexplorer_scHicDemultiplex | scHicDemultiplex demultiplexes fastq files from Nagano 2017: "Cell-cycle dynamics of chromosomal organization at single-cell resolution" according their barcodes to a seperated forward and reverse strand fastq files per cell. |
| schicexplorer_scHicNormalize | Normalize scHi-C matrices. |

## Reference documentation
- [scHiCExplorer ReadTheDocs Overview](./references/schicexplorer_readthedocs_io_en_latest.md)
- [List of scHiCExplorer Tools](./references/schicexplorer_readthedocs_io_en_latest_content_list-of-tools.html.md)
- [scHicCluster Documentation](./references/schicexplorer_readthedocs_io_en_latest_content_tools_scHicCluster.html.md)
- [scHicDemultiplex Documentation](./references/schicexplorer_readthedocs_io_en_latest_content_tools_scHicDemultiplex.html.md)
- [scHicMergeToSCool Documentation](./references/schicexplorer_readthedocs_io_en_latest_content_tools_scHicMergeToSCool.html.md)