---
name: umitools
description: umitools manages Unique Molecular Identifiers (UMIs) in sequencing data to identify and handle PCR duplicates. Use when user asks to parse UMI sequences from FASTQ files, reformat reads for alignment, or mark PCR duplicates in BAM files.
homepage: https://github.com/weng-lab/umitools
---


# umitools

## Overview

umitools is a specialized toolset designed to manage Unique Molecular Identifiers (UMIs) in high-throughput sequencing workflows. It addresses the challenge of PCR duplication by providing utilities to parse UMI sequences from raw reads and subsequently mark or remove duplicates in aligned data. It is particularly effective for small RNA-seq and standard RNA-seq pipelines where distinguishing between biological replicates and technical artifacts is critical.

## Installation

Install the toolset using pip:

```bash
pip3 install umitools
```

## Common Workflows

### 1. Processing Small RNA-seq Data
Small RNA-seq typically involves identifying UMIs at both the 5' and 3' ends.

**Identify and Reformat UMIs:**
```bash
umitools reformat_sra_fastq -i clipped.fq.gz -o sra.umi.fq -d sra.dup.fq
```
*   `-i`: Input clipped FASTQ file.
*   `-o`: Output for non-duplicate reads.
*   `-d`: Output for identified duplicates.

**Troubleshooting Quality:**
To identify reads with improper or missing UMIs for quality control:
```bash
umitools reformat_sra_fastq -i clipped.fq.gz -o sra.umi.fq -d sra.dup.fq --reads-with-improper-umi sra.improper_umi.fq
```

### 2. Processing Standard RNA-seq Data
For standard RNA-seq, UMIs are usually parsed from paired-end reads before alignment.

**Step 1: Parse UMIs from Paired-End Reads**
```bash
umitools reformat_fastq -l r1.fq.gz -r r2.fq.gz -L r1.fmt.fq.gz -R r2.fmt.fq.gz
```
*   `-l` / `-r`: Input left and right reads.
*   `-L` / `-R`: Output reformatted left and right reads containing UMI info.

**Step 2: Mark PCR Duplicates**
After aligning the reformatted reads (e.g., using STAR) and generating a BAM file:
```bash
umitools mark_duplicates -f aligned_sorted.bam -p 8
```
*   `-f`: Input BAM file.
*   `-p`: Number of threads to use.
*   **Result**: Produces a file (e.g., `aligned_sorted.deumi.sorted.bam`) where duplicates are marked with the `0x400` SAM flag.

## Advanced Configuration

### Customizing UMI Locators
If your library preparation uses non-standard UMI locators, you must specify them to ensure proper parsing.

**For RNA-seq:**
Default locators are `GGG`, `TCA`, and `ATC`.
```bash
umitools reformat_fastq [options] --umi-locator GGG,TCA,ATC,TAG
```

**For Small RNA-seq:**
Use patterns where `N` represents the UMI and specific bases represent the fixed locator.
```bash
umitools reformat_sra_fastq [options] --umi-pattern-5 NNNCGANNNTACNNN --umi-pattern-3 NNNGTCNNNTAGNNN
```

## Expert Tips

*   **Duplicate Removal**: `umitools mark_duplicates` only marks the reads. To physically remove them for downstream tools that don't recognize the `0x400` flag, use samtools:
    ```bash
    samtools view -b -h -F 0x400 input.deumi.sorted.bam > output.filtered.bam
    ```
*   **Pre-processing**: Always remove adapters before running `reformat_sra_fastq`. A common adapter for small RNA-seq is `TGGAATTCTCGGGTGCCAAGG`.
*   **Alternative Command Names**: Subcommands can be called as standalone scripts (e.g., `umitools mark_duplicates` is equivalent to `umi_mark_duplicates`).
*   **Simulation**: Use `umi_simulator` to run in silico PCR simulations to test your UMI recovery rates and deduplication logic.



## Subcommands

| Command | Description |
|---------|-------------|
| umi_mark_duplicates | A pair of FASTQ files are first reformatted using reformat_umi_fastq.py and then is aligned to get the bam file. This script can parse the umi barcode in the name of each read to mark duplicates. This script is also known as umitools mark. |
| umi_reformat_fastq | A script to reformat reads in a UMI fastq file so that the name of each record contains the UMI. This script is also known as umitools extract. |
| umi_reformat_sra_fastq | A script to process reads in from UMI small RNA-seq. This script can handle gzipped files transparently. This script is also known as umitools extract_small. |
| umitools | See https://github.com/weng-lab/umitools for more information.               For UMI RNA-seq: First, use umitools reformat_fastq to identify               UMIs in UMI RNA-seq. Then, use umitools mark_duplicates to mark               PCR duplicates. For UMI small RNA-seq: Use umitools               reformat_sra_fastq to identify UMIs and PCR duplicates. To               simulate UMIs, use umitools simulate. |

## Reference documentation
- [umitools GitHub Repository](./references/github_com_weng-lab_umitools.md)