---
name: bsmap
description: BSMAP is a specialized alignment tool designed to map bisulfite-converted DNA reads to a reference genome while accounting for C-to-T transitions. Use when user asks to map bisulfite-sequenced reads, perform RRBS alignment, or prepare data for methylation ratio extraction.
homepage: https://code.google.com/archive/p/bsmap/
metadata:
  docker_image: "quay.io/biocontainers/bsmap:2.90--py27_0"
---

# bsmap

## Overview
BSMAP (Bisulfite Sequence Mapping Program) is a specialized alignment tool that handles the unique challenges of bisulfite-converted DNA. Because bisulfite treatment converts unmethylated cytosines to uracils (read as thymines), standard aligners often fail due to the massive C-to-T mismatch rate. BSMAP addresses this by allowing for these specific mismatches during the alignment process, enabling accurate mapping of reads to a reference genome while preserving methylation information for downstream analysis.

## Usage Patterns

### Basic Alignment
The most common use case is mapping paired-end or single-end reads to a reference genome.
```bash
# Paired-end mapping
bsmap -a reads_1.fastq -b reads_2.fastq -d reference.fa -o output.sam

# Single-end mapping
bsmap -a reads.fastq -d reference.fa -o output.sam
```

### RRBS (Reduced Representation Bisulfite Sequencing)
When working with RRBS data, specify the digestion site (usually MspI) to improve mapping accuracy near restriction sites.
```bash
bsmap -a reads.fastq -d reference.fa -D C-CGG -o output.sam
```

### Key Parameters and Optimization
- `-p <int>`: Set the number of processors (threads) to use.
- `-q <int>`: Quality threshold for trimming (default is 0, but 20 is recommended for cleaner data).
- `-v <int>`: Maximum number of mismatches allowed (default is 0.08 of read length).
- `-w <int>`: Maximum number of equal best hits to report.
- `-r <0,1,2>`: How to report repeat hits (0=none, 1=random, 2=all).

### Methylation Calling
After mapping, use the companion script (often `methratio.py` included in the BSMAP package) to extract methylation ratios.
```bash
python methratio.py -d reference.fa -o methylation_output.txt output.sam
```

## Expert Tips
- **Memory Requirements**: BSMAP loads the entire reference index into memory. Ensure the system has enough RAM (typically ~5-8GB for the human genome).
- **Adapter Trimming**: While BSMAP can handle some adapter contamination via its mismatch allowance, pre-trimming reads with tools like Trim Galore! is highly recommended for bisulfite data.
- **SAM/BAM Conversion**: BSMAP outputs SAM format by default. Pipe the output to `samtools` to save disk space and create indexed BAM files:
  `bsmap -a r1.fq -b r2.fq -d ref.fa | samtools view -bS - > output.bam`

## Reference documentation
- [BSMAP Project Archive](./references/code_google_com_archive_p_bsmap.md)
- [Bioconda BSMAP Overview](./references/anaconda_org_channels_bioconda_packages_bsmap_overview.md)