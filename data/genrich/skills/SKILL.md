---
name: genrich
description: Genrich is a peak-caller designed to identify genomic enrichment from alignment data, specifically optimized for ATAC-seq and multimapping reads. Use when user asks to call peaks from ChIP-seq or ATAC-seq data, handle multiple replicates, or remove PCR duplicates from queryname-sorted alignments.
homepage: https://github.com/jsh58/Genrich
metadata:
  docker_image: "quay.io/biocontainers/genrich:0.6.1--hed695b0_0"
---

# genrich

## Overview

Genrich is a high-performance peak-caller designed to identify sites of genomic enrichment from alignment data. It is uniquely capable of processing multimapping reads by assigning fractional counts to multiple locations and features a sophisticated PCR duplicate removal algorithm that accounts for multiple alignments. It is the preferred tool when analyzing ATAC-seq data due to its built-in Tn5 transposase adjustment mode and its ability to handle multiple replicates and control samples simultaneously.

## Usage Guidelines

### Input Requirements
* **Queryname Sorting**: Input SAM/BAM files **must** be sorted by queryname (`samtools sort -n`), not by genomic coordinate. Genrich relies on this order to correctly identify paired-end fragments.
* **Multimapping**: To leverage Genrich's multimapping capabilities, ensure your aligner (e.g., Bowtie2) was run with options to report secondary alignments (e.g., `-k` or `-a`).

### Common CLI Patterns

#### Basic Peak-Calling (ChIP-seq)
To call peaks using an experimental sample and a control:
```bash
Genrich -t sample.bam -c control.bam -o output.narrowPeak -v
```

#### ATAC-seq Mode
Use the `-j` flag to enable ATAC-seq mode, which centers the fragment intervals on the transposase cut sites and applies a Tn5 shift (default 100bp expansion):
```bash
Genrich -t sample.bam -o output.narrowPeak -j -r -v
```
* Use `-d <int>` to change the expansion width around the cut site.
* Use `-D` to skip the Tn5 adjustment if the alignments were already shifted during preprocessing.

#### Handling Multiple Replicates
Provide comma-separated lists for replicates. Genrich analyzes them collectively to identify consistent peaks:
```bash
Genrich -t rep1.bam,rep2.bam -c control.bam -o combined.narrowPeak -v
```

#### Filtering and Quality Control
* **MAPQ Filtering**: Use `-m <int>` to set a minimum mapping quality (e.g., `-m 30`).
* **Exclude Chromosomes**: Use `-e` to ignore specific chromosomes (e.g., `-e chrM,chrY`).
* **Blacklist Regions**: Use `-E <bed_file>` to exclude known problematic regions (e.g., ENCODE blacklists).

### Expert Tips
* **PCR Duplicate Removal**: Use the `-r` flag within Genrich rather than external tools like Picard MarkDuplicates if you are using multimapping reads, as Genrich's algorithm is specifically designed to evaluate duplicates across multiple alignments.
* **Significance Thresholds**: The default p-value threshold is 0.01 (`-p 0.01`). For more stringent discovery, switch to q-values (FDR) using `-q <float>`.
* **Bedgraph Output**: Use `-k <file>` to generate a bedgraph-ish file of pileups and p-values, which is essential for visualization in genome browsers like IGV.
* **Unpaired Reads**: By default, Genrich ignores unpaired alignments. If working with single-end data or high-fragmentation samples, use `-y` to keep them, or `-x` to extend them to the average paired-end fragment length.

## Reference documentation
- [Genrich GitHub Repository](./references/github_com_jsh58_Genrich.md)
- [Genrich Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_genrich_overview.md)