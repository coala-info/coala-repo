---
name: fastlin
description: fastlin is a high-performance tool designed for rapid MTBC lineage classification.
homepage: https://github.com/rderelle/fastlin
---

# fastlin

## Overview

fastlin is a high-performance tool designed for rapid MTBC lineage classification. By utilizing a split-kmer approach, it bypasses the need for traditional, time-consuming alignment steps, allowing for the identification of lineages and strain mixtures in seconds. It is an ideal choice for high-throughput genomic surveillance where speed and accuracy are critical.

## Installation

The most efficient way to install fastlin is via Conda:

```bash
conda install -c bioconda fastlin
```

Alternatively, if a Rust environment is available:

```bash
cargo install fastlin
```

## Core Usage

### Required Inputs
1.  **Input Directory (`-d`)**: A path to a directory containing your genomic files. fastlin automatically detects supported formats.
2.  **Barcode File (`-b`)**: A specific kmer barcode file for MTBC. This must be downloaded separately from the [official barcode repository](https://github.com/rderelle/barcodes-fastlin).

### Basic Command
```bash
fastlin -d /path/to/data -b mtbc_barcodes.txt
```

## CLI Patterns and Best Practices

### Optimizing FASTQ Processing
For raw FASTQ data (not derived from BAM), you can significantly reduce runtime by capping the kmer coverage. This prevents the tool from over-processing high-depth samples without sacrificing typing accuracy.
```bash
# Cap kmer coverage at 80x
fastlin -d ./reads -b barcodes.txt -x 80
```

### Multi-threading
fastlin supports multi-threading using the `-t` parameter. Note that threads are used to process multiple samples in parallel; increasing threads for a single sample will not improve performance.
```bash
# Process a large batch of samples using 8 threads
fastlin -d ./batch_data -b barcodes.txt -t 8
```

### Supported File Formats
fastlin can process a mix of the following formats within the same input directory:
*   **FASTQ**: `.fastq.gz` or `.fq.gz` (Single-end or paired-end named `_1` and `_2`).
*   **BAM**: `.bam` or `.BAM`.
*   **FASTA**: `.fas.gz`, `.fasta.gz`, or `.fna.gz`.

## Interpreting Results

The output is a tab-delimited file. Key columns to monitor include:
*   **mixture**: Indicates 'yes' if multiple lineages are detected, suggesting a mixed infection or contamination.
*   **lineages**: Displays the detected lineage followed by the median kmer occurrences in parentheses.
*   **log_errors**: If a file is corrupt or fails to parse, the specific error message will be recorded here while the tool continues to the next sample.

## Expert Tips
*   **Mixed Inputs**: You do not need to separate your assemblies from your raw reads; fastlin handles mixed directories seamlessly.
*   **BAM vs FASTQ**: When using BAM files, the `-x` (max coverage) parameter is ignored because BAM files are scanned linearly.
*   **Barcode Customization**: While the standard MTBC barcodes are recommended, you can build custom kmer barcodes using the Python scripts provided in the fastlin barcode repository.

## Reference documentation
- [fastlin GitHub Repository](./references/github_com_rderelle_fastlin.md)
- [fastlin Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fastlin_overview.md)