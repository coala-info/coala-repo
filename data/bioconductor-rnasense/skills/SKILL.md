---
name: bioconductor-rnasense
description: RNAsense analyzes time-resolved RNA-seq data to identify stage-specific gene sets by combining differential expression analysis with switch point detection. Use when user asks to compare gene expression time curves between conditions, detect fold changes at specific time points, or identify significant up- or downregulation switches in expression profiles.
homepage: https://bioconductor.org/packages/release/bioc/html/RNAsense.html
---

# bioconductor-rnasense

name: bioconductor-rnasense
description: Analyze time-resolved RNA-seq data to identify stage-specific gene sets. Use this skill when comparing gene expression time curves between two experimental conditions (e.g., wild-type vs. mutant) to detect fold changes at specific time points and identify "switches" (significant up- or downregulation) in expression profiles.

# bioconductor-rnasense

## Overview

RNAsense facilitates the interpretation of time-series RNA-seq data by combining two analytical approaches:
1. **Differential Expression (Fold Change):** Comparing two conditions at each discrete time point.
2. **Switch Detection:** Identifying the specific time point where a gene's expression profile significantly shifts (up or down) within a single condition.

The package integrates these results to visualize stage-specific gene sets (SSGS) via heatmaps and Fisher's exact tests.

## Workflow and Core Functions

### 1. Data Preparation
Data must be formatted as a `SummarizedExperiment` object.
- **rowData:** Must contain gene names/identifiers.
- **colData:** Must contain `condition`, `time`, and `replicate`.
- **Filtering:** It is recommended to filter out low-count genes before analysis.

```r
library(RNAsense)
library(SummarizedExperiment)

# Example filtering
thCount <- 100
vec2Keep <- which(vapply(1:dim(mydata)[1], function(i) 
  !Reduce("&", assays(mydata)[[1]][i,] < thCount), c(TRUE)))
mydata <- mydata[vec2Keep,]

# Extract unique time points
times <- unique(sort(as.numeric(colData(mydata)$time)))
```

### 2. Fold Change Analysis (`getFC`)
Calculates differential expression between two conditions at every time point using the `NBPSeq` method.

```r
resultFC <- getFC(dataset = mydata, 
                  myanalyzeConditions = c("WT", "Mutant"), 
                  cores = 1, 
                  mytimes = times)
```

### 3. Switch Detection (`getSwitch`)
Fits one-step and zero-step functions to a single condition's time profile to find the most likely "switch" point.

```r
resultSwitch <- getSwitch(dataset = mydata,
                          experimentStepDetection = "WT",
                          cores = 1,
                          mytimes = times)
```

### 4. Integration and Visualization
Combine the results to perform Fisher's exact tests and generate a heatmap of stage-specific gene sets.

```r
# Combine results
resultCombined <- combineResults(resultSwitch, resultFC)

# Plot SSGS Heatmap
# Note: 'times' usually excludes the last time point for switch intervals
plotSSGS(resultCombined, times[-length(times)], experimentStepDetection = "WT")
```

### 5. Exporting Results
Use `outputGeneTables` to generate text files containing gene lists categorized by their switch and fold-change behavior.

```r
outputGeneTables(resultCombined)
```

## Tips for Success
- **Parallelization:** The `cores` argument uses the `parallel` package. On Windows, set `cores = 1`.
- **Time Points:** Ensure time points in `colData` are numeric or can be coerced to numeric for proper sorting.
- **Thresholding:** Use `thCount` to remove noise from genes that are barely expressed across all samples, as this improves the power of the likelihood-ratio tests in `getSwitch`.

## Reference documentation
- [RNAsense Vignette](./references/example.md)
- [RNAsense Analysis Workflow](./references/example.Rmd)