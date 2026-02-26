---
name: uniqsketch
description: UniqSketch performs high-resolution metagenomic analysis to detect specific microbial strains and their relative abundances. Use when user asks to index reference genomes, build a sketch index, query metagenomic samples, or estimate microbial abundance.
homepage: https://github.com/amazon-science/uniqsketch
---


# uniqsketch

## Overview
UniqSketch is a specialized bioinformatics toolset for high-resolution metagenomic analysis. It enables the detection of specific microbial strains and their relative abundances by focusing on unique k-mer signatures. The workflow is split into two distinct phases: **Indexing**, where unique k-mers are identified for a set of reference genomes, and **Querying**, where raw sequencing reads are matched against the index. It is optimized for resource efficiency, using Bloom filters to maintain a low memory footprint while maintaining high sensitivity.

## Installation
The recommended way to install UniqSketch is via Bioconda:
```bash
conda install bioconda::uniqsketch
```

## Building a Sketch Index (uniqsketch)
The `uniqsketch` command identifies k-mers that uniquely belong to specific reference sequences.

### Basic Usage
To index a set of FASTA files:
```bash
uniqsketch -k81 -o my_index.tsv ref1.fa ref2.fa ref3.fa
```

### Handling Large Databases
When working with many reference genomes, use the `@` prefix to pass a text file containing the list of file paths (one per line):
```bash
uniqsketch -o large_index.tsv @reference_list.txt
```

### Sensitivity Tuning
- **Standard**: Default settings.
- **Sensitive**: Use `--sensitive` (sets `-c` to 100 unique k-mers per reference).
- **High Resolution**: Use `--very-sensitive` (sets `-c` to 1000 unique k-mers per reference).

### Key Parameters
- `-k, --kmer`: Length of the k-mer (default: 81).
- `-t, --threads`: Number of parallel threads.
- `-e, --entropy`: Entropy rate threshold (default: 0.65) to filter low-complexity k-mers.

## Querying Metagenomic Samples (querysketch)
The `querysketch` command matches raw reads against the pre-built index to estimate abundance.

### Basic Usage
Query paired-end reads against a sketch index:
```bash
querysketch --r1 reads_R1.fq.gz --r2 reads_R2.fq.gz --ref my_index.tsv --out results.tsv
```

### Filtering and Accuracy
- **Sequencing Errors**: Use the `--solid` flag to discard k-mers with very low depth, which often represent sequencing errors.
- **Hit Threshold**: Adjust `-h, --hit` (default: 10) to change the number of unique hits required to "call" a reference as present.
- **Abundance Cutoff**: Use `-a, --acutoff` to filter out low-abundance noise from the final report.

### Key Parameters
- `--r1 / --r2`: Input read files (supports .gz, .bz, .zip, .xz).
- `--sensitive`: Sets hit threshold `h=10`.
- `--very-sensitive`: Sets hit threshold `h=5` for detecting rare strains.

## Output Interpretation
- **Primary Output**: A TSV file reporting the reference name, its relative abundance, and the raw count of unique k-mer hits.
- **Log File**: `log_[output_name].tsv` provides a detailed breakdown of assigned reads per reference.

## Reference documentation
- [UniqSketch GitHub Repository](./references/github_com_amazon-science_uniqsketch.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_uniqsketch_overview.md)