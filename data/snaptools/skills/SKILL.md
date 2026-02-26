---
name: snaptools
description: Snaptools processes snATAC-seq data from raw FASTQ reads into structured count matrices using the snap file format. Use when user asks to index genomes, align paired-end reads, create snap files from BAM files, or add bin, peak, and gene matrices to existing snap files.
homepage: https://github.com/r3fang/SnapTools.git
---


# snaptools

## Overview
The `snaptools` skill provides a procedural framework for handling the lifecycle of snATAC-seq data, from raw FASTQ reads to structured count matrices. It is designed to work with the `.snap` file format (version 4), which efficiently stores accessibility profiles, fragments, and metadata in a hierarchical HDF5 structure. Use this skill to execute high-performance genomic alignments, filter fragments based on mapping quality (MAPQ) and length, and append multi-resolution bin matrices to existing snap files.

## Core Workflows

### 1. Genome Indexing and Alignment
Before processing, reference genomes must be indexed. `snaptools` supports aligners like BWA and Bowtie2.

```bash
# Indexing (Example using BWA)
snaptools index-genome \
    --input-fasta=genome.fa \
    --output-prefix=genome_index \
    --aligner=bwa \
    --path-to-aligner=/path/to/bwa/bin/ \
    --num-threads=5

# Paired-end Alignment
# Note: --if-sort=True is recommended to group reads by barcode for downstream processing
snaptools align-paired-end \
    --input-reference=genome.fa \
    --input-fastq1=reads.R1.fastq.gz \
    --input-fastq2=reads.R2.fastq.gz \
    --output-bam=aligned.bam \
    --aligner=bwa \
    --path-to-aligner=/path/to/bwa/bin/ \
    --read-fastq-command=zcat \
    --min-cov=0 \
    --num-threads=8 \
    --if-sort=True
```

### 2. Snap File Creation (Pre-processing)
Convert aligned BAM files into `.snap` files. This step performs critical quality control, including PCR duplicate removal and fragment filtering.

```bash
snaptools snap-pre \
    --input-file=aligned.bam \
    --output-snap=sample.snap \
    --genome-name=hg38 \
    --genome-size=hg38.chrom.size \
    --min-mapq=30 \
    --max-flen=1000 \
    --keep-chrm=TRUE \
    --keep-single=TRUE \
    --overwrite=True \
    --min-cov=100
```

### 3. Matrix Generation
Add count matrices to the `.snap` file. These commands modify the file in-place by adding new sessions (AM, PM, or GM).

*   **Cell-by-Bin (AM):** Supports multiple resolutions (bin sizes) simultaneously.
*   **Cell-by-Peak (PM):** Requires a BED file of peaks.
*   **Cell-by-Gene (GM):** Requires a gene annotation file.

```bash
# Add bin matrices (e.g., 5kb and 10kb resolutions)
snaptools snap-add-bmat \
    --snap-file=sample.snap \
    --bin-size-list 5000 10000

# Add peak matrix
snaptools snap-add-pmat \
    --snap-file=sample.snap \
    --peak-file=peaks.bed

# Add gene matrix
snaptools snap-add-gmat \
    --snap-file=sample.snap \
    --gene-file=genes.bed
```

## Expert Tips & Best Practices
- **Memory Management**: When processing large datasets, use the `--tmp-folder` flag during alignment to specify a high-capacity disk for temporary sorting files.
- **Session Management**: Use `snap-del` to remove specific sessions (like a corrupted matrix) without recreating the entire snap file.
- **Quality Control**: Always check the `.snap.qc` file generated after `snap-pre`. Key metrics include the "Total number of unique fragments" (UQ) and "Proper paired" (PP) counts.
- **Barcode Handling**: Ensure FASTQ headers contain the cell barcode if using de-multiplexed data, or use `dex-fastq` for initial de-multiplexing.

## Reference documentation
- [SnapTools GitHub Repository](./references/github_com_r3fang_SnapTools.md)
- [SnapTools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_snaptools_overview.md)