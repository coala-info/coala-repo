---
name: smof
description: The smof toolset provides UNIX-style utilities for manipulating FASTA files by treating each entry as a single logical unit. Use when user asks to summarize sequence statistics, filter entries by header or motif, extract subsequences, sort by length, or perform sequence transformations like translation and reverse complementation.
homepage: https://github.com/incertae-sedis/smof
---


# smof

## Overview
The `smof` (Simple Manipulation Of FASTA) toolset provides a collection of UNIX-style utilities specifically designed for biological sequences. While standard tools like `grep`, `head`, and `sort` operate on a per-line basis, `smof` treats each FASTA entry (header and sequence) as a single logical unit. This allows for precise manipulation of genomic and proteomic data without breaking the FASTA format structure.

## Core CLI Patterns

### Exploration and Statistics
*   **Summarize a file**: Use `sniff` to get a quick overview of the sequence types and counts.
    ```bash
    smof sniff sequences.fasta
    ```
*   **Calculate statistics**: Use `stat` for detailed metrics including N50, GC content, and length distributions.
    ```bash
    smof stat sequences.fasta
    ```
*   **Count entries**: Use `wc` to quickly count the number of sequences and total characters.
    ```bash
    smof wc sequences.fasta
    ```

### Filtering and Extraction
*   **Search by header**: Default `grep` behavior searches the description lines.
    ```bash
    smof grep "hypothetical protein" sequences.fasta
    ```
*   **Search by sequence**: Use `-q` (or `--match-sequence`) to find motifs within the sequence itself.
    ```bash
    smof grep -q "MVKVGVNGF" proteins.faa
    ```
*   **Extract subsequences**: Use `subseq` with coordinates (1-based).
    ```bash
    smof subseq -b 10 -e 50 input.fasta
    ```
*   **Entry-based slicing**: Use `head` and `tail` to get the first or last N entries.
    ```bash
    smof head -n 10 input.fasta
    ```

### Sorting and Sampling
*   **Sort by length**: Use `-l` to order sequences from shortest to longest.
    ```bash
    smof sort -l input.fasta
    ```
*   **Sort by header metadata**: Use `-x` with a regex capture group to sort by specific fields in the header.
    ```bash
    # Sort by a 'taxon|123' field numerically
    smof sort -nx 'taxon\|(\d+)' input.fasta
    ```
*   **Random sampling**: Extract a specific number of random sequences for testing.
    ```bash
    smof sample -n 100 large_dataset.fasta > subset.fasta
    ```

### Sequence Transformation
*   **Translation**: Convert DNA/RNA to protein.
    ```bash
    smof translate dna.fna > protein.faa
    ```
*   **Reverse complement**: Use `reverse` for standard reverse complementation.
    ```bash
    smof reverse dna.fna
    ```
*   **Clean sequences**: Remove gaps or non-IUPAC characters.
    ```bash
    smof clean -g input.fasta
    ```

## Expert Tips
*   **Piping**: `smof` is designed for composition. Always pipe subcommands to build complex filters (e.g., `smof filter ... | smof sort -l | smof head -n 1`).
*   **GFF Output**: When using `smof grep` to find motifs, use the `--gff` flag to generate a feature file compatible with genome browsers.
*   **Case Sensitivity**: Unlike standard `grep`, `smof grep` is case-insensitive by default. Use `-I` if case-sensitive matching is required.
*   **Flanking Regions**: When searching for motifs with `grep`, use `-A` (after) and `-B` (before) to include surrounding residues/bases in the output.
*   **Memory Efficiency**: For very large files, `smof split` can break datasets into manageable chunks based on entry count (`-n`) or file count (`-p`).

## Reference documentation
- [smof - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_smof_overview.md)
- [Simple Manipulation Of FASTA - GitHub](./references/github_com_incertae-sedis_smof.md)