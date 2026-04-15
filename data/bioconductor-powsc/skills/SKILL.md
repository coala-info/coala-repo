---
name: bioconductor-powsc
description: Bioconductor-powsc performs power analysis and sample size estimation for single-cell RNA-sequencing differential expression experiments using simulation-based modeling. Use when user asks to estimate required cell numbers, simulate realistic scRNA-seq data from pilot parameters, or evaluate differential expression detection power across different experimental scenarios.
homepage: https://bioconductor.org/packages/release/bioc/html/POWSC.html
---

# bioconductor-powsc

name: bioconductor-powsc
description: Power and sample size analysis for single-cell RNA-seq (scRNA-seq) experiments. Use this skill to estimate required cell numbers, simulate realistic scRNA-seq data based on parameters, and evaluate DE detection power across different cell types and experimental scenarios.

# bioconductor-powsc

## Overview

POWSC (POWer analysis for SCrna-seq) is a simulation-based tool for power evaluation and sample size recommendation in single-cell RNA-sequencing differential expression (DE) analysis. It models scRNA-seq data using a mixture of zero-inflated Poisson (ZIP) and log-normal Poisson (LNP) distributions. The package supports two primary DE forms: phase transition (changes in the proportion of expressing cells) and magnitude tuning (changes in expression levels).

## Core Workflow

### 1. Parameter Estimation
Before simulating data, you must estimate parameters from a pilot or template dataset (SingleCellExperiment object or matrix).

```r
library(POWSC)
# For a single cell type
est_Paras = Est2Phase(sce_object)
```

### 2. Power Estimation (Quick Start)
The `runPOWSC` function provides a high-level wrapper for the entire pipeline, including simulation and power calculation.

```r
# sim_size: vector of cell numbers to test
# DE_Method: "MAST" is commonly used
pow_rslt = runPOWSC(sim_size = c(100, 200, 500), 
                    est_Paras = est_Paras, 
                    per_DE = 0.05, 
                    DE_Method = "MAST", 
                    Cell_Type = "PW")
```

### 3. Two-Group Comparison (Within Cell Type)
To compare the same cell type across two conditions (e.g., Case vs. Control):

```r
# Simulate data for two groups based on estimated parameters
simData = Simulate2SCE(n = 100, estParas1 = est_Paras, estParas2 = est_Paras)

# Run DE analysis
de_results = runDE(simData$sce, DE_Method = "MAST")

# Evaluate power for discrete (phase transition) and continuous (magnitude) changes
pow_discrete = Power_Disc(de_results, simData = simData)
pow_continuous = Power_Cont(de_results, simData = simData)
```

### 4. Multiple-Group Comparison (Between Cell Types)
To evaluate power when comparing multiple cell types with specific mixing proportions:

```r
# 1. Estimate parameters for each cell type
estParas_set = list(
  typeA = Est2Phase(mat_A),
  typeB = Est2Phase(mat_B)
)

# 2. Simulate multiple groups
# multiProb: vector of cell type proportions
sim = SimulateMultiSCEs(n = 500, estParas_set = estParas_set, multiProb = c(0.4, 0.6))

# 3. Run DE and Power analysis for each pairwise comparison
for (comp in names(sim)) {
    de = runDE(sim[[comp]]$sce, DE_Method = "MAST")
    p_disc = Power_Disc(de, sim[[comp]])
    p_cont = Power_Cont(de, sim[[comp]])
}
```

## Key Functions

- `Est2Phase()`: Estimates ZIP/LNP parameters from real data.
- `Simulate2SCE()`: Generates a two-group scRNA-seq dataset.
- `SimulateMultiSCEs()`: Generates datasets for multiple cell types based on proportions.
- `runDE()`: Performs differential expression using methods like "MAST".
- `Power_Disc()`: Calculates power for genes showing "Phase Transition" (0 to non-zero).
- `Power_Cont()`: Calculates power for genes showing "Magnitude Tuning" (expression level changes).

## Tips for Success

- **Sample Size**: When using `runPOWSC`, providing a numeric vector to `sim_size` allows you to visualize the power-to-sample-size relationship.
- **Total Reads vs. Cells**: POWSC can help optimize the tradeoff between sequencing depth and the number of cells captured for a fixed budget.
- **Data Input**: Ensure your input data is a `SingleCellExperiment` object or a raw count matrix.
- **DE Methods**: While "MAST" is the default recommendation in the vignette, ensure the corresponding package is installed.

## Reference documentation

- [POWSC](./references/POWSC.md)