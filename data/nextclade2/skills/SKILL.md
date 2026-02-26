---
name: nextclade2
description: "Performs viral genome alignment, mutation calling, clade assignment, and quality checks. Use when user asks to analyze viral genomic sequences for evolutionary and epidemiological studies, identify lineages, track mutations, or assess sequence quality."
homepage: https://github.com/nextstrain/nextclade
---


# nextclade2

Performs viral genome alignment, mutation calling, clade assignment, quality checks, and phylogenetic placement.
  Use when Claude needs to analyze viral genomic sequences for evolutionary and epidemiological studies.
  This skill is particularly useful for identifying SARS-CoV-2 lineages, tracking mutations, and assessing sequence quality.
---
## Overview

Nextclade2 is a powerful command-line tool designed for the rapid and accurate analysis of viral genomic sequences. It automates key steps in viral genomics, including aligning sequences to a reference genome, identifying mutations, assigning sequences to specific clades (lineages), and performing quality control checks. This tool is essential for researchers and public health professionals studying viral evolution, outbreaks, and the emergence of new variants.

## Usage Instructions

Nextclade2 is primarily used via its command-line interface. The core functionality involves providing input sequences and a reference dataset.

### Basic Usage

The most common way to use Nextclade2 is to provide a FASTA file containing your viral sequences and specify an output directory.

```bash
nextclade run --input-sequences input.fasta --output-dir results/
```

This command will:
1. Align your sequences to the default reference dataset.
2. Call mutations.
3. Assign clades.
4. Perform quality checks.
5. Generate various output files in the `results/` directory, including a CSV file with detailed results and a FASTA file of the aligned sequences.

### Specifying a Reference Dataset

For more specific analyses, you can provide a custom reference dataset or select from available datasets.

```bash
# Use a specific reference dataset (e.g., for SARS-CoV-2)
nextclade run --input-sequences input.fasta --reference-dataset sars-cov-2 --output-dir results/

# Use a custom reference dataset from a local directory
nextclade run --input-sequences input.fasta --reference-dataset /path/to/custom/dataset --output-dir results/
```

### Output Options

Nextclade2 offers several options to customize the output.

*   **Outputting only specific columns**: Use `--output-column-selection` to specify which columns from the main results table to include.

    ```bash
    nextclade run --input-sequences input.fasta --output-dir results/ --output-column-selection clade,clade_membership,pango_lineage,qc.overall.status
    ```

*   **Outputting aligned sequences in different formats**: Use `--output-format` to specify the format for aligned sequences (e.g., `fasta`, `genbank`).

    ```bash
    nextclade run --input-sequences input.fasta --output-dir results/ --output-format fasta
    ```

### Advanced Features and Tips

*   **Controlling QC thresholds**: You can adjust the thresholds for quality control metrics using `--qc-thresholds`. Refer to the Nextclade documentation for a full list of available QC parameters and their meanings.

    ```bash
    nextclade run --input-sequences input.fasta --output-dir results/ --qc-thresholds.missingGenomes.warn=0.1
    ```

*   **Using a specific reference sequence**: If you need to align against a particular reference sequence rather than a full dataset, you can use the `--reference-sequence` option.

    ```bash
    nextclade run --input-sequences input.fasta --reference-sequence reference.fasta --output-dir results/
    ```

*   **Parallel processing**: Nextclade2 automatically utilizes multiple CPU cores for faster processing. You can control the number of threads using the `--jobs` option.

    ```bash
    nextclade run --input-sequences input.fasta --output-dir results/ --jobs 4
    ```

*   **Troubleshooting**: If you encounter errors, check the output logs carefully. Common issues include incorrect FASTA formatting, incompatible reference datasets, or insufficient system resources. The `--verbose` flag can provide more detailed logging information.

    ```bash
    nextclade run --input-sequences input.fasta --output-dir results/ --verbose
    ```

## Reference documentation
- [GitHub - nextstrain/nextclade](https://github.com/nextstrain/nextclade.md)