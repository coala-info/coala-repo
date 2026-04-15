---
name: scelestial
description: Scelestial reconstructs phylogenetic trees from single-cell sequencing data by approximating Steiner Trees. Use when user asks to infer cell lineages, reconstruct phylogenetic trees from single-cell data, or impute missing genotypes.
homepage: https://github.com/hzi-bifo/scelestial-paper-materials-devel
metadata:
  docker_image: "quay.io/biocontainers/scelestial:1.2--h9948957_4"
---

# scelestial

## Overview
Scelestial is a specialized tool for reconstructing phylogenetic trees from single-cell data. It generalizes the neighbor-joining method by considering k-subsets of samples (merging more than two samples at once) to approximate the Steiner Tree problem. This approach is particularly effective for handling the noise and missing values common in single-cell sequencing. Use this skill when you need to infer cell lineages, impute missing genotypes in a phylogenetic context, or define specific root samples for a cell hierarchy.

## CLI Usage and Patterns

### Basic Execution
Scelestial operates primarily through standard input and output.
```bash
scelestial < input_matrix.txt > output_tree.txt
```

### Common Command Options
- `-min-k <int>`: Sets the minimum number of samples to consider for merging (Default: 3).
- `-max-k <int>`: Sets the maximum number of samples to consider for merging (Default: 4). Increasing this can improve accuracy but significantly increases computational time.
- `-no-internal-sample`: Forces all input samples to be leaf nodes. By default, Scelestial may place samples at internal nodes if they represent an ancestral state.
- `-root <index>`: Re-roots the inferred tree at the specified zero-based sample index (column index from the input).
- `-include-root <genotype>`: Adds a synthetic root where all sites are set to the provided genotype (e.g., `A/A`).

## Data Formats

### Input Matrix
The input must be a tab-separated matrix where rows are loci and columns are cells/samples.
- **First Column**: Locus name.
- **Subsequent Columns**: Genotypes in a 10-state representation.
- **Valid Genotypes**: `A/A`, `T/T`, `C/C`, `G/G`, `A/T`, `A/C`, `A/G`, `T/C`, `T/G`, `C/G`.
- **Missing Data**: Represented as `./.`.

### Output Structure
1. **Node Count**: The first line indicates the total number of nodes in the tree.
2. **Node Descriptions**: One line per node containing:
   - Node ID
   - Input Flag (1 if it's an original sample, 0 if it's an inferred Steiner node)
   - Original Sequence
   - Imputed Sequence (using single-letter codes like 'N' for C/G, 'X' for missing, etc.)
3. **Edge List**: Lines containing `u v w` representing an edge between node `u` and `v` with weight (distance) `w`.

## Expert Tips
- **Imputation**: Scelestial automatically performs genotype imputation. If your primary goal is to fill in missing `./.` values based on the tree structure, look at the 4th column of the node description section in the output.
- **Rooting**: If you have a known "normal" or "germline" cell, use its column index with the `-root` flag to ensure the evolutionary direction is biologically meaningful.
- **Memory Management**: For very large datasets, keep `max-k` at 4. Increasing it to 5 or higher provides better Steiner tree approximations but the combinatorial complexity grows rapidly.

## Reference documentation
- [github_com_hzi-bifo_scelestial-paper-materials-devel.md](./references/github_com_hzi-bifo_scelestial-paper-materials-devel.md)
- [anaconda_org_channels_bioconda_packages_scelestial_overview.md](./references/anaconda_org_channels_bioconda_packages_scelestial_overview.md)