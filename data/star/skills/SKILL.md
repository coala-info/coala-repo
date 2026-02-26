---
name: star
description: STAR maps RNA-seq reads to a reference genome and identifies splice junctions with high speed and accuracy. Use when user asks to generate a genome index, align RNA-seq reads, perform two-pass mapping, or process single-cell RNA-seq data.
homepage: https://github.com/alexdobin/STAR
---


# star

## Overview
STAR (Spliced Transcripts Alignment to a Reference) is a high-performance bioinformatics tool designed for mapping RNA-seq reads to a reference genome. It excels at identifying splice junctions and is widely used in transcriptomics for its speed and accuracy. This skill provides the necessary command-line patterns for the standard two-step workflow: generating a genome index and performing the actual read alignment.

## Installation
The most common way to install STAR is via Bioconda:
```bash
conda install bioconda::star
```

## Core Workflows

### 1. Genome Index Generation
Before alignment, you must generate a genome index. This requires a FASTA file of the genome and a GTF annotation file.
```bash
STAR --runThreadN 8 \
     --runMode genomeGenerate \
     --genomeDir ./genome_index \
     --genomeFastaFiles genome.fa \
     --sjdbGTFfile annotations.gtf \
     --sjdbOverhang 99
```
*   **--sjdbOverhang**: Ideally set to (ReadLength - 1). For 100bp reads, use 99.

### 2. Basic Alignment
Map your FASTQ files to the generated index.
```bash
STAR --runThreadN 8 \
     --genomeDir ./genome_index \
     --readFilesIn read1.fq read2.fq \
     --outFileNamePrefix ./results/sample1_ \
     --outSAMtype BAM SortedByCoordinate
```

## Expert Tips and Best Practices

### Hardware Requirements
*   **RAM**: STAR is memory-intensive. For mammalian genomes (e.g., Human or Mouse), you typically need at least 32GB of RAM.
*   **Multithreading**: Always use `--runThreadN` to match your available CPU cores to significantly decrease processing time.

### Two-Pass Mapping
For better detection of novel splice junctions, use the 2-pass mode. This is highly recommended for most RNA-seq pipelines.
```bash
STAR --genomeDir ./genome_index \
     --readFilesIn read1.fq read2.fq \
     --twopassMode Basic \
     --outSAMtype BAM SortedByCoordinate
```

### Handling Compressed Files
If your FASTQ files are gzipped, you must specify the decompression command:
```bash
STAR --readFilesIn read1.fq.gz read2.fq.gz \
     --readFilesCommand zcat \
     ...
```

### Single-Cell RNA-seq (STARsolo)
STAR includes a specialized "Solo" mode for processing single-cell data (e.g., 10x Genomics).
```bash
STAR --genomeDir ./genome_index \
     --readFilesIn cdna_read.fq.gz barcode_read.fq.gz \
     --readFilesCommand zcat \
     --soloType CB_UMI_Simple \
     --soloCBwhitelist /path/to/10x_whitelist.txt \
     --soloCBmatchWLtype 1MM_multi_Nbase_pseudocounts
```

### Common Output Parameters
*   **--outSAMattributes**: Use `NH HI AS nM MD` for standard compatibility.
*   **--outSAMattrRGline**: Use this to add Read Group information required by downstream tools like GATK.
    *   Example: `--outSAMattrRGline ID:sample1 LB:library1 PL:ILLUMINA SM:sample1`

## Reference documentation
- [STAR GitHub Repository](./references/github_com_alexdobin_STAR.md)
- [Bioconda STAR Overview](./references/anaconda_org_channels_bioconda_packages_star_overview.md)
- [STAR Wiki and FAQ](./references/github_com_alexdobin_STAR_wiki.md)