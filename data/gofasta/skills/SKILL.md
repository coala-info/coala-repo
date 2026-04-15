---
name: gofasta
description: gofasta is a high-performance command-line utility for genomic epidemiology that converts SAM alignments to FASTA formats and calculates genetic distances for large-scale sequence datasets. Use when user asks to convert SAM files to multiple sequence alignments, generate pairwise alignments, find closest genetic neighbors, or list mutations relative to a reference.
homepage: https://github.com/cov-ert/gofasta
metadata:
  docker_image: "quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0"
---

# gofasta

## Overview
gofasta is a high-performance command-line utility designed for genomic epidemiology, particularly for handling large-scale SARS-CoV-2 datasets. It excels at transforming pairwise alignments from SAM format into multiple sequence alignments (MSA) or individual pairwise FASTA files. It also provides optimized routines for calculating evolutionary distances and identifying genetically similar sequences by streaming data from disk, making it suitable for datasets containing millions of sequences.

## Common Workflows and CLI Patterns

### SAM to FASTA Conversion
gofasta is frequently used in conjunction with minimap2 to generate alignments.

**Generate a Multiple Sequence Alignment (MSA):**
Use `toMultiAlign` (alias `toma`) to create a single alignment file where all sequences are the same length as the reference.
```bash
minimap2 -a -x asm20 --score-N=0 reference.fa queries.fa | gofasta sam toma -t 4 --start 266 --end 29674 --pad -o aligned.fasta
```
*   `--start` / `--end`: 1-based inclusive coordinates in reference space.
*   `--pad`: Replaces trimmed regions with 'N's to maintain reference length.
*   **Note**: Insertions relative to the reference are discarded in this mode.

**Generate Pairwise Alignments (Including Insertions):**
Use `toPairAlign` (alias `topa`) to create individual FASTA files for each query, preserving insertions relative to the reference.
```bash
minimap2 -a -x asm20 --score-N=0 reference.fa queries.fa | gofasta sam topa -r reference.fa -o output_directory
```

### Genetic Distance and Neighbor Searching
gofasta can find the closest matches for query sequences within a large target database.

**Find Closest Neighbors:**
```bash
gofasta closest --query queries.fasta --target database.fasta -m tn93 -n 5 --table -o neighbors.csv
```
*   `-m`: Distance measure (`raw` for differences per site, `snp` for total count, or `tn93` for Tamura-Nei 93).
*   `-n`: Number of closest sequences to return.
*   `--table`: Outputs a long-form table instead of a list.

### Mutation Analysis
**Generate Mutation Lists:**
Use `updown list` to create a CSV of SNPs and ambiguities relative to a reference.
```bash
gofasta updown list -r reference.fasta -q alignment.fasta -o mutations.csv
```
*   The output includes a pipe-delimited list of SNPs and 1-based inclusive ranges of ambiguities.

## Expert Tips and Best Practices
*   **Pipe for Speed**: Avoid writing massive intermediate SAM files to disk by piping directly from minimap2 to gofasta.
*   **Threading**: Use the `-t` or `--threads` flag to leverage multiple CPUs, especially for the `closest` and `sam` commands.
*   **Memory Efficiency**: The `closest` command loads queries into memory but streams targets from disk, allowing you to search against target files that exceed available RAM.
*   **Coordinate System**: Always remember that `--start` and `--end` flags use 1-based inclusive reference coordinates.
*   **Handling Ambiguities**: When using `updown list`, note that any nucleotide that is not A, T, G, or C is treated as an ambiguity.



## Subcommands

| Command | Description |
|---------|-------------|
| gofasta closest | Find the closest sequence(s) to a query by genetic distance |
| gofasta completion | Generate the autocompletion script for gofasta for the specified shell. |
| gofasta sam | Do things with sam files |
| gofasta snps | Find snps relative to a reference. |
| gofasta updown | Get pseudo-tree-aware catchments for query sequences from alignments |
| gofasta variants | Annotate mutations relative to a reference from a multiple sequence alignment in fasta format |

## Reference documentation
- [gofasta README](./references/github_com_virus-evolution_gofasta_blob_master_README.md)