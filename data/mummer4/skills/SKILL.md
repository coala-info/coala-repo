---
name: mummer4
description: MUMmer4 is a high-performance system for aligning large DNA and protein sequences to identify similarities and structural variations. Use when user asks to align genomes, find maximal exact matches, identify SNPs and indels, or generate dot plots for sequence comparisons.
homepage: https://mummer4.github.io/
---


# mummer4

## Overview
MUMmer4 is a high-performance system for aligning large DNA sequences. It provides a suite of utilities to handle different biological contexts, ranging from nearly identical bacterial strains to highly divergent eukaryotic genomes. The tool is designed to be modular, allowing you to find maximal exact matches (MUMs), cluster them into longer alignments, and extract specific data like coordinates, SNPs, or tiling paths.

## Core Workflows

### Nucleotide Alignment (nucmer)
Use `nucmer` for comparing sequences with high DNA similarity (e.g., different strains of the same species or mapping assembly contigs).
- **Basic usage**: `nucmer -p <prefix> <reference.fasta> <query.fasta>`
- **Key Options**:
  - `--mum`: Use only matches that are unique in both reference and query.
  - `--maxmatch`: Use all matches regardless of uniqueness (use with caution in repetitive genomes).
  - `-c <int>`: Set minimum cluster length (default is 65). Increase this to reduce noise in complex alignments.

### Protein-Level Alignment (promer)
Use `promer` when DNA sequences are too divergent to align but protein sequences are conserved. It translates input DNA in all six frames before aligning.
- **Basic usage**: `promer -p <prefix> <reference.fasta> <query.fasta>`
- **Note**: Coordinates in the output are still nucleotide-based, but delta values represent amino acids (1 unit = 3 nucleotides).

### Automated Comparison (dnadiff)
Use `dnadiff` for a comprehensive evaluation of two highly similar genomes or assemblies. It wraps `nucmer` and several post-processing scripts.
- **Usage**: `dnadiff <reference.fasta> <query.fasta>`
- **Outputs**: Generates `.report` (summary stats), `.snps` (variants), and `.coords` (alignment table) files automatically.

## Post-Processing and Analysis

### Extracting Coordinates
Convert the encoded `.delta` output into a human-readable table.
- **Command**: `show-coords -r -c -l <file.delta> > <file.coords>`
- **Flags**:
  - `-r`: Sort by reference coordinates.
  - `-c`: Include percent coverage information.
  - `-l`: Include sequence length information.
  - `-T`: Output in tab-delimited format (useful for downstream parsing).

### Identifying SNPs and Indels
- **Command**: `show-snps -C <file.delta> > <file.snps>`
- **Flag**: `-C` ensures only SNPs from uniquely aligned regions are reported, reducing false positives.

### Visualizing Alignments
Generate dot plots to visualize rearrangements, inversions, and translocations.
- **Command**: `mummerplot -p <prefix> -postscript <file.delta>`
- **Tip**: After running, use `gnuplot <prefix>.gp` to generate the actual image file if not using the `-postscript` or `-png` flags directly.

## Expert Tips
- **Memory Management**: MUMmer4 is memory-efficient, but for extremely large eukaryotic genomes, ensure you have sufficient RAM for the suffix tree construction.
- **Contig Orientation**: Use `show-tiling` to generate a minimal tiling path of contigs across a reference, which is essential for scaffolded assembly finishing.
- **Filtering**: Use `delta-filter` before `show-coords` if you need to extract specific alignment types, such as 1-to-1 mapping (`-1`) or many-to-many mapping (`-m`).

## Reference documentation
- [MUMmer4 Manual](./references/mummer4_github_io_manual_manual.html.md)
- [MUMmer4 Tutorials](./references/mummer4_github_io_tutorial_tutorial.html.md)
- [MUMmer4 Overview](./references/mummer4_github_io_index.md)