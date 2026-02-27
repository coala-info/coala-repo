---
name: bioconductor-summarizedbenchmark
description: This tool provides a standardized framework for benchmarking computational methods by organizing experimental designs, tracking parameters, and evaluating performance metrics. Use when user asks to compare different R functions or external software, manage benchmark metadata, calculate performance metrics like TPR or FDR, and visualize results through ROC curves or method overlaps.
homepage: https://bioconductor.org/packages/3.8/bioc/html/SummarizedBenchmark.html
---


# bioconductor-summarizedbenchmark

name: bioconductor-summarizedbenchmark
description: Use this skill to perform benchmarking of computational methods using the SummarizedBenchmark R package. It is applicable for organizing benchmark comparisons, tracking method parameters, managing software versions, and evaluating performance metrics (e.g., TPR, FDR, ROC curves) across multiple datasets. Use when you need to compare different R functions or external software wrappers on genomic data (e.g., differential expression, scRNA-seq simulation, or p-value adjustment).

## Overview

The `SummarizedBenchmark` package provides a standardized framework for benchmarking computational methods. It separates the experimental design (methods and parameters) from the execution and evaluation. The workflow centers around two main objects:
1. **BenchDesign**: A container for the data and the methods (functions + parameters) to be tested.
2. **SummarizedBenchmark**: An S4 object (extending `SummarizedExperiment`) containing the results of the benchmark, metadata about the software versions used, and performance metrics.

## Typical Workflow

### 1. Initialize a BenchDesign
Create a container for your benchmark. You can initialize it with or without data.
```r
library(SummarizedBenchmark)
library(magrittr)

# Initialize with data
bd <- BenchDesign(data = my_data_list)
```

### 2. Add Methods
Methods are added using `addMethod`. Parameters must be wrapped in `rlang::quos()` to allow for delayed evaluation on the data object.
```r
bd <- bd %>%
  addMethod(label = "method_a",
            func = p.adjust,
            params = rlang::quos(p = pvals, method = "BH")) %>%
  addMethod(label = "method_b",
            func = my_custom_wrapper,
            params = rlang::quos(input = counts, threshold = 0.05),
            post = function(x) { x$results }) # Optional post-processing
```

### 3. Execute the Benchmark
Run the methods on the data to produce a `SummarizedBenchmark` object.
```r
sb <- buildBench(bd, truthCols = "ground_truth_column")
```

### 4. Evaluate Performance
Add metrics to evaluate the results. You can use built-in metrics or define custom functions.
```r
# View available built-in metrics
availableMetrics()

# Add metrics to the object
sb <- addPerformanceMetric(sb, 
                            evalMetric = c("TPR", "FDR", "rejections"), 
                            assay = "default")

# Calculate metrics
metrics_res <- estimatePerformanceMetrics(sb, alpha = 0.05, tidy = TRUE)
```

### 5. Visualization
The package provides built-in plotting functions for common benchmark visualizations.
```r
# Plot ROC curves
plotROC(sb)

# Plot overlap of rejections (UpSet plot)
plotMethodsOverlap(sb, alpha = 0.05)
```

## Advanced Features

### Benchmarking Non-R Tools
To benchmark command-line tools, write an R wrapper function that uses `system()` calls, captures the output files, and imports them back into R (e.g., using `read.table` or `tximport`). Pass this wrapper to `addMethod`.

### Handling Complex Outputs
If methods return complex objects (like `SingleCellExperiment`) rather than vectors, specify `post = list` in `addMethod` to wrap outputs. You can then use custom `evalFunction` logic in `addPerformanceMetric` to extract specific values from these objects for comparison.

### Parallelization
`buildBench` supports `BiocParallel`. Pass a `BPPARAM` object to parallelize across methods.
```r
sb <- buildBench(bd, parallel = TRUE, BPPARAM = MulticoreParam(4))
```

## Reference documentation

- [SummarizedBenchmark: General Introduction and Class Details](./references/SummarizedBenchmark.md)
- [Quantification Benchmark: Benchmarking Non-R Tools](./references/QuantificationBenchmark.md)
- [Single-Cell Case Study: Complex Outputs and Simulations](./references/SingleCellBenchmark.md)
- [Appendix: Data Preparation and Manual Construction](./references/Appendix.md)