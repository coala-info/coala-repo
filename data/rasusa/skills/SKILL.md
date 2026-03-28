---
name: rasusa
description: Rasusa stochastically downsamples genomic sequencing reads or alignments to a target coverage, fraction, or number of bases. Use when user asks to subsample FASTQ or BAM files, normalize datasets to a specific depth of coverage, or reduce the size of genomic data for assembly and benchmarking.
homepage: https://github.com/mbhall88/rasusa
---

# rasusa

## Overview
Rasusa is a high-performance tool designed for the stochastic downsampling of genomic data. Unlike simple line-counting methods, rasusa can calculate the required number of reads to achieve a target depth of coverage based on a provided genome size. It supports single-end and paired-end reads, as well as aligned sequence data, making it an essential utility for normalizing datasets, benchmarking bioinformatic pipelines, or reducing computational load for assembly and variant calling.

## Core Workflows

### Subsampling Reads (FASTQ/FASTA)
Use the `reads` subcommand to process raw sequencing files.

*   **By Coverage**: Subsample to 30x coverage for a 4.6Mb genome.
    `rasusa reads --coverage 30 --genome-size 4.6mb input.fastq.gz --output output.fastq.gz`
*   **Paired-end Reads**: Ensure both R1 and R2 are provided. Note that `--output` must be specified for each input.
    `rasusa reads -c 50 -g 5mb r1.fq r2.fq --output out.r1.fq --output out.r2.fq`
*   **By Fraction**: Keep 10% of the reads.
    `rasusa reads --frac 0.1 input.fq -o output.fq`
*   **By Absolute Number**: Keep exactly 1,000,000 bases.
    `rasusa reads --bases 1m input.fq -o output.fq`

### Subsampling Alignments (BAM/SAM/CRAM)
Use the `aln` subcommand for mapped data. This uses a sweep-line algorithm for efficient downsampling.

*   **Target Coverage**: `rasusa aln --coverage 20 input.bam -o output.bam`
*   **Strict Mode**: Use `--strict` to trigger an error if the input file has less coverage than the requested target.

## Expert Tips and Best Practices

*   **Genome Size Formats**: The `--genome-size` (or `-g`) flag accepts human-readable strings like `4.6mb`, `1gb`, or a path to a FASTA index (`.fai`) file. If a `.fai` is provided, rasusa automatically sums the lengths of all contigs.
*   **Reproducibility**: Always provide a seed with `--seed <INT>` to ensure the same reads are selected across different runs. If no seed is provided, rasusa logs the random seed used; check the logs to retrieve it for future replication.
*   **Compression**: Rasusa automatically detects output compression based on the file extension (`.gz`, `.bz2`, `.xz`, `.zst`). You can manually set the compression level using `-l <1-9>`.
*   **Performance**: For large FASTQ files, rasusa is significantly faster than many alternatives because it uses the `needletail` parser and a two-pass approach (first pass to calculate read lengths, second to stream selected reads).
*   **Validation**: If you are unsure of the input coverage, rasusa logs the calculated input coverage before it begins the downsampling process.



## Subcommands

| Command | Description |
|---------|-------------|
| rasusa aln | Randomly subsample alignments to a specified depth of coverage |
| rasusa_cite | Rasusa: Randomly subsample sequencing reads to a specified coverage |
| rasusa_reads | Randomly subsample reads |

## Reference documentation
- [Rasusa README](./references/github_com_mbhall88_rasusa_blob_main_README.md)
- [Rasusa Changelog](./references/github_com_mbhall88_rasusa_blob_main_CHANGELOG.md)
- [JOSS Paper: Rasusa](./references/joss_theoj_org_papers_10.21105_joss.03941.md)