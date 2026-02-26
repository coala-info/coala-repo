---
name: motifscan
description: MotifScan identifies DNA motif occurrences and performs enrichment analysis within specific genomic regions. Use when user asks to scan for transcription factor binding sites, perform motif enrichment analysis, or manage genome assemblies and motif libraries.
homepage: https://github.com/shao-lab/MotifScan
---


# motifscan

## Overview
MotifScan is a bioinformatics tool designed to detect known DNA motif occurrences within specific genomic coordinates. It is primarily used to analyze sequences for transcription factor binding sites and to perform statistical tests to determine if motifs are significantly enriched or depleted in a set of regions compared to a control. The tool streamlines the process by managing genome assemblies and motif libraries (like JASPAR) internally.

## Genome Management
Before scanning, you must install the relevant genome assembly.

### Remote Installation (UCSC)
List available assemblies and install by name:
```bash
# List all available genomes from UCSC
motifscan genome --list-remote

# Install a specific genome (e.g., hg19)
motifscan genome --install -n hg19 -r hg19
```

### Local Installation
If using custom or local files, provide the FASTA and a `refGene.txt` annotation file:
```bash
motifscan genome --install -n my_genome -i genome.fa -a refGene.txt
```

## Motif Set Management
MotifScan uses Position Frequency Matrices (PFMs) to identify binding sites.

### Installing JASPAR Sets
```bash
# List available JASPAR 2020 sets
motifscan motif --list-remote

# Install a specific set for an installed genome
motifscan motif --install -n vertebrates -r vertebrates_non-redundant -g hg19
```

### Custom Motif Sets
Install a local JASPAR-format PFM file:
```bash
motifscan motif --install -n custom_motifs -i pfms.jaspar -g hg19
```

### Porting Motif Sets
If you have a motif set installed for one genome (e.g., hg19) and want to use it for another (e.g., hg38), use the build command:
```bash
motifscan motif --build vertebrates -g hg38
```

## Scanning and Enrichment Analysis
The `scan` command is the primary interface for discovery.

### Basic Motif Scanning
To find occurrences of motifs in a BED file:
```bash
motifscan scan -i regions.bed -g hg19 -m vertebrates -o output_dir
```

### Enrichment Analysis
To check for over-representation, provide a control set of regions:
```bash
motifscan scan -i target_regions.bed -c control_regions.bed -g hg19 -m vertebrates -o output_dir
```

## Expert Tips
- **Help Command**: Use `motifscan <command> -h` for a full list of arguments, including p-value thresholds and background model settings.
- **Output Structure**: The output directory will contain a summary table of motif occurrences and enrichment statistics, along with detailed site locations.
- **Memory Management**: For very large BED files or extremely long sequences, ensure the system has sufficient RAM, as MotifScan loads genome sequences into memory for scanning.

## Reference documentation
- [MotifScan GitHub Repository](./references/github_com_shao-lab_MotifScan.md)
- [MotifScan Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_motifscan_overview.md)