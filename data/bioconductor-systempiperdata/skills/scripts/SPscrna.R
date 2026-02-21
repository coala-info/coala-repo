# Code example from 'SPscrna' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'----------------
BiocStyle::markdown()
options(width=60, max.print=1000)
knitr::opts_chunk$set(
    eval=as.logical(Sys.getenv("KNITR_EVAL", "TRUE")),
    cache=as.logical(Sys.getenv("KNITR_CACHE", "TRUE")), 
    tidy.opts=list(width.cutoff=60), tidy=TRUE)

## ----setup, echo=FALSE, message=FALSE, warning=FALSE, eval=FALSE----
# suppressPackageStartupMessages({
#     library(systemPipeR)
# })

## ----generate_workenvir, eval=FALSE-----------------------
# library(systemPipeRdata)
# genWorkenvir(workflow = "SPscrna", mydirname = "SPscrna")
# setwd("SPscrna")

## ----project_scrnaseq, eval=FALSE-------------------------
# library(systemPipeR)
# sal <- SPRproject()
# sal <- importWF(sal, file_path = "SPscrna.Rmd", verbose = FALSE)
# sal

## ----run_scrnaseq, eval=FALSE-----------------------------
# sal <- runWF(sal)

## ----plot_scrnaseq, eval=FALSE----------------------------
# plotWF(sal)

## ----scrnaseq-toplogy, eval=TRUE, warning= FALSE, echo=FALSE, out.width="100%", fig.align = "center", fig.cap= "Toplogy graph of scRNA-Seq workflow.", warning=FALSE----
knitr::include_graphics("results/plotwf_scrna.jpg")

## ----report_scrnaseq, eval=FALSE--------------------------
# # Scientific report
# sal <- renderReport(sal)
# rmarkdown::render("SPscrna.Rmd", clean = TRUE, output_format = "BiocStyle::html_document")
# 
# # Technical (log) report
# sal <- renderLogs(sal)

## ----status_scrnaseq, eval=FALSE--------------------------
# statusWF(sal)

## ----load_packages, eval=FALSE, spr=TRUE------------------
# cat(crayon::blue$bold("To use this workflow, following R packages are expected:\n"))
# cat(c("'Seurat", "ggplot2", "ggpubr", "patchwork", "dplyr", "tibble", "readr'\n"), sep = "', '")
# ###pre-end
# appendStep(sal) <- LineWise(
#     code = {
#         library(systemPipeR)
#         library(Seurat)
#         library(dplyr)
#         library(ggplot2)
#         library(ggpubr)
#         library(patchwork)
#     },
#     step_name = "load_packages"
# )

## ----load_data, eval=FALSE, spr=TRUE----------------------
# appendStep(sal) <- LineWise(
#     code = {
#         # unzip the data
#         untar("data/pbmc3k_filtered_gene_bc_matrices.tar.gz", exdir = "data")
#         # load data
#         pbmc.data <- Read10X(data.dir = "data/filtered_gene_bc_matrices/hg19/")
#         # Use dim to see the size of dataset, example data has 2700 cells x 32738 genes
#         dim(pbmc.data)
#     },
#     step_name = "load_data",
#     dependency = "load_packages"
# )

## ----count_plot, eval=FALSE, spr=TRUE---------------------
# appendStep(sal) <- LineWise(
#     code = {
#         at_least_one <- apply(pbmc.data, 2, function(x) sum(x>0))
#         count_p1 <- tibble::as_tibble(at_least_one) %>%
#             ggplot() +
#                 geom_histogram(aes(x = value), binwidth = floor(nrow(pbmc.data)/400), fill = "#6b97c2", color = "white") +
#                 theme_pubr(16) +
#                 scale_y_continuous(expand = c(0, 0)) +
#                 scale_x_continuous(expand = c(0, 0)) +
#                 labs(title = "Distribution of detected genes", x = "Genes with at least one tag")
# 
#         count_p2 <- tibble::as_tibble(MatrixGenerics::colSums(pbmc.data)) %>%
#             ggplot() +
#                 geom_histogram(aes(x = value), bins = floor(ncol(pbmc.data)/50), fill = "#6b97c2", color = "white") +
#                 theme_pubr(16) +
#                 scale_y_continuous(expand = c(0, 0)) +
#                 scale_x_continuous(expand = c(0, 0)) +
#                 labs(title = "Expression sum per cell", x = "Sum expression")
# 
#         png("results/count_plots.png", 1000, 700)
#         count_p1 + count_p2 +
#             patchwork::plot_annotation(tag_levels = "A")
#         dev.off()
#     },
#     step_name = "count_plot",
#     dependency = "load_data"
# )

## ----create_seurat, eval=FALSE, spr=TRUE------------------
# appendStep(sal) <- LineWise(
#     code = {
#         sce <- CreateSeuratObject(counts = pbmc.data, project = "pbmc3k", min.cells = 3, min.features = 200)
#         # calculate mitochondria gene ratio
#         sce[['percent.mt']] <- PercentageFeatureSet(sce,pattern='^MT-')
#     },
#     step_name = "create_seurat",
#     dependency = "load_data"
# )

## ----qc_seurat, eval=FALSE, spr=TRUE----------------------
# appendStep(sal) <- LineWise(
#     code = {
# 
#         png("results/qc1.png", 700, 700)
#         VlnPlot(sce, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), ncol = 3)
#         dev.off()
# 
#         qc_p1 <- FeatureScatter(sce, feature1 = "nCount_RNA", feature2 = "percent.mt")
#         qc_p2 <- FeatureScatter(sce, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")
#         png("results/qc2.png", 700, 450)
#         qc_p1 + qc_p2 + patchwork::plot_annotation(tag_levels = "A")
#         dev.off()
#     },
#     step_name = "qc_seurat",
#     dependency = "create_seurat"
# )

## ----filter_cells, eval=FALSE, spr=TRUE-------------------
# appendStep(sal) <- LineWise(
#     code = {
#         # Based on the QC plots, please change the settings accordingly
#         sce <- subset(
#             sce, subset = nFeature_RNA > 200 & nFeature_RNA < 2500 &
#                 nCount_RNA < 10000 & percent.mt <= 5
#         )
#     },
#     step_name = "filter_cells",
#     dependency = "create_seurat"
# )

## ----normalize, eval=FALSE, spr=TRUE----------------------
# appendStep(sal) <- LineWise(
#     code = {
#         # scale.factor = 10000 is a convenient number for plotting, so the
#         # normalized counts is ranged between 0.xx to 10.
#         sce <- NormalizeData(sce, normalization.method = "LogNormalize", scale.factor = 10000)
# 
#         # compare counts before and after
#         count_p_norm <- tibble::as_tibble(MatrixGenerics::colSums(sce$RNA@layers$data)) %>%
#             ggplot() +
#                 geom_histogram(aes(x = value), bins = floor(ncol(pbmc.data)/50), fill = "#6b97c2", color = "white") +
#                 theme_pubr(16) +
#                 scale_y_continuous(expand = c(0, 0)) +
#                 scale_x_continuous(expand = c(0, 0)) +
#                 labs(title = "Total expression after normalization", x = "Sum expression")
#         png("results/normalize_count_compare.png", 1000, 700)
#         count_p2 + count_p_norm + patchwork::plot_annotation(tag_levels = "A")
#         dev.off()
#     },
#     step_name = "normalize",
#     dependency = "filter_cells"
# )

## ----find_var_genes, eval=FALSE, spr=TRUE-----------------
# appendStep(sal) <- LineWise(
#     code = {
#         # 2000 is default
#         sce <- FindVariableFeatures(sce, selection.method = "vst", nfeatures = 2000)
#         # top 10 variable genes
#         top10_var <- head(VariableFeatures(sce), 10)
#         # plot the top 2000 variable genes and mark top 10
#         png("results/variable_genes.png", 700, 600)
#         VariableFeaturePlot(sce) %>%
#             LabelPoints(points = top10_var, repel = TRUE) +
#             theme_pubr(16)
#         dev.off()
#     },
#     step_name = "find_var_genes",
#     dependency = "normalize"
# )

## ----scaling, eval=FALSE, spr=TRUE------------------------
# appendStep(sal) <- LineWise(
#     code = {
#         sce <- ScaleData(sce, features = rownames(sce))
#     },
#     step_name = "scaling",
#     dependency = "find_var_genes"
# )

## ----pca, eval=FALSE, spr=TRUE----------------------------
# appendStep(sal) <- LineWise(
#     code = {
#         # only use the top 2000 genes, first 50 PCs (default)
#         sce <- RunPCA(sce,features = VariableFeatures(object = sce), npcs = 50)
#         # we can use following command to see first 5 genes in each PC
#         print(sce$pca, dims = 1:5, nfeatures = 5)
#     },
#     step_name = "pca",
#     dependency = "scaling"
# )

## ----pca_plots, eval=FALSE, spr=TRUE----------------------
# appendStep(sal) <- LineWise(
#     code = {
#         # plot PCA overview
#         png("results/pca_overview.png", 500, 500)
#         DimPlot(sce , reduction = "pca")
#         dev.off()
#         # plot top contributed genes in PC 1 and 2
#         png("results/pca_loadings.png", 700, 550)
#         VizDimLoadings(sce , dims = 1:2, reduction = "pca")
#         dev.off()
#         # we can also use heatmap to show top genes in different PCs
#         png("results/pca_heatmap.png", 700, 700)
#         DimHeatmap(sce,dims = 1:6, cells = ncol(sce)/5, balanced = TRUE, slot = "scale.data")
#         dev.off()
#     },
#     step_name = "pca_plots",
#     dependency = "pca"
# )

## ----choose_pcs, eval=FALSE, spr=TRUE---------------------
# appendStep(sal) <- LineWise(
#     code = {
#         # for demo purposes, only a few replicates are used to speed up the calculation
#         # in your real data, use larger number like 100, etc.
#         sce <- JackStraw(sce, num.replicate = 30)
#         sce <- ScoreJackStraw(sce, dims = 1:20)
#         png("results/jackstraw.png", 660, 750)
#         JackStrawPlot(sce, dims = 1:20)
#         dev.off()
# 
#         png("results/elbow.png", 500, 500)
#         ElbowPlot(sce)
#         dev.off()
#     },
#     step_name = "choose_pcs",
#     dependency = "pca"
# )

## ----find_clusters, eval=FALSE, spr=TRUE------------------
# appendStep(sal) <- LineWise(
#     code = {
#         sce<- FindNeighbors(sce, dims = 1:10)
#         # resolution 0.4-1.2 good for 3000 cells, if you have more cells, increase
#         # the number will give you more clusters
#         sce<- FindClusters(sce, resolution = 0.5)
#     },
#     step_name = "find_clusters",
#     dependency = "pca"
# )

## ----plot_cluster, eval=FALSE, spr=TRUE-------------------
# appendStep(sal) <- LineWise(
#     code = {
#         sce <- RunUMAP(sce,dims = 1:20)
#         p_umap <- DimPlot(sce,reduction = 'umap', label = TRUE)
#         sce <- RunTSNE(sce,dims = 1:20)
#         p_tsne <- DimPlot(sce,reduction = 'tsne', label = TRUE)
#         png("results/plot_clusters.png", 1000, 570)
#         p_umap + p_tsne
#         dev.off()
#     },
#     step_name = "plot_cluster",
#     dependency = "find_clusters"
# )

## ----find_markers, eval=FALSE, spr=TRUE-------------------
# appendStep(sal) <- LineWise(
#     code = {
#         # find markers for every cluster compared to all remaining cells, report only the positive ones
#         sce.markers <- FindAllMarkers(sce, only.pos = TRUE, min.pct = 0.25, logfc.threshold = 0.25)
#         sce.markers %>% group_by(cluster) %>% top_n(n = 2, wt = avg_log2FC)
#     },
#     step_name = "find_markers",
#     dependency = "find_clusters"
# )

## ----plot_markers, eval=FALSE, spr=TRUE-------------------
# appendStep(sal) <- LineWise(
#     code = {
#         png("results/vlnplot.png", 600, 600)
#         VlnPlot(sce, features = c("MS4A1", "CD79A"))
#         dev.off()
# 
#         png("results/marker_features.png", 700, 500)
#         FeaturePlot(sce, features = c("MS4A1", "GNLY", "CD3E", "CD14"))
#         dev.off()
# 
#         # plot top 10 DEG genes in each cluster as a heatmap
#         top10_markers <- sce.markers %>% group_by(cluster) %>% top_n(n = 10, wt = avg_log2FC)
#         png("results/marker_heatmap.png", 1100, 700)
#         DoHeatmap(sce, features = top10_markers$gene) + NoLegend()
#         dev.off()
#     },
#     step_name = "plot_markers",
#     dependency = "find_markers"
# )

## ----label_cell_type, eval=FALSE, spr=TRUE----------------
# appendStep(sal) <- LineWise(
#     code = {
#         new.cluster.ids <- c("Naive CD4 T", "CD14+ Mono", "Memory CD4 T", "B",
#                              "CD8 T", "FCGR3A+ Mono","NK", "DC", "Platelet")
#         names(new.cluster.ids) <- levels(sce)
#         sce<- RenameIdents(sce, new.cluster.ids)
#         png("results/marker_labels.png", 700, 700)
#         DimPlot(sce, reduction = "umap", label = TRUE, pt.size = 0.5) + NoLegend()
#         dev.off()
# 
#     },
#     step_name = "label_cell_type",
#     dependency = c("plot_cluster", "find_markers")
# )

## ----wf_session, eval=FALSE, spr=TRUE---------------------
# appendStep(sal) <- LineWise(
#     code = {
#         sessionInfo()
#     },
#     step_name = "wf_session",
#     dependency = "label_cell_type")

## ----runWF, eval=FALSE------------------------------------
# sal <- runWF(sal, run_step = "mandatory") # remove `run_step` to run all steps to include optional steps

## ----list_tools-------------------------------------------
if(file.exists(file.path(".SPRproject", "SYSargsList.yml"))) {
    local({
        sal <- systemPipeR::SPRproject(resume = TRUE)
        systemPipeR::listCmdTools(sal)
        systemPipeR::listCmdModules(sal)
    })
} else {
    cat(crayon::blue$bold("Tools and modules required by this workflow are:\n"))
    cat(c("NA"), sep = "\n")
}

## ----report_session_info, eval=TRUE-----------------------
sessionInfo()

