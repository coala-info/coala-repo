---
name: flexiplex
description: Flexiplex is a high-performance, multithreaded C++ tool designed for the flexible demultiplexing and searching of sequencing reads.
homepage: https://github.com/DavidsonGroup/flexiplex/
---

# flexiplex

## Overview

Flexiplex is a high-performance, multithreaded C++ tool designed for the flexible demultiplexing and searching of sequencing reads. It bridges the gap between general-purpose search tools and specialized single-cell demultiplexers by supporting both known barcode sets and "discovery mode," where only the flanking regions of a sequence of interest are known. It is highly error-tolerant, making it suitable for noisy long-read data or custom sequencing chemistries where standard pipelines might fail.

## Common CLI Patterns

### 1. Standard Demultiplexing (Known Chemistry)
Assign reads to cellular barcodes using a predefined chemistry (e.g., 10x Chromium v3) and a known whitelist.
```bash
flexiplex -d 10x3v3 -k barcode_list.txt reads.fastq > demultiplexed_reads.fastq
```

### 2. Barcode Discovery Mode
Use this when the exact barcodes are unknown but the flanking sequences are defined. Setting `-f 0` initiates discovery.
```bash
flexiplex -f 0 reads.fastq
```

### 3. Error-Tolerant Sequence Search (Grep-like)
Search for a specific sequence within a FASTA/FASTQ file with a defined number of allowed mismatches/indels (e.g., 3 errors).
```bash
flexiplex -x "CACTCTTGCCTACGCCACTAGC" -d grep -f 3 reads.fasta
```

### 4. Filtering and Inflection Point Analysis
After running flexiplex in discovery mode, use `flexiplex-filter` to remove empty droplets and filter against a whitelist.
```bash
flexiplex-filter --whitelist 3M-february-2018.txt --outfile filtered.txt flexiplex_barcodes_counts.txt
```

## Expert Tips and Best Practices

- **Preset Selection**: Always check if your chemistry is supported via the `-d` flag (e.g., `10x3v2`, `10x3v3`, `Visium`). This automatically configures the barcode and UMI positions.
- **Handling Long Reads**: Flexiplex is optimized for long-read data where barcodes may appear at varying positions or contain significant sequencing errors.
- **Output Redirection**: By default, `flexiplex` often outputs the modified FASTQ to `stdout`. Ensure you redirect to a file or pipe into downstream tools to avoid flooding the terminal.
- **Installation**: For the most stable environment, install via Bioconda: `conda install -c bioconda flexiplex`.
- **Filtering Workflow**: The demultiplexing process is often a two-step workflow: first run `flexiplex` to generate count statistics, then run `flexiplex-filter` to perform the actual cell calling/filtering.

## Reference documentation

- [flexiplex - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_flexiplex_overview.md)
- [GitHub - DavidsonGroup/flexiplex: The Flexible Demultiplexer](./references/github_com_DavidsonGroup_flexiplex.md)