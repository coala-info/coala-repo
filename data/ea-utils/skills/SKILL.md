---
name: ea-utils
description: The ea-utils suite provides high-performance command-line utilities for processing sequencing data, including adapter trimming, demultiplexing, and read merging. Use when user asks to trim adapters, filter low-quality bases, demultiplex barcodes, join paired-end reads, identify Phred quality encoding, or generate sequencing statistics.
homepage: https://expressionanalysis.github.io/ea-utils/
---

# ea-utils

## Overview

The `ea-utils` suite provides high-performance C-based command-line utilities for the rapid processing of sequencing data. While primarily developed for Illumina pipelines, these tools are versatile enough for any FASTQ-based workflow. The suite is particularly effective for high-throughput environments where efficiency in adapter clipping, read merging, and demultiplexing is critical for downstream analysis.

## Tool-Specific Best Practices

### Adapter Trimming and Quality Filtering (fastq-mcf)
Use `fastq-mcf` when you need to remove adapter sequences and low-quality bases simultaneously.
- **Automatic Detection**: It scans for adapters and determines clipping parameters based on log-scaled thresholds.
- **Skewing Detection**: Use this tool to identify nucleotide skewing, which can indicate library preparation issues.
- **Paired-end Sync**: Always provide both R1 and R2 files together to ensure the tool maintains read parity during filtering.

### Barcode Demultiplexing (fastq-multx)
Use `fastq-multx` to split a single FASTQ file into multiple files based on barcode sequences.
- **Auto-determination**: It can automatically identify barcode IDs if provided with a master list of potential barcodes.
- **Synchronization**: It is designed to keep multiple read files (e.g., R1, R2, and Index reads) in sync, failing if a mismatch is detected to prevent data corruption.

### Joining Paired-End Reads (fastq-join)
Use `fastq-join` to merge overlapping paired-end reads into a single, longer sequence.
- **Anchored Alignment**: The tool uses a "squared distance" algorithm for anchored alignment, making it more efficient than many script-based alternatives.
- **Tuning**: It supports automatic benchmarking to optimize the joining process based on the specific overlap characteristics of your library.

### Quality Control and Statistics
- **determine-phred**: Run this first if you are unsure of the quality encoding (Phred+33 vs Phred+64). It works on FASTQ, SAM, and pileup files, including gzipped versions.
- **fastq-stats**: Use for a quick overview of read counts and duplication rates. Enable per-cycle stats for detailed library complexity analysis.
- **sam-stats**: Use after alignment to generate concise mapping statistics in a format easily parsed by other downstream programs.

### Utility Operations
- **randomFQ**: Use this to create a representative subset of a large FASTQ file for testing pipelines or estimating library diversity. It supports paired-end data and gzipped inputs.
- **gtf2bed**: Use this to convert GFF/GTF annotations into UCSC-style BED files, specifically handling exon bundling and thick/thin feature rendering.

## Common CLI Patterns

1. **Identify Quality Encoding**:
   `determine-phred input.fastq.gz`

2. **Trim Adapters (Paired-End)**:
   `fastq-mcf adapters.fa read1.fq read2.fq -o read1.trimmed.fq -o read2.trimmed.fq`

3. **Demultiplex with Barcode List**:
   `fastq-multx -b barcodes.txt index.fq read1.fq read2.fq -o n/a -o sample_%.1.fq -o sample_%.2.fq`

4. **Join Overlapping Reads**:
   `fastq-join read1.fq read2.fq -o read.un1.fq -o read.un2.fq -o read.join.fq`

5. **Subsample a Library**:
   `randomFQ -n 1000000 input.fq output.subset.fq`



## Subcommands

| Command | Description |
|---------|-------------|
| fastq-join | Joins two paired-end reads on the overlapping ends. |
| fastq-mcf | Detects levels of adapter presence, computes likelihoods and locations (start, end) of the adapters. Removes the adapter sequences from the fastq file(s). |
| fastq-multx | Output files must contain a '%' sign which is replaced with the barcode id in the barcodes file. Output file can be n/a to discard the corresponding data (use this for the barcode read) |
| fastq-stats | Produces lots of easily digested statistics for the files listed |
| sam-stats | Produces lots of easily digested statistics for the files listed |

## Reference documentation

- [ea-utils Overview](./references/expressionanalysis_github_io_ea-utils.md)