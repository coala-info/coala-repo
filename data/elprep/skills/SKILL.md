---
name: elprep
description: elprep is a high-performance tool for processing SAM and BAM files that executes multiple genomic pipeline steps in a single pass using RAM. Use when user asks to process sequence alignment files, mark duplicates, perform base quality score recalibration, or call variants.
homepage: https://github.com/ExaScience/elprep
---

# elprep

## Overview
elprep is a specialized tool for analyzing sequence alignment files (SAM/BAM) that significantly outperforms traditional pipelines by using a single-pass execution model. Instead of running multiple independent tools that read and write intermediate files, elprep loads data into RAM and applies all filters and processing steps (like BQSR and variant calling) simultaneously. It is optimized for high-memory environments and is not recommended for use on standard laptops or low-end desktops.

## Core CLI Usage

### 1. Preparation of Reference Files
Before running a pipeline, elprep requires references and known sites to be converted into its internal high-performance formats.

*   **Convert FASTA to elfasta:**
    `elprep fasta-to-elfasta reference.fasta reference.elfasta`
*   **Convert VCF to elsites (for BQSR):**
    `elprep vcf-to-elsites known_sites.vcf known_sites.elsites`
*   **Convert BED to elsites:**
    `elprep bed-to-elsites regions.bed regions.elsites`

### 2. The sfm (Split-Filter-Merge) Command
The `sfm` command is the primary entry point for processing. It allows you to chain multiple operations in one command.

*   **Basic Pipeline (Sorting + Duplicate Marking):**
    `elprep sfm input.bam output.bam --mark-duplicates --sorting-order coordinate`

*   **Full Best Practices Pipeline:**
    `elprep sfm input.bam output.vcf --mark-duplicates --sorting-order coordinate --bqsr known_sites.elsites --reference reference.elfasta --haplotypecaller output.vcf`

### 3. Common Command Flags
*   `--mark-duplicates`: Identifies and tags duplicate reads.
*   `--mark-optical-duplicates <file>`: Specifically marks optical duplicates and outputs metrics.
*   `--sorting-order <coordinate|keep|unknown>`: Defines the output sort order. Coordinate sorting is required for most downstream tools.
*   `--bqsr <elsites>`: Performs Base Quality Score Recalibration.
*   `--haplotypecaller <vcf>`: Performs variant calling (equivalent to GATK HaplotypeCaller).
*   `--timed`: Outputs timing information for each processing stage.
*   `--log-path <dir>`: Specifies where to store execution logs.

## Expert Tips and Best Practices

*   **Hardware Requirements:** elprep is RAM-intensive. Ensure the server has enough memory to hold the entire BAM file in its uncompressed state. For Whole Genome Sequencing (WGS), this typically requires 256GB+ of RAM.
*   **Avoid Intermediate Files:** One of elprep's main advantages is the lack of intermediate disk I/O. Do not split the command into multiple elprep calls; use the `sfm` command to bundle all filters.
*   **BAM/VCF Support:** elprep 5+ natively supports `.bam` and `.vcf.gz` files. You do not need to pipe through `samtools` or `bcftools` for standard input/output.
*   **CRAM Files:** elprep does not natively support CRAM. Convert CRAM to BAM using `samtools` before processing with elprep.
*   **Single-End Data:** While optimized for paired-end, elprep supports single-end data. Ensure you use version 5.1.2 or later for correct metrics output on single-end inputs.
*   **Temporary Storage:** If memory is a constraint, use the `--tmp-path` flag to specify a fast SSD for overflow, though this will degrade performance compared to pure in-memory execution.



## Subcommands

| Command | Description |
|---------|-------------|
| elprep bed-to-elsites | Convert BED file to ELSIngleSite format. |
| elprep fasta-to-elfasta | Converts a FASTA file to an elFASTA file. |
| elprep filter | Filter SAM/BAM/CRAM files. |
| elprep sfm | sfm parameters: |
| elprep vcf-to-elsites | Converts a VCF file to an ELSIF sites file. |

## Reference documentation
- [elPrep GitHub Repository](./references/github_com_ExaScience_elprep.md)
- [elPrep Version Tags and Features](./references/github_com_ExaScience_elprep_tags.md)