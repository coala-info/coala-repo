# Code example from 'CellMixS' vignette. See references/ for full tutorial.

## ----v1, include = FALSE------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = TRUE
)

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("CellMixS")

## ----load, message=FALSE------------------------------------------------------
library(CellMixS)

## ----warning=FALSE------------------------------------------------------------
# Load required packages
suppressPackageStartupMessages({
    library(SingleCellExperiment)
    library(cowplot)
    library(limma)
    library(magrittr)
    library(dplyr)
    library(purrr)
    library(ggplot2)
    library(scater)
})

## ----data---------------------------------------------------------------------
# Load sim_list example data
sim_list <- readRDS(system.file(file.path("extdata", "sim50.rds"), 
                                package = "CellMixS"))
names(sim_list)

sce50 <- sim_list[["batch50"]]
class(sce50)

table(sce50[["batch"]])

## ----visBatch50---------------------------------------------------------------
# Visualize batch distribution in sce50
visGroup(sce50, group = "batch")

## ----visBatchAll, fig.wide=TRUE-----------------------------------------------
# Visualize batch distribution in other elements of sim_list 
batch_names <- c("batch0", "batch20")
  
vis_batch <- lapply(batch_names, function(name){
    sce <- sim_list[[name]]
    visGroup(sce, "batch") + ggtitle(paste0("sim_", name))
})

plot_grid(plotlist = vis_batch, ncol = 2)

## ----cms----------------------------------------------------------------------
# Call cell-specific mixing score for sce50
# Note that cell_min is set to 4 due to the low number of cells and small k.
# Usually default parameters are recommended!! 
sce50 <- cms(sce50, k = 30, group = "batch", res_name = "unaligned", 
             n_dim = 3, cell_min = 4)
head(colData(sce50))

# Call cell-specific mixing score for all datasets
sim_list <- lapply(batch_names, function(name){
    sce <- sim_list[[name]]
    sce <- cms(sce, k = 30, group = "batch", res_name = "unaligned", 
               n_dim = 3, cell_min = 4)
}) %>% set_names(batch_names)

# Append cms50
sim_list[["batch50"]] <- sce50

## ----hist, fig.wide=TRUE------------------------------------------------------
# p-value histogram of cms50
visHist(sce50)

# p-value histogram sim30
# Combine cms results in one matrix
batch_names <- names(sim_list)
cms_mat <- batch_names %>% 
  map(function(name) sim_list[[name]]$cms.unaligned) %>% 
  bind_cols() %>% set_colnames(batch_names)

visHist(cms_mat, n_col = 3)

## ----singlePlots, fig.wide= TRUE----------------------------------------------
# cms only cms20
sce20 <- sim_list[["batch20"]]
metric_plot <- visMetric(sce20, metric_var = "cms_smooth.unaligned")

# group only cms20
group_plot <- visGroup(sce20, group = "batch")

plot_grid(metric_plot, group_plot, ncol = 2)

## ----overview-----------------------------------------------------------------
# Add random celltype assignments as new metadata
sce20[["celltype"]] <- rep(c("CD4+", "CD8+", "CD3"), length.out = ncol(sce20)) %>% 
    as.factor 

visOverview(sce20, "batch", other_var = "celltype")

## ----compareCluster, fig.small=TRUE-------------------------------------------
visCluster(sce20, metric_var = "cms.unaligned", cluster_var = "celltype")

## ----batchCorrectionMethods---------------------------------------------------
# MNN - embeddings are stored in the reducedDims slot of sce
reducedDimNames(sce20)
sce20 <- cms(sce20, k = 30, group = "batch", 
             dim_red = "MNN", res_name = "MNN", n_dim = 3, cell_min = 4)

# Run limma
sce20 <- scater::logNormCounts(sce20)
limma_corrected <- removeBatchEffect(logcounts(sce20), batch = sce20$batch)
# Add corrected counts to sce
assay(sce20, "lim_corrected") <- limma_corrected 

# Run cms
sce20 <- cms(sce20, k = 30, group = "batch", 
             assay_name = "lim_corrected", res_name = "limma", n_dim = 3, 
             cell_min = 4)

names(colData(sce20))

## ----batch correction methods vis---------------------------------------------
# As pvalue histograms
visHist(sce20, metric = "cms.",  n_col = 3)

## ----ldfDiff, warning=FALSE---------------------------------------------------
# Prepare input 
# List with single SingleCellExperiment objects 
# (Important: List names need to correspond to batch levels! See ?ldfDiff)
sce_pre_list <- list("1" = sce20[,sce20$batch == "1"], 
                     "2" = sce20[,sce20$batch == "2"], 
                     "3" = sce20[,sce20$batch == "3"])

sce20 <- ldfDiff(sce_pre_list, sce_combined = sce20, 
                 group = "batch", k = 70, dim_red = "PCA", 
                 dim_combined = "MNN", assay_pre = "counts", 
                 n_dim = 3, res_name = "MNN")

sce20 <- ldfDiff(sce_pre_list, sce_combined = sce20, 
                 group = "batch", k = 70, dim_red = "PCA", 
                 dim_combined = "PCA", assay_pre = "counts", 
                 assay_combined = "lim_corrected",  
                 n_dim = 3, res_name = "limma")

names(colData(sce20))

## ----visldfDiff---------------------------------------------------------------
# ldfDiff score summarized
visIntegration(sce20, metric = "diff_ldf", metric_name = "ldfDiff") 

## ----evalIntegration----------------------------------------------------------
sce50 <- evalIntegration(metrics = c("isi", "entropy"), sce50, 
                         group = "batch", k = 30, n_dim = 2, cell_min = 4,
                         res_name = c("weighted_isi", "entropy"))

visOverview(sce50, "batch", 
            metric = c("cms_smooth.unaligned", "weighted_isi", "entropy"), 
            prefix = FALSE)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

