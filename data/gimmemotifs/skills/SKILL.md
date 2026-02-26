---
name: gimmemotifs
description: GimmeMotifs is a suite of tools for identifying and analyzing transcription factor motifs in genomic datasets. Use when user asks to find enriched motifs de novo, scan sequences for motif occurrences, or perform differential motif analysis between conditions.
homepage: https://github.com/vanheeringen-lab/gimmemotifs
---


# gimmemotifs

## Overview
GimmeMotifs is a specialized suite of tools designed to identify and analyze transcription factor motifs in genomic datasets. It excels at de novo motif prediction, scanning sequences for known motifs, and performing differential motif analysis (Maelstrom) to identify drivers of cell-type-specific or condition-specific regulatory activity.

## Core Workflows

### 1. De Novo Motif Discovery
Use `gimme motifs` to find enriched motifs in a set of genomic regions (BED format).

```bash
# Basic de novo motif discovery
gimme motifs peaks.bed output_dir -g hg38 --denovo

# Discovery using a specific motif database and de novo tools
gimme motifs peaks.bed output_dir -g /path/to/genome.fa --known --denovo
```

### 2. Motif Scanning
Use `gimme scan` to locate motif occurrences within sequences.

```bash
# Scan a BED file for motifs using a specific threshold
gimme scan peaks.bed -g hg38 -f 0.05 > matches.bed

# Scan and return the best match per sequence
gimme scan peaks.bed -g hg38 --best
```

### 3. Differential Motif Analysis (Maelstrom)
Use `gimme maelstrom` to identify motifs that are differentially enriched between multiple conditions or clusters.

```bash
# Analyze a table of counts or fold-changes
gimme maelstrom input_table.txt hg38 out_dir
```

## Genome Management
GimmeMotifs integrates with `genomepy` for easy genome handling. Ensure your genome is installed and accessible before running motif commands.

```bash
# Install a genome via genomepy for use in GimmeMotifs
genomepy install hg38 --annotation

# List installed genomes
genomepy list
```

## Expert Tips and Best Practices
- **Genome Configuration**: If using a custom genome directory, edit `~/.config/genomepy/genomepy.yaml` to set the `genome_dir`. GimmeMotifs will look here when you provide a genome name (e.g., `hg38`) instead of a full path to a FASTA file.
- **Background Sequences**: By default, GimmeMotifs generates matched background sequences. For specific experiments, you can provide your own background using the `-b` flag.
- **Parallelization**: Many `gimme` commands support the `-n` flag to specify the number of threads. Use this to speed up discovery and scanning on multi-core systems.
- **Tool Selection**: The `--denovo` flag runs a suite of tools (like BioProspector, MDmodule, etc.). If you have a preferred tool, you can specify it, but the default ensemble approach is generally more robust.

## Reference documentation
- [GimmeMotifs GitHub Repository](./references/github_com_vanheeringen-lab_gimmemotifs.md)
- [GimmeMotifs Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gimmemotifs_overview.md)