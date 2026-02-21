---
name: artic-porechop
description: artic-porechop is a specialized fork of the original Porechop tool, optimized for Oxford Nanopore Technologies (ONT) reads.
homepage: https://github.com/artic-network/Porechop
---

# artic-porechop

## Overview

artic-porechop is a specialized fork of the original Porechop tool, optimized for Oxford Nanopore Technologies (ONT) reads. It identifies and trims adapters from the ends of sequences and detects internal adapters that indicate chimeric reads, which are then split or discarded. This version is essential for genomic surveillance and viral sequencing projects using the ARTIC protocol, as it includes expanded support for native barcode sets (1-24) and provides additional command-line options for detailed barcode reporting and custom primer handling.

## Core Usage Patterns

### Basic Adapter Trimming
To remove adapters from a single FASTQ file and save the cleaned reads:
`porechop -i input_reads.fastq.gz -o trimmed_output.fastq.gz`

### Demultiplexing Barcoded Reads
To sort reads into folders based on their barcodes:
`porechop -i input_reads.fastq.gz -b output_directory`

### ARTIC Native Barcoding
When using ONT Native Barcoding kits (including the 13-24 extension), use the specific flag to increase speed and accuracy:
`porechop -i input_reads.fastq.gz -b output_dir --native_barcodes`

## Expert Tips and Advanced Options

### Optimization for Speed
*   **Thread Management**: Use `--threads` to match your CPU core count for significantly faster processing.
*   **Barcode Limiting**: If you know exactly which barcodes were used in a run, use `--limit_barcodes_to` followed by a list of barcode numbers to prevent false positive assignments to unused barcodes.

### Chimeric Read Handling
*   **Strict Filtering**: Use `--discard_middle` to throw away any read that contains an adapter in the middle of the sequence.
*   **Combined Filtering**: Use `--discard_middle --discard_unassigned` to skip the middle-adapter search for reads that couldn't be assigned a barcode, saving compute time.

### Metadata and Reporting
*   **Header Integration**: Use `--barcode_headers` to write the barcode call directly into the FASTQ header of each read.
*   **Detailed Scoring**: Use `--extended_headers` to include similarity scores and barcode calls for both ends of the read in the header.
*   **CSV Output**: Use `--csv` to generate a per-read summary of barcode calls, which is useful for downstream quality control and troubleshooting.

### Custom Amplicons
*   **Custom Primers**: Use `--custom_barcodes` or `--custom_primers` with a CSV file to identify specific amplicons or non-standard adapter sets.

## Reference documentation
- [Porechop Main README](./references/github_com_artic-network_Porechop.md)
- [artic-porechop Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_artic-porechop_overview.md)