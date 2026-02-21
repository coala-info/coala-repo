---
name: pairsnp
description: pairsnp is a specialized tool for rapidly generating pairwise SNP distance matrices from genomic alignments.
homepage: https://github.com/gtonkinhill/pairsnp
---

# pairsnp

## Overview
pairsnp is a specialized tool for rapidly generating pairwise SNP distance matrices from genomic alignments. Unlike traditional methods that compare every site sequentially, pairsnp utilizes sparse matrix libraries to achieve significant speedups—often an order of magnitude faster for large alignments. It is available as a command-line utility (C++ and Python) and as an R package, supporting both dense and sparse output formats to accommodate various downstream phylogenetic and clustering workflows.

## Command Line Usage

### Basic Distance Calculation
To generate a standard distance matrix from a FASTA alignment:
```bash
# Using the C++ version (standard output)
pairsnp input.fasta > matrix.csv

# Using the Python version
pairsnp -f input.fasta -o matrix.csv
```

### Handling Large Datasets
For very large alignments, use the C++ implementation and leverage multi-threading and sparse output to manage memory and file size.

*   **Multi-threading**: Use the `-t` flag to specify the number of threads.
*   **Sparse Output**: Use `-s` to output only non-zero distances in a coordinate format (i, j, distance).
*   **Distance Thresholding**: Use `-d` to only report distances below a certain threshold.

```bash
# Calculate distances using 8 threads, returning only distances <= 10 in sparse format
pairsnp -t 8 -s -d 10 input.fasta > sparse_matrix.csv
```

### Common Options and Flags
*   **Output Format**: By default, the tool often produces TSV. Use `-c` to force CSV output.
*   **Gaps and Ns**: By default, differences to 'N' or gaps are not counted. Use `-n` to include these in the distance calculation.
*   **Similarity vs Distance**: In the Python version, you can switch the metric using `-t sim` for similarity or `-t dist` for distance.
*   **Nearest Neighbors**: Use `-k` (C++ version) to return only the k-nearest neighbors for each sample in a sparse output.

## Expert Tips
*   **Performance**: If you are dealing with thousands of sequences (e.g., >3,000), prioritize the C++ version over the R or Python implementations for a significant performance boost.
*   **Input Compression**: The tool supports gzipped FASTA files. Use the `-z` flag in the Python version or simply pass the `.gz` file to the C++ version.
*   **Sparse Matrix Benefits**: When working with closely related bacterial isolates, the distance matrix is often mostly zeros. Using the `-s` flag drastically reduces the output file size, making it easier to load into memory for downstream analysis in R or Python.

## Reference documentation
- [pairsnp Overview](./references/anaconda_org_channels_bioconda_packages_pairsnp_overview.md)
- [pairsnp README](./references/github_com_gtonkinhill_pairsnp_blob_master_README.md)