---
name: bioconductor-celltrails
description: CellTrails performs de novo chronological ordering and trajectory reconstruction of single-cell expression data using manifold learning. Use when user asks to reconstruct branching trajectories, identify cellular states, calculate pseudotime, or visualize gene expression dynamics across developmental pathways.
homepage: https://bioconductor.org/packages/release/bioc/html/CellTrails.html
---

# bioconductor-celltrails

## Overview
CellTrails is a specialized tool for de novo chronological ordering of single-cell expression data. It uses manifold learning to counteract noise and dropouts, allowing for the reconstruction of complex branching trajectories. It is particularly useful for identifying how cells transition between states and for visualizing gene expression patterns across multiple developmental pathways simultaneously.

## Core Workflow

### 1. Data Preparation and Initialization
CellTrails uses the `SingleCellExperiment` container. Ensure your data is normalized (e.g., log-transformed counts).

```r
library(CellTrails)
library(SingleCellExperiment)

# Load data into a SingleCellExperiment object
# sce <- SingleCellExperiment(assays = list(logcounts = expression_matrix))

# Initialize CellTrails (adds necessary slots)
# CellTrails works on the 'logcounts' assay by default
```

### 2. Feature Selection and Dimensionality Reduction
Identify informative genes and project data into a lower-dimensional space.

```r
# Filter features based on coefficient of variation or specific biological markers
# Perform spectral embedding to learn the manifold
sce <- embedSamples(sce)

# Compute the intrinsic dimensionality of the data
sce <- computeDimensionality(sce)
```

### 3. Trajectory Reconstruction
CellTrails builds a trajectory by clustering states and connecting them via a minimum spanning tree on the manifold.

```r
# Find states (clusters) in the manifold space
sce <- findStates(sce)

# Connect states to form the trajectory graph
sce <- connectStates(sce)

# Fit the trajectory (linear or branching)
sce <- fitTrajectory(sce)
```

### 4. Pseudotime and Branching Analysis
Once the trajectory is fit, calculate the position of each cell along the paths.

```r
# Select a starting state (root) for the trajectory
# showStates(sce) # Visualize to pick a root
sce <- selectRoot(sce, state_id = 1)

# Calculate pseudotime (Latent Time)
sce <- processTrajectory(sce)
```

### 5. Visualization and Expression Dynamics
Visualize the manifold and how specific genes behave across the inferred branches.

```r
# Plot the trajectory manifold
plotManifold(sce, color_by = "State")

# Plot expression of specific genes along the trajectory
plotExpression(sce, features = c("GeneA", "GeneB"), color_by = "Trajectory")

# Visualize "Trail" maps (linearized representations of branches)
plotTrail(sce, "TrailName")
```

## Key Functions Reference
- `embedSamples`: Performs non-linear dimensionality reduction.
- `findStates`: Groups cells into functional states based on manifold coordinates.
- `connectStates`: Determines the topology of the trajectory.
- `fitTrajectory`: Maps cells onto the graph edges.
- `selectRoot`: Defines the biological starting point of the process.
- `plotManifold`: Primary 2D/3D visualization tool for the trajectory.

## Tips for Success
- **Manifold Learning**: The quality of the trajectory depends heavily on the initial embedding. Ensure you have removed low-quality cells and technical artifacts before running `embedSamples`.
- **Root Selection**: The directionality of pseudotime is determined by the root. Use prior biological knowledge (e.g., known marker genes for progenitor cells) to select the starting state.
- **Branching**: CellTrails is robust at identifying multiple bifurcations. Use `plotTrail` to isolate specific lineages if the global manifold is too complex.

## Reference documentation
- [CellTrails: Reconstruction, visualization, and analysis of branching trajectories from single-cell expression data](./references/vignette.md)