---
name: stoatydive
description: StoatyDive evaluates and classifies the shape of sequencing peak distributions to distinguish between specific and unspecific protein binding events. Use when user asks to evaluate peak quality, classify binding profiles, calculate normalized CV scores, or filter out unspecific background binding sites.
homepage: https://github.com/heylf/StoatyDive
---


# stoatydive

## Overview
StoatyDive is a diagnostic and classification tool for sequencing peak data. It evaluates the "shape" of read distributions within peaks to determine if a protein binding event is highly specific (sharp, centered profiles) or unspecific (broad, noisy profiles). It generates quantitative metrics, including a normalized CV score, and uses unsupervised learning to cluster similar binding patterns, helping researchers filter out low-quality or background binding sites from their datasets.

## Core Command Line Usage

The primary executable is `StoatyDive.py`. It requires three main inputs: a peak file (BED6), a read file (BAM/BED), and a chromosome sizes file.

### Basic Execution
```bash
StoatyDive.py -a peaks.bed -b reads.bam -c chrom_sizes.txt -o output_directory/
```

### Recommended High-Quality Workflow
For most biological datasets, use the following flags to improve centering and reduce noise:
```bash
StoatyDive.py -a peaks.bed -b reads.bam -c chrom_sizes.txt \
    --peak_correction \
    --border_penalty \
    --sm \
    -o output_directory/
```

## Parameter Optimization and Best Practices

### Peak Centering and Normalization
*   **--peak_correction**: Always recommended. It recenters peaks based on the actual summit of the read distribution.
*   **--border_penalty**: Use this to penalize peaks where the signal is concentrated at the edges, which often indicates misaligned or low-quality peaks.
*   **--peak_length [int]**: Use this to force all peaks to a constant length. If omitted, StoatyDive defaults to the maximum peak length found in the input set.

### Profile Classification and Smoothing
*   **--sm**: Enables spline regression smoothing. This is highly recommended to prevent experimental noise from interfering with the clustering algorithm.
*   **--lam [float]**: Controls the smoothing intensity (default: 0.3). 
    *   Increase value (> 0.3) if the profiles look too jagged (underfitting).
    *   Decrease value (< 0.3) if the smoothing is washing out real signal (overfitting).
*   **--maxcl [int]**: Sets the upper bound for k-means clusters (default: 15). The tool optimizes the cluster count internally, so this is a constraint rather than a fixed value.

### Specificity Thresholding
*   **-t, --thresh [float]**: Sets the normalized CV threshold (default: 1.0). 
    *   Values closer to **0** represent unspecific binding.
    *   Values closer to **1** represent specific binding.

## Interpreting Outputs

1.  **final_tab_*.bed**: A BED-formatted file containing the original peak data appended with CV, Normalized CV, and cluster assignments.
2.  **CV Distribution Plots**: 
    *   A distribution shifted to the **right** indicates a high-quality experiment with specific binding.
    *   A distribution shifted to the **left** (near zero) suggests high levels of unspecific background noise.
3.  **Normalized CV Plot**: Use this to visually identify the cutoff point between specific and unspecific sites within your specific experiment.

## Reference documentation
- [StoatyDive GitHub Repository](./references/github_com_heylf_StoatyDive.md)
- [StoatyDive Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_stoatydive_overview.md)