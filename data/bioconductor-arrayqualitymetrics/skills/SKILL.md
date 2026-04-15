---
name: bioconductor-arrayqualitymetrics
description: This tool provides automated quality control and comprehensive reporting for microarray data. Use when user asks to generate QC reports, perform outlier detection, or visualize data quality for Bioconductor microarray objects.
homepage: https://bioconductor.org/packages/release/bioc/html/arrayQualityMetrics.html
---

# bioconductor-arrayqualitymetrics

name: bioconductor-arrayqualitymetrics
description: Automated quality control and reporting for microarray data. Use this skill when you need to generate comprehensive QC reports (HTML) for Bioconductor microarray objects including ExpressionSet, AffyBatch, NChannelSet, and Illumina data. It supports both one-color and two-color platforms, performing outlier detection, density plots, PCA, and spatial analysis.

# bioconductor-arrayqualitymetrics

## Overview
The `arrayQualityMetrics` package provides a standardized, automated pipeline for assessing the quality of microarray experiments. It generates an interactive HTML report containing various metrics to identify problematic arrays, batch effects, or spatial artifacts. The package is highly versatile, accepting most standard Bioconductor microarray data containers.

## Core Workflow

### 1. Basic Report Generation
The primary function is `arrayQualityMetrics()`. It handles data preprocessing, metric computation, and HTML rendering in one step.

```r
library(arrayQualityMetrics)

# Basic usage with an ExpressionSet or AffyBatch
arrayQualityMetrics(expressionset = myData,
                    outdir = "QC_Report",
                    force = TRUE,
                    do.logtransform = FALSE)
```

### 2. Key Arguments
- `expressionset`: The data object (ExpressionSet, AffyBatch, NChannelSet, etc.).
- `outdir`: String naming the output directory.
- `force`: If `TRUE`, overwrites the output directory if it exists.
- `intgroup`: A character vector of column names from `pData(expressionset)` used to color-code samples in plots (e.g., "Treatment", "Batch").
- `do.logtransform`: Set to `TRUE` if the data is not already on a log scale.
- `spatial`: Set to `FALSE` for very large arrays if memory/CPU is limited.

### 3. Advanced Customization
For programmatic control or custom reports, you can generate individual modules using `aqm.*` functions and combine them with `aqm.writereport`.

```r
# 1. Prepare data
preparedData <- prepdata(myData, intgroup = "Group", do.logtransform = FALSE)

# 2. Create specific modules
boxModule <- aqm.boxplot(preparedData)
pcaModule <- aqm.pca(preparedData)

# 3. Write the report
aqm.writereport(modules = list(boxModule, pcaModule),
                arrayTable = pData(myData),
                reporttitle = "Custom QC Report",
                outdir = "Custom_QC")
```

## Interpreting the Report
The report (`QMreport.html`) categorizes metrics into three main areas:
- **Individual array intensity distributions**: Boxplots and density plots to identify global shifts.
- **Between-array comparison**: Heatmaps and PCA plots to identify outliers or batch effects.
- **Array preparation**: Spatial plots (for artifacts) and Affymetrix-specific metrics (RNA degradation, RLE, NUSE).

Outliers are automatically flagged based on:
- **Distances between arrays**: Based on the L1-distance.
- **Boxplot statistics**: Based on the Kolmogorov-Smirnov test.
- **MA plots**: Based on Hoeffding’s D-statistic.

## Tips for Success
- **Metadata**: Ensure your `phenoData` is well-defined before running the report. Use the `intgroup` argument to make the report much more informative.
- **Affymetrix Data**: When using `AffyBatch` objects, the package automatically includes probe-level metrics like RLE (Relative Log Expression) and NUSE (Normalized Unscaled Standard Error).
- **Memory Management**: For very large datasets, consider subsetting features or disabling spatial plots (`spatial = FALSE`) to reduce RAM usage.

## Reference documentation
- [Quality metrics report for microarray data sets](./references/reference_manual.md)