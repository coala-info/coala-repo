---
name: pgrc
description: PgRC (Pseudogenome-based Read Compressor) is a high-performance, in-memory tool specifically designed to compress the DNA sequence data within FASTQ files.
homepage: https://github.com/kowallus/PgRC
---

# pgrc

## Overview

PgRC (Pseudogenome-based Read Compressor) is a high-performance, in-memory tool specifically designed to compress the DNA sequence data within FASTQ files. It operates by building an approximation of the shortest common superstring, effectively creating a "pseudogenome" from the reads to achieve high compression ratios. This skill provides the necessary command-line patterns for single-end and paired-end compression, order-preserving workflows, and decompression.

## Command Line Usage

The basic syntax for PgRC is:
`PgRC [-i <seqSrcFile> [<pairSrcFile>]] [-t <noOfThreads>] [-o] [-d] <archiveName>`

### Compression Patterns

**Single-End (SE) Compression**
To compress a single FASTQ file without preserving the original read order (highest efficiency):
```bash
PgRC -i input.fastq output.pgrc
```

**Paired-End (PE) Compression**
To compress paired-end reads:
```bash
PgRC -i input_R1.fastq input_R2.fastq output.pgrc
```

**Preserving Read Order**
By default, PgRC may reorder reads to optimize compression. If your downstream analysis requires the original sequence order, use the `-o` flag:
```bash
PgRC -o -i input.fastq output_ordered.pgrc
```

### Decompression

To restore the DNA stream from a `.pgrc` archive to the current directory:
```bash
PgRC -d archive.pgrc
```

## Expert Tips and Constraints

*   **Read Length Limit**: PgRC is optimized for constant-length reads and has a hard limit of **255 bases**. Do not use this tool for long-read data (e.g., PacBio or Oxford Nanopore).
*   **Memory Usage**: As an in-memory algorithm, ensure the system has sufficient RAM to hold the pseudogenome structure, especially for large datasets.
*   **Multi-threading**: Use the `-t` flag to specify the number of threads. Increasing threads significantly speeds up the pseudogenome construction phase.
    ```bash
    PgRC -t 8 -i input.fastq output.pgrc
    ```
*   **DNA Stream Only**: Note that PgRC focuses on the DNA stream. While it handles the sequences efficiently, it is often used in workflows where quality scores and headers are handled separately or where the DNA sequence is the primary asset being archived.

## Reference documentation
- [PgRC GitHub Repository](./references/github_com_kowallus_PgRC.md)
- [PgRC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pgrc_overview.md)