---
name: bwa-aln-interactive
description: This tool maps DNA sequences against a large reference genome using the Burrows-Wheeler Aligner algorithms. Use when user asks to index a reference genome, align short reads using the backtrack algorithm, or map long reads using the MEM algorithm.
homepage: https://github.com/fulcrumgenomics/bwa-aln-interactive
---


# bwa-aln-interactive

## Overview
The `bwa-aln-interactive` tool is a specialized fork of the Burrows-Wheeler Aligner (BWA) designed for mapping DNA sequences against a large reference genome. It is particularly useful for bioinformatics workflows requiring the "backtrack" algorithm for short Illumina reads or the "MEM" algorithm for longer sequences. This version includes enhancements for interactive alignment and improved reporting of secondary alignments (XA tags).

## Core Workflows

### 1. Indexing the Reference
Before any alignment, you must construct the FM-index for your reference genome.
```bash
bwa index ref.fa
```

### 2. Aligning Short Reads (< 70bp)
For short reads, use the BWA-backtrack algorithm. This is a two-step process: generating `.sai` files and then converting them to SAM format.

**Single-End (SE):**
```bash
# Generate alignment coordinates
bwa aln ref.fa reads.fq > reads.sai

# Convert to SAM
bwa samse ref.fa reads.sai reads.fq > aln-se.sam
```

**Paired-End (PE):**
```bash
# Generate coordinates for each mate
bwa aln ref.fa read1.fq > read1.sai
bwa aln ref.fa read2.fq > read2.sai

# Convert to SAM
bwa sampe ref.fa read1.sai read2.sai read1.fq read2.fq > aln-pe.sam
```

### 3. Aligning Long Reads (> 70bp)
BWA-MEM is the recommended algorithm for high-quality sequences and is generally faster and more accurate than BWA-backtrack for reads 70bp–1Mbp.

**Standard MEM Alignment:**
```bash
# Single-end
bwa mem ref.fa reads.fq > aln.sam

# Paired-end
bwa mem ref.fa read1.fq read2.fq > aln.sam
```

**Long-Read Platforms:**
Use the `-x` flag to apply presets for specific technologies:
*   **PacBio:** `bwa mem -x pacbio ref.fa reads.fq > aln.sam`
*   **Oxford Nanopore:** `bwa mem -x ont2d ref.fa reads.fq > aln.sam`

## Expert Tips and Best Practices

*   **Interactive Mode:** This fork supports an interactive mode for `bwa aln`. When running without a query file, it can process sequences from stdin interactively.
*   **Enhanced XA Tags:** Use the `-D` flag to output the MD tag for each XA (alternative alignment) record. This is useful for downstream tools that need to verify the sequence of secondary hits without re-aligning.
*   **Piping to Compression:** To save disk space, pipe the SAM output directly to `gzip` or `samtools view`.
    ```bash
    bwa mem ref.fa read1.fq read2.fq | gzip -3 > aln.sam.gz
    ```
*   **Algorithm Selection:** 
    *   Use **BWA-MEM** for almost all modern Illumina data (100bp+), PacBio, and Nanopore.
    *   Use **BWA-backtrack (aln)** only for very short reads (<70bp) where sensitivity is critical.
*   **Memory Management:** For genomes larger than 4GB, ensure you are using a 64-bit system. BWA handles the human genome (~3GB) efficiently within standard memory limits.

## Reference documentation
- [BWA aln interactive: Burrow-Wheeler Aligner for pairwise alignment between DNA sequences](./references/github_com_fulcrumgenomics_bwa-aln-interactive.md)
- [bwa-aln-interactive - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_bwa-aln-interactive_overview.md)