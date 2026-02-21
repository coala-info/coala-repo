---
name: djinn
description: Djinn is a specialized utility for handling the discrepancies between various linked-read sequencing formats.
homepage: https://github.com/pdimens/djinn
---

# djinn

## Overview
Djinn is a specialized utility for handling the discrepancies between various linked-read sequencing formats. It acts as a bridge between different platform-specific data structures, allowing you to standardize barcodes and file formats for downstream analysis or public repository submission. Use this skill to manage the complexities of linked-read metadata, specifically when working with 10X Genomics, haplotagging, stLFR, and TELLseq data.

## Installation
The tool is primarily distributed via Bioconda:
```bash
conda install bioconda::djinn
```

## Common CLI Patterns

### Format Conversion
Djinn's primary utility is converting between FASTQ types and barcode styles.
- **NCBI Submission**: Convert linked-read FASTQ data into unaligned BAM files. This preserves barcode information in the `BX` or `BC` tags, which is necessary because NCBI often strips custom sequence headers from FASTQ submissions.
- **Platform Interoperability**: Convert between 10X, stLFR, and TELLseq formats using the `fastq` or `sam` subcommands.

### Barcode Management
- **Extraction**: Use Djinn to pull all barcodes from input files to assess library complexity or prepare for demultiplexing.
- **Sorting**: Sort records by barcode rather than genomic position or read name. This is often a prerequisite for tools that process linked reads in "barcode-aware" batches.
- **Filtering**: Separate linked reads from singletons or remove reads with invalid/low-quality barcodes to clean up your dataset.

### Advanced Workflows
- **Hi-C Spoofing (Experimental)**: Convert paired-end linked-read FASTQs into a format compatible with Hi-C pipelines by mix-matching R1s and R2s that share a common barcode.
- **Metadata Assignment**: Use the `assign-mi` and `concat` subcommands (integrated from the Harpy toolkit) to manage Molecular Identifier (MI) tags in SAM/BAM files.

## Expert Tips
- **Header Preservation**: When preparing data for NCBI, always prefer the BAM conversion route. Standard FASTQ headers are unreliable for storing barcode metadata during the submission process.
- **Interleaved Data**: When working with paired-end data, check if your input is interleaved; recent updates to Djinn include specific flags to handle interleaved FASTQ streams more efficiently.
- **Parallel Compression**: For large datasets, ensure your environment supports parallel compression to speed up the writing of output FASTQ/BAM files.

## Reference documentation
- [Djinn Overview](./references/anaconda_org_channels_bioconda_packages_djinn_overview.md)
- [Djinn GitHub Repository](./references/github_com_pdimens_djinn.md)
- [Djinn Commits and Subcommands](./references/github_com_pdimens_djinn_commits_main.md)