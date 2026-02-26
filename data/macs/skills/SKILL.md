---
name: macs
description: MACS identifies genome-wide protein-DNA interaction sites by analyzing ChIP-Seq data to call peaks. Use when user asks to call peaks, incorporate control samples, adjust peak calling stringency, or handle duplicate reads.
homepage: http://liulab.dfci.harvard.edu/MACS/
---


# macs

## Overview
MACS (Model-based Analysis of ChIP-Seq) is a computational tool designed to identify genome-wide protein-DNA interaction sites. It captures the influence of genome complexity to evaluate the significance of enriched ChIP regions and uses a dynamic Poisson distribution to effectively model the background. This skill provides the necessary command-line patterns to execute peak calling, handle control samples, and optimize detection sensitivity for both narrow and broad peaks.

## Common CLI Patterns

### Basic Peak Calling
To call peaks with a treatment sample and a control (input) sample:
```bash
macs -t treatment.bam -c control.bam -n experiment_name -g hs -f BAM
```
- `-t`: Treatment file (ChIP-seq).
- `-c`: Control file (Input or IgG).
- `-n`: Prefix for output files.
- `-g`: Mappable genome size (e.g., `hs` for human, `mm` for mouse, `ce` for C. elegans, `dm` for fruit fly).
- `-f`: Format of input files (BAM, SAM, BED, ELAND, etc.).

### Peak Calling without Control
If no control sample is available, MACS will use local background to estimate statistics:
```bash
macs -t treatment.bam -n experiment_name -g hs
```

### Adjusting Stringency
Modify the p-value or q-value thresholds to control the number of false positives:
- Use `-p 1e-5` to set a p-value cutoff.
- Use `-q 0.01` (default) to set a False Discovery Rate (FDR) cutoff.

### Handling Duplicate Reads
By default, MACS keeps one read at each genomic location to reduce PCR bias. To change this behavior:
- `--keep-dup 1`: Keep only one read (default).
- `--keep-dup all`: Keep all reads.
- `--keep-dup auto`: MACS calculates the maximum tags at the same location based on binomial distribution.

## Expert Tips
- **Genome Size**: If working with a non-standard organism, provide the actual number of mappable bases instead of the shortcuts (e.g., `-g 1.0e+9`).
- **Shift Size**: MACS automatically builds a model to estimate the fragment size (d). If the model fails, you can manually set the shift size using `--shiftsize` and disable the model with `--nomodel`.
- **Output Files**: MACS generates several files:
    - `_peaks.xls`: Tab-delimited file containing peak information.
    - `_peaks.bed`: Peak locations for viewing in genome browsers (IGV/UCSC).
    - `_summits.bed`: The highest point of each peak, useful for motif discovery.

## Reference documentation
- [macs Overview](./references/anaconda_org_channels_bioconda_packages_macs_overview.md)