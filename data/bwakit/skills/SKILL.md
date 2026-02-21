---
name: bwakit
description: The `bwakit` skill provides a streamlined interface for the Burrows-Wheeler Aligner (BWA) ecosystem.
homepage: https://github.com/lh3/bwa/tree/master/bwakit
---

# bwakit

## Overview
The `bwakit` skill provides a streamlined interface for the Burrows-Wheeler Aligner (BWA) ecosystem. It transforms raw sequencing data into mapped alignments by leveraging three core algorithms: BWA-backtrack (optimized for short reads <100bp), BWA-SW, and the industry-standard BWA-MEM (recommended for reads >70bp). Beyond simple alignment, this skill assists in managing complex genomic features like ALT contigs in GRCh38 and provides the necessary logic for handling paired-end vs. single-end data across various sequencing platforms (Illumina, IonTorrent, PacBio, and Oxford Nanopore).

## Core Workflows

### 1. Reference Indexing
Before any alignment, you must construct the FM-index for your reference genome.
```bash
bwa index ref.fa
```

### 2. Choosing the Right Algorithm
*   **BWA-MEM (Recommended):** Use for Illumina/454/IonTorrent reads >70bp, PacBio, or Nanopore reads. It is faster, more accurate, and supports chimeric alignments.
*   **BWA-backtrack:** Use only for short Illumina reads (<70bp).

### 3. Common Alignment Patterns

**Standard Paired-End Mapping (BWA-MEM)**
```bash
bwa mem ref.fa read1.fq read2.fq > aln-pe.sam
```

**Standard Single-End Mapping (BWA-MEM)**
```bash
bwa mem ref.fa reads.fq > aln-se.sam
```

**Short Reads (<70bp) using BWA-backtrack**
```bash
# Generate intermediate .sai files
bwa aln ref.fa read1.fq > read1.sai
bwa aln ref.fa read2.fq > read2.sai

# Convert to SAM (Paired-end)
bwa sampe ref.fa read1.sai read2.sai read1.fq read2.fq > aln-pe.sam
```

**Long-Read Sequencing (PacBio/Nanopore)**
Use specific mode flags to adjust for higher error rates:
*   **PacBio:** `bwa mem -x pacbio ref.fa reads.fq > aln.sam`
*   **Oxford Nanopore:** `bwa mem -x ont2d ref.fa reads.fq > aln.sam`

## Expert Tips & Best Practices
*   **Piping to BAM:** To save disk space and time, pipe SAM output directly to samtools for BAM conversion:
    `bwa mem ref.fa r1.fq r2.fq | samtools view -Sb - > aln.bam`
*   **ALT Contigs:** If working with GRCh38, use the `run-genotyper` script included in bwakit to properly handle alignments to ALT contigs, which prevents false-positive variants.
*   **Memory Usage:** BWA-MEM is memory-intensive. Ensure your environment has at least 5GB of RAM for a human genome index; more is required for multi-threading.
*   **Multi-threading:** Use the `-t` flag to specify the number of CPU cores:
    `bwa mem -t 8 ref.fa r1.fq r2.fq > aln.sam`

## Reference documentation
- [BWA Main Repository](./references/github_com_lh3_bwa.md)
- [BWAkit Overview](./references/anaconda_org_channels_bioconda_packages_bwakit_overview.md)