---
name: barcode_splitter
description: `barcode_splitter` is a specialized utility designed to demultiplex FASTQ files by matching sequence barcodes against a user-defined list.
homepage: https://bitbucket.org/princeton_genomics/barcode_splitter
---

# barcode_splitter

## Overview
`barcode_splitter` is a specialized utility designed to demultiplex FASTQ files by matching sequence barcodes against a user-defined list. It can process multiple input files simultaneously (such as paired-end reads) and assign sequences to specific output files based on whether a barcode is found at the beginning or end of a read. This tool is particularly effective for handling compressed data and allowing for a configurable number of mismatches during the matching process.

## Usage Instructions

### 1. Prepare the Barcode File
The tool requires a tab-delimited text file (usually named `barcodes.txt`) that maps sample names to their respective barcode sequences.
- **Format**: `SampleName [TAB] BarcodeSequence`
- **Example**:
  ```text
  Sample_A    ATGCAT
  Sample_B    GTCGTA
  ```

### 2. Basic Command Execution
The standard syntax involves specifying the barcode file and the FASTQ files to be processed.
```bash
barcode_splitter --bcfile barcodes.txt input_R1.fastq input_R2.fastq
```

### 3. Handling Mismatches
By default, the tool requires an exact match. If your sequencing quality suggests potential errors in the barcode region, increase the tolerance:
- Use `--mismatches N` to allow up to N mismatches.
- **Tip**: Start with `--mismatches 0` to check data integrity, then increase to 1 or 2 if a significant portion of reads are being categorized as "unmatched."

### 4. Working with Compressed Files
The tool natively supports Gzip compression.
- If your input files end in `.gz`, the tool will automatically read them as compressed.
- To force compressed input reading regardless of file extension, use the `gzipin` option.

### 5. Barcode Positioning
The tool matches barcodes against the beginning or end of the specified index reads. Ensure your `barcodes.txt` sequences match the orientation (5' to 3') as they appear in the FASTQ files.

## Best Practices
- **Input Consistency**: When splitting multiple files (e.g., R1 and R2), ensure they are provided in the correct order. The tool splits all provided files based on the barcode found in the designated index read.
- **Resource Management**: For very large datasets, ensure you have sufficient disk space for the resulting split files, as demultiplexing can significantly increase the number of files in your working directory.
- **Unmatched Reads**: Always check the "unmatched" output file. A high volume of unmatched reads often indicates an issue with the barcode file sequences or the need to increase the `--mismatches` parameter.

## Reference documentation
- [barcode_splitter - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_barcode_splitter_overview.md)
- [princeton_genomics / barcode_splitter — Bitbucket](./references/bitbucket_org_princeton_genomics_barcode_splitter.md)