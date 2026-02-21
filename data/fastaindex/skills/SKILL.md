---
name: fastaindex
description: FastaIndex is a high-performance utility for managing FastA files.
homepage: https://github.com/lpryszcz/FastaIndex
---

# fastaindex

## Overview
FastaIndex is a high-performance utility for managing FastA files. It functions similarly to `samtools faidx` but extends the standard `.fai` index format with four additional columns representing the counts of A, C, G, and T bases for each sequence. This skill enables efficient sequence extraction, reverse complement retrieval, and rapid calculation of assembly statistics.

## Command Line Usage

### Sequence Retrieval
Extract specific regions using the standard `contig:start-end` format.
*   **Standard extraction**: `FastaIndex -i input.fa -r 'scaffold00001:100-200'`
*   **Reverse complement**: To retrieve the reverse complement of a region, specify the end coordinate before the start coordinate:
    `FastaIndex -i input.fa -r 'scaffold00001:200-100'`

### Assembly Statistics
FastaIndex provides built-in functions to analyze the quality and composition of genomic assemblies.
*   **General Statistics**: Use the `-S` or `--stats` flag to return a comprehensive summary of the FastA file.
    `FastaIndex -i input.fa -S`
*   **NXX and LXX Calculation**: Calculate specific metrics like N50 or L50 directly.
    `FastaIndex -i input.fa -N50`
    `FastaIndex -i input.fa -L50`

### Indexing
The tool automatically handles index creation. The resulting `.fai` file is compatible with other bioinformatics tools but contains extra metadata used by FastaIndex for composition analysis.

## Best Practices
*   **Output Redirection**: By default, the tool outputs to stdout. Use the `-o` flag or standard shell redirection to save sequences to a file.
*   **Batch Processing**: You can pass multiple FASTA files to the `-i` parameter for batch indexing or statistical analysis.
*   **Alternative Command**: The package also installs a standalone `fasta_stats` command which is equivalent to running `FastaIndex --stats`.

## Reference documentation
- [FastaIndex Main Documentation](./references/github_com_lpryszcz_FastaIndex.md)