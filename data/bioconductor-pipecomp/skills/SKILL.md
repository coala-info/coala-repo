---
name: bioconductor-pipecomp
description: This tool benchmarks and evaluates multi-step computational pipelines using the pipeComp framework. Use when user asks to define pipeline objects, run benchmarks across parameter combinations, aggregate evaluation metrics, or visualize pipeline performance results.
homepage: https://bioconductor.org/packages/release/bioc/html/pipeComp.html
---

# bioconductor-pipecomp

name: bioconductor-pipecomp
description: Benchmarking and evaluation of computational pipelines using the pipeComp framework. Use this skill to define PipelineDefinition objects, run benchmarks across multiple datasets and parameter combinations, aggregate evaluation metrics, and visualize results (heatmaps, elapsed time, and accuracy curves).

## Overview
The `pipeComp` package provides a structured S4 framework for benchmarking multi-step bioinformatics pipelines. It is built around the `PipelineDefinition` class, which defines a sequence of steps, and the `runPipeline` function, which executes all combinations of parameters while avoiding redundant computations. While it includes pre-defined pipelines for scRNA-seq and Differential Expression Analysis (DEA), it can be extended to any modular workflow.

## Core Workflow

### 1. Define a Pipeline
A pipeline is a list of functions where each function represents a step.
```r
library(pipeComp)

# Define steps
my_pip <- PipelineDefinition(list(
  step1 = function(x, param1) { 
    # process x
    x 
  },
  step2 = function(x, method_name) {
    # Use get() to call a wrapper function by name
    get(method_name)(x)
  }
))
```

### 2. Add Evaluation Functions
Evaluation functions take the output of a step and return metrics (usually a vector or data.frame).
```r
stepFn(my_pip, step="step2", type="evaluation") <- function(x) {
  c(metric1 = mean(x), metric2 = sd(x))
}
```

### 3. Set Alternatives and Run
Define the parameter space as a named list and execute the benchmark.
```r
alternatives <- list(
  param1 = c(10, 20),
  method_name = c("my_wrapper_A", "my_wrapper_B")
)

# datasets can be a list of objects or paths to RDS files
res <- runPipeline(datasets, alternatives, my_pip, output.prefix="bench_")
```

## Specialized Pipelines

### scRNA-seq Clustering
Use `scrna_pipeline()` to get a pre-defined pipeline for single-cell analysis.
- **Variants**: Supports "seurat" or "sce" (SingleCellExperiment) backbones.
- **Steps**: Doublet detection, filtering, normalization, feature selection, dimensionality reduction, and clustering.
- **Wrappers**: Load standard wrappers via `source(system.file("extdata", "scrna_alternatives.R", package="pipeComp"))`.

### Differential Expression (DEA)
The DEA pipeline typically involves filtering, SVA/batch correction, and the DEA method itself.
- **Evaluation**: Uses `evaluateDEA` to compare results against a "truth" (expected logFC and DE status) stored in metadata.

## Result Analysis and Visualization

### Accessing Results
The output of `runPipeline` is a `SimpleList`:
- `res$evaluation`: Aggregated metrics per step.
- `res$elapsed`: Timing information (stepwise and total).

### Visualization
- **Heatmaps**: `evalHeatmap(res, step="clustering", what=c("ARI", "MI"), agg.by=c("norm"))`
- **Execution Time**: `plotElapsed(res, agg.by="norm")`
- **Filtering Bias**: `scrna_evalPlot_filtering(res)`
- **Silhouette Width**: `scrna_evalPlot_silh(res)`
- **DEA Curves**: `dea_evalPlot_curve(res, agg.by=c("sva.method"))`

## Advanced Usage

### Filtering Combinations
To run only specific parameter combinations, use `buildCombMatrix()` and subset the resulting data frame before passing it to the `comb` argument of `runPipeline`.

### Merging Results
If benchmarks were run separately (e.g., on different machines or at different times), use `readPipelineResults()` followed by `mergePipelineResults()` and `aggregatePipelineResults()`.

### Error Handling
Set `skipErrors=TRUE` in `runPipeline` to ensure the entire benchmark doesn't fail due to one problematic parameter combination. Failed runs can be debugged using the detailed error report provided in the output.

## Reference documentation
- [The pipeComp framework](./references/pipeComp.md)
- [The DEA PipelineDefinition](./references/pipeComp_dea.md)
- [The scRNA PipelineDefinition](./references/pipeComp_scRNA.md)