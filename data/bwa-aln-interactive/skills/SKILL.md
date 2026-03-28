---
name: bwa-aln-interactive
description: This tool maps DNA sequences to a reference genome using the Burrows-Wheeler Transform. Use when user asks to index a reference genome, align short or long reads using BWA-MEM, BWA-backtrack, or BWA-SW algorithms, and handle specific sequencing technologies like PacBio or Oxford Nanopore.
homepage: https://github.com/fulcrumgenomics/bwa-aln-interactive
---

# bwa-aln-interactive

## Overview
The `bwa-aln-interactive` tool is a specialized distribution of the BWA suite, optimized for high-performance genomic alignment. It excels at mapping DNA sequences to a reference genome using the Burrows-Wheeler Transform. This skill provides guidance on indexing reference genomes and executing the three primary alignment algorithms: BWA-MEM (recommended for most modern high-throughput sequencing), BWA-backtrack (for short reads <100bp), and BWA-SW (for long reads or high-error rates).

## Core Workflows

### 1. Reference Indexing
Before alignment, the reference FASTA must be indexed.
```bash
bwa index [-a bwtsw|is] ref.fa
```
*   **-a bwtsw**: Required for large genomes (e.g., Human).
*   **-a is**: Suitable for small genomes (faster construction, but higher memory).

### 2. BWA-MEM (Recommended)
Best for 70bp to 1Mbp reads. It is robust to sequencing errors and supports split alignments.
```bash
bwa mem -t [threads] -R [read_group] ref.fa reads.fq > aln.sam
```
*   **Paired-end**: `bwa mem ref.fa read1.fq read2.fq > aln.sam`
*   **Interleaved**: Use `-p` if read1 and read2 are in the same file.

### 3. BWA-backtrack (Short Reads)
Used for reads shorter than 100bp. This is a two-step process.
```bash
# Step 1: Generate .sai files
bwa aln ref.fa read1.fq > read1.sai
bwa aln ref.fa read2.fq > read2.sai

# Step 2: Convert to SAM (Paired-end)
bwa sampe ref.fa read1.sai read2.sai read1.fq read2.fq > aln.sam

# Step 2: Convert to SAM (Single-end)
bwa samse ref.fa read1.sai read1.fq > aln.sam
```

## Expert Tips and Patterns

### Handling ALT Contigs (GRCh38)
When using GRCh38 with ALT contigs, BWA-MEM can map to the primary assembly while considering ALT sequences.
*   Ensure the `.alt` file is present in the same directory as the reference.
*   Use the `bwakit` wrapper for automated post-processing of ALT mappings.

### Algorithm Selection by Data Type
Use the `-x` flag in `bwa mem` to apply pre-set parameters for specific technologies:
*   **PacBio**: `bwa mem -x pacbio ref.fa reads.fq`
*   **Oxford Nanopore**: `bwa mem -x ont2d ref.fa reads.fq`
*   **Sanger/Capillary**: `bwa mem -x intract ref.fa reads.fq`

### Performance Tuning
*   **Threads**: Always specify `-t` to match available CPU cores.
*   **Memory**: BWA-MEM typically requires ~5GB of RAM for a human genome index.
*   **Piping**: To save disk space and time, pipe SAM output directly to Samtools for BAM conversion:
    ```bash
    bwa mem -t 8 ref.fa reads.fq | samtools view -Sb - > aln.bam
    ```

### Specific Tags
This version supports the **XB** tag to output alignment scores and mapping quality directly in the SAM record, which is useful for downstream filtering and interactive analysis.



## Subcommands

| Command | Description |
|---------|-------------|
| bwa aln | Align sequences using BWA (Burrows-Wheeler Aligner) aln algorithm. |
| bwa bwasw | BWA-SW algorithm for long-read alignment |
| bwa bwt2sa | Generate suffix array (SA) from BWT |
| bwa bwtupdate | Update or regenerate the BWT (Burrows-Wheeler Transform) file. |
| bwa fa2pac | Convert FASTA to PAC format for BWA indexing |
| bwa fastmap | Fastmap identifies Super Maximal Exact Matches (SMEMs) in sequences using a BWA index. |
| bwa index | Index database sequences in the FASTA format |
| bwa mem | Burrows-Wheeler Alignment Tool, MEM algorithm for long-read alignment |
| bwa pac2bwt | Convert a PAC file to a BWT file. |
| bwa pemerge | Merge paired-end reads |
| bwa sampe | Generate alignments in the SAM format given single-end alignments for paired-end reads. |
| bwa samse | Generate alignments in the SAM format for single-end reads |
| bwa shm | Manage BWA indices in shared memory |
| bwtgen | Generate a BWT (Burrows-Wheeler Transform) from a PAC file. |

## Reference documentation
- [BWA NEWS and Release Notes](./references/github_com_fulcrumgenomics_bwa-aln-interactive_blob_main_NEWS.md)
- [BWA Makefile and Build Configuration](./references/github_com_fulcrumgenomics_bwa-aln-interactive_blob_main_Makefile.md)
- [BWA ALT Mapping README](./references/github_com_fulcrumgenomics_bwa-aln-interactive_blob_main_README-alt.md)