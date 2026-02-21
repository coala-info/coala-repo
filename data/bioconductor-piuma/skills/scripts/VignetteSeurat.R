# Code example from 'VignetteSeurat' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----install-package, eval=FALSE----------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("PIUMA")

## ----seurat-0, fig.width=10, fig.height=10, warning=FALSE, eval=FALSE,message=FALSE----
# set.seed(42)
# library(Seurat)
# library(SingleCellExperiment)
# library(SummarizedExperiment)
# library(PIUMA)
# #devtools::install_github('satijalab/seurat-data')
# library(SeuratData)
# 
# SeuratData::InstallData("pbmc3k")
# pbmc3k <- SeuratData::LoadData("pbmc3k")
# 
# pbmc3k <- UpdateSeuratObject(pbmc3k)
# pbmc3k <- NormalizeData(pbmc3k)
# pbmc3k <- ScaleData(pbmc3k)
# pbmc3k <- FindVariableFeatures(pbmc3k)
# pbmc3k <- RunPCA(pbmc3k)
# pbmc3k <- RunUMAP(pbmc3k,dims = 1:20)
# DimPlot(pbmc3k,group.by = 'seurat_annotations')

## ----seurat-1, fig.width=10, fig.height=10, warning=FALSE, eval=FALSE,message=FALSE----
# set.seed(42)
# counts_mat <- pbmc3k@assays$RNA@layers$counts
# logcounts_mat <- pbmc3k@assays$RNA@layers$data
# 
# colnames(counts_mat) <- rownames(pbmc3k@meta.data)
# colnames(logcounts_mat) <- rownames(pbmc3k@meta.data)
# 
# rownames(counts_mat) <- rownames(pbmc3k@assays$RNA@features@.Data)
# rownames(logcounts_mat) <- rownames(pbmc3k@assays$RNA@features@.Data)
# 
# counts_dense    <- as.matrix(counts_mat)
# logcounts_dense <- as.matrix(logcounts_mat)
# cell_meta     <- pbmc3k@meta.data
# 
# gene_meta     <- DataFrame(
#   gene_id = rownames(counts_mat),
#   row.names = rownames(counts_mat)
# )
# 
# # assemble the SummarizedExperiment
# se <- SummarizedExperiment(
#   assays   = list(
#     counts    = counts_dense,
#     logcounts = logcounts_dense
#   ),
#   colData = cell_meta,
#   rowData = gene_meta
# )
# 
# #refine Seurat annotation
# colData(se)$seurat_annotations <- factor(
#   ifelse(
#     is.na(colData(se)$seurat_annotations),
#     "Unknown",
#     as.character(colData(se)$seurat_annotations)
#   )
# )
# 
# # Create a PIUMA TDAobj from the SummarizedExperiment
# tda_obj <- makeTDAobjFromSE(se,'seurat_annotations')

## ----seurat-2, fig.width=10, fig.height=10, warning=FALSE, eval=FALSE,message=FALSE----
# set.seed(42)
# library(umap)
# tda_obj <- dfToDistance(tda_obj, distMethod = "euclidean")
# umap <- pbmc3k@reductions$umap@cell.embeddings
# colnames(umap) <- c('comp1','comp2')
# 
# tda_obj@comp <- as.data.frame(umap)

## ----seurat-4, fig.width=10, fig.height=10, warning=FALSE, eval=FALSE,message=FALSE----
# set.seed(42)
# tda_obj <- mapperCore(x = tda_obj,
#                       nBins = 33,
#                       overlap = 0.15)
# tda_obj <- jaccardMatrix(tda_obj)
# tda_obj <- setGraph(tda_obj)
# tda_obj <- predict_mapper_class(tda_obj)
# tda_obj <- autoClusterMapper(tda_obj,method = 'walktrap')

## ----seurat-5, fig.width=20, fig.height=10, warning=FALSE, eval=FALSE,message=FALSE----
# set.seed(42)
# clusters_piuma <- tda_obj@clustering$obs_cluster
# all_cells     <- rownames(pbmc3k@meta.data)
# piuma_clusters <- setNames(
#   rep(NA_integer_, length(all_cells)),
#   all_cells
# )
# piuma_clusters[ clusters_piuma$obs ] <- clusters_piuma$cluster
# pbmc3k@meta.data$PIUMA_clusters <- as.factor(piuma_clusters)
# 
# DimPlot(pbmc3k,group.by = 'PIUMA_clusters',label = TRUE,label.box = TRUE,repel = TRUE)+
#   DimPlot(pbmc3k,group.by = 'seurat_annotations',label = TRUE,label.box = TRUE,repel = TRUE)
# 

## ----seurat-6, fig.width=10, fig.height=10, warning=FALSE, eval=FALSE,message=FALSE,fig.cap = "(1) Feature plot of GZMK in the original UMAP space (2) Violin plots of GZMK expression across Seurat‐annotated cell types in the pbmc3k dataset. Within each cell type, violins are split to compare cells belonging to PIUMA/TDA Cluster 12 versus all other cells. PIUMA Cluster 12 selectively enriches for a GZMK+ CD8+ T-cell subpopulation"----
# set.seed(42)
# library(dplyr)
# library(ggplot2)
# 
# Idents(pbmc3k) <- 'PIUMA_clusters'
# markers_12 <- FindMarkers(pbmc3k,
#                          ident.1    = 12,
#                          group.by   = "PIUMA_clusters",
#                          test.use   = "wilcox",
#                          logfc.threshold = 0.25,
#                          only.pos=TRUE)
# markers_12_top <- markers_12 %>% filter(pct.1 - pct.2 > 0.7)
# 
# FeaturePlot(pbmc3k,features=rownames(markers_12_top),alpha = 1)+ggplot2::ggtitle('Expression of Granzime K')
# pbmc3k$GZMK_pos <- FetchData(pbmc3k, vars = "GZMK")[,1] > 2
# pbmc3k$GZMK_pos <- factor(pbmc3k$GZMK_pos,
#                           levels = c(FALSE, TRUE),
#                           labels = c("GZMK–", "GZMK+"))
# pbmc3k$Cluster_12 <- pbmc3k$PIUMA_clusters==12
# pbmc3k_sub <- subset(pbmc3k, subset = !is.na(seurat_annotations))
# 
# VlnPlot(pbmc3k_sub,
#         features = "GZMK",
#         group.by = "seurat_annotations",
#         split.by = "Cluster_12",
#         pt.size  = 0,
#         assay    = "RNA"
# ) +
#   ggplot2::scale_fill_manual(
#     name   = "PIUMA Cluster 12",
#     values = c("FALSE" = "grey80", "TRUE" = "steelblue"),
#     labels = c("Other cells", "Cluster 12")
#   ) +
#   ggplot2::guides(fill = ggplot2::guide_legend(override.aes = list(alpha = 1))) +
#   ggplot2::theme(
#     axis.text.x     = ggplot2::element_text(angle = 45, hjust = 1),
#     legend.position = "right"
#   ) +
#   ggplot2::labs(
#     title = "TDA Cluster 12 identifies a GZMK+ CD8+ T subset",
#     x     = "Seurat annotation",
#     y     = "GZMK expression"
#   )
# 

## ----seurat-7, fig.width=10, fig.height=10, warning=FALSE, eval=FALSE,message=FALSE,fig.cap = "Quantitative comparison of PIUMA‐derived clusters against the original Seurat annotations, showing Adjusted Rand Index (ARI) = 0.571 and Normalized Mutual Information (NMI) = 0.68 (computed on cells with non-missing labels). These values indicate strong overall concordance: major cell‐type compartments are preserved, while leaving substantial “wiggle room” (<1.0) for PIUMA to unearth novel substructure (e.g. the GZMK+ CD8+ T-cell subset in cluster 8)."----
# set.seed(42)
# library(mclust)
# library(aricode)
# library(viridis)
# valid   <- which(!is.na(pbmc3k$seurat_annotations) & !is.na(pbmc3k$PIUMA_clusters))
# ari     <- mclust::adjustedRandIndex(pbmc3k$seurat_annotations[valid],
#                              pbmc3k$PIUMA_clusters[valid])
# nmi     <- aricode::NMI(pbmc3k$seurat_annotations[valid],
#                pbmc3k$PIUMA_clusters[valid])
# df <- data.frame(
#   Metric = c("ARI","NMI"),
#   Value  = c(ari, nmi)
# )
# 
# ggplot2::ggplot(df, ggplot2::aes(x = Metric, y = 1, fill = Value)) +
#   ggplot2::geom_tile(color = "white", width = 0.9, height = 0.9) +
#   ggplot2::geom_text(aes(label = sprintf("%.3f", Value)),
#             color = "white", size = 6) +
#   viridis::scale_fill_viridis(option = "magma", limits = c(0, 1)) +
#   coord_fixed(ratio = 1) +      # force squares
#   ggplot2::theme_minimal() +
#   ggplot2::theme(
#     axis.title    = element_blank(),
#     axis.text     = element_blank(),
#     axis.ticks    = element_blank(),
#     panel.grid    = element_blank(),
#     plot.title    = element_text(hjust = 0.5)
#   ) +
#   ggplot2::labs(
#     fill  = "Score",
#     title = "Clustering Concordance (ARI & NMI)"
#   )

## ----session_info-------------------------------------------------------------
sessionInfo()

