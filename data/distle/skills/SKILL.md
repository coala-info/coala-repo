---
name: distle
description: `distle` is a high-performance utility written in Rust designed for the rapid generation of distance matrices.
homepage: https://github.com/KHajji/distle
---

# distle

## Overview

`distle` is a high-performance utility written in Rust designed for the rapid generation of distance matrices. It is optimized for large-scale genomic datasets, specifically targeting pathogen comparisons. The tool supports multiple input types, including nucleotide alignments and core genome multi-locus sequence typing (cgMLST) data, and can output results in formats compatible with common phylogenetic software.

## Installation

Install `distle` via Bioconda:

```bash
conda install bioconda::distle
```

## Common CLI Patterns

### Basic Distance Calculation
For a standard nucleotide alignment in FASTA format:
```bash
distle input_alignment.fasta output_distances.tsv
```

### Working with cgMLST Data
When using allele tables (e.g., from chewBBACA), specify the input format and handle headers if necessary:
```bash
distle --input-format cgmlst --skip-header input_cgmlst.tsv output_distances.tsv
```

### Generating Phylip Matrices
To create a matrix compatible with PHYLIP-based phylogenetic tools:
```bash
distle --output-format phylip input.fasta output.phy
```

## Expert Tips and Best Practices

### Optimizing for Large Datasets
*   **Distance Thresholding**: Use `-d` or `--maxdist` to stop calculations once a specific distance is reached. This significantly speeds up processing when you only care about closely related isolates.
*   **Memory Management**: `distle` is designed to be memory-efficient, but for extremely large FASTA files, ensure your environment has sufficient RAM as the alignment is loaded into memory.
*   **Threading**: By default, `distle` uses all available threads. Use `-t <THREADS>` to limit CPU usage if running on a shared HPC node.

### Incremental Updates
If you have already calculated distances for a subset of your data, use the `--precomputed-distances` flag. This allows `distle` to skip pairs that are already present in the provided tabular file, saving significant computation time when adding new sequences to an existing project.

### Input Format Variations
*   **fasta**: Standard nucleotide comparison (ACTG).
*   **fasta-all**: Counts every difference between sequences, including non-canonical bases.
*   **cgmlst-hash**: Use this if your cgMLST table contains SHA1 hashes of alleles rather than simple allele numbers.

### Output Control
By default, `distle` outputs the `lower-triangle` of the matrix to save space, as distance matrices are symmetric. If your downstream tool requires a full square matrix, use:
```bash
distle --output-mode full input.fasta output.tsv
```

## Reference documentation
- [distle GitHub Repository](./references/github_com_KHajji_distle.md)
- [distle Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_distle_overview.md)