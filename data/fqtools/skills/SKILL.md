---
name: fqtools
description: fqtools is a high-performance C-based toolkit designed for the rapid processing, validation, and transformation of sequencing data. Use when user asks to validate FASTQ integrity, detect quality encoding, count reads, convert FASTQ to FASTA, trim reads, or process interleaved paired-end data.
homepage: https://github.com/alastair-droop/fqtools
---


# fqtools

## Overview

fqtools is a high-performance C-based toolkit designed for the rapid processing of sequencing data. It provides a modular set of subcommands to handle common FASTQ tasks with minimal overhead. It supports compressed (.gz) files, unaligned BAM files, and interleaved paired-end data. This tool is ideal for quick data inspection, quality control validation, and preparing sequences for downstream analysis.

## Common CLI Patterns

### File Inspection and Validation
* **Validate file integrity**: Check if a FASTQ file is properly formatted.
  `fqtools validate input.fastq.gz`
* **Detect quality encoding**: Automatically guess if a file uses Sanger, Solexa, or Illumina encoding.
  `fqtools type input.fastq.gz`
* **Count reads**: Quickly get the total number of reads in a file.
  `fqtools count input.fastq.gz`
* **Preview data**: View the first few reads (similar to the unix `head` command but FASTQ-aware).
  `fqtools head input.fastq.gz`

### Data Transformation
* **Convert to FASTA**: Transform FASTQ data into FASTA format.
  `fqtools fasta input.fastq.gz > output.fasta`
* **Trim reads**: Remove bases from the start or end of reads.
  `fqtools trim -5 10 -3 10 input.fastq.gz -o trimmed.fastq.gz`
* **Tabulate frequencies**: Generate tables of base or quality character frequencies.
  `fqtools basetab input.fastq.gz`
  `fqtools qualtab input.fastq.gz`

### Working with Paired-End Data
fqtools uses a specific pattern for paired files. The `%` character is used as a placeholder for the pair member (1 or 2).
* **Process pairs**:
  `fqtools count read_%.fastq.gz` (This will process read_1.fastq.gz and read_2.fastq.gz)
* **Interleaved files**: Use `-i` for interleaved input and `-I` for interleaved output.
  `fqtools view -i interleaved_input.fastq.gz`

### Advanced Filtering and Searching
* **Find sequences**: Search for reads containing specific sequences.
  `fqtools find -s GATCGGAAGAG input.fastq.gz`
* **Translate quality scores**: Use a mapping file to change quality values.
  `fqtools qualmap -m map_file.txt input.fastq.gz`

## Expert Tips

* **Standard Input/Output**: If no input file is specified, fqtools reads from `stdin`. When piping data into fqtools, always specify the input format using `-f` (e.g., `-f F` for uncompressed FASTQ, `-f f` for compressed).
* **Buffer Tuning**: For extremely large datasets, you can tune the input (`-b`) and output (`-B`) buffer sizes. Suffixes like `k`, `M`, or `G` are supported (e.g., `-b 1M`).
* **Sequence Constraints**: By default, fqtools is strict. Use global flags to allow specific characters:
    * `-a`: Allow ambiguous bases (RYKMSWBDHV).
    * `-m`: Allow masked bases (X).
    * `-l`/`-u`: Allow lowercase or uppercase bases.
* **BAM Support**: fqtools can read unaligned BAM files directly if built with `htslib`. Use `-f b` to specify BAM input.



## Subcommands

| Command | Description |
|---------|-------------|
| fqtools_basetab | Tabulate FASTQ base frequencies. |
| fqtools_count | Count FASTQ file reads. |
| fqtools_fasta | Convert FASTQ files to FASTA format. |
| fqtools_find | Find FASTQ reads containing specific sequences. |
| fqtools_head | View the first reads in FASTQ files. |
| fqtools_header | View FASTQ file header data. |
| fqtools_header2 | View FASTQ file secondary header data. |
| fqtools_lengthtab | Tabulate FASTQ read lengths. |
| fqtools_quality | View FASTQ file quality data. |
| fqtools_qualmap | Translate quality values using a mapping file. |
| fqtools_qualtab | Tabulate FASTQ quality character frequencies. |
| fqtools_sequence | View FASTQ file sequence data. |
| fqtools_trim | View FASTQ files. |
| fqtools_type | Attempt to guess the FASTQ quality encoding type. |
| fqtools_validate | Validate FASTQ file. |
| fqtools_view | View FASTQ files. |

## Reference documentation

- [fqtools README](./references/github_com_alastair-droop_fqtools_blob_master_README.md)