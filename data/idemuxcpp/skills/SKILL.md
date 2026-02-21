---
name: idemuxcpp
description: idemuxcpp is a high-performance C++ tool used to demultiplex sequencing data based on various index types.
homepage: https://github.com/Lexogen-Tools/idemuxcpp
---

# idemuxcpp

## Overview

idemuxcpp is a high-performance C++ tool used to demultiplex sequencing data based on various index types. It is significantly faster than its Python predecessor and provides specialized error correction for Lexogen 12nt Unique Dual Indices (UDIs). The tool processes paired-end FASTQ files and a sample sheet to generate organized output directories containing demultiplexed reads.

## Basic Usage

The standard command requires Read 1, Read 2, a sample sheet, and an output directory:

```bash
idemuxcpp --r1 read_1.fastq.gz --r2 read_2.fastq.gz --sample-sheet samples.csv --out /path/to/output
```

## Sample Sheet Configuration

The sample sheet must be a CSV file with a specific header and four columns: `sample_name,i7,i5,i1`.

*   **sample_name**: Used as the prefix for the resulting FASTQ files. Must be unique.
*   **i7 / i5**: Standard Illumina-style indices.
*   **i1**: Inline barcodes (common in QuantSeq-Pool).
*   **Missing Barcodes**: If a sample does not use a specific index type, leave the field empty (e.g., `sample_A,ATGCATGC,,`).
*   **Consistency**: i7 and i5 indices must be used consistently; they must be present for all samples or none at all. i1 indices can be used for a subset of samples.

## Handling Inline Barcodes (i1)

When demultiplexing QuantSeq-Pool data or other libraries with inline barcodes in Read 2, you must specify the starting position:

*   Use `--i1-start <INT>` to define the 0-based start position of the i1 barcode within the Read 2 sequence.

## Index Orientation and Auto-detection

Sequencing platforms vary in how they sequence the i5 index. 

*   **Reverse Complement**: If the i5 index is sequenced as a reverse complement, provide the RC sequences in the sample sheet and use the `--i5-rc` flag.
*   **Auto-detection**: If the orientation is unknown, use the `--auto-detect` option to allow the tool to determine the correct orientation automatically.

## Best Practices and Tips

*   **Error Correction**: To benefit from superior error correction, ensure you are using Lexogen 12nt UDIs and that at least 8 nucleotides of the index have been sequenced.
*   **Performance**: Since the tool is written in C++ and utilizes OpenMP, ensure your environment has sufficient threads available for parallel processing of large FASTQ files.
*   **Validation**: idemuxcpp validates the sample sheet before processing. If an error occurs regarding "ambiguous combinations," check for duplicate barcode sets assigned to different sample names.
*   **Input Formats**: The tool natively supports gzipped FASTQ files (.fastq.gz), which is the recommended input format to save disk space and I/O overhead.

## Reference documentation
- [idemuxcpp GitHub Repository](./references/github_com_Lexogen-Tools_idemuxcpp.md)
- [idemuxcpp Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_idemuxcpp_overview.md)