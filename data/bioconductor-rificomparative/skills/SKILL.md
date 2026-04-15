---
name: bioconductor-rificomparative
description: This package compares RNA half-life and intensity data across two conditions to distinguish between transcriptional and post-transcriptional regulation. Use when user asks to compare transcriptomics data across treatments, segment half-life and intensity differences, or identify changes in RNA synthesis and decay rates.
homepage: https://bioconductor.org/packages/release/bioc/html/rifiComparative.html
---

# bioconductor-rificomparative

## Overview

The `rifiComparative` package is designed to compare transcriptomics data (specifically RNA half-life and intensity) across two different conditions or treatments. It serves as a successor to the `rifi` package, providing a workflow to align and segment data from different conditions that might otherwise be impossible to compare due to varying gene structures or fragmentation patterns.

The core logic involves independent segmentation of half-life differences and intensity log2 fold-changes (log2FC). By comparing these segments, the package helps distinguish between transcriptional regulation (synthesis) and post-transcriptional regulation (decay).

## Workflow and Key Functions

### 1. Data Preparation and Joining
To begin, you must have `rifi_fit` or `rifi_stats` objects from two conditions and a differential expression analysis at the probe/bin level.

```r
library(rifiComparative)
library(dplyr)

# Load condition-specific data and differential expression results
# differential_expression must contain: logFC_int, P.Value, position, and strand
inp_s <- loading_fun(stats_se_cdt1, stats_se_cdt2, differential_expression)[[1]]
inp_f <- loading_fun(stats_se_cdt1, stats_se_cdt2, differential_expression)[[2]]

# Combine data by row
data_combined <- joining_data_row(input1 = inp_s, input2 = inp_f)

# Combine data by column for comparison
df_comb <- joining_data_column(data = data_combined)
```

### 2. Penalty Calculation and Segmentation
The package uses dynamic programming for segmentation. You must first determine optimal penalties for both half-life (HL) and intensity (int).

```r
# Calculate penalties
pen_results <- penalties(df_comb)
penalties_df <- pen_results[[1]]
pen_HL <- pen_results[[2]]
pen_int <- pen_results[[3]]

# Perform fragmentation
# Half-life fragmentation
fragmented_df <- fragment_HL(
    probe = penalties_df,
    cores = 2,
    pen = pen_HL[[1]][[9]],
    pen_out = pen_HL[[1]][[10]]
)

# Intensity fragmentation
fragmented_df <- fragment_inty(
    probe = fragmented_df,
    cores = 2,
    pen = pen_int[[1]][[9]],
    pen_out = pen_int[[1]][[10]]
)
```

### 3. Statistical Analysis and Output Generation
After fragmentation, perform statistical tests to identify significant segments and adjust the fragments to the genome annotation.

```r
# Run t-tests on segments
stats_results <- statistics(data = fragmented_df)
stats_df <- stats_results[[1]]

# Preprocess GFF3 for annotation
annot_list <- gff3_preprocess(path = "path/to/your/annotation.gff")

# Generate final summary table with synthesis and decay rates
final_summary <- adjusting_HLToInt(data = stats_df, annotation = annot_list[[1]])
```

### 4. Visualization
`rifiComparative` provides specialized plots to interpret the relationship between synthesis and decay.

```r
# Genome-wide fragment comparison
rifi_visualization_comparison(
    data = data_combined,
    data_c = stats_df,
    genomeLength = annot_list[[2]],
    annot = annot_list[[1]]
)

# Comparative figures (Decay vs Synthesis, Volcano, Density, etc.)
figures_fun(
    data.1 = final_summary, 
    data.2 = data_combined, 
    input.1 = df_comb, 
    input.2 = differential_expression, 
    cdt1 = "condition1_name", 
    cdt2 = "condition2_name"
)
```

## Key Output Columns
*   **log2FC(decay_rate)**: Comparison of RNA decay between conditions.
*   **log2FC(synthesis_rate)**: Calculated as the sum of decay rate log2FC and intensity log2FC.
*   **p_value**: Marked with `*` if either the half-life or intensity fragment shows significant change.

## Reference documentation
- [rifiComparative Vignette (Rmd)](./references/rifiComparative.Rmd)
- [rifiComparative Vignette (Markdown)](./references/rifiComparative.md)