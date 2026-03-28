---
name: ptools_bin
description: ptools_bin is a collection of bioinformatics utilities for managing and converting positional BAM (pBAM) files and processing high-throughput sequencing data. Use when user asks to convert between BAM and pBAM formats, extract Fastq records from 10x Genomics files, retrieve genomic sequences, or filter for unique alignments.
homepage: https://github.com/ENCODE-DCC/ptools_bin
---


# ptools_bin

## Overview

ptools_bin is a specialized collection of bioinformatics utilities developed by the ENCODE-DCC to support high-throughput sequencing data processing. Its primary function is to manage "pBAM" (positional BAM) files, a specific format used within ENCODE pipelines. The toolkit bridges the gap between raw sequencing data, standard BAM files, and the specialized pBAM format, offering both shell-based workflow wrappers and Python-based console scripts for granular data manipulation.

## Core CLI Usage

### Environment Setup
Ensure that `samtools` is installed and available in your system PATH, as it is a hard requirement for most ptools_bin operations.

### BAM and pBAM Conversions
Use these tools to move between standard alignment formats and positional BAMs:
- **pbam2bam**: Convert pBAM files to standard BAM format.
- **makeBAM.sh**: A shell wrapper to generate BAM files.
- **makepBAM_genome.sh**: Generate genomic positional BAMs.
- **makepBAM_transcriptome.sh**: Generate transcriptomic positional BAMs.

### Fastq and 10x Genomics Processing
- **10x_bam2fastq**: Specifically designed to extract Fastq records from 10x Genomics BAM files.
- **makeFastq.sh**: General utility for generating Fastq files from alignment data.

### Sequence Extraction
Retrieve sequences from genome references based on coordinates:
- **getSeq_genome_wN**: Extract sequences including 'N' (ambiguous) bases.
- **getSeq_genome_woN**: Extract sequences while filtering or handling 'N' bases differently.

### Data Filtering and Utilities
- **make_unique / print_unique**: Use these to handle PCR duplicates or filter for unique alignments.
- **compress**: Utility for data compression within the ptools workflow.
- **createDiff / makeDiff.sh**: Generate difference files for comparing datasets or alignments.

## Expert Tips and Best Practices

- **Standardized Entry Points**: Always prefer using the console script entry points (e.g., `pbam2bam`) over calling the underlying Python files directly to ensure the environment and dependencies are handled correctly.
- **Memory Management**: When processing large BAM files with `make_unique` or `pbam_mapped_transcriptome`, ensure your environment has sufficient RAM, as these tools often perform operations that benefit from large buffers.
- **Pipe Integration**: Most ptools_bin utilities are designed to work within Unix pipes. Combine them with `samtools view` to process specific genomic regions without decompressing entire files.
- **Spike-in Handling**: Be aware that recent versions of the ptools suite include logic to skip or specifically handle reads mapped to spike-in sequences (e.g., ERCCs) to avoid polluting biological signal.



## Subcommands

| Command | Description |
|---------|-------------|
| pbam2bam | A tool for converting pBAM files to BAM files, supporting different modes such as genome-based conversion. |
| pbam_mapped_transcriptome | A tool to process mapped transcriptome data. Based on the source code, it requires at least one input file as a positional argument. |

## Reference documentation
- [setup.py - Entry Points and Script List](./references/github_com_ENCODE-DCC_ptools_bin_blob_dev_setup.py.md)
- [README - Requirements and Installation](./references/github_com_ENCODE-DCC_ptools_bin_blob_dev_README.md)