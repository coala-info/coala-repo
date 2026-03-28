---
name: chip-r
description: ChIP-R identifies reproducible genomic regions across multiple biological replicates using a rank product statistic. Use when user asks to find consistent ChIP-seq peaks, evaluate peak significance across replicates, or identify high-confidence genomic regions without using IDR.
homepage: https://github.com/rhysnewell/ChIP-R
---


# chip-r

## Overview
ChIP-R provides a statistically robust method to identify reproducible genomic regions across any number of biological replicates. Unlike simple intersections, it uses an adaptation of the rank product statistic to evaluate peak significance across the entire experiment. It is particularly useful for transcription factor (TF) and histone mark studies where traditional IDR (Irreproducible Discovery Rate) might be too restrictive or require specific peak-caller thresholds.

## CLI Usage and Best Practices

### Basic Command Pattern
The core command requires a list of input files and an output prefix.
```bash
chipr -i rep1.bed rep2.bed rep3.bed -o experiment_results
```

### Key Parameters
- `-m, --minentries`: The minimum number of replicates a peak must appear in to be considered for the intersection. The default is 1, but **2** is generally recommended for better reproducibility.
- `-a, --alpha`: The user-defined significance threshold for "Tier 1" peaks. Default is 0.05.
- `-s, --size`: The minimum peak size (in bp) when reconnecting fragments. Use the default **20** for punctate transcription factors; increase this value for broader histone marks to filter out small, noisy peaks.
- `--rankmethod`: Choose how to rank peaks within replicates. Options include `pvalue` (default), `qvalue`, or `signalvalue`.

### Handling Ties
If multiple peaks have identical scores (e.g., the same p-value), use `--duphandling`:
- `average`: Assigns the average rank to tied entries (default).
- `random`: Randomly rearranges tied entries (requires `--seed` for reproducibility).

## Understanding Output Files
ChIP-R categorizes results into "Tiers" based on confidence:
- `prefix_T1.bed`: **Tier 1**. High-confidence peaks meeting your specific `--alpha` threshold.
- `prefix_T2.bed`: **Tier 2**. Peaks falling within the calculated binomial threshold (reproducible but less significant than T1).
- `prefix_ALL.bed`: All intersected peaks, ordered by significance.
- `prefix_log.txt`: Summary statistics showing the count of peaks in each tier.

## Expert Tips
- **No Relaxed Thresholds**: Unlike IDR, ChIP-R does not require you to call peaks with relaxed thresholds. You can use standard MACS2 or similar peak-caller outputs directly.
- **Input Formats**: Ensure your BED files follow ENCODE specifications (narrowPeak or broadPeak). ChIP-R is also compatible with GEM and SISSR outputs.
- **Entrypoints**: The tool can be invoked via `chipr`, `chip-r`, or `ChIP-R`.



## Subcommands

| Command | Description |
|---------|-------------|
| chipr | Combine multiple ChIP-seq files and return a union of all peak locations and a set confident, reproducible peaks as determined by rank product analysis |
| chipr | Combine multiple ChIP-seq files and return a union of all peak locations and a set confident, reproducible peaks as determined by rank product analysis |

## Reference documentation
- [ChIP-R GitHub README](./references/github_com_rhysnewell_ChIP-R_blob_master_README.md)
- [ChIP-R Setup and Entrypoints](./references/github_com_rhysnewell_ChIP-R_blob_master_setup.py.md)