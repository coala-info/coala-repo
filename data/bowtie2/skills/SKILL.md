---
name: bowtie2
description: Builds a Bowtie 2 index from a set of DNA sequences.
homepage: https://bowtie-bio.sourceforge.net/bowtie2/index.shtml
---

# bowtie2

## Overview
Bowtie 2 is an industry-standard tool for mapping sequencing reads (typically 50 to 1,000+ bp) to large reference genomes. It utilizes an FM Index based on the Burrows-Wheeler Transform to maintain a low memory footprint (approx. 3.2 GB for the human genome). It is highly versatile, supporting various alignment modes including end-to-end and local alignment, as well as paired-end and unpaired read inputs.

## Core Workflow

### 1. Indexing the Reference
Before alignment, you must create a set of index files from your reference FASTA.
```bash
bowtie2-build reference.fasta genome_index_base
```
*   **Tip**: For very large genomes, `bowtie2-build` automatically switches to a "large" index format (.bt2l).

### 2. Basic Alignment Patterns
Aligning reads to the generated index:

**Unpaired Reads (Single-end):**
```bash
bowtie2 -x genome_index_base -U reads.fastq -S output.sam
```

**Paired-end Reads:**
```bash
bowtie2 -x genome_index_base -1 reads_1.fastq -2 reads_2.fastq -S output.sam
```

**Using Compressed Inputs:**
Bowtie 2 natively supports `.gz` and `.zst` files.
```bash
bowtie2 -x genome_index_base -U reads.fastq.gz -S output.sam
```

### 3. Performance and Presets
Bowtie 2 provides "presets" that balance speed, sensitivity, and accuracy. These are shortcuts for multiple internal parameters.

*   **End-to-end (Default)**: `--very-fast`, `--fast`, `--sensitive`, `--very-sensitive`
*   **Local Alignment**: `--very-fast-local`, `--fast-local`, `--sensitive-local`, `--very-sensitive-local`

**Multithreading:**
Always use the `-p` flag to specify the number of CPU cores to accelerate alignment.
```bash
bowtie2 -p 8 -x genome_index_base -U reads.fq -S output.sam
```

## Expert Tips and Best Practices

*   **Local vs. End-to-end**: Use `--local` if your reads might contain adapter sequences at the ends or if you expect significant structural variation. In local mode, Bowtie 2 "trims" the ends of the read to maximize the alignment score.
*   **Reporting Multiple Alignments**: 
    *   By default, Bowtie 2 finds the best alignment.
    *   Use `-k <int>` to report up to N alignments.
    *   Use `-a` to report all possible alignments (can be very slow and produce massive SAM files).
*   **Memory Management**: If you are working on a system with limited RAM, Bowtie 2 is generally more efficient than BWA-MEM for large genomes.
*   **SAM Output**: To save disk space, pipe the output directly to `samtools` to create a compressed BAM file:
    ```bash
    bowtie2 -x index -U reads.fq | samtools view -bS - > output.bam
    ```
*   **Discordant Pairs**: For paired-end data, Bowtie 2 looks for "concordant" alignments (mates facing each other at the expected distance). Use `--no-discordant` or `--no-mixed` to suppress specific types of non-standard mappings if your downstream pipeline requires strict pairing.

## Reference documentation
- [Bowtie 2: fast and sensitive read alignment](./references/bowtie-bio_sourceforge_net_bowtie2_index.shtml.md)
- [bowtie2 - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_bowtie2_overview.md)