---
name: bioconductor-broadseq
description: This tool provides a unified interface for RNA-seq data normalization, quality control, and differential expression analysis using multiple Bioconductor methods. Use when user asks to normalize RNA-seq counts, perform PCA or MDS quality control, or compare differential expression results across methods like DESeq2, edgeR, and limma.
homepage: https://bioconductor.org/packages/release/bioc/html/broadSeq.html
---


# bioconductor-broadseq

name: bioconductor-broadseq
description: Analyze RNA-seq data using the broadSeq package. Use this skill to perform standardized normalization (CPM, TMM), transformations (VST, rlog), quality control (MDS, PCA, Hierarchical clustering), and comparative differential expression analysis using multiple Bioconductor methods (DESeq2, edgeR, limma, etc.) within a SummarizedExperiment framework.

## Overview

The `broadSeq` package provides a unified interface for RNA-seq data analysis. It streamlines the transition between different Bioconductor tools by using `SummarizedExperiment` as the primary input and standard `data.frames` for output. It is particularly useful for comparing results across multiple differential expression (DE) methods and generating publication-ready visualizations using `ggplot2` and `ggpubr`.

## Core Workflow

### 1. Data Preparation and Filtering
Load your data into a `SummarizedExperiment` object. It is common to filter out low-expression genes before proceeding.

```r
library(broadSeq)
library(SummarizedExperiment)

# Load data (example assumes 'se' is a SummarizedExperiment)
# Filter: keep genes with counts >= 3 in at least 5 samples
keep <- (assays(se)[["counts"]] >= 3) %>% rowSums() >= 5
se <- se[keep, ]
```

### 2. Normalization and Transformation
`broadSeq` wraps several methods to scale and stabilize variance, adding the results as new assay slots.

*   **Normalization (edgeR-based):**
    *   `normalizeEdgerCPM(se, method = "none")`: Basic logCPM.
    *   `normalizeEdgerCPM(se, method = "TMM")`: TMM normalization.
*   **Transformation (DESeq2-based):**
    *   `transformDESeq2(se, method = "vst")`: Variance stabilizing transformation (recommended for PCA/clustering).
    *   `transformDESeq2(se, method = "rlog")`: Regularized log.

### 3. Quality Control and Visualization
Use these functions to assess sample clustering and gene expression patterns.

*   **MDS Plot:** `plot_MDS(se, scaledAssay = "vst", color = "condition")`
*   **Heatmaps:** `plotHeatmapCluster(se, scaledAssay = "vst", ntop = 30, annotation_col = c("group"))`
*   **PCA Analysis:**
    ```r
    pca_res <- prcompTidy(se, scaledAssay = "vst", ntop = 500)
    plotAnyPC(pca_res, x = 1, y = 2, color = "group")
    biplotAnyPC(pca_res, x = 1, y = 2, genesLabel = "symbol")
    ```
*   **Gene Plots:**
    *   `assay_plot()`: Compare multiple assays (counts, TMM, VST) for one gene.
    *   `genes_plot()`: Compare multiple genes within one assay.

### 4. Differential Expression (DE)
`broadSeq` uses a consistent naming convention `use_[method]` for DE analysis.

*   **Individual Methods:**
    *   `use_deseq2(se, colData_id = "group", control = "A", treatment = "B")`
    *   `use_edgeR_exact(...)` or `use_edgeR_GLM(...)`
    *   `use_limma_voom(...)` or `use_limma_trend(...)`
    *   `use_NOIseq(...)`, `use_EBSeq(...)`, `use_SAMseq(...)`

*   **Multi-Method Comparison:**
    Run multiple algorithms simultaneously to find consensus genes.
    ```r
    funs <- list(deseq2 = use_deseq2, edgeR = use_edgeR_GLM, limma = use_limma_voom)
    multi_result <- use_multDE(se, deFun_list = funs, colData_id = "group", 
                               control = "Ctrl", treatment = "Trt", rank = TRUE)
    ```

### 5. Result Visualization
*   **Volcano Plot:**
    ```r
    volcanoPlot(multi_result, pValName = "deseq2_padj", lFCName = "deseq2_log2FoldChange", labelName = "symbol")
    ```

## Tips for Success
*   **Assay Names:** Always check `assayNames(se)` after running a normalization or transformation function to ensure the new slot (e.g., "vst", "TMM") was created.
*   **Factor Levels:** Ensure your metadata columns (in `colData(se)`) are factors with the correct reference levels before running DE functions.
*   **Journal Palettes:** Use the `palette` argument in plotting functions (e.g., "npg", "aaas", "jco") for publication-quality colors.

## Reference documentation
- [Using broadSeq to analyze RNA-seq data](./references/broadSeq.Rmd)