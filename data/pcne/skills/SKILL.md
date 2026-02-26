---
name: pcne
description: PCNE estimates the number of plasmid copies in a cell relative to the chromosome by calculating the ratio of median sequencing depths. Use when user asks to estimate plasmid copy number, calculate plasmid-to-chromosome ratios, or normalize sequencing depth with GC-content bias correction.
homepage: https://github.com/riccabolla/PCNE
---


# pcne

## Overview

PCNE (Plasmid Copy Number Estimator) is a bioinformatics tool designed to determine how many copies of a plasmid are present in a cell relative to the chromosome. It works by aligning raw sequencing reads (FASTQ) to an assembly (FASTA) and calculating the ratio of median depths. The tool is versatile, supporting both complete and draft assemblies, and provides built-in GC-content bias correction to improve accuracy in PCR-amplified libraries.

## Execution Modes

PCNE operates in two distinct modes depending on how your assembly data is organized.

### Mode 1: Separated FASTA Files
Use this mode if you have already partitioned your assembly into a chromosome file and a plasmid file (e.g., using tools like Platon or MOB-Suite).

```bash
pcne -c chromosome.fasta -p plasmid.fasta -r reads_R1.fastq.gz -R reads_R2.fastq.gz -o output_prefix
```

### Mode 2: Assembly with Contig Lists
Use this mode if you have a single multi-FASTA assembly file and text files listing which contigs belong to the chromosome and which belong to the plasmid(s).

```bash
pcne -a assembly.fasta -C chr.list -P plasmid.list -r reads_R1.fastq.gz -R reads_R2.fastq.gz -o output_prefix
```
*Note: The list files should contain one contig name per line.*

## Common CLI Patterns and Best Practices

### Handling Fragmented Plasmids
If a single plasmid is represented by multiple contigs in your FASTA file, use the `-s` or `--single-plasmid` flag. This tells PCNE to treat all contigs in the plasmid input as a single biological entity for copy number estimation.

```bash
pcne -c chr.fasta -p fragmented_plasmid.fasta -r R1.fq -R R2.fq -s -o sample_01
```

### Improving Accuracy with GC Correction
Sequencing libraries prepared with PCR often exhibit depth biases related to GC content. Enable LOESS-based correction to normalize these fluctuations.

```bash
pcne [inputs] --gc-correction --gc-plot gc_profile.png
```

### Filtering for High Confidence
To reduce noise from reads that map ambiguously to multiple locations (common in repetitive plasmid regions), set a minimum mapping quality (MQ).

```bash
pcne [inputs] -Q 30 -F 1024
```
*   `-Q 30`: Filters for reads with a MAPQ score of 30 or higher.
*   `-F 1024`: Excludes reads marked as optical or PCR duplicates.

### Batch Processing and Summarization
After running PCNE on multiple isolates within the same directory, use the summary utility to aggregate results and generate a comparative plot.

```bash
# Run in the directory containing .tsv outputs from individual pcne runs
pcne_summary
```
This generates `pcne_summary_all_results.tsv` and `pcne_summary_plot.png`.

## Expert Tips

1.  **Baseline Selection**: PCNE typically uses the median depth of the entire chromosome as the baseline. Ensure your chromosome FASTA is "clean" (free of large prophages or integrated elements that might skew depth) for the most accurate normalization.
2.  **Thread Management**: Alignment (BWA) is the most resource-intensive step. Scale performance using the `-t` flag (e.g., `-t 8` or `-t 16`).
3.  **Intermediate Files**: By default, PCNE cleans up BAM and temporary files. If you need to inspect the alignments to troubleshoot unexpected copy number values, use `-k` or `--keep-intermediate`.
4.  **Input Requirements**: Ensure contig names in your list files (`-C`, `-P`) exactly match the headers in your FASTA file (excluding the `>` symbol).

## Reference documentation
- [PCNE GitHub Repository](./references/github_com_riccabolla_PCNE.md)
- [PCNE Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pcne_overview.md)