---
name: nimnexus
description: nimnexus is a high-performance toolkit designed for processing ChIP-nexus sequencing data, specifically for read trimming and PCR de-duplication. Use when user asks to trim Fastq reads based on barcodes, remove PCR duplicates from BAM files, or process ChIP-nexus library structures.
homepage: https://github.com/avsecz/nimnexus
metadata:
  docker_image: "quay.io/biocontainers/nimnexus:0.1.1--hcb20899_3"
---

# nimnexus

## Overview

The `nimnexus` skill provides procedural knowledge for using a high-performance Nim-based toolkit designed for ChIP-nexus data processing. It is primarily used in the early stages of sequencing analysis to handle the unique structural requirements of ChIP-nexus libraries, such as random barcodes (UMIs) and fixed barcodes. The tool replaces slower R-based implementations with efficient CLI commands for read trimming and PCR de-duplication.

## Command Usage and Best Practices

### 1. Trimming Fastq Reads (`trim`)
The `trim` command filters and renames sequences based on barcodes. It expects the random barcode (UMI) to be at the very start of the read.

**Basic Syntax:**
`nimnexus trim [options] <barcodes>`

*   **Barcodes**: A comma-separated list of fixed barcode sequences that follow the random barcode.
*   **Pre-trimming (`-t`)**: Use this if there are known low-quality bases at the start of every read before the UMI.
*   **Random Barcode Length (`-r`)**: Default is 5. Adjust this to match your specific experimental design.
*   **Minimum Length (`-k`)**: Reads shorter than this value after barcode removal are discarded (default: 18).

**Expert Tip: Parallel Processing**
Since `nimnexus` reads from `stdin` and writes to `stdout`, use `pigz` for high-speed decompression and compression:
```bash
pigz -cd input.fastq.gz | nimnexus trim -t 1 CTGA,TGAC,GACT,ACTG | pigz -c > processed.fastq.gz
```

### 2. De-duplicating BAM Files (`dedup`)
The `dedup` command removes PCR duplicates. It requires a **sorted** BAM file as input.

**Basic Syntax:**
`nimnexus dedup [options] <BAM>`

*   **Threads (`-t`)**: Increase decompression threads for faster processing (default: 2).
*   **Output Format**: The command outputs **SAM** format to `stdout`. You must pipe this to `samtools` to generate a compressed BAM file.

**Standard Workflow:**
```bash
nimnexus dedup -t 8 sorted_input.bam | samtools view -b > final_deduped.bam
```



## Subcommands

| Command | Description |
|---------|-------------|
| nimnexus dedup | Remove duplicate reads from the sorted bam file |
| nimnexus_trim | Trim the fastq reads |

## Reference documentation
- [nimnexus GitHub Repository](./references/github_com_Avsecz_nimnexus_blob_master_README.md)
- [nimnexus Package Metadata](./references/github_com_Avsecz_nimnexus_blob_master_nimnexus.nimble.md)