---
name: bioconductor-normalyzerde
description: NormalyzerDE identifies the optimal normalization method for mass spectrometry-based omics data and performs differential expression analysis. Use when user asks to evaluate normalization performance, normalize proteomics data, or perform differential expression analysis on mass spectrometry datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/NormalyzerDE.html
---


# bioconductor-normalyzerde

## Overview
NormalyzerDE is an R package designed to identify the optimal normalization method for mass spectrometry-based omics data. It provides a systematic framework to test various normalization approaches, visualize their performance through evaluation metrics, and perform downstream differential expression (DE) analysis. A key feature is its ability to handle retention-time based biases using segmented normalization.

## Core Workflow

### 1. Data Preparation
NormalyzerDE requires two inputs:
- **Data Matrix**: A file or data frame where rows are features (e.g., peptides) and columns are samples. It can include annotation columns.
- **Design Matrix**: A table mapping sample names to experimental groups.
  - `sample`: Must match column headers in the data matrix.
  - `group`: Condition levels for comparison.

### 2. Normalization Evaluation
Use the `normalyzer` function to run a suite of normalization methods and generate an evaluation report.

```r
library(NormalyzerDE)

# Using file paths
normalyzer(
  jobName="my_experiment", 
  designPath="design.tsv", 
  dataPath="raw_data.tsv",
  outputDir="results"
)

# Using SummarizedExperiment
# assay: raw data, colData: design, rowData: annotations
normalyzer(jobName="exp_run", experimentObj=sumExpObj, outputDir="results")
```

### 3. Differential Expression Analysis
After reviewing the evaluation report (PDF) and selecting the best normalization (e.g., "CycLoess"), run the DE pipeline.

```r
# comparisons: "GroupA-GroupB" format
normalyzerDE(
  jobName="my_stats",
  comparisons=c("Cond1-Cond2"),
  designPath="design.tsv",
  dataPath="results/my_experiment/CycLoess-normalized.txt",
  outputDir="results",
  condCol="group"
)
```

## Advanced Features

### Retention Time (RT) Normalization
For data with fluctuating electrospray intensities, use RT-segmented normalization. This requires a column with retention time values.

```r
# Stepwise RT normalization
rtNormMat <- getRTNormalizedMatrix(
  dataMat, 
  retentionTimes, 
  normalizationFunction, # e.g., a wrapper for limma::normalizeCyclicLoess
  stepSizeMinutes=1, 
  windowMinCount=100
)
```

### Stepwise Manual Processing
If you need finer control than the wrapper functions provide:
1. **Setup**: `setupRawDataObject()` to create a `NormalyzerDataset`.
2. **Normalize**: `normMethods(normObj)` to generate results.
3. **Evaluate**: `analyzeNormalizations(normResults)` to calculate measures.
4. **Statistics**: `NormalyzerStatistics()` followed by `calculateContrasts()`.

## Tips for Success
- **Sample Names**: Ensure sample names in the design matrix are characters, not factors, to avoid indexing errors.
- **Log Transformation**: NormalyzerDE typically expects raw values for the normalization step (as it performs log transformation internally) but check if your specific matrix is already log-transformed before DE analysis.
- **SummarizedExperiment**: Using `SummarizedExperiment` objects is recommended for memory-resident data to avoid unnecessary file I/O.

## Reference documentation
- [Evaluation and statistics of expression data using NormalyzerDE](./references/vignette.md)