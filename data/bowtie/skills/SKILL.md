---
name: bowtie
description: Bowtie is an ultrafast, memory-efficient short read aligner designed to map DNA sequences to large genomes using a Burrows-Wheeler index. Use when user asks to build a reference index, align short DNA reads to a genome, or perform exact and low-mismatch sequence mapping.
homepage: https://github.com/BenLangmead/bowtie
---


# bowtie

## Overview

Bowtie is an ultrafast, memory-efficient short read aligner designed to map DNA sequences to large genomes. It utilizes a Burrows-Wheeler index based on the Full-text Minute-space (FM) index to maintain a small memory footprint (typically around 2.2 GB for the human genome). While Bowtie 2 is preferred for longer reads and gapped alignments, the original Bowtie remains a standard for very short reads where speed and exact or low-mismatch matching are prioritized.

## Installation

The recommended method for installation is via Bioconda:

```bash
conda install bioconda::bowtie
```

## Core Workflow

### 1. Building an Index
Before alignment, you must create a Burrows-Wheeler index from your reference FASTA files.

```bash
bowtie-build reference.fa index_base
```

### 2. Aligning Reads
Align reads to the generated index. By default, Bowtie outputs a proprietary format; use `-S` for standard SAM output.

**Single-end reads:**
```bash
bowtie -S index_base reads.fastq output.sam
```

**Paired-end reads:**
```bash
bowtie -S index_base -1 forward.fastq -2 reverse.fastq output.sam
```

## Common CLI Patterns and Flags

### Alignment Policy
*   `-v <int>`: Report alignments with at most V mismatches (ignores quality scores).
*   `-n <int>`: Maximum mismatches in the "seed" (first 28 bases by default).
*   `-e <int>`: Maximum permitted total of quality values at mismatched read positions.

### Reporting and Filtering
*   `-k <int>`: Report up to N valid alignments per read.
*   `-a`: Report all valid alignments per read (can be very slow and produce large files).
*   `-m <int>`: Suppress all alignments for a read if more than N reportable alignments exist (useful for ignoring repetitive regions).
*   `-M <int>`: Similar to `-m`, but if more than N alignments exist, it reports one at random.
*   `--best`: Guarantees that reported alignments are "best" in terms of stratum (mismatches) and quality.
*   `--strata`: When combined with `--best`, only reports alignments in the best stratum.

### Output Configuration
*   `-S` / `--sam`: Output in SAM format (highly recommended for compatibility with Samtools/Picard).
*   `--sam-RG <text>`: Add a specific Read Group (RG) tag to the SAM header and alignments.
*   `-t` / `--time`: Print the amount of time taken for various phases of the alignment.

## Expert Tips

*   **Read Length Matters**: Use Bowtie 1 for reads shorter than 50bp. For reads longer than 50bp or those requiring gapped alignments (indels), use Bowtie 2.
*   **Memory Efficiency**: Bowtie's index is extremely compact. If working on a machine with limited RAM, Bowtie is often more viable than hash-based aligners.
*   **Multithreading**: Use `-p <int>` to specify the number of threads. Bowtie scales well across multiple cores.
*   **Handling Multimappers**: In many short-read pipelines (like ChIP-seq), it is common practice to use `-m 1` to ensure only uniquely mapping reads are kept for downstream analysis.

## Reference documentation

- [bioconda | bowtie](./references/anaconda_org_channels_bioconda_packages_bowtie_overview.md)
- [BenLangmead/bowtie GitHub Repository](./references/github_com_BenLangmead_bowtie.md)
- [Bowtie Issues and Usage Questions](./references/github_com_BenLangmead_bowtie_issues.md)