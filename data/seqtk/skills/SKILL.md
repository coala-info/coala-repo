---
name: seqtk
description: The `seqtk` skill provides a streamlined interface for high-performance sequence manipulation.
homepage: https://github.com/lh3/seqtk
---

# seqtk

## Overview
The `seqtk` skill provides a streamlined interface for high-performance sequence manipulation. It is particularly effective for handling large, gzipped genomic data files without the overhead of heavy bioinformatics libraries. Use this skill to perform common pre-processing tasks such as quality filtering, format conversion (FASTQ to FASTA), and random subsampling of read pairs for pilot studies or normalization.

## Core CLI Patterns

### Sequence Conversion and Transformation
The `seq` command is the most versatile tool in the kit for general transformations.

*   **FASTQ to FASTA**: Convert formats while optionally handling compression.
    `seqtk seq -a in.fq.gz > out.fa`
*   **Reverse Complement**: Generate the reverse complement of sequences.
    `seqtk seq -r in.fq > out.fq`
*   **Line Folding**: Reformat FASTA files to have a specific line length (e.g., 60 bp) and remove comments.
    `seqtk seq -Cl60 in.fa > out.fa`
*   **Standardize FASTQ**: Convert multi-line FASTQ files into the standard 4-line format.
    `seqtk seq -l0 in.fq > out.fq`

### Quality Control and Masking
*   **Quality Masking**: Mask bases with quality scores lower than a threshold (e.g., 20) to lowercase or 'N'.
    `seqtk seq -aQ64 -q20 in.fq > out.fa` (to lowercase)
    `seqtk seq -aQ64 -q20 -n N in.fq > out.fa` (to N)
*   **Region Masking**: Use a BED file to mask specific genomic regions to lowercase.
    `seqtk seq -M reg.bed in.fa > out.fa`

### Subsetting and Sampling
*   **Subsampling**: Extract a specific number of random sequences. Always use the same seed (`-s`) when processing paired-end reads to maintain pairing.
    `seqtk sample -s100 read1.fq 10000 > sub1.fq`
    `seqtk sample -s100 read2.fq 10000 > sub2.fq`
*   **Extract by Name**: Pull specific sequences listed in a text file (one name per line).
    `seqtk subseq in.fq name.lst > out.fq`
*   **Extract by Region**: Pull sequences defined in a BED file.
    `seqtk subseq in.fa reg.bed > out.fa`

### Trimming
*   **Adaptive Trimming**: Trim low-quality bases from both ends using the Phred algorithm.
    `seqtk trimfq in.fq > out.fq`
*   **Fixed Trimming**: Remove a specific number of bases from the beginning (`-b`) or end (`-e`) of reads.
    `seqtk trimfq -b 5 -e 10 in.fa > out.fa`

### Specialized Analysis
*   **Telomere Identification**: Find (TTAGGG)n repeats in a genome assembly.
    `seqtk telo seq.fa > telo.bed 2> telo.count`

## Expert Tips
*   **Piping**: `seqtk` is designed for Unix pipes. You can chain commands to avoid creating intermediate files, e.g., `seqtk seq -r in.fq | seqtk trimfq - > processed.fq`.
*   **Gzip Support**: `seqtk` natively detects and handles gzipped input, so there is no need to `zcat` files into the tool.
*   **Random Seeds**: When subsampling, the `-s` parameter is critical. If you don't provide it, the tool may use a time-based seed, making results non-reproducible and breaking paired-end synchronization.

## Reference documentation
- [Seqtk GitHub Repository](./references/github_com_lh3_seqtk.md)