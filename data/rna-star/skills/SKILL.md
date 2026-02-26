---
name: rna-star
description: STAR aligns RNA-seq reads to a reference genome while accounting for splicing events. Use when user asks to align RNA-seq reads, generate a genome index, perform 2-pass mapping for junction discovery, or process single-cell RNA-seq data using STARsolo.
homepage: https://github.com/alexdobin/STAR
---


# rna-star

## Overview
STAR (Spliced Transcripts Alignment to a Reference) is a specialized bioinformatics tool designed to align RNA-seq reads to a reference genome. Unlike standard genomic aligners, STAR is optimized to handle the gaps created by splicing events. It is widely recognized for its high mapping speed and accuracy. This skill provides guidance on executing the two-step workflow (genome indexing and read mapping), utilizing the high-utility 2-pass mode for improved junction discovery, and configuring STARsolo for single-cell transcriptomics.

## Hardware Requirements
*   **RAM**: Minimum 16GB for small genomes; 32GB is recommended for mammalian genomes (e.g., Human or Mouse).
*   **Architecture**: x86-64 compatible processors running 64-bit Linux or macOS.

## Core CLI Patterns

### 1. Genome Index Generation
Before alignment, you must generate a genome index. This requires the genome FASTA and an optional GTF annotation file.
```bash
STAR --runMode genomeGenerate \
     --genomeDir /path/to/index/ \
     --genomeFastaFiles genome.fa \
     --sjdbGTFfile annotations.gtf \
     --runThreadN 8
```

### 2. Standard Mapping (Basic)
For standard alignment of paired-end reads:
```bash
STAR --genomeDir /path/to/index/ \
     --readFilesIn read_R1.fq.gz read_R2.fq.gz \
     --readFilesCommand zcat \
     --outFileNamePrefix ./output_prefix \
     --outSAMtype BAM SortedByCoordinate \
     --runThreadN 8
```

### 3. 2-Pass Mapping
Use `--twopassMode Basic` to improve the mapping of reads over novel junctions. This is highly recommended for better sensitivity in splice junction detection.
```bash
STAR --genomeDir /path/to/index/ \
     --readFilesIn R1.fq R2.fq \
     --twopassMode Basic \
     --outSAMtype BAM SortedByCoordinate
```

### 4. Single-Cell RNA-seq (STARsolo)
STARsolo is an integrated pipeline for droplet-based single-cell RNA-seq (e.g., 10x Genomics).
```bash
STAR --genomeDir /path/to/index/ \
     --readFilesIn cdna_reads.fq.gz barcode_umi_reads.fq.gz \
     --readFilesCommand zcat \
     --soloType CB_UMI_Simple \
     --soloCBwhitelist /path/to/whitelist.txt \
     --soloFeatures Gene GeneFull \
     --outFileNamePrefix ./solo_output_
```

## Expert Tips & Best Practices
*   **Read Group Information**: When preparing BAM files for downstream variant calling, use `--outSAMattrRGline` to define read group headers (e.g., `--outSAMattrRGline ID:sample1 SM:sample1 PL:ILLUMINA`).
*   **Compressed Inputs**: Always use `--readFilesCommand zcat` (for .gz) or `bzcat` (for .bz2) to process compressed fastq files directly without manual decompression.
*   **Memory Management**: If running on a shared cluster with limited memory, ensure you request at least 32GB of RAM. If the process fails with a "Segmentation Fault" or "Killed" message, it is almost always due to insufficient memory during the genome loading phase.
*   **Chromosome Name Consistency**: Ensure that the chromosome names in your FASTA files exactly match those in your GTF annotation files to avoid empty mapping results.

## Reference documentation
- [STAR Main Repository](./references/github_com_alexdobin_STAR.md)
- [STAR Wiki and FAQ](./references/github_com_alexdobin_STAR_wiki.md)
- [STARsolo and Parameter Discussions](./references/github_com_alexdobin_STAR_discussions.md)