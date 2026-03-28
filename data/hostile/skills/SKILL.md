---
name: hostile
description: Hostile removes host DNA sequences from metagenomic datasets using masked reference indexes to preserve microbial reads. Use when user asks to clean fastq files, remove human reads from sequencing data, or mask reference genomes to prevent accidental pathogen removal.
homepage: https://github.com/bede/hostile
---

# hostile

## Overview
Hostile is a high-performance bioinformatics tool designed to "clean" metagenomic datasets by filtering out DNA sequences belonging to a host organism. Unlike traditional methods that might accidentally discard microbial reads, Hostile uses specialized masked indexes to ensure high sensitivity for pathogens while maintaining >99.5% removal of host DNA. It supports both Bowtie2 (short reads) and Minimap2 (long reads) and can handle streaming data via stdin/stdout.

## Common CLI Patterns

### Basic Decontamination
By default, Hostile downloads and uses a human T2T (Telomere-to-Telomere) reference index.

**Short reads (Paired-end):**
```bash
hostile clean --fastq1 reads_R1.fastq.gz --fastq2 reads_R2.fastq.gz --output cleaned_reads/
```

**Long reads (ONT):**
```bash
hostile clean --fastq1 reads.fastq.gz --output cleaned_reads/
```

### Using Masked Indexes
To prevent the accidental removal of specific pathogens (like bacteria or viruses), use a masked index.
```bash
# Masked against 985 bacterial genomes
hostile clean --index human-t2t-hla-argos985 --fastq1 reads.fq.gz

# Masked against bacteria, viruses, and phages (best for viral discovery)
hostile clean --index human-t2t-hla.argos-bacteria-985_rs-viral-202401_ml-phage-202401 --fastq1 reads.fq.gz
```

### Streaming and Pipelines
Hostile supports stdin and stdout using the `-` shortcut, allowing it to be piped between other tools.
```bash
cat reads.fastq.gz | hostile clean --fastq1 - --output - | gzip > decontaminated.fastq.gz
```

### Privacy and Optimization
*   **Anonymization**: Use `--rename` to replace original read headers with integers, which also reduces file size.
*   **Performance**: Hostile automatically detects available CPU cores, but you can provide specific aligner arguments if needed.
*   **Inverted Mode**: Use `--invert` to keep only the host reads (useful for host genomics or QC).

## Expert Tips
*   **Memory Requirements**: Ensure your environment has at least 4GB RAM for short reads (Bowtie2) and 13GB RAM for long reads (Minimap2).
*   **Custom Cache**: If working on a cluster with limited home directory space, set the `HOSTILE_CACHE_DIR` environment variable to a high-capacity storage path.
*   **Offline Usage**: Use the `--airplane` flag to prevent the tool from attempting to check for index updates or downloads when working in air-gapped environments.
*   **Custom Masking**: If you have a specific organism you must preserve, use the `hostile mask` utility to create a custom index from your own reference genomes.



## Subcommands

| Command | Description |
|---------|-------------|
| hostile clean | Remove reads aligning to an index from fastq[.gz] input files or stdin. |
| hostile index | Manage and download indexes for use with hostile clean |
| hostile mask | Mask reference genome against target genome(s) |

## Reference documentation
- [Hostile README](./references/github_com_bede_hostile_blob_main_README.md)
- [Hostile Changelog](./references/github_com_bede_hostile_blob_main_CHANGELOG.md)