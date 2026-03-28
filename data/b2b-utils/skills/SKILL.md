---
name: b2b-utils
description: The b2b-utils package provides a suite of lightweight command-line tools for genomic data plumbing, format conversion, and sequence analysis. Use when user asks to interleave or synchronize FASTQ reads, convert between GenBank and FASTA formats, generate assembly statistics, or decode SAM flags.
homepage: https://github.com/jvolkening/b2b-utils
---


# b2b-utils

## Overview

The `b2b-utils` package is a specialized toolkit developed by BASE₂BIO for handling various genomic data formats and metadata. It provides a set of lightweight, high-performance Perl scripts designed for the Linux command line. The suite is particularly useful for "data plumbing"—the small but essential tasks required to prepare data for larger pipelines, such as synchronizing paired-end reads, identifying sequencing instruments from headers, or generating consensus sequences from alignments.

## Core Utilities and CLI Patterns

Most tools in this suite follow standard Unix conventions and provide detailed usage information via the `--help` flag.

### FASTQ Manipulation
*   **Interleaving Reads**: Combine R1 and R2 files into a single interleaved stream.
    `fq_interleave reads_R1.fq reads_R2.fq > interleaved.fq`
*   **Deinterleaving Reads**: Split an interleaved file back into paired files.
    `fq_deinterleave interleaved.fq -1 reads_R1.fq -2 reads_R2.fq`
*   **Synchronizing Pairs**: If your R1 and R2 files have become desynchronized (e.g., due to different filtering steps), use `sync_reads` to restore the pairing.
    `sync_reads -1 R1.fq -2 R2.fq -o1 synced_R1.fq -o2 synced_R2.fq`

### Format Conversion
*   **GenBank to FASTA**: Extract sequences from GenBank files.
    `gb2fasta input.gb > output.fasta`
*   **Phylogeny Formats**: Convert FASTA alignments to formats required by phylogenetic software.
    `fasta2nexus alignment.fasta > alignment.nex`
    `fasta2phylip alignment.fasta > alignment.phy`

### Assembly and Alignment Analysis
*   **Assembly Stats**: Generate N50, L50, and total length statistics for a genome assembly.
    `summarize_assembly assembly.fasta`
*   **SAM Flag Decoding**: Quickly interpret the bitwise flags in SAM/BAM files.
    `decode_sam_flag 163`
*   **Consensus Generation**: Create a consensus sequence from a BAM alignment.
    `bam2consensus -i input.bam -f reference.fasta > consensus.fasta`

### Metadata and Diagnostics
*   **Instrument Identification**: Determine which Illumina platform produced a specific FASTQ file based on the read headers.
    `guess_ill_instrument sample.fq.gz`
*   **Fragment Lengths**: Calculate fragment length distribution from a BAM file.
    `frag_lens input.bam > lengths.tsv`

## Expert Tips
*   **Piping**: Most utilities support STDIN/STDOUT, making them ideal for use in one-liner pipes to avoid creating large intermediate files.
*   **Gzip Support**: Many of the tools (like `fq_interleave`) handle gzipped input natively or via PerlIO::gzip, but if a tool fails on a compressed file, pipe it through `zcat` or `gunzip -c`.
*   **Runtime Dependencies**: While the base package is lightweight, specific tools like `bam2consensus` may require external dependencies (e.g., `samtools`). If a tool fails, check the error message for missing system binaries.



## Subcommands

| Command | Description |
|---------|-------------|
| bam2consensus | Re-calls a consensus sequence based on a BAM alignment to reference, with various knobs and optional output formats |
| fq_interleave | A simple script to interleave two paired FASTQ files (alternate forward/reverse reads in a single output file). This requires that the two files correspond exactly in terms of number and order of the paired reads ('--check' will make sure of this and throw an error otherwise). Interleaved FASTQ is sent to STDOUT. |
| minimeta | Produces a polished consensus assembly from long-read sequencing data using miniasm, racon, and medaka. Software settings are tuned for metagenomic/metatranscriptomic assemblies of variable, sometimes low, coverage. |
| shrink_bedgraph | reduce resolution/size of bedgraph files |

## Reference documentation
- [github_com_jvolkening_b2b-utils.md](./references/github_com_jvolkening_b2b-utils.md)
- [github_com_jvolkening_b2b-utils_blob_master_README.md](./references/github_com_jvolkening_b2b-utils_blob_master_README.md)
- [github_com_jvolkening_b2b-utils_blob_master_MANIFEST.md](./references/github_com_jvolkening_b2b-utils_blob_master_MANIFEST.md)