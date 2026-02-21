# Code example from 'using_schex' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)
options(rmarkdown.html_vignette.check_title = FALSE)
library(ggplot2)
theme_set(theme_classic())

## ----setup, message=FALSE-----------------------------------------------------
library(igraph)
library(schex)
library(TENxPBMCData)
library(scater)
library(scran)
library(ggrepel)

## ----load---------------------------------------------------------------------
tenx_pbmc3k <- TENxPBMCData(dataset = "pbmc3k")

rownames(tenx_pbmc3k) <- uniquifyFeatureNames(
    rowData(tenx_pbmc3k)$ENSEMBL_ID,
    rowData(tenx_pbmc3k)$Symbol_TENx
)

## ----filter-cells-------------------------------------------------------------
rowData(tenx_pbmc3k)$Mito <- grepl("^MT-", rownames(tenx_pbmc3k))
colData(tenx_pbmc3k) <- cbind(
    colData(tenx_pbmc3k),
    perCellQCMetrics(tenx_pbmc3k,
        subsets = list(Mt = rowData(tenx_pbmc3k)$Mito)
    )
)
rowData(tenx_pbmc3k) <- cbind(
    rowData(tenx_pbmc3k),
    perFeatureQCMetrics(tenx_pbmc3k)
)

tenx_pbmc3k <- tenx_pbmc3k[, !colData(tenx_pbmc3k)$subsets_Mt_percent > 50]

libsize_drop <- isOutlier(tenx_pbmc3k$total,
    nmads = 3, type = "lower", log = TRUE
)
feature_drop <- isOutlier(tenx_pbmc3k$detected,
    nmads = 3, type = "lower", log = TRUE
)

tenx_pbmc3k <- tenx_pbmc3k[, !(libsize_drop | feature_drop)]

## ----filter-genes-------------------------------------------------------------
rm_ind <- calculateAverage(tenx_pbmc3k) < 0
tenx_pbmc3k <- tenx_pbmc3k[!rm_ind, ]

## ----norm, message=FALSE, warning=FALSE---------------------------------------
tenx_pbmc3k <- scater::logNormCounts(tenx_pbmc3k)

## ----dim-red, message=FALSE, warning=FALSE------------------------------------
tenx_pbmc3k <- runPCA(tenx_pbmc3k)
set.seed(10)
tenx_pbmc3k <- runUMAP(tenx_pbmc3k,
    dimred = "PCA", spread = 1,
    min_dist = 0.4
)

## ----cluster------------------------------------------------------------------
snn_gr <- buildSNNGraph(tenx_pbmc3k, use.dimred = "PCA", k = 50)
clusters <- cluster_louvain(snn_gr)
tenx_pbmc3k$cluster <- factor(clusters$membership)

## ----calc-hexbin--------------------------------------------------------------
tenx_pbmc3k <- make_hexbin(tenx_pbmc3k,
    nbins = 40,
    dimension_reduction = "UMAP", use_dims = c(1, 2)
)

## ----plot-density, fig.height=7, fig.width=7----------------------------------
plot_hexbin_density(tenx_pbmc3k)

## ----plot-meta, fig.height=7, fig.width=7-------------------------------------
plot_hexbin_meta(tenx_pbmc3k, col = "cluster", action = "majority")
plot_hexbin_meta(tenx_pbmc3k, col = "total", action = "median")

## ----plot-meta-trad, fig.height=7, fig.width=7--------------------------------
plotUMAP(tenx_pbmc3k, colour_by = "cluster")
plotUMAP(tenx_pbmc3k, colour_by = "total")

## ----plot-meta-label, message=FALSE, fig.height=7, fig.width=7----------------
label_df <- make_hexbin_label(tenx_pbmc3k, col = "cluster")
pp <- plot_hexbin_meta(tenx_pbmc3k, col = "cluster", action = "majority")
pp + ggrepel::geom_label_repel(
    data = label_df, aes(x = x, y = y, label = label),
    colour = "black", label.size = NA, fill = NA
)

## ----plot-gene, fig.height=7, fig.width=7-------------------------------------
gene_id <- "POMGNT1"
plot_hexbin_feature(tenx_pbmc3k,
    type = "logcounts", feature = gene_id,
    action = "mean", xlab = "UMAP1", ylab = "UMAP2",
    title = paste0("Mean of ", gene_id)
)

## ----plot-gene-trad, fig.height=7, fig.width=7--------------------------------
plotUMAP(tenx_pbmc3k, by_exprs_values = "logcounts", colour_by = gene_id)

## ----message=FALSE, fig.height=7, fig.width=7---------------------------------
plot_hexbin_feature_plus(tenx_pbmc3k,
    col = "cluster", type = "logcounts",
    feature = "POMGNT1", action = "mean"
)

## -----------------------------------------------------------------------------
gene_id <- "CD19"
gg <- schex::plot_hexbin_feature(tenx_pbmc3k,
    type = "logcounts", feature = gene_id,
    action = "mean", xlab = "UMAP1", ylab = "UMAP2",
    title = paste0("Mean of ", gene_id)
)
gg + theme_void()

## ----eval=FALSE---------------------------------------------------------------
# ggsave(gg, file = "schex_plot.pdf")

## -----------------------------------------------------------------------------
sessionInfo()

