---
name: trimnami
description: Trimnami is a specialized Snaketool designed to automate the preprocessing of metagenomic sequencing data.
homepage: https://github.com/beardymcjohnface/Trimnami
---

# trimnami

## Overview

Trimnami is a specialized Snaketool designed to automate the preprocessing of metagenomic sequencing data. It eliminates the need for manual script writing by providing a unified interface for several popular trimming tools and host-removal workflows. Whether working with short-read Illumina data or long-read Nanopore data, Trimnami handles sample discovery, paired-end matching, and quality reporting in a single execution.

## Common CLI Patterns

### Basic Trimming
By default, Trimnami uses **Fastp** for trimming.
```bash
trimnami run --reads path/to/reads/
```

To use a different trimmer or multiple trimmers at once:
```bash
# Use Prinseq++
trimnami run --reads path/to/reads/ prinseq

# Run both Fastp and Prinseq++
trimnami run --reads path/to/reads/ fastp prinseq
```

### Host Removal
To filter out host-contaminant reads (e.g., human or lab-animal sequences), provide a reference genome in FASTA format.
```bash
trimnami run --reads path/to/reads/ --host host_genome.fasta
```

### Longread (Nanopore) Processing
For longreads, specify the `nanopore` target and use the appropriate minimap2 preset.
```bash
trimnami run --reads path/to/reads/ --host host_genome.fasta --minimap map-ont nanopore
```

### Specialized Viral Metagenomics
For Round A/B viral metagenomics, use the BBtools-based workflow:
```bash
trimnami run --reads path/to/reads/ roundAB
```

## Input Management

Trimnami is flexible with how it identifies samples via the `--reads` flag:

1.  **Directory Input**: Point to a folder containing FASTQ files. Trimnami automatically infers sample names and identifies `_R1`/`_R2` pairs.
2.  **TSV Input**: Provide a tab-separated file for explicit control.
    *   **2 Columns**: Sample Name, Read File (Single-end)
    *   **3 Columns**: Sample Name, R1 File, R2 File (Paired-end)

## Expert Tips

*   **Configuration**: To customize tool-specific parameters, generate a default configuration file using `trimnami config`. This creates `trimnami.out/trimnami.config.yaml` which can be edited and passed back using the `--configfile` flag.
*   **Subsampling**: If subsampling is enabled in the configuration, Trimnami will produce additional `.subsampled.fastq.gz` files in the output directory.
*   **Output Structure**: All results are organized by the tool name within the output directory (e.g., `trimnami.out/fastp/`). Quality reports (FastQC/MultiQC) are consolidated in `trimnami.out/reports/`.
*   **Testing**: Before running a large batch, use `trimnami test` (short-reads) or `trimnami testnp` (nanopore) to verify the environment and installation.

## Reference documentation
- [Trimnami GitHub Repository](./references/github_com_beardymcjohnface_Trimnami.md)
- [Trimnami Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_trimnami_overview.md)