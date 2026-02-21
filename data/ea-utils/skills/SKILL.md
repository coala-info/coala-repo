---
name: ea-utils
description: The `ea-utils` suite provides high-performance C-based utilities for the initial stages of genomic data analysis.
homepage: https://expressionanalysis.github.io/ea-utils/
---

# ea-utils

## Overview
The `ea-utils` suite provides high-performance C-based utilities for the initial stages of genomic data analysis. It is designed to handle the high-volume data produced by Illumina platforms, offering tools for cleaning, filtering, and organizing FASTQ files. Key capabilities include sophisticated adapter clipping, multi-read demultiplexing, and calculating sequence statistics.

## Core Utilities and Usage

### Adapter Trimming (fastq-mcf)
Use `fastq-mcf` to scan for adapters and perform quality-based clipping. It automatically detects clipping parameters based on a log-scaled threshold.
- **Basic Pattern**: `fastq-mcf [adapters.fa] [read1.fq] [read2.fq] -o [out1.fq] -o [out2.fq]`
- **Key Feature**: It performs skewing detection and quality filtering simultaneously with trimming.

### Demultiplexing (fastq-multx)
Use `fastq-multx` to split a FASTQ file into multiple files based on barcodes.
- **Basic Pattern**: `fastq-multx -m [mismatches] [barcodes.tab] [read1.fq] [read2.fq] -o [out1.%.fq] -o [out2.%.fq]`
- **Best Practice**: It can auto-determine barcode IDs from a master set and ensures that paired-end reads remain synchronized during the split.

### Joining Paired-End Reads (fastq-join)
Use `fastq-join` to merge overlapping paired-end reads into a single sequence.
- **Basic Pattern**: `fastq-join [read1.fq] [read2.fq] -o [output.%.fq]`
- **Mechanism**: Uses a "squared distance for anchored alignment" approach, similar to other stitch programs but optimized for speed in C.

### Sequence Statistics (fastq-stats & sam-stats)
- **fastq-stats**: Provides basic counts, duplicate detection, and optional per-cycle statistics.
- **sam-stats**: Generates summary statistics for SAM/BAM files in a format easily parsed by other downstream programs.

### Quality Control and Utilities
- **determine-phred**: Automatically detects the Phred quality score offset (33 or 64) for FASTQ, SAM, or pileup files.
- **randomFQ**: Subsets a FASTQ file (supports gzipped and paired-end) to a specific number of random reads for testing or downsampling.
- **gtf2bed**: Converts GFF/GTF exon data into a UCSC-style BED file.

## Expert Tips
- **Piping**: Many tools in this suite support gzipped input and can be integrated into pipes to save disk I/O.
- **Synchronization**: When processing paired-end data, always use the tools' native paired-end support (passing both files) to ensure the read order is never broken.
- **Barcode Identification**: If the barcode list is unknown, `fastq-multx` can help identify the most frequent barcodes present in the data to build a mapping file.

## Reference documentation
- [ea-utils Project Overview](./references/expressionanalysis_github_io_ea-utils.md)
- [Bioconda Package Summary](./references/anaconda_org_channels_bioconda_packages_ea-utils_overview.md)