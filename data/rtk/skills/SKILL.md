---
name: rtk
description: The Rarefaction Toolkit (rtk) rarefies large count tables and calculates diversity measures for ecological and microbiome research. Use when user asks to rarefy OTU or ASV tables, calculate alpha diversity metrics, or estimate rarefaction depth using column sums.
homepage: https://github.com/hildebra/Rarefaction/
---


# rtk

## Overview

The Rarefaction Toolkit (RTK) is a high-performance tool designed to rarefy large count tables (such as OTU or ASV tables) and calculate diversity measures. It is particularly useful for ecological and microbiome research where sequencing depth varies across samples. RTK provides multiple modes to balance speed and memory usage, allowing for the processing of datasets that might otherwise exceed system RAM.

## Core CLI Usage

RTK requires a mode specification followed by input/output parameters.

### Primary Modes
- **memory**: Faster execution; loads the dataset into RAM. Use this for standard datasets.
- **swap**: Uses temporary files to reduce memory footprint. Use this for extremely large datasets that exceed available RAM.
- **colsums**: A utility mode to calculate and report column sums. Use this first to determine an appropriate rarefaction depth.

### Common Command Patterns

**1. Estimate Rarefaction Depth**
Before rarefying, check the sample sums to choose a depth that balances data retention with sample inclusion.
```bash
rtk colsums -i input.tsv -o depth_check/
```

**2. Standard Rarefaction and Diversity Calculation**
Rarefy to a specific depth (e.g., 10,000) with 100 iterations for diversity measures.
```bash
rtk memory -i input.tsv -o results/ -d 10000 -r 100
```

**3. Generating Rarefied Matrices**
To output the actual downsampled tables (not just diversity metrics), use the `-w` flag.
```bash
rtk memory -i input.tsv -o rarefied_tables/ -d 5000 -w 5
```

## Expert Tips and Best Practices

### Input Requirements
- **Format**: RTK expects `.csv` or `.tsv` files.
- **Orientation**: Rarefaction is performed on **columns**. Ensure your samples are columns and your features (OTUs/taxa) are rows.
- **Transposing**: If your data is sample-per-row, transpose it before running RTK. On Linux/macOS, you can use `awk` or a simple Python script to swap axes.

### Parameter Optimization
- **Depth (`-d`)**: You can provide a comma-separated list (e.g., `-d 1000,5000,10000`) to rarefy to multiple depths in a single pass.
- **Threads (`-t`)**: RTK is multi-threaded. Increase `-t` to match your CPU cores for significant speedups on large tables.
- **Reproducibility (`-s`)**: Always provide a seed (e.g., `-s 42`) if you need to generate the exact same rarefied tables in future runs.
- **Disk I/O (`-ns`)**: When writing many rarefied tables (`-w > 0`), use the `-ns` (no swap) flag to prevent the creation of intermediate binary files if you have sufficient RAM, as this reduces disk wear and can improve speed.

### Output Interpretation
- **median_alpha_diversity.tsv**: The most commonly used file; contains the median values across all iterations.
- **richness/evenness.tsv**: Contains the raw values for every repeat, useful for calculating your own statistics or confidence intervals.
- **global_diversity.tsv**: Provides ACE, ICE, and Chao2 estimates for the entire table.

## Reference documentation
- [Rarefaction tool kit - RTK](./references/github_com_hildebra_Rarefaction.md)
- [rtk - rarefaction toolkit for OTU tables](./references/anaconda_org_channels_bioconda_packages_rtk_overview.md)