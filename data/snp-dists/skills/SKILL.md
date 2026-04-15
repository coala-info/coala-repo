---
name: snp-dists
description: snp-dists transforms multiple sequence alignments into pairwise SNP distance matrices. Use when user asks to calculate pairwise SNP distances, generate a distance matrix from FASTA alignments, or compare genomic isolates for relatedness.
homepage: https://github.com/tseemann/snp-dists
metadata:
  docker_image: "quay.io/biocontainers/snp-dists:1.2.0--h577a1d6_0"
---

# snp-dists

## Overview
`snp-dists` is a high-performance tool written in C that transforms multiple sequence alignments (FASTA format) into pairwise SNP distance matrices. It is a staple in bioinformatics for comparing bacterial or viral genomes to identify closely related isolates. By default, it focuses on standard nucleotides (A, G, T, C) and provides various output formats suitable for downstream analysis in R, Python, or spreadsheet software.

## Usage Patterns

### Basic Distance Matrix
Generate a tab-separated (TSV) matrix from an alignment:
```bash
snp-dists alignment.aln > matrix.tsv
```

### Optimized for Large Datasets
For large alignments, use multi-threading and short-circuiting to save time:
```bash
# Use 8 threads and stop counting after 100 SNPs
snp-dists -j 8 -x 100 alignment.aln > matrix.tsv
```

### Output Formats
*   **CSV Format**: Use `-c` for comma-separated values.
*   **Molten (Long) Format**: Use `-m` for a three-column list (Sample1, Sample2, Distance).
*   **Molten with Headers**: Combine `-m` and `-t` for labeled columns.
*   **Lower Triangle**: Use `-L` to output only the lower triangle of the matrix, which is useful for reducing file size in large pairwise comparisons.

### Handling Ambiguities and Case
*   **Count All Differences**: By default, `snp-dists` ignores gaps and ambiguous bases. Use `-a` to count every difference including gaps and Ns.
*   **Case Sensitivity**: Use `-k` to preserve the case of the input sequences if lower-case characters represent masked regions that should not be compared.

## Expert Tips
*   **Short-circuiting (`-x`)**: This is highly effective for transmission cluster analysis. If you only care about isolates within a 15-SNP threshold, setting `-x 15` significantly reduces computation time on large alignments.
*   **Tool Identification**: Use `-b` to remove the tool name and version from the top-left cell of the matrix, making it easier to parse directly into data frames (e.g., `pandas.read_csv` or `read.table`).
*   **Gzipped Inputs**: The tool natively supports `.fasta.gz` files, so there is no need to decompress alignments before processing.

## Reference documentation
- [snp-dists GitHub Repository](./references/github_com_tseemann_snp-dists.md)
- [snp-dists Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_snp-dists_overview.md)