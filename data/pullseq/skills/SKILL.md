---
name: pullseq
description: pullseq extracts and filters sequences from FASTA or FASTQ files based on identifiers, regular expressions, or length constraints. Use when user asks to extract specific reads by ID, filter sequences by length or regex, exclude certain sequences, or identify differences between two sequence files.
homepage: https://github.com/bcthomas/pullseq
metadata:
  docker_image: "quay.io/biocontainers/pullseq:1.0.2--h1104d80_11"
---

# pullseq

## Overview

The `pullseq` suite provides high-performance C-based utilities for subsetting and comparing genomic sequence files. It is particularly effective for bioinformatics workflows where you need to extract specific reads from large datasets based on a list of identifiers, regular expression patterns, or sequence length constraints. The tool handles both FASTA and FASTQ formats and includes `seqdiff` for identifying unique or shared sequences between two files.

## Command Line Usage

### Sequence Extraction with pullseq

The primary command is `pullseq`. Note that it prints to **stdout**, so you must use redirection (`>`) to save results to a file.

*   **Extract by ID list**:
    `pullseq -i input.fasta -n names_to_extract.txt > output.fasta`
*   **Extract by Regex**:
    `pullseq -i input.fastq -g "NODE_1[0-9]+" > filtered.fastq`
*   **Filter by Length**:
    `pullseq -i input.fasta -m 500 -a 2000 > length_filtered.fasta`
    *(Extracts sequences between 500bp and 2000bp)*
*   **Exclude specific IDs**:
    `pullseq -i input.fasta -n unwanted_ids.txt -e > clean.fasta`
*   **Count matches without extracting**:
    `pullseq -i input.fasta -g "contig_" -t`

### Sequence Comparison with seqdiff

Use `seqdiff` to find overlaps or differences between two sequence files.

*   **Find common sequences**:
    `seqdiff -1 file1.fa -2 file2.fa -c common.fa`
*   **Find unique sequences**:
    `seqdiff -1 file1.fa -2 file2.fa -a unique_to_1.fa -b unique_to_2.fa`
*   **Compare by headers instead of sequence content**:
    `seqdiff -1 file1.fa -2 file2.fa -d -s`

## Expert Tips and Best Practices

*   **Redirection is Mandatory**: `pullseq` does not have an output file flag. Always append `> output.file` to your command to avoid flooding the terminal.
*   **Piping Identifiers**: You can pipe a list of names from other tools (like `grep` or `awk`) directly into `pullseq` using the `-N` flag:
    `cat ids.txt | pullseq -i input.fasta -N > output.fasta`
*   **Format Conversion**: Use the `-c` flag to toggle between FASTA and FASTQ. If converting FASTA to FASTQ, use `-q` to specify a default quality score (ASCII character).
*   **Regex Behavior**: Regular expression matching via `-g` is PERL-compatible and always case-insensitive.
*   **Line Wrapping**: By default, `pullseq` wraps sequence lines at 50 characters. Use `-l` to change this (e.g., `-l 0` for no wrapping/single-line sequences).
*   **Header Flexibility**: When using a names file (`-n`), `pullseq` allows the inclusion of the `>` or `@` symbols in the ID list, making it compatible with raw header lines.

## Reference documentation
- [pullseq README](./references/github_com_bcthomas_pullseq.md)