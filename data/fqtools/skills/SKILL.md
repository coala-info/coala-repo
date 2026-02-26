---
name: fqtools
description: fqtools is a high-performance software suite designed for the efficient processing, manipulation, and validation of FASTQ files. Use when user asks to count reads, validate file integrity, identify quality encoding, convert FASTQ to FASTA, trim sequences, or extract specific read components.
homepage: https://github.com/alastair-droop/fqtools
---


# fqtools

## Overview

`fqtools` is a high-performance software suite written in C, designed for the efficient processing of FASTQ files. It provides a modular set of subcommands to handle common sequence manipulation tasks without the overhead of larger bioinformatics frameworks. The tool is particularly adept at handling compressed data (.gz) and unaligned BAM files, supporting both single-end and paired-end data structures, including interleaved formats.

## Common CLI Patterns

### Basic File Inspection
*   **Count reads**: `fqtools count input.fastq.gz`
*   **View first few reads**: `fqtools head input.fastq.gz`
*   **Validate file integrity**: `fqtools validate input.fastq.gz`
*   **Identify quality encoding**: `fqtools type input.fastq.gz` (Detects Sanger, Solexa, or Illumina encodings).

### Data Transformation
*   **Convert to FASTA**: `fqtools fasta input.fastq.gz > output.fasta`
*   **Trim reads**: `fqtools trim -l [length] input.fastq.gz`
*   **Extract specific components**:
    *   Headers only: `fqtools header input.fastq.gz`
    *   Sequences only: `fqtools sequence input.fastq.gz`
    *   Quality scores only: `fqtools quality input.fastq.gz`

### Working with Paired-End Data
`fqtools` natively supports paired files. Most subcommands accept two input files:
*   **Count paired reads**: `fqtools count read1.fq.gz read2.fq.gz`
*   **Process interleaved files**: Use the `-i` flag for input and `-I` for output.
    *   `fqtools view -i interleaved.fq`

### Advanced Filtering and Tabulation
*   **Find sequences**: Search for specific motifs within reads.
    *   `fqtools find -s ATGC input.fastq.gz`
*   **Base frequencies**: Generate a table of nucleotide distributions.
    *   `fqtools basetab input.fastq.gz`
*   **Quality distribution**: Tabulate quality character frequencies.
    *   `fqtools qualtab input.fastq.gz`

## Expert Tips and Best Practices

### Handling Formats and Compression
*   **Auto-inference**: By default, `fqtools` attempts to infer the file format from the extension. If using non-standard extensions or piping from `stdin`, explicitly set the format using `-f`.
    *   `F`: Uncompressed FASTQ
    *   `f`: Compressed FASTQ (.gz)
    *   `b`: Unaligned BAM
*   **Standard Input**: When reading from a pipe, specify the format: `cat data.fq | fqtools count -f F`.

### Performance Tuning
*   **Buffer Sizes**: For high-throughput environments, you can tune the input (`-b`) and output (`-B`) buffer sizes. Suffixes like `k`, `M`, or `G` are supported (e.g., `-b 1M`).
*   **Character Sets**: By default, `fqtools` is strict. Use global flags to allow specific character sets if your data contains them:
    *   `-d`: DNA (ACGTN)
    *   `-r`: RNA (ACGUN)
    *   `-a`: Ambiguous bases (RYKMSWBDHV)
    *   `-m`: Masked bases (X)

### Quality Score Mapping
If you need to migrate quality scores between encodings (e.g., converting old Illumina data to Sanger), use the `qualmap` subcommand with a mapping file to translate values deterministically.

## Reference documentation
- [fqtools: An efficient FASTQ manipulation suite](./references/github_com_alastair-droop_fqtools.md)