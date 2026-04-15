---
name: bioconductor-powerexplorer
description: PowerExplorer performs power and sample size estimation for RNA-Seq and quantitative proteomics data using simulation-based approaches and Reproducibility-Optimized Test Statistics. Use when user asks to estimate the statistical power of an existing dataset, predict the power for increased sample sizes, or determine the number of replicates needed for future experiments.
homepage: https://bioconductor.org/packages/3.8/bioc/html/PowerExplorer.html
---

# bioconductor-powerexplorer

name: bioconductor-powerexplorer
description: Power and sample size estimation for RNA-Seq and quantitative proteomics data. Use this skill to estimate statistical power of existing datasets or predict power for increased sample sizes using simulations and Reproducibility-Optimized Test Statistics (ROTS).

# bioconductor-powerexplorer

## Overview

PowerExplorer is a Bioconductor package designed to address the critical need for power analysis in high-throughput biological experiments. It uses a simulation-based approach to estimate the distribution parameters of each gene or protein and performs repetitive statistical tests (t-test or Wald-test) to calculate power. It is particularly useful for determining if a current experiment is sufficiently powered or for planning the number of replicates needed for future studies.

## Core Workflow

### 1. Data Preparation

Input data must be a matrix with features (genes/proteins) in rows and samples in columns. A grouping vector is required to define experimental conditions.

```r
library(PowerExplorer)

# Load data
data("exampleProteomicsData")
data_matrix <- exampleProteomicsData$dataMatrix
groups <- exampleProteomicsData$groupVec

# Ensure grouping vector matches column count
ncol(data_matrix) == length(groups)
```

### 2. Power Estimation

Use `estimatePower` to calculate the power of the current dataset.

```r
res <- estimatePower(
  inputObject = data_matrix,
  groupVec = groups,
  dataType = "Proteomics", # Or "RNA-Seq"
  isLogTransformed = FALSE,
  minLFC = 0.5,           # Log2 Fold Change threshold
  alpha = 0.05,          # Type I Error rate
  ST = 50,               # Number of simulations (50+ recommended)
  enableROTS = TRUE,     # Use Reproducibility-Optimized Test Statistic
  seed = 123
)

# View summary
show(res)
```

### 3. Power Prediction

Use `predictPower` to estimate how power changes with different sample sizes (replicate numbers).

```r
res_pred <- predictPower(
  inputObject = res,      # Can take existing estimation object
  groupVec = groups,
  rangeSimNumRep = c(5, 10, 15, 20), # Replicate numbers to test
  ST = 50,
  dataType = "Proteomics"
)
```

### 4. Visualization and Results

PowerExplorer provides specific functions to visualize results and extract top-performing features.

*   **Estimation Plots**: `plotEstPwr(res)` - Generates barplots of power levels, boxplots of power distribution, and a summary table.
*   **Prediction Plots**: `plotPredPwr(res_pred, LFCscale = 0.5)` - Shows power tendency across sample sizes for different LFC ranges.
*   **Listing Results**:
    *   `listEstPwr(res, top = 10)` - List top features by estimated power.
    *   `listPredPwr(res_pred, selected = c("ID1", "ID2"))` - Check predicted power for specific IDs.

## Performance Tips

*   **Parallelization**: For large datasets (>1000 features), enable parallel processing to save time.
    ```r
    library(BiocParallel)
    # For Linux/Mac
    res <- estimatePower(..., parallel = TRUE, BPPARAM = MulticoreParam(4))
    # For Windows
    res <- estimatePower(..., parallel = TRUE, BPPARAM = SnowParam(4))
    ```
*   **Filtering**: Use `minLFC` to filter out features with low fold changes, as these typically have low power and increase computational load.
*   **Simulations**: While `ST = 50` is a starting point, higher values (e.g., 100) provide more stable power estimates at the cost of time.

## Reference documentation

- [PowerExplorer Manual](./references/PowerExplore_vignette.md)