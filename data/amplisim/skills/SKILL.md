---
name: amplisim
description: "amplisim simulates synthetic amplicon sequences from a reference genome and a primer scheme. Use when user asks to generate synthetic FASTA data, simulate amplicon-based sequencing assays, or model PCR dropout and replication depth."
homepage: https://github.com/rki-mf1/amplisim
---


# amplisim

## Overview
`amplisim` is a specialized C++ tool designed for the rapid simulation of amplicon sequences. By providing a reference genome and a defined primer scheme, users can generate synthetic FASTA data that mimics the output of an amplicon-based sequencing assay. The tool is lightweight, POSIX-compliant, and allows for the adjustment of replication depth and stochastic dropout rates to model real-world laboratory variability.

## Installation
The most reliable way to install `amplisim` on Linux systems is via the Bioconda channel:

```bash
conda install -c bioconda amplisim
```

For macOS or custom builds, ensure system dependencies for `lzma`, `libbz2`, and `libcurl` are present to support the underlying `htslib` compilation.

## Command Line Usage
The basic syntax requires a reference file in FASTA format and a primer file in BED format.

### Basic Execution
By default, `amplisim` streams results to standard output:
```bash
amplisim reference.fasta primers.bed > simulated_amplicons.fasta
```

### Controlling Simulation Parameters
To create more realistic datasets, use the following flags to control replication and error:

*   **Replication Depth**: Set the mean and standard deviation of replicates per amplicon.
    ```bash
    amplisim -m 100 -n 20 reference.fasta primers.bed -o output.fasta
    ```
*   **Amplicon Dropout**: Simulate PCR failure by setting a likelihood (between 0 and 1) that an amplicon will be skipped.
    ```bash
    # 5% chance of dropout per amplicon
    amplisim -x 0.05 reference.fasta primers.bed -o output.fasta
    ```
*   **Reproducibility**: Use a specific seed for the random number generator.
    ```bash
    amplisim -s 42 reference.fasta primers.bed -o output.fasta
    ```

## Input Specifications
`amplisim` has specific requirements for its input files that differ slightly from standard bioinformatics tools:

### Primer BED Format
The BED file must be a plain tab-separated text file following these rules:
1.  **Column 1**: Chromosome/Contig identifier.
2.  **Column 2 & 3**: Start and end indices (Start < End).
3.  **Consecutive Pairs**: Forward and reverse primers for a single amplicon **must** occupy consecutive lines.
4.  **Block Arrangement**: All primers for a specific chromosome must be grouped together consecutively in the file.
5.  **No Alternatives**: The tool currently does not support alternative primers within a pair; each pair must be unique.

### Reference FASTA
The reference file should be a standard FASTA. Ensure that the chromosome identifiers in the FASTA exactly match the first column of the primer BED file.

## Output Format
The output is a FASTA file where headers follow a specific indexing convention:
`>amplicon_<amplicon_index>_<replicate_index>`
*   `amplicon_index`: The 0-based index of the primer pair defined in the BED file.
*   `replicate_index`: A unique identifier for each generated replicate across the entire simulation.

## Expert Tips
*   **Piping**: Since `amplisim` defaults to stdout, it is highly efficient for use in bash pipes, allowing you to pass simulated reads directly into aligners or quality control tools without writing large intermediate files.
*   **Validation**: If the tool throws an `std::out_of_range` error, verify that your primer coordinates in the BED file do not exceed the actual length of the sequences in your FASTA reference.
*   **Data Cleaning**: When using public primer schemes (like ARTIC), ensure the BED file is strictly tab-separated. Use `sed` or `awk` to convert multi-whitespace delimiters to tabs if the tool fails to parse the primer blocks correctly.

## Reference documentation
- [amplisim Main Documentation](./references/github_com_rki-mf1_amplisim.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_amplisim_overview.md)