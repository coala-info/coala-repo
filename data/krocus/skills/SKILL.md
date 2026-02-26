---
name: krocus
description: Krocus predicts sequence types directly from uncorrected long-read genomic data using a k-mer based alignment-free approach. Use when user asks to predict MLST sequence types from raw reads, download MLST schemas, or perform real-time sequence typing during a sequencing run.
homepage: https://github.com/andrewjpage/krocus
---


# krocus

## Overview

Krocus is a specialized genomic tool designed to predict sequence types (ST) directly from noisy, uncorrected long-read data. While traditional MLST methods typically require high-quality assemblies or short-read data, Krocus utilizes a k-mer based alignment-free approach to identify alleles in real-time. It is optimized to consume data as it is being sequenced, providing results in minutes rather than hours, making it a powerful asset for clinical diagnostics and field surveillance.

## Database Management

Before running the analysis, you must obtain the relevant MLST schema. Krocus provides a dedicated utility for this purpose.

### Listing and Downloading Species
1. **List available species**:
   `krocus_database_downloader -l`
2. **Download a specific schema**:
   `krocus_database_downloader --species "Escherichia coli" --output_directory ecoli_db`

## Core CLI Usage

The primary command requires a directory containing the MLST database (created in the previous step) and a FASTQ file (which can be gzipped).

### Basic Command
`krocus ecoli_db sample_reads.fastq.gz`

### Using Standard Input
Krocus can process data from a stream, which is useful for real-time analysis during an active sequencing run:
`cat sample_reads.fastq | krocus ecoli_db -`

## Expert Tips and Parameter Tuning

### Optimizing for Error Rates
The k-mer size (`-k`) is the most critical parameter for accuracy.
* **Default**: 11.
* **High Error Rates**: If your raw reads have a high error rate (e.g., 1 error every 10 bases), decrease the k-mer size to 8 or 9.
* **Low Error Rates**: If the data is higher quality, increasing the k-mer size can improve specificity.

### Real-time Monitoring
To see how the sequence type prediction evolves as more data is processed, use the print interval flag:
`krocus -p 100 ecoli_db reads.fastq`
*This will update the ST prediction every 100 reads.*

### Extracting Reads for Downstream Tasks
If you intend to perform de novo assembly on only the MLST-relevant portions of your data, use the filtered reads flag:
`krocus -f matching_reads.fastq ecoli_db reads.fastq`
*This saves only the regions of the reads that matched the MLST alleles.*

### Performance Thresholds
If Krocus is failing to return a result, check the minimum hit threshold (`-m`). The default is 10. If your coverage is extremely low or error rates are extremely high, you may need to lower this value, though this increases the risk of false positives.

## Reference documentation
- [Krocus GitHub Repository](./references/github_com_andrewjpage_krocus.md)