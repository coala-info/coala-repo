---
name: sinto
description: Sinto is a specialized toolkit designed to handle the "plumbing" of single-cell data processing.
homepage: https://timoast.github.io/sinto/
---

# sinto

## Overview

Sinto is a specialized toolkit designed to handle the "plumbing" of single-cell data processing. It bridges the gap between initial sequence alignment and downstream analysis by providing deterministic tools for barcode manipulation and fragment file generation. Use this skill to perform high-performance filtering of BAM files by cell identity, to generate standardized BED-format fragment files for ATAC-seq, or to reformat FASTQ files so that barcodes are stored in read names for easier tracking through alignment pipelines.

## Core CLI Patterns

### 1. Creating scATAC-seq Fragment Files
The `fragments` command is the most common use case for scATAC-seq data. It converts a position-sorted, indexed BAM into a collapsed fragment file.

```bash
# Basic fragment generation
sinto fragments -b input.sort.bam -f fragments.bed --barcode_regex "[^:]*"

# Post-processing (Required for downstream tools like Signac/ArchR)
sort -k 1,1 -k2,2n fragments.bed > fragments.sort.bed
bgzip fragments.sort.bed
tabix -p bed fragments.sort.bed.gz
```

### 2. Filtering BAMs by Cell Barcode
Use `filterbarcodes` to subset a BAM file. This is useful for creating "pseudo-bulk" alignments or extracting specific clusters.

```bash
# Filter for a specific list of barcodes
sinto filterbarcodes -b input.bam -c cell_barcodes.txt -p 8
```

### 3. Pre-alignment Barcode Attachment
If barcodes are in a separate FASTQ (e.g., Index read), use `barcode` to move them into the read names of the genomic FASTQs before mapping.

```bash
# Move 12bp barcode from R1 to the read names of R2 and R3
sinto barcode -b 12 --barcode_fastq R1.fastq --read1 R2.fastq --read2 R3.fastq
```

## Expert Tips and Best Practices

- **Parallelization Strategy**: The `--nproc` parameter parallelizes by chromosome. Do not set `--nproc` higher than the number of contigs/chromosomes in your BAM file, as it will provide no additional benefit.
- **Memory Management**: If encountering memory issues during `fragments` generation, decrease the `--chunksize` (default is 500,000). Conversely, increase it for faster processing if RAM is abundant.
- **Tn5 Shift**: By default, `sinto fragments` applies a +4/-5 bp shift to account for Tn5 transposase stagger. If your data is already shifted or requires different parameters, use `--shift_plus` and `--shift_minus`.
- **Barcode Extraction**: 
  - If barcodes are in a BAM tag (default "CB"), ensure the tag exists.
  - If barcodes are in the read name (common in SNARE-seq or custom pipelines), use `--barcode_regex`. For example, `^[^:]*` matches everything before the first colon.
- **Duplicate Handling**: By default, Sinto collapses fragments with the same coordinates across all cells. To only collapse duplicates within the same cell barcode, use the `--collapse_within` flag.
- **Performance**: The `barcode` function is significantly faster on uncompressed FASTQ files. If processing large datasets, unzip the FASTQs before running `sinto barcode`.

## Reference documentation

- [Sinto Overview](./references/timoast_github_io_sinto.md)
- [Basic Usage Guide](./references/timoast_github_io_sinto_basic_usage.html.md)
- [Processing scATAC-seq Data](./references/timoast_github_io_sinto_scatac.html.md)