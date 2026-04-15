---
name: bioconductor-muscat
description: This tool performs differential state analysis to identify cell-type-specific responses across experimental conditions in multi-sample single-cell RNA-seq data. Use when user asks to perform differential state analysis, aggregate single-cell data into pseudobulk, run cell-level mixed models, or visualize cluster-specific gene expression changes across groups.
homepage: https://bioconductor.org/packages/release/bioc/html/muscat.html
---

# bioconductor-muscat

## Overview
The `muscat` package is designed for **Differential State (DS)** analysis in multi-sample, multi-condition scRNA-seq datasets. Unlike standard differential expression that compares clusters to find markers, DS analysis compares the same cell type across different experimental groups (e.g., Control vs. Treatment) to identify cell-type-specific responses. It supports both "pseudobulk" methods (aggregating cells by sample) and cell-level mixed models.

## Data Preparation
`muscat` requires a `SingleCellExperiment` (SCE) object with specific columns in `colData`:
*   `sample_id`: Unique identifier for each biological replicate.
*   `cluster_id`: Cell type or cluster assignments.
*   `group_id`: Experimental condition (e.g., stim vs. ctrl).

Use `prepSCE()` to format your object correctly:
```r
sce <- prepSCE(sce, 
               kid = "cell_type_column", 
               sid = "sample_id_column", 
               gid = "condition_column", 
               drop = TRUE)
```

## Pseudobulk Analysis Workflow
This is the recommended starting point as it is computationally efficient and leverages robust bulk RNA-seq frameworks like `edgeR` and `limma`.

1.  **Aggregate Data**: Sum counts by cluster and sample.
    ```r
    pb <- aggregateData(sce, assay = "counts", fun = "sum")
    ```
2.  **MDS Plot**: Visualize sample relationships at the pseudobulk level.
    ```r
    pbMDS(pb)
    ```
3.  **Run DS Analysis**:
    ```r
    # Default: tests the last coefficient (usually group_id)
    res <- pbDS(pb)
    
    # Custom contrast (e.g., Treatment - Control)
    library(limma)
    ei <- metadata(sce)$experiment_info
    mm <- model.matrix(~ 0 + ei$group_id)
    dimnames(mm) <- list(ei$sample_id, levels(ei$group_id))
    contrast <- makeContrasts("stim-ctrl", levels = mm)
    res <- pbDS(pb, design = mm, contrast = contrast)
    ```

## Cell-Level Mixed Models
Use mixed models when you want to account for cell-level variability directly without aggregation.
```r
# Using the 'dream' method (linear mixed model)
res_mm <- mmDS(sce, method = "dream")
```

## Handling and Visualizing Results
Results are returned as a list of data frames (one per cluster).

*   **Extract Tables**: Use `resDS` to flatten results into a tidy format.
    ```r
    tbl <- resDS(sce, res, bind = "row")
    ```
*   **Calculate Expression Frequencies**: Find the fraction of cells expressing a gene per group.
    ```r
    frq <- calcExprFreqs(sce, assay = "counts")
    ```
*   **Heatmaps**: Visualize top DS genes across clusters and samples.
    ```r
    pbHeatmap(sce, res, top_n = 5)
    ```
*   **UpSet Plots**: View shared vs. cluster-specific DE genes.
    ```r
    library(UpSetR)
    de_gs <- lapply(res$table[[1]], function(u) u$gene[u$p_adj.loc < 0.05])
    upset(fromList(de_gs))
    ```

## Increasing Power with BBHW
If independent bulk RNA-seq data for the same contrast is available, use Bulk-Based Hypothesis Weighing (`bbhw`) to improve FDR power.
```r
# res2 is a merged table of DS results
# bulkDEA is a data.frame with 'logFC' and 'PValue' from bulk data
res_weighted <- bbhw(pbDEA = res2, bulkDEA = bulkDEA, pb = pb, method = "gBH.LSL")
```

## Reference documentation
- [Differential state analysis with muscat](./references/analysis.md)
- [Increasing power with bulk-based hypothesis weighing (bbhw)](./references/bbhw.md)
- [Cell-type specific gene expression detection](./references/detection.md)
- [Simulation of multi-sample scRNA-seq data](./references/simulation.md)