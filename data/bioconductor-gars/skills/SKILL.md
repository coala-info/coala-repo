---
name: bioconductor-gars
description: bioconductor-gars performs feature selection for high-dimensional datasets using a genetic algorithm based on the averaged Silhouette Index. Use when user asks to identify robust subsets of variables, reduce dimensionality in -omics data, or select informative features for multi-class classification problems.
homepage: https://bioconductor.org/packages/release/bioc/html/GARS.html
---

# bioconductor-gars

name: bioconductor-gars
description: Feature selection for high-dimensional datasets using Genetic Algorithms (GA). Use when identifying robust subsets of variables (e.g., genes, miRNAs) in -omics data. This skill is particularly useful for multi-class classification problems where you need to reduce dimensionality without relying on a specific classifier for the selection process.

# bioconductor-gars

## Overview

GARS (Genetic Algorithm for Robust Subsets) is a Bioconductor package designed to identify informative features in high-dimensional datasets. Unlike many GA-based feature selection methods that require a specific classifier (like SVM or Random Forest) to evaluate subsets, GARS uses the **averaged Silhouette Index** calculated after Multi-Dimensional Scaling (MDS). This approach reduces overfitting and is computationally efficient for datasets with tens of thousands of features.

## Core Workflow

### 1. Data Preparation
GARS accepts `SummarizedExperiment`, `matrix`, or `data.frame` objects. For RNA-Seq data, `SummarizedExperiment` is recommended.

```r
library(GARS)
# data: A matrix or SummarizedExperiment (features in rows, samples in columns)
# classes: A factor or vector containing class labels for the samples
```

### 2. Running the Genetic Algorithm
The primary function is `GARS_GA`. It evolves a population of feature subsets over multiple generations.

```r
set.seed(123)
res_GA <- GARS_GA(data = datanorm,
                  classes = class_vector,
                  chr.num = 1000,      # Number of chromosomes (subsets)
                  chr.len = 10,        # Number of features to select
                  generat = 500,       # Max generations
                  co.rate = 0.8,       # Crossover rate
                  mut.rate = 0.01,     # Mutation rate
                  n.elit = 10,         # Number of best solutions preserved
                  type.sel = "RW",     # Selection: "RW" (Roulette Wheel) or "Tournament"
                  type.co = "one.p",   # Crossover: "one.p" or "two.p"
                  n.gen.conv = 80)     # Stop if fitness doesn't improve for N generations
```

### 3. Extracting Results
The output is a `GarsSelectedFeatures` object. Use accessor functions to retrieve data:

*   `MatrixFeatures(res_GA)`: Returns the expression matrix of the selected features.
*   `FitScore(res_GA)`: Returns the maximum fitness score for each generation.
*   `LastPop(res_GA)`: Returns the final population (the first column is the best solution).
*   `AllPop(res_GA)`: Returns a list of all populations across generations.

### 4. Visualization
Monitor the GA performance and feature stability:

```r
# Plot the improvement of fitness over generations
GARS_PlotFitnessEvolution(FitScore(res_GA))

# Plot how frequently specific features were selected across all generations
GARS_PlotFeaturesUsage(AllPop(res_GA), rownames(datanorm), nFeat = 10)
```

## Optimization Strategies

### Finding the Optimal Number of Features
Since `chr.len` is a fixed parameter, you should test a range of values to find the most parsimonious set that yields high fitness:

```r
results_list <- list()
for (n in c(5, 10, 15)) {
  results_list[[as.character(n)]] <- GARS_GA(data = datanorm, classes = cl, chr.len = n, ...)
}
# Compare max(FitScore()) across the results
```

### Custom GA Construction
If the wrapper `GARS_GA` is too restrictive, you can build a custom loop using the underlying modular functions:
*   `GARS_create_rnd_population()`
*   `GARS_FitFun()`
*   `GARS_Elitism()`
*   `GARS_Selection()`
*   `GARS_Crossover()`
*   `GARS_Mutation()`

## Tips for Success
*   **Normalization**: Ensure data is normalized (e.g., VST or CPM for RNA-Seq) before running GARS.
*   **Reproducibility**: Always `set.seed()` as GAs are stochastic.
*   **Computational Cost**: If the dataset is extremely large, start with a smaller `chr.num` (e.g., 100-200) and `generat` (e.g., 50) to test the workflow before running a full production analysis.
*   **Feature Names**: Ensure row names do not contain special characters that might interfere with downstream R modeling (e.g., replace `-` with `_`).

## Reference documentation
- [GARS](./references/GARS.md)