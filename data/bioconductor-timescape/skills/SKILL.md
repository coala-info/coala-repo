---
name: bioconductor-timescape
description: This tool creates interactive visualizations of clonal evolution in tumors by integrating phylogeny with clonal prevalence data over time. Use when user asks to visualize clonal dynamics, track tumor evolution across time points, or generate TimeScape plots from clonal prevalence and tree edge data.
homepage: https://bioconductor.org/packages/release/bioc/html/timescape.html
---


# bioconductor-timescape

## Overview

The `timescape` package is a Bioconductor tool designed to visualize the clonal evolution of tumors over time. It integrates clonal phylogeny (the ancestral relationships between clones) with clonal prevalence data (the proportion of the tumor composed of each clone at specific time points). The resulting interactive visualization helps researchers track how specific lineages expand or contract, particularly in response to perturbations like treatment.

## Core Workflow

### 1. Data Preparation

To generate a TimeScape, you require two primary data frames:

*   **Clonal Prevalence (`clonal_prev`)**: A data frame with three columns:
    *   `timepoint`: Character, the label for the time point (e.g., "Diagnosis", "Relapse").
    *   `clone_id`: Character, the unique identifier for the clone.
    *   `clonal_prev`: Numeric, the prevalence value (0 to 1).
*   **Tree Edges (`tree_edges`)**: A data frame defining the phylogeny:
    *   `source`: Character, the ID of the parent clone.
    *   `target`: Character, the ID of the child clone.

### 2. Basic Function Call

```r
library(timescape)

# Minimal example
timescape(clonal_prev = my_prevalence_df, 
          tree_edges = my_tree_df)
```

### 3. Advanced Customization

*   **Mutations Table**: To include a searchable mutation table below the plot, provide a `mutations` data frame containing `chrom`, `coord`, `clone_id`, `timepoint`, and `VAF`.
*   **Visual Styling**:
    *   `clone_colours`: A data frame with `clone_id` and `colour` (hex codes).
    *   `alpha`: Numeric (0-100) to set transparency.
    *   `genotype_position`: Set to `"stack"` (default), `"space"`, or `"centre"` to change how clones are layered relative to their ancestors.
*   **Annotations**:
    *   `perturbations`: A data frame with `pert_name` and `prev_tp` (the timepoint occurring *before* the event) to mark clinical interventions on the x-axis.
    *   `xaxis_title`, `yaxis_title`, `phylogeny_title`: Character strings for labeling.

## Interactive Features

The output is an interactive HTML widget (optimized for Chrome):
*   **Mouseover**: View specific prevalence values and IDs.
*   **View Switch**: Toggle between the traditional "TimeScape" (stacked) view and a "Clonal Trajectory" view (individual tracks).
*   **Phylogeny Interaction**: Clicking a node in the phylogeny filters the mutation table (if provided) to that specific clone.
*   **Export**: Buttons are available to download the visualization as PNG or SVG.

## Implementation Tips

*   **Data Consistency**: Ensure that every `clone_id` present in the `clonal_prev` data is accounted for in the `tree_edges` phylogeny.
*   **Timepoint Ordering**: Timepoints on the x-axis follow the order they appear in the `clonal_prev` data frame; ensure they are sorted chronologically before passing them to the function.
*   **Prevalence Logic**: For the "stack" layout, the sum of child prevalences at any time point should not exceed the prevalence of the parent clone.

## Reference documentation

- [TimeScape Vignette](./references/timescape_vignette.md)