---
name: anglerfish
description: Anglerfish demultiplexes Oxford Nanopore reads that were prepared using Illumina adapters to identify and separate samples based on their barcodes. Use when user asks to demultiplex ONT reads with Illumina indices, check pool balancing, assess sample contamination, or verify library insert sizes.
homepage: https://github.com/remiolsen/anglerfish
---

# anglerfish

## Overview

Anglerfish is a specialized bioinformatic tool designed for researchers who use Oxford Nanopore flowcells to sequence libraries originally prepared with Illumina adapters. It identifies and separates reads based on their barcodes, allowing for accurate sample attribution and quality assessment of pooled runs. It is particularly useful for checking pool balancing, assessing contamination, and verifying library insert sizes in long-read sequencing contexts.

## Usage Instructions

### 1. Prepare the Samplesheet
Anglerfish requires a CSV samplesheet to map sample names to their respective indices and FASTQ files. The file follows a specific four-column format:
`SampleName,AdaptorType,Index,FastqPath`

**Common Adaptor Types:**
- `truseq`: For single-indexed Illumina libraries.
- `truseq_dual`: For dual-indexed Illumina libraries.

**Samplesheet Examples:**
- **Dual Index:** `P12864_201,truseq_dual,TAATGCGC-CAGGACGT,/path/to/ONTreads.fastq.gz`
- **Single Index with Wildcard:** `P12345_101,truseq,CAGGACGT,/path/to/*.fastq.gz`

### 2. Execute Demultiplexing
Run the tool using the `run` command and point it to your prepared samplesheet.

```bash
anglerfish run -s /path/to/samples.csv
```

### 3. Best Practices and Expert Tips
- **Wildcard Support:** You can use the `*` wildcard in the FASTQ path column of the samplesheet to process multiple files (e.g., all chunks from a Guppy basecalling run) simultaneously.
- **Hardware Considerations:** If running on Arm64 architecture (like Apple M-series chips), ensure `minimap2` is compiled from source and available in your PATH before installing anglerfish via pip.
- **QC Focus:** Use the output to assess "pool balancing." If one sample has significantly fewer reads than others in the same pool, it may indicate issues with the initial library quantification or pooling ratios.
- **Contamination Checks:** Review the "unmatched" or "cross-talk" statistics in the output to identify potential contamination between samples in the same flowcell.



## Subcommands

| Command | Description |
|---------|-------------|
| anglerfish explore | This is an advanced samplesheet-free version of anglerfish. |
| anglerfish run | Run anglerfish. This is the main command for anglerfish |

## Reference documentation
- [Anglerfish README](./references/github_com_remiolsen_anglerfish_blob_master_README.md)