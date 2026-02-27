---
name: bioconductor-optimalflow
description: This package implements an optimal-transport approach to analyze flow cytometry data by grouping similar samples and generating representative templates. Use when user asks to build a database of gated cytometries, generate templates using Wasserstein barycenters, or perform supervised gating and classification on new samples.
homepage: https://bioconductor.org/packages/release/bioc/html/optimalFlow.html
---


# bioconductor-optimalflow

## Overview

The `optimalFlow` package implements an optimal-transport approach for analyzing flow cytometry data. It is designed to handle the variability between different cytometries by grouping similar samples and generating "templates" (artificial cytometries) that represent each group. These templates are then used to guide the supervised gating and classification of new, ungated samples.

## Core Workflow

### 1. Database Preparation
Before analysis, you must assemble a database of gated cytometries. Each entry should contain cell data and population IDs.

```r
library(optimalFlow)
library(optimalFlowData)

# Build a database from existing gated datasets
database <- buildDatabase(
  dataset_names = paste0('Cytometry', c(2:5, 7:9)),
  population_ids = c('Monocytes', 'CD4+CD8-', 'Mature SIg Kappa', 'TCRgd-')
)
```

### 2. Generating Templates
Use `optimalFlowTemplates` to cluster the cytometries in your database and generate representative prototypes.

```r
# Default: Hierarchical clustering with pooling consensus
templates.obj <- optimalFlowTemplates(database = database, templates.number = 5)

# Alternative: Using k-barycenters in Wasserstein space
templates.bary <- optimalFlowTemplates(
  database = database, 
  templates.number = 5, 
  consensus.method = "k-barycenter",
  barycenters.number = 4
)
```

### 3. Supervised Classification
Once templates are created, use `optimalFlowClassification` to gate a new, unlabeled cytometry.

```r
# Classify a new cytometry using Quadratic Discriminant Analysis (default)
classification <- optimalFlowClassification(
  input_data = test.cytometry[, 1:10], 
  database = database, 
  templates = templates.obj,
  consensus.method = "pooling"
)

# Access results
assigned_labels <- classification$cluster
closest_template <- classification$assigned.template.index
```

### 4. Evaluation
Compare classification results against ground truth (if available) using F1-scores.

```r
# For hard classification
f1_results <- f1Score(classification$cluster, test.cytometry, noise.types = NULL)

# For fuzzy/voting classification
f1_voting <- f1ScoreVoting(
  classification$cluster.vote, 
  classification$cluster,
  test.cytometry, 
  threshold = 1.01
)
```

## Visualization
The package provides specialized functions to visualize the elliptical distributions of cytometries and templates.

*   `cytoPlotDatabase`: Plots multiple cytometries from a cluster.
*   `cytoPlot`: Plots a single template cytometry.
*   `cytoPlot3d` / `cytoPlotDatabase3d`: 3D versions of the above.

```r
# Visualize the 3rd template in 2D (dimensions 4 and 3)
cytoPlot(templates.obj$templates[[3]], dimensions = c(4, 3))
```

## Key Parameters and Methods

*   **consensus.method**: 
    *   `"pooling"`: Combines data from all cytometries in a cluster (default).
    *   `"k-barycenter"`: Uses Wasserstein barycenters for the template.
    *   `"hierarchical"`: Uses density-based clustering (hdbscan) to find cell types automatically.
*   **classif.method**:
    *   `"qda"`: Quadratic Discriminant Analysis (default).
    *   `"matching"`: Label-transfer via matching initial clusters to template components.
    *   `"random forest"`: Uses a Random Forest classifier trained on the most similar database samples.

## Reference documentation

- [optimalFlow: optimal-transport approach to Flow Cytometry analysis](./references/optimalFlow_vignette.md)