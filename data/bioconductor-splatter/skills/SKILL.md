---
name: bioconductor-splatter
description: Bioconductor-splatter provides a unified framework for the comprehensive simulation of single-cell RNA sequencing data. Use when user asks to estimate simulation parameters from real count matrices, generate synthetic datasets with groups or trajectories, or simulate population-scale data with genetic variation.
homepage: https://bioconductor.org/packages/release/bioc/html/splatter.html
---


# bioconductor-splatter

name: bioconductor-splatter
description: Comprehensive simulation of single-cell RNA sequencing (scRNA-seq) data. Use this skill to (1) Estimate simulation parameters from real scRNA-seq count matrices, (2) Generate synthetic datasets with specific biological structures (groups, paths, batches), and (3) Simulate population-scale data with eQTL effects using splatPop.

# bioconductor-splatter

## Overview
The `splatter` package provides a unified framework for simulating scRNA-seq data. Its core model, "Splat," uses a Gamma-Poisson distribution to generate counts, incorporating library size effects, expression outliers, and mean-variance trends. It is highly modular, allowing for the simulation of discrete cell types (groups), continuous differentiation trajectories (paths), and technical variation (batches). The `splatPop` extension further enables population-scale simulations incorporating genetic variation (genotypes/VCF) and eQTL effects.

## Core Workflow: Splat Simulation

The standard workflow involves estimating parameters from a real dataset and then simulating new data.

```r
library(splatter)
library(scater)

# 1. Estimate parameters from a SingleCellExperiment or matrix
# 'sce' is an existing SingleCellExperiment object with raw counts
params <- splatEstimate(sce)

# 2. (Optional) Modify parameters
params <- setParams(params, nGenes = 2000, batchCells = c(100, 100))

# 3. Simulate data
sim <- splatSimulate(params)

# 4. Process for visualization
sim <- logNormCounts(sim)
sim <- runPCA(sim)
plotPCA(sim, colour_by = "Batch")
```

## Simulation Methods

### Discrete Groups (Cell Types)
Use `method = "groups"` to simulate distinct populations with differential expression (DE).
```r
sim.groups <- splatSimulate(
    group.prob = c(0.4, 0.6), 
    method = "groups",
    de.prob = 0.1,
    verbose = FALSE
)
# Access group info in colData(sim.groups)$Group
```

### Continuous Paths (Trajectories)
Use `method = "paths"` to simulate differentiation.
```r
sim.paths <- splatSimulate(
    method = "paths",
    path.from = c(0, 1), # Path 2 starts where Path 1 ends
    path.nSteps = 100,
    verbose = FALSE
)
# Access progression info in colData(sim.paths)$Step
```

### Technical Batches
Control batch effects via `batchCells`.
```r
# Two batches with 50 cells each
sim.batches <- splatSimulate(batchCells = c(50, 50), batch.facLoc = 0.1)
```

## Population Simulation (splatPop)

`splatPop` simulates data for multiple individuals using genotype information.

```r
# Requires VariantAnnotation and genotype data (VCF)
vcf <- mockVCF()
gff <- mockGFF()

# Simulate population means then single-cell counts
sim.pop <- splatPopSimulate(vcf = vcf, gff = gff, sparsify = FALSE)

# Access individual sample info in colData(sim.pop)$Sample
```

## Parameter Management
Parameters are stored in `SplatParams` (or `SplatPopParams`) objects.
- **View:** `print(params)`
- **Get:** `getParam(params, "nGenes")`
- **Set:** `setParams(params, nGenes = 500, lib.loc = 12)`

## Key Output Slots
The simulation returns a `SingleCellExperiment` object:
- `counts(sim)`: The simulated count matrix.
- `rowData(sim)`: Gene-level metadata (BaseGeneMean, OutlierFactor, GeneMean, DEFactors).
- `colData(sim)`: Cell-level metadata (Batch, Group, ExpLibSize, Step).
- `assays(sim)`: Intermediate values like `TrueCounts` (pre-dropout) and `BCV`.

## Tips for Effective Simulation
- **Sparsity:** Use `minimiseSCE(sim)` to reduce the memory footprint of the output object by removing intermediate assays.
- **Comparison:** Use `compareSCEs(list(Real = sce, Sim = sim))` to generate diagnostic plots comparing synthetic data to real data.
- **Reproducibility:** Always set a seed using `set.seed()` or the `seed` parameter in the Params object.
- **Library Size:** If `splatEstimate` warns about normal vs log-normal library sizes, check your input data normalization status; `splatter` expects raw counts.

## Reference documentation
- [splatPop: simulating single-cell data for populations](./references/splatPop.md)
- [Splat simulation parameters](./references/splat_params.md)
- [Introduction to Splatter](./references/splatter.md)