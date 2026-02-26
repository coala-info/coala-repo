---
name: dupsifter
description: Dupsifter identifies and marks PCR duplicates in sequencing libraries, with specific optimizations for whole-genome bisulfite sequencing data. Use when user asks to mark PCR duplicates, process WGBS data, or perform UMI-aware deduplication.
homepage: https://github.com/huishenlab/dupsifter
---


# dupsifter

## Overview
`dupsifter` is a specialized command-line tool for identifying and marking PCR duplicates in sequencing libraries. While compatible with standard WGS, it is specifically engineered for WGBS data, where it provides a faster and more resource-efficient alternative to traditional tools. It operates by comparing the genomic coordinates and orientations of read pairs, effectively handling the reduced sequence complexity found in bisulfite-treated samples.

## Installation
The recommended way to install `dupsifter` is via Bioconda:

```bash
conda install -c bioconda dupsifter
```

## Common Usage Patterns

### Basic Duplicate Marking
Process a BAM file to mark duplicates. `dupsifter` identifies duplicates and sets the 0x400 SAM flag.

```bash
dupsifter -i input.bam -o marked_duplicates.bam
```

### UMI/Barcode Aware Deduplication
If your library uses Unique Molecular Identifiers (UMIs) or barcodes to distinguish between PCR duplicates and independent fragments, use the `--barcode` flag. This ensures that reads are only marked as duplicates if they share both the same genomic coordinates and the same barcode.

```bash
dupsifter --barcode -i input.bam -o marked_duplicates.bam
```
*Note: Version 1.3.0+ supports single-end barcodes and handles 'N' symbols in barcode sequences.*

### Streaming Workflow
To minimize disk I/O and save space, pipe the output of an aligner (like `bwa-meth` for WGBS) directly into `dupsifter`:

```bash
bwa-meth ref.fa read1.fq.gz read2.fq.gz | dupsifter | samtools sort -o final.bam
```

## Best Practices and Tips
- **WGBS Optimization**: Use `dupsifter` instead of Picard MarkDuplicates for WGBS pipelines. It is specifically designed to handle the alignment properties of bisulfite-converted reads which can sometimes confuse general-purpose tools.
- **Performance**: Being written in C, `dupsifter` is significantly more memory-efficient and faster than Java-based deduplication tools, making it ideal for high-depth WGS or WGBS datasets.
- **Input Requirements**: Like the `samblaster` tool it is based on, `dupsifter` generally expects input where paired-end reads are grouped together (typically the output of an aligner).
- **Single-End Support**: While paired-end data provides the most accurate duplicate detection, `dupsifter` can be used for single-end data, particularly when combined with the `--barcode` option to improve specificity.

## Reference documentation
- [dupsifter Overview](./references/anaconda_org_channels_bioconda_packages_dupsifter_overview.md)
- [GitHub Repository](./references/github_com_huishenlab_dupsifter.md)