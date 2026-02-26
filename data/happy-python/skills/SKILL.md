---
name: happy-python
description: HapPy assesses the haploidy of a genome assembly by analyzing per-base coverage histograms to identify collapsed and uncollapsed regions. Use when user asks to generate coverage histograms from BAM files, estimate haploidy metrics, or evaluate genome assembly quality.
homepage: https://github.com/AntoineHo/HapPy
---


# happy-python

## Overview

HapPy (Haploidy using Python) is a specialized tool for assessing the haploidy of a genome assembly. It calculates the fraction of the genome that exists in a collapsed state versus an uncollapsed state by analyzing per-base coverage histograms. This is particularly useful for evaluating long-read assemblies of non-model organisms where uncollapsed haplotypes can lead to overestimation of genome size and assembly fragmentation.

## Core Workflow

The tool operates in two primary stages: generating a coverage histogram and then estimating haploidy metrics from that histogram.

### 1. Generating Coverage Histograms
Use the `coverage` module to process a sorted BAM file. This module utilizes `sambamba` internally.

```bash
# Basic usage
happy coverage -d output_directory mapping_file.bam

# Using multiple threads for faster processing
happy coverage -t 8 -d output_directory mapping_file.bam
```

### 2. Estimating Haploidy
Use the `estimate` module on the `.hist` file generated in the previous step. You must provide an estimated haploid genome size.

```bash
# Basic estimation with a 100Mb genome size
happy estimate -s 100M -o results_stats.txt output_directory/mapping_file.bam.hist

# Estimation with visualization (recommended for validation)
happy estimate -s 100M -o results_stats.txt --plot output_directory/mapping_file.bam.hist
```

## Expert Tips and Best Practices

### Peak Limit Calibration
While HapPy can attempt to detect peaks automatically, manual intervention often yields more accurate results for complex genomes. Use the following flags to define the boundaries of the contaminant, diploid, and haploid peaks:
- `--limit-low`: The lower threshold (separates noise/contaminants from the diploid peak).
- `--limit-diploid`: The middle threshold (between the diploid and haploid peaks).
- `--limit-high`: The upper threshold (beyond the haploid peak).

### Handling Noisy Data
If the coverage histogram is noisy, adjust the Savitzky-Golay filter window:
- Use `-w <INT>` (default 41) to change the window length.
- If the data is already clean, use `--no-smooth` to skip the filtering step entirely.

### Peak Detection Tuning
If the tool fails to find peaks in your specific dataset, adjust the SciPy-based peak parameters:
- `-m <INT>`: Minimum peak height (default 15000).
- `-p <INT>`: Minimum peak prominence (default 10000).

### Input Requirements
- **BAM Files**: Must be sorted and indexed (e.g., using `samtools sort` and `samtools index`) before running the `coverage` module.
- **Size Modifiers**: The `-s` (size) argument recognizes K (Kilobases), M (Megabases), and G (Gigabases).

## Reference documentation
- [HapPy GitHub Repository](./references/github_com_AntoineHo_HapPy.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_happy-python_overview.md)