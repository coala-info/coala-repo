---
name: cgmlst-dists
description: cgmlst-dists converts allele call tables into distance matrices by calculating Hamming distances while accounting for missing data. Use when user asks to transform allele tables into distance matrices, calculate genetic distances for cgMLST data, or generate formatted distance outputs like CSV or lower triangle matrices.
homepage: https://github.com/tseemann/cgmlst-dists
metadata:
  docker_image: "quay.io/biocontainers/cgmlst-dists:0.4.0--h7b50bb2_5"
---

# cgmlst-dists

## Overview
The `cgmlst-dists` tool is a high-performance C utility designed to transform allele call tables into distance matrices. It is specifically optimized for core genome Multi-Locus Sequence Typing (cgMLST) data. The tool calculates the Hamming distance between samples while intelligently handling non-numeric allele calls (like "INF-x", "LNF", or "PLOT") by treating them as missing data (zeroes) and excluding them from the distance calculation.

## Usage Patterns

### Basic Distance Calculation
To generate a full distance matrix from a standard tab-separated allele table:
```bash
cgmlst-dists input_alleles.tab > distances.tsv
```

### Optimizing for Large Datasets
When comparing highly divergent samples where you only care about close relatives (e.g., outbreak detection), use the short-circuit option to significantly speed up processing:
```bash
# Stop calculating once distance exceeds 10
cgmlst-dists -x 10 input_alleles.tab > distances.tsv
```

### Output Formatting
By default, the tool produces a full symmetric matrix in tab-separated format. You can modify this behavior for compatibility with different downstream tools:
```bash
# Output as CSV instead of TSV
cgmlst-dists -c input_alleles.tab > distances.csv

# Output only the lower triangle (useful for reducing file size)
cgmlst-dists -m 1 input_alleles.tab > lower_tri_distances.tsv
```

## Expert Tips
- **Allele Call Cleaning**: The tool automatically handles "weird" strings. It replaces alphabet characters and specific strings like `PLOT3` and `PLOT5` with spaces, then converts the remaining values to integers. Any negative signs are ignored.
- **Missing Data**: The distance calculated is the Hamming distance, but zeroes (representing missing or invalid calls) are excluded from the comparison. This ensures that missing data doesn't artificially inflate or deflate the distance between samples.
- **Performance**: For very large matrices, use the `-q` (quiet) mode to suppress progress information, which can slightly reduce overhead in automated pipelines.

## Reference documentation
- [github_com_tseemann_cgmlst-dists.md](./references/github_com_tseemann_cgmlst-dists.md)
- [anaconda_org_channels_bioconda_packages_cgmlst-dists_overview.md](./references/anaconda_org_channels_bioconda_packages_cgmlst-dists_overview.md)