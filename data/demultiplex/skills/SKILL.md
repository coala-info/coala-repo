---
name: demultiplex
description: The `demultiplex` tool is a versatile Python-based utility designed to sort sequencing reads into separate files based on barcode sequences.
homepage: https://github.com/jfjlaros/demultiplex
---

# demultiplex

## Overview
The `demultiplex` tool is a versatile Python-based utility designed to sort sequencing reads into separate files based on barcode sequences. Unlike simpler demultiplexers, it excels at handling non-standard barcode placements and sequencing errors. It supports compressed files (gzip/bzip2) and can manage extremely large barcode sets (over one million).

## Installation
Install the tool via Bioconda:
```bash
conda install -c bioconda demultiplex
```

## Core Workflow
The primary operation is performed using the `match` subcommand. You typically need a barcode file and one or more sequence files.

### Barcode File Format
The barcode file should be a simple text file (often `.txt` or `.tsv`) containing the barcode name and the sequence:
```text
Sample1  ATGCATGC
Sample2  GCTAGCTA
```

### Basic Execution
To demultiplex a single FASTQ file:
```bash
demultiplex match barcodes.txt reads.fastq.gz -o output_directory/
```

## Common CLI Patterns

### Handling Sequencing Errors
If your data has quality issues, enable fuzzy matching to allow for mismatches, insertions, or deletions:
- **Mismatches**: Use `-m` followed by the number of allowed mismatches.
- **Indels**: The tool natively supports insertions and deletions during the matching process when configured.

### Barcode Locations
- **In Header**: Use when barcodes have been moved to the FASTQ header line by previous processing steps.
- **Unknown Locations**: For long-read data (Nanopore/PacBio) where the barcode might not be at the very start of the read, `demultiplex` can search the entire read for the best match.

### Paired-End Data
For paired-end fragments, provide both read files. The tool ensures that pairs are kept together:
```bash
demultiplex match barcodes.txt forward_reads.fastq reverse_reads.fastq -o output_dir/
```

### Barcode Guessing
If the barcodes used in a run are unknown, you can use the guessing feature to identify the most frequent sequences:
- **By Frequency**: Identifies barcodes based on how often they appear.
- **Fixed Amount**: Identifies a specific number of top barcodes.

### UMI and Part Selection
- **UMI Selection**: Use the `--umi` options if your fragments contain Unique Molecular Identifiers that need to be preserved or handled.
- **Partial Barcodes**: If only a portion of the sequence in your barcode file should be used for matching, use the selection parameters to define the start and end coordinates.

## Expert Tips
- **Compression**: Always provide `.gz` or `.bz2` files directly to save disk space; the tool handles decompression on the fly.
- **Output Management**: Use the `-o` or `--output` flag to specify a directory. Note that by default, the tool may append to existing files; ensure your output directory is clean if you want fresh results.
- **Large Barcode Sets**: The tool is optimized for high-throughput; if you are working with over 1,000,000 barcodes, ensure your system has sufficient memory for the lookup tables.

## Reference documentation
- [Demultiplex GitHub Repository](./references/github_com_jfjlaros_demultiplex.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_demultiplex_overview.md)