---
name: bioconductor-iseede
description: This tool provides specialized panels for the iSEE framework to interactively visualize differential expression results from limma, DESeq2, and edgeR. Use when user asks to embed differential expression statistics into SummarizedExperiment objects, create interactive Volcano or MA plots, or compare log-fold changes across different contrasts.
homepage: https://bioconductor.org/packages/release/bioc/html/iSEEde.html
---

# bioconductor-iseede

name: bioconductor-iseede
description: Provides specialized panels for the iSEE interactive visualization framework to explore differential expression (DE) results. Use this skill when you need to embed DE results from limma, DESeq2, or edgeR into SummarizedExperiment objects and launch interactive apps with Volcano plots, MA plots, and DE tables.

## Overview

The `iSEEde` package extends the `iSEE` ecosystem by providing dedicated panels for visualizing differential expression (DE) results. It standardizes the storage of DE statistics (log-fold change, p-values, average expression) within the `rowData` of a `SummarizedExperiment` object, allowing for seamless interactive exploration. It supports results from major DE analysis frameworks including `limma`, `DESeq2`, and `edgeR`.

## Core Workflow

### 1. Prepare the Data Object
Ensure your `SummarizedExperiment` (or `SingleCellExperiment`) object has unique and informative feature names.

```r
library(iSEEde)
library(scuttle)

# Recommended: Uniquify feature names using Symbols and IDs
rownames(se) <- uniquifyFeatureNames(
    ID = rowData(se)[["ENSEMBL"]],
    names = rowData(se)[["SYMBOL"]]
)
```

### 2. Embed DE Results
Use `embedContrastResults()` to store DE tables in the object. This function handles the mapping of features and ensures synchronization.

*   **For DESeq2:** Pass the `DESeqResults` object directly.
*   **For edgeR:** Pass the `TopTags` object directly.
*   **For limma:** Pass the `topTable` data frame and specify `class = "limma"`.

```r
# Example for DESeq2
se <- embedContrastResults(res_deseq2, se, name = "Treatment_vs_Control")

# Example for limma
se <- embedContrastResults(res_limma, se, name = "Limma_Contrast", class = "limma")
```

### 3. Accessing Results
Use `contrastResultsNames(se)` to see available contrasts and `contrastResults(se, name)` to retrieve the specific DE table.

### 4. Launching the iSEE App
Initialize the app with `iSEEde` specific panels: `DETable()`, `VolcanoPlot()`, and `MAPlot()`.

```r
library(iSEE)

app <- iSEE(se, initial = list(
    DETable(ContrastName = "Treatment_vs_Control", PanelWidth = 4L),
    VolcanoPlot(ContrastName = "Treatment_vs_Control", PanelWidth = 4L),
    MAPlot(ContrastName = "Treatment_vs_Control", PanelWidth = 4L)
))

if (interactive()) {
    shiny::runApp(app)
}
```

## Specialized Panels and Features

### Comparing Contrasts
Use `LogFCLogFCPlot` to compare the log2 fold-changes of two different DE analyses (e.g., comparing two different treatments or two different methods).

```r
LogFCLogFCPlot(ContrastNameX = "Contrast_A", ContrastNameY = "Contrast_B")
```

### Rounding and Formatting
You can control the precision of numeric values displayed in `DETable` panels globally or per-panel.

```r
# Global default
panelDefaults(RoundDigits = TRUE, SignifDigits = 2L)

# Per-panel override
DETable(ContrastName = "edgeR", RoundDigits = TRUE, SignifDigits = 3L)
```

### Tooltip Customization
Enhance the interactive experience by specifying which `rowData` columns appear when hovering over points in plots.

```r
panelDefaults(TooltipRowData = c("SYMBOL", "ENSEMBL", "GENETYPE"))
```

## Reference documentation

- [Using annotations to facilitate interactive exploration](./references/annotations.md)
- [Introduction to iSEEde](./references/iSEEde.md)
- [Supported differential expression methods](./references/methods.md)
- [Rounding numeric values](./references/rounding.md)