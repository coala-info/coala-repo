---
name: gofasta
description: gofasta is a high-performance command-line utility designed for the rapid processing, conversion, and analysis of short genome alignments. Use when user asks to convert SAM files to multiple sequence alignments, find closest neighbors by genetic distance, or list variants and mutations relative to a reference.
homepage: https://github.com/cov-ert/gofasta
---


# gofasta

## Overview
gofasta is a high-performance command-line utility designed for the rapid processing of short genome alignments. While optimized for SARS-CoV-2, it is a general-purpose tool for any microbial pathogen. It excels at bridging the gap between alignment tools (like minimap2) and downstream analysis by providing efficient conversion, clipping, and distance-based neighbor searching. Use this skill to streamline bioinformatics pipelines where memory efficiency and speed are required for datasets containing millions of sequences.

## Common CLI Patterns

### Alignment Conversion (SAM to FASTA)
gofasta is most frequently used to convert pairwise SAM output from minimap2 into a Multiple Sequence Alignment (MSA) format where all sequences are the same length as the reference.

**Create a padded Multi-Alignment:**
```bash
minimap2 -a -x asm20 --score-N=0 reference.fa query.fa | gofasta sam toMultiAlign --start 266 --end 29674 --pad -o aligned.fasta
```
*   `--pad`: Replaces trimmed regions with 'N's to maintain reference length.
*   `--start`/`--end`: 1-based inclusive coordinates.

**Create Pairwise Alignments (including insertions):**
```bash
minimap2 -a -x asm20 --score-N=0 reference.fa query.fa | gofasta sam toPairAlign -r reference.fa -o output_dir
```
*   Unlike `toMultiAlign`, `toPairAlign` preserves insertions relative to the reference.

### Genetic Distance & Neighbor Searching
Use the `closest` command to find sequences in a large target file that are most similar to your query sequences.

**Find the 5 closest neighbors by SNP count:**
```bash
gofasta closest --query queries.fasta --target database.fasta -m snp -n 5 --table -o neighbors.csv
```

**Distance Measures (`-m`):**
*   `raw`: Nucleotide differences per site (default).
*   `snp`: Total count of nucleotide differences.
*   `tn93`: Tamura-Nei 93 distance.

### Variant & Mutation Listing
Generate summaries of SNPs and ambiguities relative to a reference.

```bash
gofasta updown list -r reference.fasta -q alignment.fasta -o mutations.csv
```
*   The output includes a pipe-delimited (`|`) list of SNPs and ambiguity ranges.

## Expert Tips
*   **Streaming for Efficiency**: gofasta is designed to work with pipes. Avoid writing large intermediate SAM files to disk by piping directly from `minimap2` into `gofasta sam toma`.
*   **Threading**: Use the `-t` flag to specify CPU cores. For piped commands, give `minimap2` more threads than `gofasta` as the alignment step is more computationally intensive.
*   **Coordinate System**: Always remember that `--start` and `--end` flags use 1-based inclusive reference coordinates.
*   **Memory Management**: For `closest` searches, queries are loaded into memory while targets are streamed. If you have many queries, consider batching them.

## Reference documentation
- [gofasta GitHub Repository](./references/github_com_virus-evolution_gofasta.md)