---
name: flaimapper
description: FlaiMapper (Fragment Location Annotation Identification Mapper) is a specialized tool for the computational annotation of fragments derived from small non-coding RNAs (sncRNAs) such as tRNAs, snoRNAs, and snRNAs.
homepage: https://github.com/yhoogstrate/flaimapper/
---

# flaimapper

## Overview

FlaiMapper (Fragment Location Annotation Identification Mapper) is a specialized tool for the computational annotation of fragments derived from small non-coding RNAs (sncRNAs) such as tRNAs, snoRNAs, and snRNAs. It processes high-throughput RNA-seq data to pinpoint the exact genomic boundaries of these fragments. This skill provides guidance on the native command-line interface, alignment strategies, and the necessary preprocessing steps required to generate high-quality fragment annotations.

## Installation and Setup

The recommended way to install FlaiMapper is via Bioconda to ensure all dependencies (like `pysam`) are correctly managed.

```bash
# Create and activate a dedicated environment
conda create -n flaimapper -c bioconda -c conda-forge flaimapper
conda activate flaimapper
```

To verify the installation:
```bash
flaimapper --help
```

## Core Workflow

### 1. Preprocessing and Alignment
Before running FlaiMapper, reads must be processed and aligned. The quality of FlaiMapper's output depends heavily on the alignment strategy:

*   **Adapter Trimming:** Remove sequencing adapters and perform quality trimming.
*   **Read Collapsing:** Collapse identical sequences to unique reads to improve performance.
*   **Alignment Strategy:**
    *   **Full Genome:** Better for discovering fragments from unannotated ncRNAs, but carries a higher risk of false positives due to multi-mapping in repetitive regions.
    *   **ncRNAdb09:** A targeted reference containing annotated small ncRNAs (pre-miRNAs, snoRNAs, tRNAs, etc.) with 10bp genomic extensions. This is faster and more specific for known ncRNA classes.
*   **Post-Alignment:** You must handle multi-mapping reads and ensure the resulting BAM file is **sorted and indexed**.

### 2. Running FlaiMapper
The primary execution requires a BAM file and the corresponding reference FASTA.

```bash
flaimapper --fasta reference.fa --parameters parameters.txt input.bam
```

### Key Arguments
*   `--fasta`: Path to the reference genome or ncRNA database FASTA file used during alignment.
*   `--parameters`: A configuration file defining specific thresholds or run settings.
*   `input.bam`: The sorted and indexed alignment file.

## Expert Tips and Best Practices

*   **BAM Indexing:** FlaiMapper requires random access to the BAM file. Always run `samtools index your_alignment.bam` before starting.
*   **Reference Consistency:** Ensure the FASTA file provided to `--fasta` is the exact same file (or contains the exact same headers) used by the aligner (e.g., Bowtie2 or BWA).
*   **Handling Multi-mapping:** Small RNA reads often map to multiple locations. Use aligner settings that either report a single best hit or use a tool to redistribute multi-mappers before running FlaiMapper to avoid inflated fragment counts.
*   **Memory Optimization:** For large datasets, ensure reads are collapsed. FlaiMapper's performance is more sensitive to the number of unique alignments than the total depth of the library.

## Reference documentation
- [FlaiMapper Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_flaimapper_overview.md)
- [FlaiMapper GitHub Repository](./references/github_com_yhoogstrate_flaimapper.md)