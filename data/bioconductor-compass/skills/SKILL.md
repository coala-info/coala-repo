---
name: bioconductor-compass
description: bioconductor-compass is a Bayesian hierarchical framework for analyzing high-dimensional single-cell data from intracellular cytokine staining assays to identify antigen-specific cell subsets. Use when user asks to model polyfunctional immune responses, calculate functionality scores, or visualize posterior probabilities of antigen specificity from flow cytometry data.
homepage: https://bioconductor.org/packages/release/bioc/html/COMPASS.html
---

# bioconductor-compass

## Overview

COMPASS (Combinatorial Polyfunctionality Analysis of Single Cells) is a Bioconductor package designed to analyze high-dimensional single-cell data, specifically Intracellular Cytokine Staining (ICS) assays. It uses a Bayesian hierarchical framework to model all observed cell subsets (combinations of cytokines) and identifies those most likely to be antigen-specific. It excels at handling the "small cell count" problem in multi-parameter space by regularizing the data, providing posterior probabilities of specificity for each cell subset.

## Core Workflows

### 1. Data Preparation (COMPASSContainer)
The model requires a `COMPASSContainer` object, which bundles cell-level data, total cell counts, and sample metadata.

```r
library(COMPASS)

# data: list of matrices (one per sample). Rows = cells, Cols = markers.
# counts: named integer vector of total cells recovered per sample.
# meta: data.frame with sample_id, individual_id, and group/treatment info.

CC <- COMPASSContainer(
  data = list_of_matrices,
  counts = total_counts_vector,
  meta = metadata_df,
  individual_id = "subject_id",
  sample_id = "sample_id"
)
```

### 2. Fitting the Model
Use the `COMPASS()` function to fit the model. You must define which samples are "treatment" (stimulated) and which are "control" (unstimulated).

```r
fit <- COMPASS(CC,
  treatment = trt == "Stimulated",
  control = trt == "Unstimulated",
  iterations = 40000, # Default is 40000 for production
  replications = 8    # Default is 8
)
```

### 3. SimpleCOMPASS Interface
For users with tabular data (e.g., exported from FlowJo) rather than `GatingSet` objects, `SimpleCOMPASS` provides a direct interface using count matrices.

*   **n_s**: Matrix of stimulated counts.
*   **n_u**: Matrix of unstimulated counts.
*   **Requirements**: Rows must be matched by individual; the last column must be the "all-negative" subset; marker names must use boolean logic (e.g., `IFNg&!IL2`).

```r
fit <- SimpleCOMPASS(
  n_s = stimulated_counts_matrix,
  n_u = unstimulated_counts_matrix,
  meta = metadata_df,
  individual_id = "subject_id"
)
```

## Scoring and Visualization

### Functionality Scores
COMPASS provides two summary scores to quantify a subject's immune response:
*   **Functionality Score (FS)**: The proportion of antigen-specific subsets detected.
*   **Polyfunctionality Score (PFS)**: Similar to FS, but weights subsets by the number of cytokines expressed (higher weight for more cytokines).

```r
fs <- FunctionalityScore(fit)
pfs <- PolyfunctionalityScore(fit)
```

### Visualization
*   **Heatmaps**: Visualize the mean probability of response across categories.
*   **Posterior Measures**: Extract or plot the posterior difference or log-ratio.
*   **Interactive**: Use `shinyCOMPASS(fit)` to launch a web-based visualization tool.

```r
# Standard heatmap
plot(fit)

# Heatmap of posterior differences
plot(fit, measure = PosteriorDiff(fit), threshold = 0)

# Interactive Shiny app
shinyCOMPASS(fit, stimulated = "Treatment", unstimulated = "Control")
```

## Tips for Success
*   **Cell Counts**: COMPASS requires raw cell counts, not proportions or percentages.
*   **Marker Names**: Ensure marker names are consistent. Use `COMPASS:::translate_marker_names()` to convert "Marker+" or "Marker-" notation to the required "Marker" and "!Marker" boolean format.
*   **Filtering**: The `plot` function automatically filters out categories with low response probabilities; you can adjust this with the `threshold` argument.
*   **Integration**: Use `COMPASSContainerFromGatingSet` to seamlessly import data from `flowWorkspace` objects.

## Reference documentation
- [COMPASS](./references/COMPASS.md)
- [SimpleCOMPASS](./references/SimpleCOMPASS.md)