---
name: je-suite
description: The `je-suite` (Just Extract) is a specialized toolkit for handling the initial stages of high-throughput sequencing data analysis.
homepage: https://gbcs.embl.de/Je
---

# je-suite

## Overview
The `je-suite` (Just Extract) is a specialized toolkit for handling the initial stages of high-throughput sequencing data analysis. It excels at de-multiplexing reads based on in-line or header barcodes and performing UMI-based deduplication. Use this tool to ensure that PCR duplicates are correctly identified by combining mapping coordinates with molecular tags, which is essential for accurate quantification in RNA-seq or iCLIP-seq protocols.

## Core Workflows

### De-multiplexing (je demultiplex)
Use this to split FASTQ files based on sample barcodes.
- **In-line barcodes**: Use when barcodes are part of the read sequence.
- **Header barcodes**: Use when barcodes have already been moved to the FASTQ header.
- **Key Parameter**: `BPOS` (Barcode Position). Set to `READ_1`, `READ_2`, or `BOTH`.
- **Mismatches**: Control sensitivity using `MAX_MISMATCHES` (default is usually 1).

### UMI Extraction (je markdupes)
Use this to filter PCR duplicates using UMI information. Unlike standard Picard MarkDuplicates, `je-suite` uses the UMI sequence to distinguish between technical duplicates and independent biological molecules mapping to the same coordinate.
- **Input**: Coordinate-sorted BAM file.
- **Requirement**: UMIs must be present in the read name (usually separated by a colon or underscore).
- **Recommendation**: Always use `REMOVE_DUPLICATES=true` if the goal is to produce a clean BAM for downstream quantification.

## CLI Patterns and Best Practices

### Memory Management
`je-suite` is Java-based. For large FASTQ files, explicitly define the heap size to avoid `OutOfMemoryError`:
```bash
je demultiplex Xmx4g F1=reads_R1.fastq.gz BARCODE_FILE=codes.txt
```

### Barcode File Format
The barcode file should be a simple tab-delimited text file:
1. Sample_Name
2. Barcode_Sequence
*Note: Ensure no headers are present in the file unless specified.*

### Handling Complex Layouts
If your UMI is at the beginning of the read followed by a constant linker:
- Use the `CLIP` option to remove the UMI and linker sequences after extraction to prevent them from interfering with alignment.
- Use `LEN` to specify the exact length of the molecular tag to be extracted.

## Reference documentation
- [je-suite Overview](./references/anaconda_org_channels_bioconda_packages_je-suite_overview.md)