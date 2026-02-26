---
name: psdm
description: psdm computes pairwise SNP distance matrices from one or two FASTA alignment files. Use when user asks to calculate SNP distances, generate distance matrices, compare sequences between two different alignments, or format distance data into long-form or tab-delimited outputs.
homepage: https://github.com/mbhall88/psdm
---


# psdm

## Overview
psdm is a high-performance utility designed to compute pairwise SNP distance matrices from one or two FASTA alignment files. While it functions as a standard distance matrix generator for single alignments, its primary strength lies in its ability to perform "inter-alignment" comparisons. This allows researchers to update existing datasets with new samples efficiently or validate consistency between different sequencing platforms. The tool is written in Rust, supports multi-threading, and handles compressed input files natively.

## Common CLI Patterns

### Basic Matrix Generation
Generate a standard comma-separated (CSV) distance matrix from a single alignment:
```bash
psdm alignment.fa
```

### Incremental Updates and Comparisons
To compare sequences in one file against sequences in another (without calculating distances within the same file), provide two arguments. The first file defines the columns and the second defines the rows:
```bash
psdm existing_samples.fa new_samples.fa.gz -o updated_distances.csv
```

### Output Formatting
By default, psdm outputs a square (or rectangular) matrix. Use these flags to change the structure or delimiter:
- **Long-form (Melted):** Useful for downstream tidyverse/pandas analysis.
  ```bash
  psdm -l alignment.fa
  ```
- **TSV Format:** Change the delimiter to a tab.
  ```bash
  psdm -d "\t" alignment.fa
  ```

### Performance Optimization
For large alignments (e.g., whole-genome bacterial alignments), utilize all available CPU cores and monitor progress:
```bash
psdm -t 0 -P large_alignment.fa
```

## Expert Tips and Best Practices

### Handling Ambiguous Bases and Gaps
By default, psdm ignores `N` and `-` (gaps), meaning `dist(A, N) = 0`. 
- **Custom Ignored Characters:** If your alignment uses `X` for masked regions, include it:
  ```bash
  psdm -e "NX-" alignment.fa
  ```
- **Strict Comparison:** To treat every character difference as a distance (including gaps/N), use an empty string:
  ```bash
  psdm -e "" alignment.fa
  ```

### Case Sensitivity
By default, psdm is case-insensitive (`a` and `A` are treated as the same). If your pipeline uses case to distinguish between high-quality and low-quality calls and you want this reflected in the distance:
```bash
psdm -c alignment.fa
```
*Note: If using `-c`, ensure your `-e` ignored characters also include both cases (e.g., `-e "Nn-"`).*

### Sorting for Consistency
If you need the matrix rows and columns to be in a predictable order regardless of the input FASTA order, use the sort flag:
```bash
psdm -s alignment.fa
```

### Compressed Inputs
psdm automatically detects and handles Gzip-compressed files (`.gz`). There is no need to decompress files before running the tool, which saves disk space and I/O time.

## Reference documentation
- [psdm GitHub Repository](./references/github_com_mbhall88_psdm.md)
- [psdm Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_psdm_overview.md)