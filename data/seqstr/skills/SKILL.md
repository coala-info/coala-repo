---
name: seqstr
description: `seqstr` (sequence string) is a specialized utility for programmatically defining genomic sequences.
homepage: https://github.com/jzhoulab/Seqstr
---

# seqstr

## Overview
`seqstr` (sequence string) is a specialized utility for programmatically defining genomic sequences. It allows you to construct complex sequences using a "recipe" format that combines reference genome intervals, specific point mutations, and custom nucleotide strings. This tool is particularly effective for bioinformatic workflows where you need to generate specific sequence variants or chimeric sequences without the overhead of manual sequence manipulation or transferring large genomic files.

## Syntax Specification

The core of `seqstr` is its string format. A single sequence is composed of one or more subsequences separated by semicolons (`;`).

### 1. Genomic Intervals
Extract sequences from a reference genome using the following format:
`[reference_genome]chromosome:start-end strand`

*   **Reference Genome**: Specified in brackets (e.g., `[hg38]`). Defaults to `hg38` if omitted.
*   **Coordinates**: 0-based, inclusive of start and exclusive of end (UCSC convention).
*   **Strand**: Use `+` (default) or `-`. If `-` is specified, the tool automatically takes the reverse complement.
*   **Example**: `[hg38]chr7:5530575-5530625 -`

### 2. Sequence Modifiers (Mutations)
Apply variants to a genomic interval using the `@` symbol. Modifiers must follow the interval they modify, separated by a comma.
`@chromosome position reference_allele alternative_allele`

*   **Reference Frame**: Coordinates are relative to the original reference genome and the `+` strand, regardless of the interval's strand.
*   **Multiple Mutations**: Separate multiple modifiers with commas.
*   **Example**: `[hg38]chr7:5530575-5530625 +, @chr7 5530575 C T, @chr7 5530576 GC A`

### 3. Concatenation and Raw Strings
You can join multiple intervals or raw nucleotide strings.
*   **Example**: `[hg38]chr7:100-200 +; ATGCATGC; [hg19]chr1:500-600 -`

### 4. Naming Sequences
Label sequences using angle brackets at the start of the line.
*   **Example**: `<variant_1>[hg38]chr7:5530575-5530625 +`

## CLI Usage Patterns

### Basic Execution
Process a file containing `seqstr` specifications into a FASTA file:
```bash
seqstr input_file.txt --output sequences.fasta
```

### Managing Genome Data
To avoid slow API queries to UCSC, download genome files locally:
```bash
# Download a specific genome
seqstr --download hg38 --dir ./genome_data

# Use the local directory for processing
seqstr input_file.txt --dir ./genome_data
```

### Configuration
The tool stores the default genome directory in `~/.seqstr.config`. You can overwrite this by using the `--dir` flag in any command.

## Expert Tips
*   **0-Based Logic**: Always double-check that your coordinates follow the 0-based, half-open interval format (start is included, end is not).
*   **Mutation Positioning**: Remember that mutations are applied based on the reference genome coordinates. If a mutation changes the length (insertion/deletion), subsequent mutation coordinates in the same string still refer to the *original* reference positions.
*   **Overlaps**: `seqstr` does not allow overlapping mutations. Ensure your variants are distinct.
*   **Batch Processing**: For multiple sequences, place each on a new line in your input file. If no `<name>` is provided, they will be indexed numerically (0, 1, 2...).

## Reference documentation
- [Seqstr GitHub Repository](./references/github_com_jzhoulab_Seqstr.md)
- [Bioconda Seqstr Package Overview](./references/anaconda_org_channels_bioconda_packages_seqstr_overview.md)