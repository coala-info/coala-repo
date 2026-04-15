---
name: ucsc-matrixclustercolumns
description: This tool reduces the dimensionality of a numerical matrix by clustering columns and averaging their values. Use when user asks to cluster columns in a matrix, reduce matrix dimensionality, or aggregate matrix columns by their mean.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-matrixclustercolumns:482--h0b57e2e_0"
---

# ucsc-matrixclustercolumns

## Overview
The `matrixClusterColumns` utility is a specialized tool from the UCSC Genome Browser "kent" source tree designed for matrix dimensionality reduction. It processes a numerical matrix where rows represent features and columns represent samples or conditions. By grouping related columns into clusters, it produces a new matrix with the same number of rows but significantly fewer columns. The values in the resulting columns are the arithmetic means of the original columns assigned to that cluster.

## Usage Instructions

### Basic Command Syntax
To view the specific usage statement and available options, run the binary without arguments:
```bash
matrixClusterColumns
```

### Common Workflow Pattern
The tool typically requires an input matrix and a mapping file that defines which columns belong to which clusters.

1.  **Input Matrix**: Usually a tab-separated file with a header row for column names and a leading column for row identifiers.
2.  **Cluster Specification**: A file or argument mapping original column names to their target cluster names.
3.  **Execution**:
    ```bash
    matrixClusterColumns input.matrix clusters.txt output.matrix
    ```

### Expert Tips
*   **Data Preparation**: Ensure your input matrix is strictly numerical (except for headers and row IDs). Missing values may affect the mean calculation depending on the version; pre-impute or filter if necessary.
*   **Mean Aggregation**: Since the tool combines columns by taking the mean, it is most effective on data that has already been normalized (e.g., TPM, FPKM, or log-transformed values) to ensure that high-magnitude columns do not disproportionately skew the cluster average.
*   **Permissions**: If you have just downloaded the binary from the UCSC server, remember to set executable permissions:
    ```bash
    chmod +x matrixClusterColumns
    ```
*   **Environment**: If using the Bioconda version, ensure your conda environment is active to have the tool in your PATH.

## Reference documentation
- [UCSC MatrixClusterColumns Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-matrixclustercolumns_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)