---
name: bioconductor-benchmarkfdrdata2019
description: This package provides access to benchmarking results and datasets for evaluating False Discovery Rate control methods. Use when user asks to load SummarizedBenchmark objects from the Korthauer and Kimes study, evaluate performance metrics like FDR and TPR, or extend existing benchmarks with new statistical methods.
homepage: https://bioconductor.org/packages/release/data/experiment/html/benchmarkfdrData2019.html
---

# bioconductor-benchmarkfdrdata2019

name: bioconductor-benchmarkfdrdata2019
description: Access and analyze benchmarking results for False Discovery Rate (FDR) control methods. Use this skill to load SummarizedBenchmark objects from the Korthauer and Kimes et al. (2019) study, evaluate performance metrics (FDR, TPR, rejections), and extend existing benchmarks with new FDR-controlling methods using ExperimentHub data.

## Overview

The `benchmarkfdrData2019` package provides a collection of benchmarking results for methods that control the False Discovery Rate (FDR). These results are stored as `SummarizedBenchmark` objects (an extension of `SummarizedExperiment`) and include both simulated (yeast RNA-seq) and biological (ChIP-seq) datasets. This skill enables the retrieval of these datasets via `ExperimentHub`, the calculation of performance metrics, and the integration of new statistical methods into the existing benchmark framework.

## Loading Data from ExperimentHub

Data is retrieved using `ExperimentHub`. You must query the hub for the package name to find specific resource IDs.

```r
library(ExperimentHub)
library(benchmarkfdrData2019)
library(SummarizedBenchmark)

# Query available resources
hub <- ExperimentHub()
bfdrData <- query(hub, "benchmarkfdrData2019")

# Retrieve a specific resource (e.g., ChIP-seq benchmark)
# Common titles: "cbp-csaw-benchmark", "yeast-results-de5"
cbp_id <- bfdrData$ah_id[bfdrData$title == "cbp-csaw-benchmark"]
chipres <- bfdrData[[cbp_id]]

# Retrieve yeast results (returns a list of 100 replicates)
yeastres <- `yeast-results-de5`()
```

**Note:** To use these objects with the latest version of `SummarizedBenchmark`, you must manually initialize the `BenchDesign` slot:
```r
chipres@BenchDesign <- BenchDesign()
```

## Analyzing Benchmark Results

The objects contain a `"bench"` assay with corrected significance values for various methods (e.g., BH, IHW, BL, qvalue).

### Evaluating Performance Metrics
Use `addPerformanceMetric` and `estimatePerformanceMetrics` to compare methods.

```r
# Add a metric (e.g., number of rejections)
chipres <- addPerformanceMetric(chipres, evalMetric = "rejections", assay = "bench")

# Estimate across a range of alpha thresholds
chipdf <- estimatePerformanceMetrics(chipres, 
                                     alpha = seq(0.01, 0.10, by = 0.01), 
                                     tidy = TRUE)
```

### Available Metrics
- `rejections`: Number of rejected hypotheses.
- `FDR`: False Discovery Rate (requires ground truth, available in yeast simulations).
- `TPR`: True Positive Rate (requires ground truth).

## Adding New Methods

You can apply new FDR methods to the original p-values and covariates stored in the objects.

1. **Extract Data:**
   ```r
   dat <- data.frame(pval = assay(chipres)[, "unadjusted"],
                     covariate = rowData(chipres)$ind_covariate)
   ```

2. **Define and Run New Design:**
   ```r
   library(rlang)
   # Define a new method (e.g., standard BH)
   bh_method <- BDMethod(x = p.adjust, params = quos(p = pval, method = "BH"))
   
   # Create BenchDesign and build benchmark
   new_design <- BenchDesign(newBH = bh_method, data = dat)
   new_res <- buildBench(new_design)
   ```

## Workflow Tips

- **IHW/BL Methods:** These often appear multiple times in the results (e.g., `ihw-a01`, `bl-df02`) representing different parameter settings. Filter these in your tidy data frames to match the specific alpha threshold being evaluated.
- **Ground Truth:** Only the yeast in silico datasets (`yeast-results-de5`) contain the ground truth necessary for calculating actual FDR and TPR.
- **Visualization:** The tidy data frames returned by `estimatePerformanceMetrics` are optimized for `ggplot2` plotting (e.g., `aes(x = alpha, y = value, color = label)`).

## Reference documentation
- [Exploring and updating FDR benchmarking results](./references/benchmarkfdrData2019.Rmd)