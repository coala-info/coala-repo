---
name: coolpuppy
description: coolpuppy performs pile-up analysis on Hi-C contact matrices to identify and quantify recurring genomic interaction patterns like loops and TAD boundaries. Use when user asks to perform aggregate peak analysis, normalize pile-ups using expected values or random shifts, and visualize averaged genomic interactions.
homepage: https://github.com/open2c/coolpuppy
---


# coolpuppy

## Overview

coolpuppy is a high-performance tool designed to average multiple 2D regions (snippets) of a Hi-C contact matrix to identify recurring patterns of genomic interaction. It is particularly effective for quantifying the strength of loops (APA) or TAD boundaries. By loading chromosomes into memory one by one, it can process millions of potential interactions without the memory bottlenecks common in other pile-up tools. It provides a complete workflow from raw contact matrices to normalized pile-ups and publication-quality visualizations.

## Command Line Usage Patterns

### Basic Pile-up Analysis
The core command is `coolpup.py`. It requires a `.cool` file and a feature file (BED or BEDPE).

```bash
# Basic pile-up of loops defined in a BEDPE file
coolpup.py input.cool loops.bedpe -o output.clpp

# Pile-up of interactions between regions in a BED file
coolpup.py input.cool regions.bed -o output.clpp
```

### Normalization Strategies
Normalization is critical to account for the natural decay of contact probability over distance.

```bash
# Using a pre-calculated expected file (e.g., from cooltools expected-cis)
coolpup.py input.cool features.bed --expected expected.tsv -o output.clpp

# Using random shifts (internal control) if no expected file is available
coolpup.py input.cool features.bed --nshifts 10 -o output.clpp

# Disabling Observed-over-Expected (OoE) normalization per snippet
# (Useful if you prefer to normalize the final average instead)
coolpup.py input.cool features.bed --expected expected.tsv --not-ooe -o output.clpp
```

### Advanced Analysis Options
coolpuppy supports complex workflows like inter-chromosomal analysis and feature grouping.

```bash
# Inter-chromosomal (trans) pile-ups
coolpup.py input.cool features.bed --trans -o output_trans.clpp

# Grouping snippets by a specific column in the BED/BEDPE file
coolpup.py input.cool features.bed --groupby category_column -o grouped_output.clpp

# Handling stranded features (flips snippets on the negative strand)
coolpup.py input.cool features.bed --flip-negative-strand -o stranded_output.clpp

# Restricting analysis to a specific genomic view (e.g., chromosome arms)
coolpup.py input.cool features.bed --view arms.bed -o view_restricted.clpp
```

### Post-processing and Plotting
Use `dividepups.py` to compare conditions and `plotpup` for visualization.

```bash
# Divide one pile-up by another to see enrichment/depletion
dividepups.py pup1.clpp pup2.clpp -o ratio.clpp

# Generate a heatmap grid from the pile-up results
plotpup --input output.clpp --output_path heatmap.png --cols 3
```

## Expert Tips and Best Practices

- **Memory Efficiency**: If you have limited RAM, coolpuppy is superior to `cooltools pileup` because it never stores the entire stack of snippets in memory.
- **Distance Decay**: Always use normalization (either `--expected` or `--nshifts`) when comparing sets of regions at different genomic distances, as the distance-dependent decay of contact probability will otherwise dominate the signal.
- **Header Detection**: coolpuppy CLI automatically detects headers in BED/BEDPE files. Ensure your metadata columns are named if you plan to use `--groupby`.
- **Stripe Analysis**: Use the `--store_stripes` flag if you need to analyze vertical or horizontal enrichment patterns (e.g., for architectural proteins like CTCF) rather than just focal points.
- **Zooming**: If your features are very close to the diagonal, ensure your resolution is high enough; otherwise, use the `--ignore-diags` parameter to avoid artifacts from the main diagonal.



## Subcommands

| Command | Description |
|---------|-------------|
| coolpup.py | Create pileups of Hi-C data around specified genomic features. |
| plotpup.py | Plot pileups from coolpuppy |

## Reference documentation
- [Main README and Introduction](./references/github_com_open2c_coolpuppy_blob_master_README.md)
- [API and CLI Change Logs](./references/github_com_open2c_coolpuppy_blob_master_CHANGELOG.md)