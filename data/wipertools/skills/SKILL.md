---
name: wipertools
description: wipertools is a utility suite designed to sanitize malformed FASTQ files, synchronize paired-end reads, and recover data from corrupted GZIP archives. Use when user asks to fix malformed FASTQ lines, synchronize desynchronized R1 and R2 files, or salvage reads from broken GZIP streams.
homepage: https://github.com/mazzalab/fastqwiper
---


# wipertools

## Overview
wipertools is a specialized utility suite designed to sanitize "dirty" sequencing data. It acts as a pre-processing guardrail for bioinformatics pipelines, specifically targeting issues that standard aligners or quality control tools cannot handle. Use this skill to fix malformed FASTQ lines, recover data from broken GZIP streams, and ensure that paired-end R1 and R2 files are perfectly synchronized by removing orphaned reads.

## Core Functional Cases

### 1. Sanitizing Readable but Malformed FASTQ
Use this workflow when your FASTQ files can be opened and decompressed, but contain "pesky" lines—such as extra whitespace, non-compliant headers, or inconsistent line counts per record.
- **Goal**: Transform unformatted lines into a strictly compliant FASTQ format.
- **Trigger**: Downstream errors regarding FASTQ formatting or unexpected characters.

### 2. Synchronizing Paired-End Reads
Use this workflow when R1 and R2 files have become desynchronized (e.g., one file has more reads than the other or the order is mismatched).
- **Goal**: Drop unpaired reads and fix interleaving to ensure every read in R1 has a corresponding mate in R2.
- **Trigger**: Errors in aligners (like BWA or Bowtie2) reporting mismatched read IDs or unequal file lengths.

### 3. Recovering Corrupted GZIP Archives
Use this workflow when a `.fastq.gz` file is "unreadable"—meaning standard decompression tools like `gunzip` or `zcat` fail with CRC errors or unexpected End-Of-File (EOF) markers.
- **Goal**: Salvage healthy reads from the non-corrupted segments of the archive and reformat them into a new, valid GZIP file.
- **Trigger**: "Unexpected end of file" or "invalid compressed data" errors during decompression.

## CLI Usage Patterns

The primary command-line interface is accessed via `wipertools`.

- **Help and Discovery**:
  `wipertools --help`
  Use this to view the latest subcommands and available flags for scattering or gathering data.

- **Version Check**:
  `wipertools --version`
  Ensure you are running a compatible version (typically requires Python 3.10 to 3.12).

## Expert Tips and Best Practices

- **GZIP Validation**: Before processing, run `gunzip -t filename.fastq.gz`. If it returns an error, you must use the recovery workflow (Case 3) rather than standard cleaning.
- **Resource Management**: For very large datasets, look for "scatter" subcommands (like `fastq_scatter`) mentioned in the tool's internal documentation to split files for parallel processing.
- **OS Compatibility**: While the core `wipertools` CLI runs on Linux, Mac, and Windows, advanced Snakemake-based workflows within the suite are optimized for Linux/Docker environments.
- **Input Integrity**: Always maintain a backup of the original corrupted file, as the recovery process creates a new sanitized version rather than modifying the source in-place.



## Subcommands

| Command | Description |
|---------|-------------|
| fastqgather | Joins multiple FASTQ files into a single one. |
| fastqwiper | Wipes quality scores from a FASTQ file. |
| wipertools reportgather | Gathers multiple report files into a single final report. |
| wipertools_fastqscatter | Split a FASTQ file into multiple smaller files. |

## Reference documentation
- [FastqWiper README](./references/github_com_mazzalab_fastqwiper_blob_main_README.md)
- [Wipertools Overview](./references/anaconda_org_channels_bioconda_packages_wipertools_overview.md)