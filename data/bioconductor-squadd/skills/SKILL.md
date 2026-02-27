---
name: bioconductor-squadd
description: SQUADD processes and visualizes simulation data from SQUAD software to analyze the dynamics of regulatory network models. Use when user asks to interpolate simulation results, generate response curve matrices, create prediction heatmaps, or assess model coherence using Principal Component Analysis.
homepage: https://bioconductor.org/packages/3.5/bioc/html/SQUADD.html
---


# bioconductor-squadd

## Overview
SQUADD is an R package designed to process and visualize simulation data from SQUAD (Standardized Qualitative Dynamical Systems) software. It bridges Boolean logic and continuous systems by providing tools for interpolation, comparative analysis, and statistical validation of regulatory network models. It is particularly useful for visualizing node behaviors across multiple perturbations and assessing model coherence through Principal Component Analysis (PCA).

## Core Workflow

### 1. Initialize the Service
The package uses S4 classes. You must first create an instance of `SquadSimResServiceImpl` using the `simResService` constructor.

```R
library(SQUADD)

# Define path to folder containing SQUAD .txt result files
fpath <- system.file("extdata", package="SQUADD")
folder <- file.path(fpath, "data_IAA")

# Initialize service
sim <- simResService(
  folder = folder,
  time = 45,              # Time point for interpolation
  ncolor = 5,             # Number of colors for heatmap
  method = "lowess",      # Interpolation method: "lowess" or "linear"
  indexDeno = 1,          # Index of the file to use as reference/denominator
  legend = c("Node1", "Node2", ...) # Names of the components
)
```

### 2. Visualize Simulation Matrix
Use `plotSimMatrix` to view the response curves of specific nodes across all simulated conditions.

```R
# Select specific nodes to display
sim["selectNode"] <- c("DO", "IAA", "BR")

# Generate the matrix plot
plotSimMatrix(sim)
```

### 3. Extract Interpolated Data
To obtain a table of fitted values at the specified time point:

```R
fitted_table <- getFittedTable(sim)
```

### 4. Generate Prediction Heatmaps
`plotPredMap` creates a heatmap showing the ratio of activation states between a condition and the reference (defined by `indexDeno`).

```R
# Generates heatmap (blue intensities indicate activation levels)
plotPredMap(sim)
```

### 5. Assess Model Coherence (PCA)
Use `plotCC` to generate a correlation circle. This helps determine if the model's predictions align with biological expectations (e.g., checking if loss-of-function mutants cluster correctly).

```R
# Provide labels for the conditions (files in the folder)
sim["conditionList"] <- c("WildType", "Mutant1", "Rescue", ...)

# Generate Correlation Circle
plotCC(sim)
```

## Usage Tips
- **File Naming**: SQUAD result files in the target folder should be prefixed with an index number (e.g., `1_normal.txt`, `2_lof.txt`) to ensure correct ordering and reference indexing.
- **Interpolation**: The `lowess` method is generally preferred for smoother curves in oscillatory systems, while `linear` is faster for simple transitions.
- **Model Refinement**: If the correlation circle (`plotCC`) shows high correlation between contradictory biological states (e.g., Wild Type and Loss-of-Function), the model likely needs refinement (changing interaction signs or adding nodes).

## Reference documentation
- [SQUADD](./references/SQUADD.md)
- [SQUADD_ERK](./references/SQUADD_ERK.md)