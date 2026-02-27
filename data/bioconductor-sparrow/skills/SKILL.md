---
name: bioconductor-sparrow
description: The sparrow package orchestrates and compares multiple gene set enrichment analysis methods through a unified interface. Use when user asks to perform GSEA using methods like camera or fgsea, calculate single-sample gene set scores, or generate gene-set-centric visualizations.
homepage: https://bioconductor.org/packages/release/bioc/html/sparrow.html
---


# bioconductor-sparrow

name: bioconductor-sparrow
description: Orchestrate and compare multiple gene set enrichment analysis (GSEA) methods using a unified interface. Use this skill when you need to perform GSEA (e.g., camera, fry, ora, fgsea) on RNA-seq data, calculate single-sample gene set scores, or generate gene-set-centric visualizations like heatmaps. It is particularly useful for workflows involving limma, edgeR, or MSigDB collections.

# bioconductor-sparrow

## Overview

The `sparrow` package provides a unified interface for performing and comparing various gene set enrichment analysis (GSEA) methods. Instead of running multiple packages separately, `sparrow` wraps them into a single orchestration function (`seas`), storing results in a `SparrowResult` object. It also provides robust tools for single-sample scoring and specialized heatmaps.

## Core Workflow

### 1. Prepare Data and Gene Sets
`sparrow` works best with `EList` (limma) or `DGEList` (edgeR) objects. Gene sets are managed via the `GeneSetDb` class.

```r
library(sparrow)

# Load example data
vm <- exampleExpressionSet(dataset = "tumor-subtype", do.voom = TRUE)

# Retrieve MSigDB Hallmark collection
gdb <- getMSigGeneSetDb("H", "human", id.type = "entrez")

# Define experimental contrast
design <- vm$design
contrast <- limma::makeContrasts(BvH = Basal - Her2, levels = design)
```

### 2. Execute Multiple GSEA Methods
Use `seas()` to run multiple algorithms (e.g., `camera`, `fry`, `ora`) simultaneously.

```r
mg <- seas(
  x = vm, 
  gsdb = gdb, 
  methods = c("camera", "fry", "ora"),
  design = design, 
  contrast = contrast[, "BvH"],
  feature.max.padj = 0.05, 
  feature.min.logFC = 1
)
```

### 3. Inspect Results
The `SparrowResult` object (`mg`) contains both the GSEA results and the underlying differential expression statistics.

```r
# Summary of significant sets across methods
tabulateResults(mg, max.p = 0.20)

# Get top results for a specific method
res_cam <- result(mg, "camera")

# Get individual gene statistics for a specific gene set
gs_stats <- geneSet(mg, name = "HALLMARK_WNT_BETA_CATENIN_SIGNALING")
```

## Single Sample Scoring

Transform a gene-by-sample matrix into a geneset-by-sample matrix using `scoreSingleSamples`.

```r
# Calculate scores using EigenWeightedMean (ewm) and ssGSEA
ss_scores <- scoreSingleSamples(
  gdb, 
  vm, 
  methods = c("ewm", "ssgsea"),
  ssgsea.norm = TRUE
)
```

## Visualization

### Gene Set Heatmaps
Use `mgheatmap` to visualize expression at the gene level (split by gene set) or the aggregate gene set score level.

```r
# Gene-level heatmap for specific sets
mgheatmap(vm, gdb[1:2], aggregate.by = "none", split = TRUE, recenter = TRUE)

# Gene set-level heatmap (aggregate scores)
mgheatmap(vm, gdb, aggregate.by = "ewm", split = TRUE)
```

### Enrichment Plots
`sparrow` provides interactive and static plots to visualize the distribution of gene set members against the background.

```r
# Boxplot of logFC for a specific gene set
iplot(mg, "HALLMARK_MYC_TARGETS_V1", type = "boxplot")

# Standard GSEA running sum plot
iplot(mg, "HALLMARK_MYC_TARGETS_V1", type = "gsea")
```

## Key Tips
- **Method Selection**: `camera` is generally recommended for competitive GSEA; `fry` is a fast approximation of `roast` (self-contained).
- **ORA Bias**: When using `ora`, you can provide a `feature.bias` vector (e.g., gene length or average expression) to correct for technical biases.
- **GeneSetDb**: You can convert `BiocSet` or `GeneSetCollection` objects to `GeneSetDb` using the constructor `GeneSetDb(your_collection)`.
- **Data Tables**: Most functions return `data.frame` objects by default. Set `as.dt = TRUE` to receive `data.table` objects for faster processing of large results.

## Reference documentation
- [Performing gene set enrichment analyses with sparrow](./references/sparrow.Rmd)
- [Performing gene set enrichment analyses with sparrow (Markdown)](./references/sparrow.md)