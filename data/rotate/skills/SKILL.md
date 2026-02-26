---
name: rotate
description: The rotate utility re-centers circular DNA sequences by shifting their starting positions and provides sequence composition analysis. Use when user asks to shift the start of a circular sequence to a specific index or motif, generate reverse complements of rotated sequences, or calculate sequence statistics and base distributions.
homepage: https://github.com/richarddurbin/rotate
---


# rotate

## Overview
The `rotate` utility is a specialized tool for re-centering circular DNA sequences. Because circular genomes are represented linearly in FASTA files, the "start" and "end" points are often arbitrary. This tool allows researchers to shift the starting position to a specific index or a biological landmark (like a start codon or origin of replication) without breaking the circular continuity. It also includes a companion tool, `composition`, for rapid analysis of sequence lengths and base distributions in FASTA/FASTQ files.

## Command Line Usage

### Basic Rotation
To shift the start of a sequence to a specific 0-indexed position:
```bash
rotate -x 100 input.fa -o rotated_output.fa
```

### Motif-Based Rotation
To rotate the sequence so it begins with a specific string (e.g., a known gene start or restriction site):
```bash
rotate -s "TCTACGGA" input.fa > output.fa
```

### Mismatch-Tolerant Search
If the exact motif is unknown or subject to variation, use the `-m` flag to allow a specific number of mismatches:
```bash
rotate -s "TCTACGGA" -m 2 input.fa
```

### Reverse Complementation
To rotate the sequence and then generate its reverse complement in one step:
```bash
rotate -x 500 -rc input.fa -o rc_rotated.fa
```

### Working with Compressed Files and Pipes
The tool natively supports gzipped FASTA files and standard input:
```bash
cat genome.fa.gz | rotate -x 0 -o -
```

## Sequence Inspection with `composition`
The `rotate` package includes `composition`, a high-performance utility for summarizing sequence files.

### Summary Statistics
Get basic counts, N50, and length distributions:
```bash
composition test.fa
```

### Detailed Base Analysis
Show base counts (A, C, G, T, N) and memory usage:
```bash
composition -b -t test.fa
```

### Length Distribution
Visualize the length distribution using quadratic bins:
```bash
composition -l test.fa
```

## Best Practices
- **Coordinate System**: Remember that `-x` uses 0-indexed positioning.
- **Standard Input**: Use `-` as the filename to read from a pipe and `-o -` to write to standard output.
- **Circular Logic**: When rotating by string (`-s`), the tool searches across the original linear end-to-start junction, ensuring motifs split by the arbitrary FASTA break are still found.
- **Batch Processing**: `rotate` processes multiple sequences within a single FASTA file independently based on the provided parameters.

## Reference documentation
- [rotate GitHub Repository](./references/github_com_richarddurbin_rotate.md)
- [bioconda rotate Overview](./references/anaconda_org_channels_bioconda_packages_rotate_overview.md)