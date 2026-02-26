---
name: hcluster_sg
description: This tool performs hierarchical clustering on sparse graphs. Use when user asks to cluster nodes in a sparse graph.
homepage: https://anaconda.org/channels/bioconda/packages/hcluster_sg/overview
---


# hcluster_sg

yaml
name: hcluster_sg
description: Hierarchical clustering tool for sparse graphs. Use when Claude needs to perform hierarchical clustering on graph data, particularly when dealing with sparse matrices or graph structures where traditional dense matrix clustering might be inefficient. This tool is suitable for biological network analysis, social network analysis, or any domain requiring graph-based hierarchical clustering.
```

## Overview
hcluster_sg is a command-line tool designed for hierarchical clustering specifically on sparse graphs. It's particularly useful when you have large datasets with many nodes but relatively few connections between them, making dense matrix approaches computationally expensive or infeasible. This tool allows you to group similar nodes together based on their connectivity patterns within the graph structure.

## Usage Instructions

hcluster_sg operates by taking graph data as input and producing cluster assignments. The primary input is typically a sparse matrix representation of the graph.

### Basic Usage

The most common way to use `hcluster_sg` is to provide an input file containing the sparse graph representation and specify an output file for the clustering results.

```bash
hcluster_sg -i <input_sparse_matrix_file> -o <output_cluster_file>
```

### Input File Formats

`hcluster_sg` expects input in a sparse matrix format. Common formats include:

*   **Coordinate list (COO)**: A simple format where each line represents a non-zero entry in the matrix, typically `row_index col_index value`.
*   **Compressed Sparse Row (CSR)** or **Compressed Sparse Column (CSC)**: More efficient formats for matrix operations, often generated from COO.

Ensure your input file adheres to one of these formats. If your data is in a different format, you may need to convert it first using other tools or scripts.

### Output File Format

The output file will contain the hierarchical clustering results. The exact format may vary, but it typically includes:

*   **Linkage matrix**: Describes the merges performed at each step of the hierarchical clustering.
*   **Cluster assignments**: The final assignment of nodes to clusters at a specified level of the hierarchy.

### Key Options and Tips

*   **Distance Metrics**: While not explicitly detailed in the provided documentation, hierarchical clustering tools often support various distance metrics (e.g., Euclidean, Manhattan, Cosine). Consult the tool's full documentation or `--help` output for available options if you need to specify a particular metric.
*   **Linkage Methods**: Similarly, different linkage methods (e.g., 'ward', 'average', 'complete', 'single') can significantly impact clustering results. Look for options to specify the linkage method.
*   **Thresholding/Cut-off**: You might need to specify a threshold or a number of clusters to obtain a flat partition from the hierarchical structure.
*   **Large Datasets**: For very large sparse graphs, consider optimizing your input file format (e.g., CSR/CSC) and ensuring sufficient memory is available.
*   **Error Handling**: Always check the exit code of the `hcluster_sg` command. Non-zero exit codes indicate an error. Review the standard error output for specific error messages.

## Reference documentation
- [Overview of hcluster_sg on bioconda](./references/anaconda_org_channels_bioconda_packages_hcluster_sg_overview.md)