---
name: tadtool
description: TADtool identifies and visualizes Topologically Associating Domains from Hi-C contact matrices using interactive parameter exploration and automated calling algorithms. Use when user asks to call TADs, visualize Hi-C data alongside domain boundaries, explore optimal window size parameters, or subset large contact matrices.
homepage: https://github.com/vaquerizaslab/tadtool
---

# tadtool

## Overview
TADtool is a specialized bioinformatics utility designed to bridge the gap between raw Hi-C contact matrices and the identification of structural genomic domains. It addresses the challenge of parameter selection in TAD-calling algorithms by providing an interactive environment to visualize how different window sizes and thresholds affect domain boundaries. Use this skill when you need to process Hi-C data in square, sparse, or `.npy` formats to define chromosomal architectures.

## Core Workflows

### 1. Interactive Parameter Exploration
Use the `plot` command to visualize Hi-C data alongside TAD-calling indices. This is the recommended first step to determine the optimal window size for your specific dataset.

```bash
tadtool plot <matrix_file> <regions_bed> <region_string>
```
- **Matrix File**: Supports square tab-delimited text, sparse (row col val), or numpy `.npy`.
- **Regions BED**: A headerless BED file where rows match the matrix dimensions.
- **Region String**: Format as `chr:start-end` (e.g., `chr12:31000000-33000000`).

### 2. Automated TAD Calling
Once parameters are identified, use the `tads` command for non-interactive, high-throughput processing of full matrices.

- **Insulation Index (Default)**: Best for identifying boundaries based on local contact depletion.
- **Directionality Index**: Best for identifying domains based on upstream/downstream bias.
- **Normalized Insulation**: Use `-a ninsulation` to normalize against chromosomal averages.

### 3. Data Preparation and Subsetting
For very large matrices, use the `subset` command to create smaller, more manageable files for initial parameter testing.

## CLI Reference and Best Practices

### Common Command Patterns
- **Define Custom Window Sizes**: Use `-w` to pass specific sizes or a range (start stop step).
  ```bash
  tadtool plot matrix.txt regions.bed chr1:1-1000000 -w 10000 100000 10000
  ```
- **Change Algorithm**: Use `-a directionality` to switch from the default insulation index.
- **Sparse Matrix Handling**: Ensure your BED file has a fourth column if using sparse notation; this column acts as the identifier for the row/column indices.

### Expert Tips
- **Memory Management**: For high-resolution data, work with intra-chromosomal matrices. Loading a full-genome matrix at high resolution may lead to significant performance degradation.
- **Precomputed Data**: If you have already calculated indices, use the `-d` flag in the `plot` command to load them directly and skip the internal calculation step.
- **Coordinate Systems**: Remember that the BED format used for regions is 0-indexed and end-exclusive, while the plotting region string is typically 1-indexed and inclusive.



## Subcommands

| Command | Description |
|---------|-------------|
| tadtool plot | Main interactive TADtool plotting window |
| tadtool tads | Call TADs with pre-defined parameters |
| tadtool_subset | Reduce a matrix to a smaller region. |

## Reference documentation
- [TADtool GitHub README](./references/github_com_vaquerizaslab_tadtool_blob_master_README.md)
- [TADtool Repository Overview](./references/github_com_vaquerizaslab_tadtool.md)