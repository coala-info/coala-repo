---
name: bioconductor-escape
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/escape.html
---

# bioconductor-escape

name: bioconductor-escape
description: Perform gene-set enrichment analysis (GSEA) on single-cell RNA-seq data using the escape R package. Use this skill to calculate per-cell enrichment scores (ssGSEA, GSVA, AUCell, UCell), normalize scores for drop-out bias, visualize enrichment distributions, and perform differential enrichment analysis on Seurat or SingleCellExperiment objects.

## Overview

The `escape` package bridges the gap between raw single-cell counts and functional biological pathways. It transforms a gene-by-cell matrix into a gene-set-by-cell matrix, allowing researchers to treat biological pathways as individual features for clustering, visualization, and differential testing.

## Core Workflow

### 1. Prepare Gene Sets
You can use built-in sets, fetch from MSigDB, or define your own list.

```r
library(escape)

# Option A: Built-in sets
data("escape.gene.sets", package="escape")

# Option B: MSigDB via getGeneSets()
GS.hallmark <- getGeneSets(library = "H")

# Option C: Custom list
my_sets <- list(Bcells = c("MS4A1", "CD79A"), Tcells = c("CD3E", "CD8A"))
```

### 2. Calculate Enrichment Scores
Use `runEscape()` to add scores directly to a Seurat or SingleCellExperiment object.

```r
# Supported methods: "ssGSEA", "GSVA", "AUCell", "UCell"
pbmc <- runEscape(pbmc, 
                  method = "UCell",
                  gene.sets = GS.hallmark, 
                  new.assay.name = "escape.UCell",
                  min.size = 5)
```

### 3. Normalization
Single-cell data is prone to drop-out bias. `performNormalization()` adjusts scores based on the number of genes expressed per cell.

```r
pbmc <- performNormalization(pbmc, 
                             assay = "escape.UCell", 
                             gene.sets = GS.hallmark)
```

## Visualization Gallery

`escape` provides several specialized plotting functions that return ggplot objects:

*   **Heatmaps**: `heatmapEnrichment(pbmc, group.by = "ident", assay = "escape.UCell")`
*   **Distributions**: 
    *   `geyserEnrichment()`: Individual cells with median/interval summaries.
    *   `ridgeEnrichment()`: Density ridges for specific pathways.
    *   `splitEnrichment()`: Comparison violins (e.g., Control vs Treatment).
*   **GSEA Plots**: 
    *   `gseaEnrichment()`: Classic running enrichment score plot.
    *   `densityEnrichment()`: Kernel-density traces of gene ranks.
*   **Relationships**: `scatterEnrichment(pbmc, x.axis = "Pathway-A", y.axis = "Pathway-B")`

## Statistical Analysis

### Principal Component Analysis (PCA)
Analyze the variance of enrichment scores across cells.

```r
pbmc <- performPCA(pbmc, assay = "escape.UCell")
pcaEnrichment(pbmc, dimRed = "escape.PCA", display.factors = TRUE, number.of.factors = 5)
```

### Differential Enrichment
Treat enrichment assays like RNA assays to find markers for clusters.

```r
# Ensure normalization is done with make.positive = TRUE for ssGSEA/GSVA
diff.results <- FindAllMarkers(pbmc, assay = "escape.UCell_normalized")
```

### Precomputed Rank Lists
If you already have Differential Expression Genes (DEG) results, use `enrichIt()` for classical GSEA.

```r
GSEA.results <- enrichIt(input.data = DEG.markers, 
                         gene.sets = escape.gene.sets, 
                         ranking_fun = "signed_log10_p")
enrichItPlot(GSEA.results, "dot")
```

## Tips for Success
*   **Method Selection**: `UCell` is generally recommended for large single-cell datasets due to speed and its 1500-gene rank cutoff which mitigates drop-out effects.
*   **Parallelization**: For large datasets, use `BPPARAM = BiocParallel::SnowParam(workers = n)` within `runEscape` or `escape.matrix`.
*   **Positive Scaling**: When performing differential testing on ssGSEA or GSVA scores, use `make.positive = TRUE` in normalization to avoid issues with negative values in log-fold change calculations.

## Reference documentation
- [Gene-set enrichment on single-cell data with escape (Rmd)](./references/escape.Rmd)
- [Gene-set enrichment on single-cell data with escape (Markdown)](./references/escape.md)