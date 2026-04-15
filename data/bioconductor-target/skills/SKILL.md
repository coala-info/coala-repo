---
name: bioconductor-target
description: This tool predicts direct gene targets by integrating ChIP-seq binding data with differential expression statistics using the BETA algorithm. Use when user asks to identify target genes for transcription factors or histone markers, calculate gene regulatory potential, or analyze cooperative and competitive binding between two factors.
homepage: https://bioconductor.org/packages/release/bioc/html/target.html
---

# bioconductor-target

name: bioconductor-target
description: Predicts associated peaks and direct gene targets by integrating ChIP-seq binding data and transcriptome (expression) data using the BETA algorithm. Use when analyzing DNA-binding protein targets, histone markers, or cooperative/competitive binding between two factors in R.

# bioconductor-target

## Overview

The `target` package implements the Binding and Expression Target Analysis (BETA) algorithm in R. It integrates genomic binding data (ChIP-seq) with expression data (RNA-seq/Microarray) to identify direct target genes. It calculates a "regulatory potential" for each gene based on the distance and number of nearby binding peaks, then combines this with differential expression statistics to rank and predict functional targets.

## Core Workflow: Single Factor Analysis

To predict direct targets for a single transcription factor or histone mark:

1.  **Prepare Input Data**:
    *   `peaks`: A `GRanges` object containing binding site coordinates.
    *   `regions`: A `GRanges` object containing gene/transcript coordinates (e.g., TSS) and metadata columns for identifiers and differential expression statistics (e.g., t-statistics or log fold change).

2.  **Identify Associated Peaks**:
    Use `associated_peaks` to assign peaks to the nearest regions and calculate individual peak scores based on distance.
    ```r
    library(target)
    ap <- associated_peaks(peaks = real_peaks, regions = real_transcripts, regions_col = 'ID')
    ```

3.  **Predict Direct Targets**:
    Use `direct_targets` to calculate the gene regulatory potential and rank genes by the product of binding potential and expression change.
    ```r
    dt <- direct_targets(peaks = real_peaks, regions = real_transcripts, regions_col = 'ID', stats_col = 't')
    ```

4.  **Visualize and Test Predictions**:
    *   Use `plot_predictions` to generate an Empirical Cumulative Distribution Function (ECDF) plot comparing regulated vs. non-regulated genes.
    *   Use `test_predictions` to statistically verify if regulated genes have higher regulatory potentials than non-regulated ones (Kolmogorov-Smirnov test).

## Advanced Workflow: Two-Factor Interaction

To predict cooperative or competitive binding between two factors (x and y):

1.  **Define Regulatory Interaction (RI)**:
    Calculate $RI$ as the product of signed statistics from two comparable perturbation experiments.
    *   **Positive RI**: Suggests cooperative binding.
    *   **Negative RI**: Suggests competitive binding.

2.  **Rank Product Calculation**:
    Calculate the rank product ($RP_g$) using the rank of the regulatory potential ($R_{gb}$) and the rank of the interaction term ($RI_{ge}$).
    $$RP_g = \frac{R_{gb} \times RI_{ge}}{n^2}$$

## Key Functions

*   `associated_peaks(peaks, regions, regions_col)`: Returns `GRanges` of peaks with `assigned_region`, `distance`, and `peak_score`.
*   `direct_targets(peaks, regions, regions_col, stats_col)`: Returns `GRanges` of regions with `score` (regulatory potential), `stat`, and `rank` (rank product).
*   `plot_predictions(rank, group, colors, labels, ...)`: Plots ECDF of ranks across different gene groups.
*   `test_predictions(rank, group, compare, alternative)`: Performs KS test to compare distributions of ranks between groups.

## Data Requirements

*   **Genomic Coordinates**: Must use `GenomicRanges` objects. Ensure chromosome naming (e.g., "chr1") is consistent between peaks and regions.
*   **Statistics**: The `stats_col` should ideally be a signed statistic (like a t-statistic) where the sign indicates the direction of regulation (up/down).

## Reference documentation

- [Using the target package](./references/target.md)
- [Using target to predict combined binding](./references/extend-target.md)