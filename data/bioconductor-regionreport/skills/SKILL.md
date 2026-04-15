---
name: bioconductor-regionreport
description: This package generates interactive HTML or PDF reports for visualizing and exploring genomic regions and differential expression results. Use when user asks to create standardized reports for genomic regions, visualize differential expression results from DESeq2 or edgeR, or explore base-level results from derfinder.
homepage: https://bioconductor.org/packages/release/bioc/html/regionReport.html
---

# bioconductor-regionreport

## Overview

The `regionReport` package creates standardized, interactive HTML or PDF reports for genomic analyses. It is designed to bridge the gap between raw statistical results and exploratory data visualization. It supports general genomic regions (stored as `GRanges`), single base-level results from `derfinder`, and feature-level differential expression results from `DESeq2` or `edgeR`.

## Core Workflows

### 1. General Genomic Regions
Use `renderReport()` to explore any set of genomic regions. This is the most flexible function and works with results from tools like `bumphunter` or `DiffBind`.

```r
library(regionReport)
library(GenomicRanges)

# Requirement: GRanges object with metadata columns for p-values/scores
# Requirement: seqlengths must be set
seqlengths(regions) <- seqlengths(getChromInfoFromUCSC("hg19", as.Seqinfo = TRUE))[names(seqlengths(regions))]

report <- renderReport(
    regions = regions,
    project = "My Analysis",
    pvalueVars = c("P-values" = "pvalue", "Q-values" = "qvalues"),
    densityVars = c("Area" = "area", "Value" = "value"),
    significantVar = regions$qvalues <= 0.05,
    output = "index",
    outdir = "report_folder",
    device = "png"
)
```

### 2. DESeq2 Results
Use `DESeq2Report()` to visualize differential expression results. It automatically generates MA plots, volcano plots, and heatmaps.

```r
# dds is a DESeqDataSet; res is the result of results(dds)
report <- DESeq2Report(
    dds = dds,
    project = "DESeq2 Analysis",
    intgroup = c("condition", "treatment"),
    res = res,
    outdir = "DESeq2_results",
    device = "png"
)
```

### 3. edgeR Results
Use `edgeReport()` for `edgeR` workflows. It internally converts data using `DEFormats` and produces a report similar to the DESeq2 template.

```r
# dge is a DGEList; edger_res is the output of glmQLFTest or similar
report <- edgeReport(
    dge = dge,
    object = edger_res,
    project = "edgeR Analysis",
    outdir = "edgeR_results"
)
```

### 4. derfinder Results
Use `derfinderReport()` specifically for single base-level approach results. This requires the output directory prefix from a `derfinder` run.

```r
report <- derfinderReport(
    prefix = "derfinder_output_folder",
    project = "derfinder Analysis",
    fullCov = fullCov_list, # List of coverage Rle objects
    optionsStats = optionsStats # Options used in derfinder
)
```

## Key Parameters and Tips

*   **pvalueVars**: A named character vector mapping display names to metadata column names in the `GRanges` object that contain p-values (values between 0 and 1).
*   **densityVars**: A named character vector for continuous variables (like fold change or area) to be visualized with density plots.
*   **significantVar**: A logical vector (same length as the regions) indicating which regions are statistically significant.
*   **Output Formats**: Reports are HTML by default. For PDF reports, set `device = "pdf"` and ensure a LaTeX installation (like `tinytex`) is available.
*   **Internet Connection**: Rendering reports requires an active internet connection to load Bootstrap and JavaScript dependencies (unless configured otherwise via `rmarkdown` templates).
*   **Performance**: If `derfinderReport` is slow, reduce `nBestRegions` or set `makeBestClusters = FALSE`.

## Reference documentation

- [Example report using bumphunter results](./references/bumphunterExample.md)
- [Introduction to regionReport](./references/regionReport.md)