---
name: solexaqa
description: SolexaQA performs quality control and preprocessing of high-throughput sequencing data by analyzing read quality and trimming sequences. Use when user asks to analyze sequencing quality, generate quality heatmaps, perform dynamic trimming of reads, or filter sequences by length.
homepage: http://solexaqa.sourceforge.net/
metadata:
  docker_image: "quay.io/biocontainers/solexaqa:3.1.7.1--h6f6f108_7"
---

# solexaqa

## Overview
The `solexaqa` skill provides a suite of tools for the initial quality control (QC) and preprocessing of high-throughput sequencing data. It is particularly useful for identifying per-tile or per-cycle quality drops in Illumina runs and preparing reads for downstream assembly or mapping by removing low-quality segments. The tool automatically detects FASTQ variants (Sanger, Illumina, Solexa) and handles compressed (.gz) files.

## Core Commands

### 1. Quality Analysis (`analysis`)
Generates statistics and heatmaps to visualize data quality across tiles and cycles.
- **Basic usage**: `SolexaQA++ analysis input.fastq`
- **Custom Thresholds**: Use `-p` (probability, default 0.05) or `-h` (Phred score) to define the error cutoff for the "best read segment" calculation.
- **Technology Specifics**: Use `-t` for Ion Torrent or 454 data to handle variable read lengths correctly.
- **Sampling**: For very large files, use `-s <int>` to limit the number of sequences sampled per tile (default is 10,000) to speed up processing.

### 2. Dynamic Trimming (`dynamictrim`)
Crops each read to its longest contiguous segment where quality scores exceed a threshold.
- **Standard Trim**: `SolexaQA++ dynamictrim input.fastq -h 20` (Trims to Phred > 20).
- **BWA Algorithm**: Use `-b` to employ the BWA-style trimming algorithm instead of the default contiguous segment approach.
- **3' Only**: Use `-a` (anchor) to restrict trimming to the 3' end only, preserving the 5' start of the read.

### 3. Length Filtering (`lengthsort`)
Filters trimmed reads to ensure they meet minimum length requirements, essential for maintaining paired-end integrity.
- **Paired-end**: `SolexaQA++ lengthsort -l 50 read1.fastq.trimmed read2.fastq.trimmed`
- **Output**: Generates `.paired` (both kept), `.single` (one kept), and `.discard` files.
- **Syncing**: Use `-c` to remove non-matching reads from two FASTQ files before processing if the inputs are out of sync.

## Expert Tips
- **Execution**: On Linux/macOS, ensure the binary is executable using `chmod +x SolexaQA++`.
- **Visualization**: `solexaqa` requires `R` to be in your system PATH to generate the PDF/PNG graphics. If graphs are missing, verify the `R` installation.
- **Memory/Speed**: Calculating variance (`-v`) or min/max stats (`-m`) significantly increases runtime and memory usage; only use these if detailed tile-level troubleshooting is required.
- **File Naming**: The tool appends suffixes (e.g., `.quality`, `.segments`) to the original filename. Ensure you have write permissions in the input directory or specify an output path with `-d`.

## Reference documentation
- [SolexaQA Home and Manual](./references/solexaqa_sourceforge_net_index.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_solexaqa_overview.md)