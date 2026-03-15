---
name: star
description: STAR maps RNA-seq reads to a reference genome by identifying splice junctions and handling transcriptomic complexities. Use when user asks to generate a genome index, align single-end or paired-end reads, perform 2-pass mapping, or process single-cell RNA-seq data using STARsolo.
homepage: https://github.com/alexdobin/STAR
---


# star

## Overview

STAR (Spliced Transcripts Alignment to a Reference) is a high-performance bioinformatics tool designed to map RNA-seq reads to a reference genome. It is specifically optimized to handle the complexities of the transcriptome, such as identifying splice junctions and mapping reads that span multiple exons. While STAR is exceptionally fast, it is memory-intensive, typically requiring 30GB to 40GB of RAM for mammalian genomes. This skill assists in configuring the two-step STAR workflow: generating a genome index and performing the actual read alignment.

## Core Workflows

### 1. Genome Index Generation
Before mapping, you must generate a genome index for your specific organism.

```bash
STAR --runMode genomeGenerate \
     --runThreadN 8 \
     --genomeDir /path/to/indices/ \
     --genomeFastaFiles /path/to/genome.fa \
     --sjdbGTFfile /path/to/annotations.gtf \
     --sjdbOverhang 99
```
*   **--sjdbOverhang**: Ideally set to (ReadLength - 1). For 100bp reads, use 99.

### 2. Basic Read Alignment
Map single-end or paired-end reads to the generated index.

```bash
STAR --runThreadN 8 \
     --genomeDir /path/to/indices/ \
     --readFilesIn reads_R1.fq.gz reads_R2.fq.gz \
     --readFilesCommand zcat \
     --outFileNamePrefix ./results/Sample1_ \
     --outSAMtype BAM SortedByCoordinate
```
*   **--readFilesCommand zcat**: Required if input files are gzipped (.gz).
*   **--outSAMtype**: Use `BAM SortedByCoordinate` to generate a sorted BAM file ready for downstream analysis.

### 3. 2-Pass Mapping
Use 2-pass mapping to improve the discovery of novel splice junctions. This is highly recommended for better alignment quality.

```bash
STAR --genomeDir /path/to/indices/ \
     --readFilesIn reads_R1.fq.gz reads_R2.fq.gz \
     --readFilesCommand zcat \
     --twopassMode Basic \
     --outSAMtype BAM SortedByCoordinate
```

## Expert Tips and Best Practices

### Memory Management
*   **Mammalian Genomes**: Ensure the system has at least 32GB of RAM.
*   **Shared Memory**: If running multiple STAR jobs on the same node, use `--genomeLoad LoadAndKeep` to load the genome into memory once and share it across processes. Use `--genomeLoad Remove` after the last job finishes.

### Alignment Tuning
*   **Maximum Intron Size**: For human/mouse, set `--alignIntronMax 1000000` to allow for long-range splicing. If not set, STAR uses a default window size that may be too small for some species.
*   **Read Groups**: If you plan to use Picard or GATK later, add read group information during alignment:
    `--outSAMattrRGline ID:Sample1 LB:Library1 PL:Illumina PU:Unit1 SM:Sample1`

### Single-Cell RNA-Seq (STARsolo)
For 10x Genomics or similar protocols, use the STARsolo integrated pipeline:
```bash
STAR --genomeDir /path/to/indices/ \
     --readFilesIn cdna_reads.fq.gz barcode_reads.fq.gz \
     --readFilesCommand zcat \
     --soloType CB_UMI_Simple \
     --soloCBwhitelist /path/to/whitelist.txt \
     --soloBarcodeReadLength 0
```

## Reference documentation
- [STAR Main README](./references/github_com_alexdobin_STAR.md)
- [FAQ: Options and Parameters](./references/github_com_alexdobin_STAR_wiki_FAQ_-Options-and-Parameters.md)
- [FAQ: Output and SAM Tags](./references/github_com_alexdobin_STAR_wiki_FAQ_-Output.md)