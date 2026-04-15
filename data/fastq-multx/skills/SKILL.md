---
name: fastq-multx
description: fastq-multx demultiplexes sequencing reads by sorting them into separate files based on barcode matches. Use when user asks to demultiplex FASTQ files, sort reads by barcode, or handle dual-indexed sequencing data while maintaining paired-end synchronization.
homepage: https://github.com/brwnj/fastq-multx
metadata:
  docker_image: "quay.io/biocontainers/fastq-multx:1.4.2--h9948957_5"
---

# fastq-multx

## Overview
The `fastq-multx` tool is a specialized utility for sorting sequencing reads into separate files based on barcode matches. It is designed to handle complex sequencing runs, including those with dual indices, by comparing read sequences against a provided barcode map. Its primary advantage is its ability to keep multiple read files (e.g., Forward, Reverse, and Index reads) in perfect sync during the demultiplexing process, ensuring that paired-end relationships are never broken.

## Usage Guidelines

### Barcode File Format
The tool requires a barcode guide file (typically passed with `-B`). This file should be a tab-delimited text file containing:
1.  **Sample Name**: The identifier used for output filenames.
2.  **Barcode Sequence**: The actual DNA sequence of the index. For dual indices, sequences are often joined or listed according to the tool's expected format (e.g., `ATGC-GCTA`).

### Command Line Patterns

#### Single Index Demultiplexing
When demultiplexing a standard paired-end run with one index file:
```bash
fastq-multx -B barcodes.tsv -m 0 \
    index_reads.fastq.gz \
    read_1.fastq.gz \
    read_2.fastq.gz \
    -o n/a -o %_R1.fastq -o %_R2.fastq
```
*   **`-m 0`**: Sets the number of allowed mismatches (0 is strictest).
*   **`-o n/a`**: Tells the tool to discard the demultiplexed index reads.
*   **`-o %_R1.fastq`**: The `%` character is a wildcard replaced by the sample name from the barcode file.

#### Dual Index Demultiplexing
For runs with two separate index files (I1 and I2):
```bash
fastq-multx -B barcodes.tsv -m 1 \
    index_1.fastq.gz \
    index_2.fastq.gz \
    read_1.fastq.gz \
    read_2.fastq.gz \
    -o n/a -o n/a -o %_R1.fastq -o %_R2.fastq
```

### Expert Tips and Best Practices
*   **Output Mapping**: The number of `-o` flags must exactly match the number of input FASTQ files. Use `n/a` for any input file you do not wish to save as a demultiplexed output (common for index files).
*   **Wildcard Usage**: Always use the `%` wildcard in the output filenames to ensure the tool automatically generates unique files for every sample defined in your barcode TSV.
*   **Mismatch Tolerance**: If you are getting a high "unmatched" count, consider increasing the mismatch parameter (e.g., `-m 1` or `-m 2`), but be aware this increases the risk of misassignment.
*   **Synchronization Check**: The tool natively verifies that reads are in-sync. If the tool fails with a synchronization error, it usually indicates that one of your input FASTQ files is truncated or corrupted.
*   **Auto-Detection**: While the tool can auto-determine barcodes, providing a master set via `-B` is significantly more reliable for production pipelines.

## Reference documentation
- [fastq-multx Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fastq-multx_overview.md)
- [fastq-multx GitHub Repository](./references/github_com_brwnj_fastq-multx.md)