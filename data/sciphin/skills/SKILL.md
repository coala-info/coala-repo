---
name: sciphin
description: SCIPhI performs joint mutation calling and phylogeny estimation from single-cell sequencing data using a Markov Chain Monte Carlo scheme. Use when user asks to call mutations in single cells, estimate tumor phylogenies, or process mpileup files to identify somatic variants while accounting for sequencing errors.
homepage: https://github.com/cbg-ethz/SCIPhI
---


# sciphin

## Overview

SCIPhI (Single-Cell mutation Identification via finite-sites Phylogenetic Inference) is a specialized tool for joint mutation calling and phylogeny estimation. By employing a Markov Chain Monte Carlo (MCMC) scheme, it robustly accounts for the high error rates and missingness inherent in single-cell sequencing. Instead of treating cells as independent samples, it uses the inferred tumor phylogeny to improve the reliability of mutation calls in individual cells.

## Installation

The most efficient way to install the tool is via Bioconda:

```bash
conda install bioconda::sciphin
```

## Input Requirements

SCIPhI requires two primary inputs:

1.  **Mpileup File**: Sequencing information must be in the standard `mpileup` format (generated via `samtools mpileup`).
    *   Ensure fastq files are aligned to a reference and post-processed (e.g., following GATK best practices) before generating the pileup.
    *   Note: SCIPhI ignores positions where the reference is 'N'.
2.  **Cell Names File**: A tab-delimited text file mapping cell names to their types.
    *   **Column 1**: Cell name (must match the order in the mpileup file).
    *   **Column 2**: Cell type identifier:
        *   `CT`: Tumor cell
        *   `CN`: Control normal cell (single-cell)
        *   `BN`: Control bulk normal

## Common CLI Patterns

### Basic Execution
To run a standard mutation calling and tree inference task:

```bash
sciphi -o <output_prefix> --in <cellNames.txt> --seed <integer> <input.mpileup>
```

### Streaming Input
For large datasets, SCIPhI supports streaming the mpileup file to save disk space and I/O overhead:

```bash
samtools mpileup -f reference.fa alignments.bam | sciphi -o result --in cellNames.txt -
```

## Expert Tips and Best Practices

*   **Reproducibility**: Always specify a `--seed` value. Because SCIPhI uses an MCMC scheme, results may vary between runs if the seed is not fixed.
*   **Control Samples**: Including bulk normal (`BN`) or single-cell normal (`CN`) samples is highly recommended to improve the precision of somatic mutation identification.
*   **Parameter Tuning**: Use `sciphi -h` to view all available options. If the default MCMC chain does not converge or if you need more permissive calling, adjust the sampling parameters.
*   **Output Analysis**: The tool generates a result file containing the joint mutation calls and the estimated phylogeny. Ensure the output prefix is directed to a directory with sufficient write permissions.

## Reference documentation
- [SCIPhI GitHub Repository](./references/github_com_cbg-ethz_SCIPhI.md)
- [Bioconda sciphin Overview](./references/anaconda_org_channels_bioconda_packages_sciphin_overview.md)