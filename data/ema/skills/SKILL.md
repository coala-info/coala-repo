---
name: ema
description: The `ema` (EMA) tool is a specialized aligner for barcoded sequencing data.
homepage: http://ema.csail.mit.edu/
---

# ema

## Overview
The `ema` (EMA) tool is a specialized aligner for barcoded sequencing data. Unlike general-purpose aligners, EMA leverages the barcode information to resolve ambiguities in read mapping. It works by grouping reads by barcode and using the local context of the barcode "cloud" to place reads more accurately, particularly in genomic regions that are difficult to map with standard short-read technologies.

## Usage Patterns

### Core Workflow
The standard EMA pipeline typically involves three main stages: preprocessing, alignment, and post-processing.

1.  **Preprocessing (Count and Bin):**
    Reads must be preprocessed to count barcode frequencies and bin them for parallel processing.
    ```bash
    ema count -w whitelist.txt fastq_R1.fastq.gz fastq_R2.fastq.gz
    ```

2.  **Alignment:**
    EMA uses a modified version of BWA-MEM for the actual alignment step. It is often run in a "map-only" mode or a full alignment mode depending on the specific library type.
    ```bash
    ema align -r reference.fa -1 fastq_R1.fastq.gz -2 fastq_R2.fastq.gz -w whitelist.txt -p 8 > aligned.sam
    ```

### Key CLI Commands
- `ema count`: Generates barcode frequency statistics.
- `ema preproc`: Prepares FASTQ files by organizing reads by barcode.
- `ema align`: The primary alignment engine that incorporates barcode information into the mapping algorithm.
- `ema select`: Filters alignments based on barcode-aware probability scores.

### Expert Tips
- **Whitelist Importance:** Always use the correct barcode whitelist corresponding to the specific 10x Genomics kit used (e.g., Long Ranger whitelist for Linked-Reads).
- **Memory Management:** EMA can be memory-intensive during the binning phase. Ensure your environment has sufficient RAM relative to the number of unique barcodes in your library.
- **Output Handling:** EMA typically outputs SAM format. It is best practice to pipe this directly into `samtools view -bS` to save disk space and generate BAM files for downstream analysis.

## Reference documentation
- [ema - bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ema_overview.md)