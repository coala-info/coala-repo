---
name: bioconductor-simpic
description: bioconductor-simpic simulates single-cell ATAC-seq data using a gamma-Poisson model optimized for paired-insertion count matrices. Use when user asks to estimate simulation parameters from existing datasets, generate synthetic single-cell ATAC-seq counts with multiple cell types or batch effects, and compare simulated data against reference experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/simPIC.html
---

# bioconductor-simpic

## Overview
`simPIC` is a Bioconductor package designed to simulate single-cell ATAC-seq data using a gamma-Poisson model. It is particularly optimized for Paired-Insertion Count (PIC) matrices. The package allows users to estimate simulation parameters from existing datasets and then generate synthetic `SingleCellExperiment` objects with controlled cell-type proportions and technical variation (batch effects).

## Core Workflow

### 1. Parameter Estimation
To simulate data that resembles a specific experiment, start by estimating parameters from an existing sparse count matrix (peaks by cells).

```r
library(simPIC)

# counts should be a sparse matrix (dgCMatrix)
# Rows = Peaks, Columns = Cells
est_params <- simPICestimate(counts)

# Optional: Specify peak mean distribution (default is "weibull")
# Options: "weibull", "gamma", "lognormal-gamma", "pareto"
est_params_gamma <- simPICestimate(counts, pm.distr = "gamma")
```

### 2. Basic Simulation
Generate a synthetic dataset using the estimated parameters or default values.

```r
# Simulate using estimated parameters
sim <- simPICsimulate(est_params, nCells = 500, nPeaks = 10000)

# Access results
sim_counts <- counts(sim)
peak_metadata <- rowData(sim)
cell_metadata <- colData(sim)
```

### 3. Simulating Multiple Cell Types (Groups)
To model heterogeneity, use the `method = "groups"` argument.

```r
sim_groups <- simPICsimulate(
    est_params, 
    method = "groups",
    nGroups = 3, 
    group.prob = c(0.5, 0.3, 0.2) # Must sum to 1
)
```

### 4. Simulating Batch Effects
Incorporate technical variation across different experimental runs.

```r
sim_batch <- simPICsimulate(
    est_params,
    method = "groups",
    nGroups = 2,
    nBatches = 2,
    batchCells = c(250, 250) # Number of cells per batch
)
```

## Parameter Management
The `simPICcount` object stores all simulation settings. You can inspect or modify these manually.

*   **Get a parameter:** `simPICget(params, "nPeaks")`
*   **Set parameters:** `setsimPICparameters(params, nPeaks = 2000, nCells = 100)`
*   **Get multiple:** `simPICgetparameters(params, c("nPeaks", "nCells"))`

## Comparison and Validation
Use `simPICcompare` to evaluate how well the simulated data matches the reference data.

```r
# Compare two SingleCellExperiment objects
comparison <- simPICcompare(list(Real = sim_real, Simulated = sim_synthetic))

# Access comparison plots (Means, Variances, LibrarySizes, Zeros, etc.)
comparison$Plots$Means
comparison$Plots$LibrarySizes
```

## Tips for Success
*   **Input Format:** While `simPIC` works with standard count matrices, it is optimized for PIC matrices. Ensure your input matrix has peaks as rows and cells as columns.
*   **Sparsity:** The package uses a Bernoulli distribution to model the high sparsity characteristic of scATAC-seq. If the simulated data is too dense or sparse, check the `sparsity` slot in the parameters.
*   **Distributions:** If the default Weibull distribution does not fit your peak means well, try `pm.distr = "gamma"`.

## Reference documentation
- [simPIC: simulating single-cell ATAC-seq data](./references/vignette.md)