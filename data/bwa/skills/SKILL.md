---
name: bwa
description: BWA maps DNA sequences against a large reference genome using the Burrows-Wheeler transform. Use when user asks to index a reference genome, align short or long sequencing reads, or generate SAM files for downstream genomic analysis.
homepage: https://github.com/lh3/bwa
---


# bwa

## Overview

BWA (Burrows-Wheeler Aligner) is a software package for mapping DNA sequences against a large reference genome, such as the human genome. It consists of three main algorithms: BWA-backtrack (for short reads up to 100bp), BWA-SW (for longer reads with more errors), and BWA-MEM (the latest and generally recommended algorithm for high-quality queries). This skill provides the necessary command-line patterns to execute the full alignment workflow, from reference indexing to generating SAM files.

## Core Workflow

### 1. Indexing the Reference
Before alignment, the reference genome (FASTA format) must be indexed. This is a one-time operation per reference.

```bash
# Standard indexing
bwa index reference.fa

# For very large genomes (e.g., BLAST nt database), use a larger batch size
bwa index -b 1000000000 reference.fa
```

### 2. Aligning Reads with BWA-MEM
BWA-MEM is the preferred algorithm for 70bp-1Mbp reads. It is robust to sequencing errors and supports split alignments.

**Paired-end alignment:**
```bash
bwa mem -t 8 reference.fa read1.fq read2.fq > aligned.sam
```

**Single-end alignment:**
```bash
bwa mem -t 8 reference.fa reads.fq > aligned.sam
```

### 3. Handling Specific Data Types
BWA-MEM includes presets for different sequencing technologies using the `-x` flag:

*   **PacBio subreads:** `bwa mem -x pacbio reference.fa pb_reads.fq`
*   **Oxford Nanopore 2D reads:** `bwa mem -x ont2d reference.fa ont_reads.fq`
*   **Illumina linked-reads:** `bwa mem -p reference.fa interleaved.fq` (Use `-p` if the input is an interleaved FASTQ where adjacent reads form a pair).

## Expert Tips and Best Practices

### Performance Optimization
*   **Multi-threading:** Always use the `-t` option to specify the number of CPU cores. BWA-MEM scales well with threads.
*   **Piping to Samtools:** To save disk space and I/O time, pipe the SAM output directly to Samtools to create a compressed BAM file:
    ```bash
    bwa mem -t 8 reference.fa r1.fq r2.fq | samtools view -Sb - > aligned.bam
    ```

### Read Group Information
For downstream tools like GATK, you must add Read Group information during alignment:
```bash
bwa mem -t 8 -R '@RG\tID:foo\tSM:bar\tPL:ILLUMINA' reference.fa r1.fq r2.fq > aligned.sam
```

### Working with ALT Contigs
If using GRCh38 with ALT contigs, BWA-MEM handles them by mapping reads to the best location. For the best results with ALT contigs, use the `bwakit` wrapper or ensure your reference is formatted correctly with a `.alt` file.

### Alignment Scoring and Tags
*   **XB Tag:** In version 0.7.18+, BWA can output the XB tag to show alignment score and mapping quality.
*   **Hard Clipping:** Use `-H` in BWA-MEM to use hard clipping in the SAM output, which can reduce file size for long reads with many split alignments.
*   **Marking Shorter Splits:** Use `-M` to mark shorter split hits as secondary (for Picard/GATK compatibility).



## Subcommands

| Command | Description |
|---------|-------------|
| aln | Find the SA coordinates of the input reads |
| bwasw | BWA-SW alignment algorithm for long reads, supporting Smith-Waterman alignment and chimeric read detection. |
| bwt2sa | Generate suffix array from BWT |
| bwtgen | Generate a BWT from a PAC file |
| bwtupdate | Update the BWT (Burrows-Wheeler Transform) file. |
| fa2pac | Convert FASTA format to PAC format for BWA indexing |
| fastmap | Identify Super Maximal Exact Matches (SMEMs) in a sequence against a reference index. |
| index | Index database sequences in the FASTA format |
| mem | Burrows-Wheeler Alignment Tool, MEM algorithm for aligning low-divergence sequences against a large reference genome |
| pac2bwt | Generate BWT from a PAC file |
| pemerge | Merge paired-end reads from BWA |
| sampe | Generate alignments in the SAM format given paired-end reads. |
| samse | Generate alignments in the SAM format given single-end reads |
| shm | Manage BWA indices in shared memory |

## Reference documentation
- [BWA News and Version History](./references/github_com_lh3_bwa_blob_master_NEWS.md)
- [BWA Repository Overview](./references/github_com_lh3_bwa.md)
- [BWA Makefile and Build Configuration](./references/github_com_lh3_bwa_blob_master_Makefile.md)