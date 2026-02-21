---
name: chromosight
description: Chromosight is a specialized tool for pattern recognition in chromosome contact maps.
homepage: https://github.com/koszullab/chromosight
---

# chromosight

## Overview
Chromosight is a specialized tool for pattern recognition in chromosome contact maps. It leverages template matching (convolution) to identify features like loops and boundaries with high sensitivity. It is particularly useful for researchers working with Hi-C data who need to automate the detection of structural elements or quantify the strength of known interactions across different samples.

## Core Workflows

### Pattern Detection
Use the `detect` subcommand to find structural features in a Hi-C matrix.
```bash
# Basic loop detection
chromosight detect input.cool output_prefix

# Optimized detection for specific loop sizes (e.g., 20kb to 200kb)
chromosight detect --threads 8 --min-dist 20000 --max-dist 200000 input.cool output_prefix
```

### Scoring Known Coordinates
Use the `quantify` subcommand to calculate correlation scores for a pre-defined list of genomic pairs (e.g., comparing loop strength between wild-type and mutant).
```bash
# Input bed2d format: chrom1 start1 end1 chrom2 start2 end2
chromosight quantify coordinates.bed2d input.cool output_prefix
```

### Custom Pattern Creation
If the built-in kernels (loops, borders, centromeres, etc.) are insufficient, generate a custom kernel configuration.
```bash
# Generate a config based on a specific pattern in your data
chromosight generate-config --preset loops --click input.cool custom_kernel_prefix
```

## Parameter Tuning & Best Practices

| Parameter | Purpose | Expert Tip |
| :--- | :--- | :--- |
| `--min-dist` | Minimum genomic distance | Set this to at least 2-3x your matrix resolution to avoid diagonal noise. |
| `--pearson` | Detection threshold | Default is `auto`. Decrease this value if you are missing known loops; increase it to reduce false positives. |
| `--perc-zero` | Zero-pixel tolerance | For low-coverage datasets, increase this value to prevent valid regions from being skipped. |
| `--norm` | Normalization | Use `auto` (default) which typically handles balanced/ICE matrices correctly. |

## Output Interpretation
Chromosight generates three primary files:
- `.tsv`: The main results file containing coordinates, bin IDs, and Pearson correlation scores.
- `.json` or `.npy`: Contains the raw windows/sub-matrices extracted around each detected pattern.
- `.pdf`: A "pileup" plot showing the average signal of all detected patterns, useful for visual validation of the run's success.

**Note on Statistics:** The p-values and q-values in the `.tsv` output are best used for ranking calls rather than absolute filtering, as they can be biased by the spatial dependence of Hi-C data.

## Reference documentation
- [Chromosight GitHub Repository](./references/github_com_koszullab_chromosight.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_chromosight_overview.md)