---
name: ngsutils
description: ngsutils is a suite of tools for the programmatic manipulation and analysis of high-throughput sequencing data including BAM, BED, FASTQ, and GTF files. Use when user asks to filter BAM files, calculate RPKM, manipulate genomic intervals, preprocess FASTQ sequences, or manage gene annotations.
homepage: https://github.com/ngsutils/ngsutils
---


# ngsutils

## Overview

ngsutils is a comprehensive suite of tools designed for the programmatic manipulation and analysis of high-throughput sequencing data. It is organized into four primary driver scripts—`bamutils`, `bedutils`, `fastqutils`, and `gtfutils`—each containing a variety of sub-commands for specific bioinformatic tasks. This toolset is particularly useful for legacy pipelines requiring Python 2.6+ environments and provides robust utilities for sequence quality control, alignment filtering, and gene model processing.

## General Usage Pattern

All utilities follow a standard command-line structure:
`[utility] [command] {options} [filename]`

To see available sub-commands for any utility, run the driver script without arguments:
- `bamutils`
- `bedutils`
- `fastqutils`
- `gtfutils`

To see specific parameters for a sub-command, run:
`[utility] [command]` (e.g., `bamutils filter`)

## BAM Manipulation (bamutils)

Use `bamutils` for analyzing and filtering alignment files.

- **Filtering**: Remove reads based on specific criteria (e.g., mapping quality, flags).
  `bamutils filter input.bam output.bam {options}`
- **Expression Analysis**: Calculate RPKM or counts for genes/regions. Note that gene counts require a `RefIso` file.
  `bamutils rpkm genes.refiso input.bam`
- **Statistics**: Generate quick summary statistics for a BAM file.
  `bamutils stats input.bam`
- **Conversion**: Convert BAM files to other formats like BED, FASTQ, or BedGraph.
  `bamutils tobedgraph input.bam output.bg`
- **Extraction**: Pull reads from specific genomic regions defined in a BED file.
  `bamutils extract regions.bed input.bam`

## BED File Operations (bedutils)

Use `bedutils` for genomic interval manipulation.

- **Sorting**: Sort a BED file in place (essential for many downstream tools).
  `bedutils sort input.bed`
- **Merging**: Combine overlapping regions into single intervals.
  `bedutils reduce input.bed`
- **Extension**: Extend regions from the 3' end.
  `bedutils extend -len 100 input.bed`
- **Sequence Extraction**: Extract FASTA sequences for specific BED regions using a reference genome.
  `bedutils tofasta ref.fasta input.bed`

## FASTQ Processing (fastqutils)

Use `fastqutils` for raw sequence data preprocessing.

- **Quality Conversion**: Convert Illumina quality scales to Sanger (standard) scales.
  `fastqutils convertqual input.fastq output.fastq`
- **Trimming**: Remove adapters or linkers using Smith-Waterman alignment.
  `fastqutils trim -adapter ATCG... input.fastq output.fastq`
- **Truncation**: Cut all reads to a fixed length.
  `fastqutils truncate -len 50 input.fastq`
- **Pairing**: Merge paired-end FASTQ files into a single interleaved file.
  `fastqutils merge forward.fastq reverse.fastq output.fastq`

## Gene Model Utilities (gtfutils)

Use `gtfutils` to manage gene annotations and create the `RefIso` format used by other ngsutils scripts.

- **RefIso Creation**: Compile RefIso files from UCSC refFlat or KnownGene files to ensure isoforms are correctly grouped.
- **Splice Junctions**: Generate a library of potential splice junctions based on a GTF model.
  `gtfutils junctions input.gtf`
- **Format Conversion**: Convert GTF/GFF models to BED format for interval analysis.
  `gtfutils tobed input.gtf`

## Expert Tips and Best Practices

- **Environment Setup**: Ensure `pysam` and `cython` are installed. It is highly recommended to add the `bin` directory of ngsutils to your `$PATH` for easier access to the driver scripts.
- **Legacy Support**: This tool is designed for Python 2.6+. If working in a modern environment, ensure you are using a compatible virtual environment.
- **RefIso Format**: When calculating gene-level metrics (like RPKM), always use the `gtfutils` suite to prepare your annotation first, as the tools expect the specific `RefIso` format which includes an isoform-grouping column.
- **Piping**: Many commands support standard I/O, allowing you to chain operations to save disk space and reduce I/O overhead.

## Reference documentation
- [ngsutils README](./references/github_com_ngsutils_ngsutils.md)