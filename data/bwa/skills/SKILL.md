---
name: bwa
description: "BWA aligns low-divergent DNA sequences against a large reference genome using the Burrows-Wheeler transform. Use when user asks to index a reference genome, align short or long sequencing reads, or map reads from specific platforms like Illumina, PacBio, and Oxford Nanopore."
homepage: https://github.com/lh3/bwa
---


# bwa

## Overview
BWA (Burrows-Wheeler Aligner) is a foundational bioinformatics tool suite for aligning low-divergent sequences against a large reference genome. While it contains several algorithms, BWA-MEM is the industry standard for most modern applications due to its speed, accuracy, and versatility across different read lengths (70bp to several megabases). This skill provides the necessary command-line patterns to index genomes and execute alignments for various sequencing technologies.

## Core Workflows

### 1. Reference Indexing
Before any alignment can occur, you must construct an FM-index for the reference genome.
```bash
bwa index reference.fa
```

### 2. Alignment with BWA-MEM (Recommended)
BWA-MEM is the preferred algorithm for reads longer than 70bp. It supports paired-end reads, split alignments, and is robust against sequencing errors.

**Single-end reads:**
```bash
bwa mem reference.fa reads.fq > alignment.sam
```

**Paired-end reads:**
```bash
bwa mem reference.fa read1.fq read2.fq > alignment.sam
```

**Using multiple threads:**
Use the `-t` flag to speed up the process on multi-core systems.
```bash
bwa mem -t 8 reference.fa read1.fq read2.fq > alignment.sam
```

### 3. Specialized Read Types (BWA-MEM)
BWA-MEM includes presets for specific sequencing platforms using the `-x` flag:

*   **PacBio subreads:** `bwa mem -x pacbio reference.fa reads.fq > aln.sam`
*   **Oxford Nanopore reads:** `bwa mem -x ont2d reference.fa reads.fq > aln.sam`

### 4. Short Reads (< 70bp) with BWA-backtrack
For very short Illumina reads, the backtrack algorithm (aln/samse/sampe) may be more appropriate.

**Single-end short reads:**
```bash
bwa aln reference.fa reads.fq > reads.sai
bwa samse reference.fa reads.sai reads.fq > aln.sam
```

**Paired-end short reads:**
```bash
bwa aln reference.fa read1.fq > read1.sai
bwa aln reference.fa read2.fq > read2.sai
bwa sampe reference.fa read1.sai read2.sai read1.fq read2.fq > aln.sam
```

## Expert Tips and Best Practices

*   **Piping to Samtools:** To save disk space and time, pipe the SAM output directly to Samtools to create a compressed BAM file.
    ```bash
    bwa mem reference.fa read1.fq read2.fq | samse view -Sb - > alignment.bam
    ```
*   **Read Groups:** When preparing data for GATK or other downstream variant callers, always add Read Group information using the `-R` flag.
    ```bash
    bwa mem -R '@RG\tID:foo\tSM:bar\tLB:library1\tPL:ILLUMINA' reference.fa r1.fq r2.fq > aln.sam
    ```
*   **Marking Shorter Splits:** Use the `-M` flag for compatibility with older versions of Picard/GATK to mark shorter split hits as secondary.
*   **Memory Usage:** BWA-MEM typically requires ~5GB of RAM for a human genome index. Ensure the system has sufficient memory before starting the alignment.
*   **Alternative for Long Reads:** While BWA-MEM supports long reads, the developer (lh3) recommends `minimap2` for PacBio and Nanopore data as it is significantly faster and more accurate for those specific technologies.

## Reference documentation
- [BWA GitHub Repository](./references/github_com_lh3_bwa.md)
- [BWA Overview and Usage](./references/lh3_bwa.md)