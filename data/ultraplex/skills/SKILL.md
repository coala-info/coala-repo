---
name: ultraplex
description: Ultraplex processes raw sequencing data by combining adapter trimming, quality filtering, UMI extraction, and combinatorial demultiplexing. Use when user asks to demultiplex sequencing data, trim adapters, filter reads by quality, extract UMIs, or process paired-end sequencing data.
homepage: https://github.com/ulelab/ultraplex.git
metadata:
  docker_image: "quay.io/biocontainers/ultraplex:1.2.10--py39hbcbf7aa_0"
---

# ultraplex

## Overview
Ultraplex is a high-performance tool designed to process raw sequencing data from custom library preparations. It streamlines the initial bioinformatics pipeline by combining adapter trimming, quality filtering, UMI (Unique Molecular Identifier) extraction, and combinatorial demultiplexing into a single step. It is particularly effective for complex barcoding strategies where barcodes contain randomers (Ns) used for deduplication.

## Core Usage Patterns

### Basic Demultiplexing
The most common entry point requires a gzipped FASTQ and a barcode configuration file.
```bash
ultraplex -i input_reads.fastq.gz -b barcodes.csv
```

### Paired-End Processing
When dealing with paired-end data, especially if 3' barcodes are present on the reverse read:
```bash
ultraplex -i forward.fastq.gz -i2 reverse.fastq.gz -b barcodes.csv
```

### Performance Optimization
Ultraplex is multithreaded. While the default is 4, increasing this can significantly speed up processing for large HiSeq or NovaSeq lanes.
```bash
ultraplex -i input.fastq.gz -b barcodes.csv -t 16
```

## Barcode CSV Configuration
The CSV structure determines how reads are split. 

- **Single 5' Barcode**: `BarcodeSequence,`
- **Combinatorial (5' and 3')**: `5PrimeBarcode,3PrimeBarcode1,3PrimeBarcode2`
- **With Sample Names**: Append names using a colon.
  - `NNNATGNN:SampleA,`
  - `NNNCCGNN,ATG:SampleB,TCA:SampleC`

### Barcode Constraints
- **Consistency**: All 5' barcodes must have non-N characters in the same relative positions.
- **Randomers (Ns)**: Positions marked with `N` are treated as UMIs. Ultraplex extracts these bases and moves them to the read header (prefixed with `rbc:`) for use with downstream tools like UMI-tools.

## Expert Tips & Best Practices
- **Input Format**: Ultraplex strictly requires `.fastq.gz`. If your files are uncompressed, you must gzip them before running the tool.
- **Mismatch Tolerance**: By default, 1 mismatch is allowed for 5' barcodes. Adjust this using `-m5` (5' mismatches) or `-m3` (3' mismatches) based on your library quality.
- **Output Management**: Use the `-d` flag to specify an output directory. Ultraplex creates temporary files during processing; ensuring a dedicated directory keeps your workspace clean.
- **Adapter Trimming**: Ultraplex automatically handles Illumina universal adapters. If using non-standard adapters, ensure they are specified or handled according to the library protocol.
- **Sequential Runs**: For extremely complex nested barcoding, Ultraplex can be run sequentially. It is smart enough to only append the `rbc:` UMI tag once.

## Reference documentation
- [Ultraplex GitHub Repository](./references/github_com_ulelab_ultraplex.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ultraplex_overview.md)