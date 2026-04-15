---
name: bioconductor-mistyr
description: bioconductor-mistyr is a multiview machine learning framework for analyzing spatial omics data to relate marker expressions to their local and tissue-wide spatial contexts. Use when user asks to build spatial modeling workflows, analyze intercellular interactions, or quantify the contribution of different spatial views to marker expression.
homepage: https://bioconductor.org/packages/release/bioc/html/mistyR.html
---

# bioconductor-mistyr

name: bioconductor-mistyr
description: Multiview Intercellular SpaTial modeling framework (MISTy) for analyzing spatial omics data. Use this skill to build workflows that relate marker expressions within a cell (intraview) to different spatial contexts (juxtaview, paraview, or custom views). Ideal for investigating pathway activities, ligand-receptor interactions, and cell-type compositions in spatial transcriptomics (e.g., 10X Visium, IMC).

## Overview

MISTy (Multiview Intercellular SpaTial modeling framework) is an explainable machine learning framework for extracting biological insights from spatially resolved omics data. It models the expression of a marker as a function of:
1.  **Intraview**: Other markers within the same cell/spot.
2.  **Juxtaview**: Markers in the immediate neighborhood.
3.  **Paraview**: Markers in the broader tissue structure (distance-weighted).
4.  **Custom Views**: User-defined spatial or functional contexts.

The workflow typically follows: View Composition -> Model Training -> Result Processing -> Visualization.

## Core Workflow

### 1. View Composition
Every MISTy analysis starts with an initial view (intraview) and adds spatial contexts.

```r
library(mistyR)
library(future)
plan(multisession) # Highly recommended for parallel processing

# 1. Create initial view (intraview) from expression data
# expr: rows = spots/cells, cols = markers
misty.views <- create_initial_view(expr)

# 2. Add spatial views
# pos: rows = spots/cells, cols = coordinates (row/col or x/y)
misty.views <- misty.views %>%
  add_juxtaview(pos, neighbor.thr = 1.5) %>% # Local neighborhood
  add_paraview(pos, l = 10)                  # Broader context (radius l)

# 3. Add custom views (optional)
# custom_data: same row order as expr
misty.views <- misty.views %>%
  add_views(create_view("custom_name", custom_data, "abbrev"))
```

### 2. Model Training
Train models for each marker across all views. By default, MISTy uses Random Forest, but linear models are supported for speed.

```r
# Standard run (Random Forest)
misty.views %>% run_misty(results.folder = "results")

# Faster run (Linear Model)
misty.views %>% run_misty(model.function = linear_model, results.folder = "results_linear")
```

### 3. Result Processing and Visualization
Collect results from one or multiple samples to analyze performance gain and interactions.

```r
# Collect results from one or more folders
misty.results <- collect_results("results")

# 1. Improvement: How much does spatial context help explain the data?
plot_improvement_stats(misty.results, "gain.R2")

# 2. Contributions: Which view is most important for each marker?
plot_view_contributions(misty.results)

# 3. Interactions: Which specific markers drive the relationships?
plot_interaction_heatmap(misty.results, view = "paraview.10", cutoff = 0.5)

# 4. Communities: Group markers with similar interaction patterns
plot_interaction_communities(misty.results, view = "intra")
```

## Common Use Cases

### Pathway Activity Analysis
Combine MISTy with `decoupleR` to model spatial relationships between pathway activities (e.g., PROGENy scores) instead of raw gene counts.
- Use `run_mlm()` from `decoupleR` to estimate activities.
- Create the intraview from these activity scores.

### Ligand-Receptor Interactions
Investigate if the presence of a ligand in the neighborhood (paraview) explains the expression of a receptor in the spot (intraview).
- Create an intraview of receptors.
- Create a paraview of ligands.
- Run MISTy and check the interaction heatmap for the ligand paraview.

### Structural Analysis (Deconvolution)
Analyze cell-type colocalization using proportions from tools like `cell2location` or `DOT`.
- Intraview: Cell type proportions in the spot.
- Paraview: Cell type proportions in the neighborhood.
- High `gain.R2` for a cell type indicates its presence is strongly influenced by the surrounding tissue architecture.

## Tips for Success
- **Coordinates**: Use pixel coordinates (e.g., `imagerow`, `imagecol`) rather than integer grid coordinates for 10X Visium to account for hexagonal packing and shifts.
- **Normalization**: Always normalize data (e.g., `SCTransform` or `vst`) before running MISTy.
- **Filtering**: Filter for genes expressed in at least 5% of spots to reduce noise and computation time.
- **Caching**: MISTy caches views and models by default. Use `clear_cache()` if you change parameters but keep the same variable names.
- **Signatures**: Use `extract_signature()` to get performance, contribution, or importance vectors for downstream PCA or clustering across multiple samples.

## Reference documentation
- [Learning functional and structural spatial relationships with MISTy](./references/FunctionalAndStructuralPipeline.Rmd)
- [Functional analysis with MISTy - pathway activity and ligand expression](./references/FunctionalPipelinePathwayActivityLigands.Rmd)
- [Functional analysis with MISTy - pathway specific genes](./references/FunctionalPipelinePathwaySpecific.Rmd)
- [Structural analysis with MISTy - based on cell2location deconvolution](./references/MistyRStructuralAnalysisPipelineC2L.Rmd)
- [Structural analysis with MISTy - based on DOT deconvolution](./references/MistyRStructuralAnalysisPipelineDOT.Rmd)
- [MISTy representation based analysis of IMC breast cancer data](./references/ReproduceSignaturePaper.Rmd)
- [mistyR and data formats](./references/mistyDataFormats.Rmd)
- [Modeling spatially resolved omics with mistyR](./references/mistyR.Rmd)
- [Modeling spatially resolved omics with mistyR (Markdown)](./references/mistyR.md)