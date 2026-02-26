---
name: debarcer
description: Debarcer is a bioinformatics suite that processes molecular barcodes to improve DNA sequencing accuracy and detect low-frequency mutations. Use when user asks to extract UMIs from FASTQ files, group reads into families, collapse sequences into consensus reads, or call variants from UMI-tagged data.
homepage: https://github.com/oicr-gsi/debarcer
---


# debarcer

## Overview
Debarcer is a bioinformatics suite designed to improve the accuracy of DNA sequencing by leveraging molecular barcodes. It handles the lifecycle of UMI data from raw FASTQ processing to variant calling. It is particularly useful for detecting low-frequency mutations where distinguishing true biological variants from sequencing noise is critical. By collapsing multiple reads from the same original DNA molecule into a single consensus sequence, it effectively filters out PCR duplicates and stochastic sequencing errors.

## Installation
Debarcer is available via Bioconda.
```bash
conda install bioconda::debarcer
```

## Core Workflow

### 1. Preprocessing
Extract UMIs from raw FASTQ files based on a library preparation definition.
```bash
debarcer preprocess -o /path/to/output_dir -r1 read1.fastq -r2 read2.fastq -p "PREP_NAME" -pf library_prep_types.ini -c config.ini -px output_prefix
```

### 2. Alignment (External)
Debarcer does not align sequences. You must use an external aligner (e.g., `bwa-mem`).
**Critical Requirement**: The resulting BAM file must be coordinate-sorted and indexed (`samtools index`) before proceeding to the grouping step.

### 3. Grouping
Group UMIs into families based on genomic coordinates and barcode similarity.
```bash
debarcer group -o /path/to/output_dir -b aligned_sorted.bam -r "chrN:posA-posB" -d 1 -p 10
```
- `-d`: Maximum edit distance for UMI grouping.
- `-p`: Number of threads.

### 4. Collapsing
Generate consensus sequences by collapsing read families to remove errors.
```bash
debarcer collapse -o /path/to/output_dir -b aligned_sorted.bam -rf reference.fasta -r "chrN:posA-posB" -u umifile.json -f "1,3,5"
```
- `-u`: The JSON file generated during the `group` step.
- `-f`: Comma-separated list of family sizes to collapse.

### 5. Variant Calling
Call variants from the collapsed consensus data for specific family sizes.
```bash
debarcer call -o /path/to/output_dir -rf reference.fasta -ft 10 -f 3
```
- `-ft`: Frequency threshold for calling a variant.
- `-f`: Minimum family size to consider.

## Library Prep Configuration
Custom library preparations are defined in a `.ini` file (e.g., `library_prep_types.ini`). Debarcer requires specific metadata to locate the UMI:

| Parameter | Description |
|-----------|-------------|
| `INPUT_READS` | Number of unprocessed FASTQ files (1-3). |
| `UMI_LOCS` | Indices of FASTQ files containing the UMI. |
| `UMI_LENS` | Length of the UMIs. |
| `UMI_INLINE` | `TRUE` if UMIs are within the read; `FALSE` if in a separate FASTQ. |
| `SPACER` | `TRUE` if a spacer sequence exists between the UMI and the insert. |
| `SPACER_SEQ` | The actual sequence of the spacer. |

## Expert Tips and Best Practices
- **Config Precedence**: Parameters defined in a `config.ini` file take precedence over command-line arguments. If you want to override a config file setting, you must edit the file or omit the `-c` flag.
- **Region-Based Processing**: Always use the `-r` (region) flag (format: "chr:start-stop") for the `group` and `collapse` steps when working with large datasets to significantly improve performance and reduce memory usage.
- **BAM Indexing**: Ensure both the `.bam` and `.bam.bai` files are present in the same directory. Debarcer will fail if the index is missing.
- **Consensus Thresholds**: When using `debarcer call`, the `-ft` (frequency threshold) is a percentage. A value of `10` means a variant must be present in at least 10% of the consensus reads at that position.

## Reference documentation
- [Debarcer GitHub Repository](./references/github_com_oicr-gsi_debarcer.md)
- [Bioconda Debarcer Overview](./references/anaconda_org_channels_bioconda_packages_debarcer_overview.md)