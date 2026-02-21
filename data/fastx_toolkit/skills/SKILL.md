---
name: fastx_toolkit
description: The FASTX-Toolkit is a collection of command-line utilities designed for the preprocessing of short-read sequencing data.
homepage: https://github.com/agordon/fastx_toolkit
---

# fastx_toolkit

## Overview

The FASTX-Toolkit is a collection of command-line utilities designed for the preprocessing of short-read sequencing data. It is primarily used to clean and prepare raw data (FASTA/FASTQ) before downstream analysis like genome mapping or assembly. While the software is unmaintained, it remains a standard for lightweight, single-end sequence manipulation tasks such as removing adapters, filtering by quality scores, and extracting specific sub-sequences.

## Common CLI Patterns

### Quality Control and Filtering
*   **Generate Statistics**: Use `fastx_quality_stats` to produce a text file of quality metrics.
    `fastx_quality_stats -i input.fastq -o output_stats.txt`
*   **Filter by Quality**: Remove reads that do not meet a minimum quality threshold.
    `fastq_quality_filter -q 20 -p 80 -i input.fastq -o filtered.fastq`
    *   `-q`: Minimum quality score to keep.
    *   `-p`: Minimum percentage of bases that must have `-q` quality.

### Sequence Manipulation
*   **Trimming**: Extract a specific range of bases (e.g., removing a fixed-length barcode from the start).
    `fastx_trimmer -f 1 -l 50 -i input.fastq -o trimmed.fastq`
    *   `-f`: First base to keep (1-based).
    *   `-l`: Last base to keep.
*   **Clipping Adapters**: Remove known adapter sequences.
    `fastx_clipper -a ATCGTAG -i input.fastq -o clipped.fastq`
    *   `-v`: Verbose mode (reports number of clipped sequences).
    *   `-M`: Minimum alignment length.
*   **Reverse Complement**: Generate the reverse complement of sequences.
    `fastx_reverse_complement -i input.fasta -o rc_input.fasta`

### Format and Organization
*   **FASTQ to FASTA**: Convert formats while stripping quality data.
    `fastq_to_fasta -i input.fastq -o output.fasta`
*   **Barcode Splitting**: Separate a multiplexed file into individual samples based on a barcode file.
    `cat input.fastq | fastx_barcode_splitter.pl --bcfile barcodes.txt --prefix ProjectA_ --suffix .fastq`
*   **Collapsing**: Merge identical sequences into a single entry with a count header.
    `fastx_collapser -i input.fasta -o collapsed.fasta`

## Expert Tips

*   **Piping for Efficiency**: Most tools in the toolkit support standard input and output. Chain commands to avoid creating massive intermediate files:
    `fastq_to_fasta -i reads.fastq | fastx_trimmer -f 5 | fastx_reverse_complement > processed.fasta`
*   **Compressed Files**: The native tools do not always support GZIP input directly. Use `zcat` to pipe data into the tools:
    `zcat reads.fastq.gz | fastq_quality_filter -q 20 -p 80 -o filtered.fastq`
*   **Paired-End Data**: FASTX-Toolkit was designed primarily for single-end reads. When processing paired-end data, ensure that filtering or clipping does not "desynchronize" the forward and reverse files (i.e., removing a read from R1 but not R2). For paired-end filtering, modern alternatives like `fastp` are often preferred.
*   **Quality Score Encoding**: If you encounter errors regarding quality scores, use `fastq_quality_converter` to ensure your data is in the expected Sanger/Illumina 1.8+ format (Phred+33).

## Reference documentation
- [FASTX-Toolkit README](./references/github_com_agordon_fastx_toolkit.md)