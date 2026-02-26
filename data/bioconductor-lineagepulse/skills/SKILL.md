---
name: bioconductor-lineagepulse
description: LineagePulse performs differential expression analysis on single-cell RNA-seq data using a zero-inflated negative binomial noise model to account for drop-outs. Use when user asks to identify genes with significant expression changes across pseudotime trajectories, perform differential expression analysis on discrete cell clusters, or model gene expression using splines and impulse models.
homepage: https://bioconductor.org/packages/3.8/bioc/html/LineagePulse.html
---


# bioconductor-lineagepulse

## Overview

LineagePulse is a specialized R package for differential expression (DE) analysis in single-cell RNA-seq data. It accounts for the high frequency of drop-outs (zeros) using a zero-inflated negative binomial (ZINB) noise model. Unlike tools that infer trajectories, LineagePulse is a downstream analytic tool that takes an existing cell ordering (e.g., pseudotime from Monocle or DPT) or discrete groupings (e.g., clusters) and identifies genes whose expression changes significantly across those structures.

## Core Workflow

### 1. Data Preparation
LineagePulse requires raw, non-normalized count data.
*   **Counts**: A matrix (genes x cells), `SummarizedExperiment`, or `SingleCellExperiment`.
*   **Annotation**: A data frame where rownames match the column names of the count matrix.
    *   For continuous models: Must contain a column named `"continuous"` (e.g., pseudotime).
    *   For discrete models: Must contain a column named `"groups"` (e.g., cluster IDs).

### 2. Running the Analysis
The main wrapper function is `runLineagePulse()`. It handles normalization, model fitting (H0 vs H1), and DE testing.

```r
library(LineagePulse)

# Basic run for continuous (pseudotime) data
objLP <- runLineagePulse(
  counts = matCounts,
  dfAnnotation = dfAnnot,
  strMuModel = "splines" # or "impulse"
)

# Access results
head(objLP$dfResults)
```

**Key Parameters:**
*   `strMuModel`: The alternative model ("splines", "impulse", or "groups").
*   `vecConfoundersMu`: Vector of column names in `dfAnnotation` to correct for batch effects in the mean.
*   `scaNProc`: Number of processes for parallelization.

### 3. Visualizing Results
LineagePulse provides built-in functions to visualize the fitted models against the raw data.

*   **Gene-wise Trajectories**: Use `plotGene()` to see how a specific gene behaves across the lineage.
```r
plotGene(
  objLP = objLP,
  strGeneID = "GeneName",
  boolLogPlot = TRUE,
  boolLineageContour = FALSE
)
```

*   **Global Heatmaps**: Use `sortGeneTrajectories()` to visualize z-scores of multiple DE genes.
```r
lsHeatmaps <- sortGeneTrajectories(
  vecIDs = objLP$dfResults[objLP$dfResults$padj < 0.01, ]$gene,
  lsMuModel = lsMuModelH1(objLP)
)
print(lsHeatmaps$hmGeneSorted)
```

### 4. Extracting Parameters
For custom analysis, you can extract the fitted mean parameters.
```r
# Get fitted means for specific genes
matMeanParamFit <- getFitsMean(
  lsMuModel = lsMuModelH1(objLP),
  vecGeneIDs = c("Gene1", "Gene2")
)
```

## Tips for Success
*   **Input Counts**: Never use TPM, CPM, or log-transformed data. The statistical model relies on integer-like count properties.
*   **Model Selection**: Use `"splines"` for flexible trajectories or `"impulse"` for short-term transitions (up-down or down-up). Use `"groups"` for categorical comparisons.
*   **Batch Correction**: If your data has known technical batches, always specify them in `vecConfoundersMu` to avoid false positives.
*   **Memory/Time**: For large datasets, ensure `scaNProc` is set to utilize multiple cores, as ZINB fitting is computationally intensive.

## Reference documentation
- [LineagePulse Tutorial (Rmd)](./references/LineagePulse_Tutorial.Rmd)
- [LineagePulse Tutorial (Markdown)](./references/LineagePulse_Tutorial.md)