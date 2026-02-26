---
name: fastqtk
description: fastqtk is a lightweight C-based toolkit for the rapid manipulation and preprocessing of FASTQ sequencing data. Use when user asks to interleave or deinterleave paired-end reads, trim sequences, filter by length, count reads, or convert between FASTQ and FASTA formats.
homepage: https://github.com/ndaniel/fastqtk
---


# fastqtk

## Overview
fastqtk is a lightweight, C-based toolkit designed for the rapid manipulation of sequencing data. It provides a suite of subcommands for common FASTQ preprocessing tasks, such as read counting, sequence trimming, and format conversion. It is particularly effective for managing paired-end data structures and performing lossy ID compression to reduce file sizes. Use this skill to generate efficient command-line strings for bioinformatics pipelines where speed and low memory overhead are required.

## Core CLI Patterns

### Paired-End Management
*   **Interleave**: Combine two separate R1 and R2 files into a single interleaved file.
    `fastqtk interleave reads1.fq reads2.fq out.fq`
*   **Deinterleave**: Split an interleaved file back into two separate files.
    `fastqtk deinterleave interleaved.fq out1.fq out2.fq`
*   **Drop Unpaired**: Remove singletons from an interleaved file to ensure all reads have a mate.
    `fastqtk drop-se interleaved.fq out.fq`

### Trimming and Filtering
*   **Fixed Trimming**: Remove a specific number of bases from either end.
    `fastqtk trim-5 10 input.fq output.fq` (Removes 10bp from 5' end)
*   **Retention**: Keep only a specific number of bases from an end and discard the rest.
    `fastqtk retain-5 70 input.fq output.fq` (Keeps first 70bp)
*   **Poly-tail Trimming**: Remove specific nucleotide tails (e.g., Poly-A or Poly-N).
    `fastqtk trim-poly A 15 input.fq output.fq` (Trims Poly-A ≥ 15bp)
*   **Length Filtering**: Discard reads shorter than a threshold.
    `fastqtk drop-short 30 input.fq output.fq`

### Statistics and Conversion
*   **Read Counts**: Get total read numbers.
    `fastqtk count input.fq`
*   **Length Distribution**: Generate summary statistics for read lengths.
    `fastqtk lengths input.fq lengths.txt`
*   **Format Conversion**:
    *   FASTQ to FASTA: `fastqtk fq2fa input.fq output.fa`
    *   FASTQ to Tab-delimited (4 columns): `fastqtk tab-4 input.fq output.txt`
    *   Interleaved to Tab-delimited (8 columns): `fastqtk tab-8 input.fq output.txt`

### Advanced Operations
*   **ID Compression**: Reduce file size by simplifying read headers. Requires a read count or a maximum estimate.
    `fastqtk compress-id 200000000 input.fq output.fq`
*   **Reverse Complement**: Generate the reverse complement of all reads in a file.
    `fastqtk rev-com input.fq output.fq`
*   **N-Masking**: Replace all 'N' bases with 'A'.
    `fastqtk NtoA input.fq output.fq`

## Expert Tips
*   **Stream Processing**: fastqtk supports standard streams using `-`. Always pipe from `zcat` or into `gzip` to handle compressed files without intermediate decompression.
    `zcat reads.fq.gz | fastqtk trim-5 10 - - | gzip > trimmed.fq.gz`
*   **ID Trimming**: Use `trim-id` to clean up headers by removing everything after the first space, which often resolves compatibility issues with downstream tools.
*   **Tab-Delimited Workflow**: For custom text-based filtering, convert to tab format (`tab-4`), use standard Unix tools like `awk` or `grep`, and convert back using `detab`.

## Reference documentation
- [fastqtk GitHub Repository](./references/github_com_ndaniel_fastqtk.md)
- [fastqtk Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fastqtk_overview.md)