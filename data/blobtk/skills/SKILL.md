---
name: blobtk
description: BlobTk is a high-performance toolkit designed to process genome assembly data for quality assessment and contamination identification. Use when user asks to calculate sequencing coverage depth, filter reads based on sequence names, generate assembly visualizations like snail or blob plots, or process taxonomic data.
homepage: https://github.com/genomehubs/blobtk
---


# blobtk

## Overview
BlobTk is a high-performance Rust-based toolkit designed to support the BlobToolKit ecosystem. It provides essential utilities for bioinformaticians working on genome assemblies to assess assembly quality and contamination. The tool excels at processing large alignment files (BAM/CRAM) to extract coverage statistics and allows for precise filtering of sequencing reads based on specific contig or scaffold selections.

## Core Workflows

### Calculating Coverage Depth
Use `blobtk depth` to generate coverage profiles. This is often the first step in identifying contamination or binned populations within an assembly.

- **Basic BAM coverage**: `blobtk depth -b input.bam -O output.bed`
- **Binned coverage (e.g., 1kb windows)**: `blobtk depth -b input.bam -s 1000 -O output.1000.bed`
- **CRAM support**: Requires the reference fasta: `blobtk depth -c input.cram -a reference.fasta -O output.bed`

### Filtering Sequences and Reads
Use `blobtk filter` to extract specific reads that map to a subset of sequences (e.g., removing cobionts or extracting a specific organelle).

- **Filter paired-end reads**:
  ```bash
  blobtk filter -i ids.txt -b mapping.bam -f forward.fq.gz -r reverse.fq.gz -F
  ```
- **Output options**:
  - `-A`: Output filtered FASTA.
  - `-F`: Output filtered FASTQ.
  - `-O <file>`: Just output the list of read IDs.

### Visualization and Taxonomy
BlobTk provides specialized commands for generating standard BlobToolKit visualizations and managing taxonomic data.

- **Snail Plots**: Use `blobtk snail` to generate assembly statistics visualizations (N50, BUSCO, etc.).
- **Blob Plots**: Use `blobtk plot` for GC-coverage-taxonomic plots.
- **Taxonomy**: Use `blobtk taxonomy` to process ENA/NCBI taxonomic data or validate configuration files for GenomeHubs.

## Expert Tips
- **Bin Size**: Setting `-s 0` (default) calculates a single average depth per contig. For highly fragmented assemblies or looking for localized coverage drops, use a fixed bin size like `-s 1000`.
- **Memory Efficiency**: Since BlobTk is written in Rust, it is significantly faster and more memory-efficient than equivalent Python scripts for parsing large BAM files.
- **Python Integration**: For custom analysis pipelines, you can import the modules directly: `from blobtk import depth, filter`.



## Subcommands

| Command | Description |
|---------|-------------|
| blobtk_taxonomy | Process a taxonomy and lookup lineages, or start the API server with --api |
| depth | Calculate sequencing coverage depth. |
| filter | Filter files based on list of sequence names. |
| index | Index files for GenomeHubs. Called as `blobtk index` |
| plot | Process a BlobDir and produce static plots. |
| validate | Validate BlobToolKit and GenomeHubs files. |

## Reference documentation
- [blobtk depth](./references/github_com_genomehubs_blobtk_wiki_blobtk-depth.md)
- [blobtk filter](./references/github_com_genomehubs_blobtk_wiki_blobtk-filter.md)
- [blobtk overview](./references/github_com_genomehubs_blobtk_wiki_blobtk.md)