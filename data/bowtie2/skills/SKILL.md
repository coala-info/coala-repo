---
name: bowtie2
description: "Bowtie 2 is an ultrafast and memory-efficient tool for aligning sequencing reads to long reference sequences. Use when user asks to build a genome index, align single-end or paired-end reads, perform local or end-to-end alignment, or optimize alignment performance for large datasets."
homepage: https://bowtie-bio.sourceforge.net/bowtie2/index.shtml
---

# bowtie2

## Overview
Bowtie 2 is a cornerstone tool in computational biology for the ultrafast and memory-efficient alignment of sequencing reads. It utilizes an FM Index based on the Burrows-Wheeler Transform to maintain a small memory footprint (approximately 3.2 GB for the human genome). This skill enables the configuration of alignment modes—including gapped, local, and paired-end—and provides guidance on indexing reference sequences and optimizing performance through multithreading and hardware-specific instructions like AVX2.

## Core CLI Patterns

### 1. Building a Genome Index
Before alignment, you must index the reference FASTA file.
```bash
bowtie2-build [options] <reference_in.fasta> <index_base_name>
```
*   **Large Genomes**: For references > 4GB, `bowtie2-build` automatically builds a "large" index (.bt2l).
*   **Speed**: Use `--threads <int>` to parallelize index construction.
*   **Compression**: Recent versions support Zstd-compressed reference files directly.

### 2. Basic Read Alignment
Aligning unpaired (single-end) or paired-end reads to a pre-built index.

**Single-end:**
```bash
bowtie2 -x <index_base> -U <reads.fastq> -S <output.sam>
```

**Paired-end:**
```bash
bowtie2 -x <index_base> -1 <mates_1.fastq> -2 <mates_2.fastq> -S <output.sam>
```

### 3. Alignment Modes
*   **End-to-end (Default)**: Requires the entire read to align.
    *   `--very-fast`, `--fast`, `--sensitive`, `--very-sensitive` (Presets for speed vs. sensitivity).
*   **Local**: Allows "soft-clipping" of read ends to find the best alignment.
    *   `--local` (Use this for reads with adapter contamination or low-quality ends).
    *   Presets: `--very-fast-local`, `--very-sensitive-local`.

## Expert Tips and Best Practices

### Performance Optimization
*   **Multithreading**: Always use `-p <threads>` to utilize multiple CPU cores.
*   **Hardware Acceleration**: On x86_64 systems, Bowtie 2 utilizes AVX2 instructions. Ensure your environment supports these for maximum throughput.
*   **Input Handling**: Bowtie 2 supports wildcards (e.g., `-q *.fq`) and direct processing of compressed files (Gzip, Zstd).

### Reporting and Sensitivity
*   **Deterministic Mode**: Use `-d` (or `--deterministic-mode`) in newer versions (v2.5.5+) to ensure that reporting for `-k` or `-a` options is consistent across runs while maintaining high speed.
*   **Multiple Alignments**:
    *   `-k <int>`: Report up to N alignments per read.
    *   `-a`: Report all valid alignments (can be very slow and produce massive SAM files).
*   **MAPQ Calculation**: Note that Bowtie 2 assigns a MAPQ of 255 to supplementary alignments when using `-k` or `-a`.

### SAM Output Management
*   **Preserve Tags**: Use `--preserve-tags` when aligning BAM files to keep original metadata.
*   **Comments**: Use `--sam-append-comment` to include FASTA/Q comments in the SAM record.
*   **Memory Management**: If aligning very large BAM files, monitor memory usage; versions prior to v2.5.4 had known memory leaks during BAM parsing.

## Index Inspection
To extract information or the original reference sequence from an index:
```bash
bowtie2-inspect <index_base>
```
*   Use `-s` to see summary information about the index.
*   Use `-o <file>` to save the reconstructed FASTA to a specific file.



## Subcommands

| Command | Description |
|---------|-------------|
| bowtie2 | An ultrafast and memory-efficient tool for aligning sequencing reads to long reference sequences. |
| bowtie2-build | Builds a Bowtie 2 index from a set of DNA sequences. |

## Reference documentation
- [Bowtie 2 Home](./references/bowtie-bio_sourceforge_net_bowtie2_index.shtml.md)
- [Bowtie 2 Wiki](./references/github_com_BenLangmead_bowtie2_wiki.md)
- [Bioconda Bowtie2 Package](./references/anaconda_org_channels_bioconda_packages_bowtie2_overview.md)