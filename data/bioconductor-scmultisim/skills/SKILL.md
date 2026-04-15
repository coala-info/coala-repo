---
name: bioconductor-scmultisim
description: scMultiSim simulates multimodal single-cell data including RNA, ATAC, velocity, and spatial information from a shared biological ground truth. Use when user asks to generate synthetic single-cell datasets, simulate gene regulatory networks, or benchmark computational methods for trajectory and spatial cell-cell interaction analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/scMultiSim.html
---

# bioconductor-scmultisim

## Overview

`scMultiSim` is a comprehensive simulation tool for generating multimodal single-cell data. It allows for the co-simulation of multiple modalities (RNA, ATAC, Velocity, Spatial) from a shared biological ground truth. The package is particularly useful for benchmarking computational methods because it provides explicit control over the Gene Regulatory Network (GRN), cell differentiation trees (trajectories), and spatial cell-cell interactions (CCI).

## Core Workflow

The typical simulation workflow follows two main stages: generating "true" biological counts and then applying technical noise/batch effects.

### 1. Simulating True Counts
The primary function is `sim_true_counts()`, which takes a list of options.

```R
library(scMultiSim)

# Load sample GRN data
data(GRN_params_100)

# Define simulation parameters
options <- list(
  GRN = GRN_params_100,          # Gene Regulatory Network data frame
  tree = Phyla5(),               # Differentiation tree (phylo object)
  num.cells = 500,               # Number of cells
  num.cifs = 50,                 # Number of Cell Identity Factors
  discrete.cif = FALSE,          # FALSE for trajectory, TRUE for clusters
  do.velocity = TRUE,            # Enable RNA velocity simulation
  atac.effect = 0.5              # Influence of ATAC on RNA
)

# Run simulation
results <- sim_true_counts(options)
```

### 2. Adding Technical Variation
After generating true counts, apply experimental noise and batch effects to mimic real-world data.

```R
# Add technical noise (adds 'counts_obs' to results)
add_expr_noise(results, alpha_mean = 1e4)

# Add batch effects (adds 'counts_with_batches' to results)
divide_batches(results, nbatch = 2, effect = 1)
```

## Key Features and Parameters

### Differentiation Trees
The population structure is controlled by a `phylo` object.
- `Phyla1()`, `Phyla3()`, `Phyla5()`: Built-in trees for 1, 3, or 5 lineages.
- Custom trees: Use `ape::read.tree(text = "(A:1,B:1);")`.

### Gene Regulatory Networks (GRN)
The GRN must be a data frame with columns: `target`, `regulator`, and `effect`.
- If `GRN = NA`, the simulation runs without regulatory constraints.
- `unregulated.gene.ratio`: Controls the proportion of genes not governed by the GRN.

### Spatial Cell-Cell Interactions (CCI)
To simulate spatial data, provide a `cci` list in the options.

```R
options$cci <- list(
  params = data.frame(target=101, regulator=103, effect=5.2),
  grid.size = 15,
  layout = "enhanced", # "layers", "islands", or custom function
  step.size = 0.5,
  max.neighbors = 4
)
results <- sim_true_counts(options)
```

## Accessing and Visualizing Results

The output is a `scMultiSim Environment` object. Access data using `$`:
- `results$counts`: Gene-by-cell RNA counts.
- `results$atac_counts`: Region-by-cell ATAC counts.
- `results$cell_meta`: Metadata (cell type, pseudotime).
- `results$velocity`: Ground truth RNA velocity.

### Visualization Functions
- `plot_tsne(log2(results$counts + 1), results$cell_meta$pop)`: Visualize clusters/trajectories.
- `plot_rna_velocity(results)`: Plot velocity arrows on t-SNE.
- `plot_cell_loc(results)`: Visualize spatial cell locations and interactions.
- `plot_gene_module_cor_heatmap(results)`: Inspect gene-gene correlations.

## Tips for Success
- **Help System**: Use `scmultisim_help("options")` or `scmultisim_help("cci")` to see detailed parameter descriptions directly in the R console.
- **Speed**: For large simulations, set `speed.up = TRUE` in the options list.
- **Interactive Setup**: Use `run_shiny()` to launch a GUI for exploring how different parameters affect the resulting data.
- **CIFs**: `num.cifs` and `diff.cif.fraction` are the most sensitive parameters for controlling how "clean" the trajectories appear.

## Reference documentation
- [Simulating Multimodal Single-cell Datasets](./references/basics.md)
- [Parameter Guide](./references/options.md)
- [Simulating Spatial Cell-Cell Interactions](./references/spatialCCI.md)
- [Getting Started](./references/workflow.md)