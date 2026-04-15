---
name: fusioncatcher-seqtk
description: fusioncatcher-seqtk is a lightweight utility for manipulating, converting, and subsampling genomic sequence files in FASTA and FASTQ formats. Use when user asks to convert FASTQ to FASTA, reverse complement sequences, extract or exclude sequences by name or region, subsample reads, or perform quality-based and fixed-length trimming.
homepage: https://github.com/ndaniel/seqtk
metadata:
  docker_image: "quay.io/biocontainers/fusioncatcher-seqtk:1.2--h577a1d6_7"
---

# fusioncatcher-seqtk

## Overview

fusioncatcher-seqtk is a high-performance, lightweight utility designed for the rapid manipulation of genomic sequence files. As a modified version of the original seqtk, it provides essential functions for converting between FASTQ and FASTA, subsampling large datasets, and performing quality-based or coordinate-based trimming. This specific version includes unique enhancements—such as exclusion modes for sequence extraction and more granular trimming parameters—that are particularly useful when preparing raw sequencing data for downstream analysis in fusion gene detection or general bioinformatics pipelines.

## Common CLI Patterns

### Format Conversion and Transformation
*   **Convert FASTQ to FASTA**:
    `seqtk seq -a input.fastq.gz > output.fasta`
*   **Reverse Complement**:
    `seqtk seq -r input.fq > output.fq`
*   **Fold long lines**: Use `-l` to set the maximum line length (e.g., 60 characters).
    `seqtk seq -l 60 input.fa > output.fa`

### Sequence Extraction and Filtering
*   **Extract by Name**: Extract sequences listed in a text file (one name per line).
    `seqtk subseq input.fq name_list.lst > output.fq`
*   **Exclude by Name**: (Specific to this fork) Use `-e` to exclude sequences in the list.
    `seqtk subseq -e input.fq name_list.lst > output.fq`
*   **Extract by Region**: Extract sequences based on coordinates in a BED file.
    `seqtk subseq input.fa regions.bed > output.fa`

### Subsampling
*   **Random Subsampling**: Extract a specific number of reads.
    `seqtk sample -s100 input.fq 10000 > subsampled.fq`
*   **Paired-end Subsampling**: To keep read pairs synchronized, you **must** use the same random seed (`-s`).
    `seqtk sample -s42 read1.fq 50000 > sub1.fq`
    `seqtk sample -s42 read2.fq 50000 > sub2.fq`

### Quality and Length Trimming
*   **Phred-based Trimming**: Automatically trim low-quality ends using the Phred algorithm.
    `seqtk trimfq input.fq > trimmed.fq`
*   **Fixed-length Trimming**: Trim a specific number of bases from the left (`-b`) or right (`-e`) ends.
    `seqtk trimfq -b 5 -e 10 input.fq > trimmed.fq`
*   **Advanced Trimming**: (Specific to this fork) Use `-E` to keep a fixed length from the right end or `-s` to set a minimum length threshold after trimming.
    `seqtk trimfq -E 50 -s 20 input.fq > output.fq`

## Expert Tips

*   **Gzip Integration**: The tool natively supports gzipped input files. You do not need to decompress files before processing, which saves significant disk space and I/O time.
*   **Masking vs. Deleting**: Instead of removing low-quality reads, you can mask low-quality bases to lowercase using `-q` or to 'N' using `-n N` within the `seq` command.
*   **Memory Efficiency**: fusioncatcher-seqtk is extremely memory-efficient because it processes sequences as a stream. It is suitable for very large files that exceed available RAM.
*   **Seed Consistency**: When using `sample`, always provide a manual seed with `-s`. If you rely on the default (which may be based on time), you cannot reproduce the exact subset or maintain pairing between R1 and R2 files.

## Reference documentation
- [GitHub - ndaniel/seqtk: Toolkit for processing sequences in FASTA/Q formats](./references/github_com_ndaniel_seqtk.md)
- [fusioncatcher-seqtk - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_fusioncatcher-seqtk_overview.md)
- [Commits · ndaniel/seqtk](./references/github_com_ndaniel_seqtk_commits_master.md)