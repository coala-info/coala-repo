---
name: chip-r
description: ChIP-R identifies consistent genomic signals across multiple biological replicates using rank product statistics and peak fragmentation. Use when user asks to identify reproducible peaks, generate a consensus peak set from replicates, or filter noise from ChIP-seq data.
homepage: https://github.com/rhysnewell/ChIP-R
---


# chip-r

## Overview
ChIP-R (ChIP-seq Reproducibility) is a specialized tool designed to identify consistent genomic signals across multiple biological replicates. Unlike simple intersection methods, it uses an adaptation of the rank product statistic and peak fragmentation to evaluate the reliability of peak calls. It is particularly useful for generating a "consensus" peak set that filters out noise while preserving biological signal that is consistent across replicates, even if the signal strength varies.

## CLI Usage and Best Practices

### Basic Command Pattern
The tool can be invoked using `chipr`, `chip-r`, or `ChIP-R`.
```bash
chipr -i rep1.bed rep2.bed rep3.bed -m 2 -o experiment_reproducible
```

### Input Requirements
- **Format**: Supports ENCODE narrowPeak, broadPeak, or standard BED files.
- **Peak Calling**: You do not need to use relaxed thresholds during initial peak calling (unlike IDR). Standard MACS2 outputs are ideal.

### Parameter Optimization
- **Minimum Overlaps (`-m` / `--minentries`)**: 
  - Default is 2. 
  - For high-stringency requirements or experiments with many replicates (e.g., n > 5), consider increasing this value to ensure the peak is present in a majority of samples.
- **Ranking Method (`--rankmethod`)**:
  - Default is `pvalue`.
  - Use `signalvalue` if your peak caller provides more reliable fold-enrichment values than statistical significance scores.
- **Peak Size (`-s` / `--size`)**:
  - Default is 20bp.
  - **Transcription Factors**: Keep the default or lower for punctate peaks.
  - **Histone Marks**: Increase this value (e.g., 100-500) for broad marks to prevent the tool from outputting small, fragmented "noisy" peaks.
- **Significance Threshold (`-a` / `--alpha`)**:
  - Controls the Tier 1 (T1) output. Default is 0.05.

### Interpreting Results
The tool produces three primary BED files:
1. **`prefix_T1.bed`**: The most confident peaks meeting your specific alpha threshold. Use this for downstream analysis where high precision is required.
2. **`prefix_T2.bed`**: Peaks falling within a calculated binomial threshold. These are generally reproducible but less significant than T1.
3. **`prefix_ALL.bed`**: All intersected peaks ordered by significance. Useful for exploratory analysis.

### Expert Tips
- **Duplicate Handling**: If your replicates have many peaks with identical ranks, use `--duphandling random` with a specific `--seed` to ensure reproducibility of the ChIP-R run itself.
- **Memory/Performance**: ChIP-R is lightweight, but ensure BED files are sorted by coordinate if processing extremely large datasets to improve fragmentation efficiency.

## Reference documentation
- [ChIP-R GitHub Repository](./references/github_com_rhysnewell_ChIP-R.md)
- [ChIP-R Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_chip-r_overview.md)