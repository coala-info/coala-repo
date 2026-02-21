# Code example from 'supervised_demultiplexing' vignette. See references/ for full tutorial.

## ----eval=TRUE, include = FALSE-----------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    message = FALSE,
    fig.width = 7.5
)

## ----message=FALSE------------------------------------------------------------
library(demuxSNP)
library(ComplexHeatmap)
library(viridisLite)
library(Seurat)
library(ggpubr)
library(dittoSeq)
library(utils)
library(EnsDb.Hsapiens.v86)

## -----------------------------------------------------------------------------
colors <- structure(viridis(n = 3), names = c("-1", "0", "1"))

## ----eval=FALSE---------------------------------------------------------------
# 
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("demuxSNP")
# 
# ## or for development version:
# 
# devtools::install_github("michaelplynch/demuxSNP")
# 

## ----eval=FALSE---------------------------------------------------------------
# #Data loading
# data(multiplexed_scrnaseq_sce,
#      commonvariants_1kgenomes_subset,
#      vartrix_consensus_snps,
#      package = "demuxSNP")
# 
# small_sce<-multiplexed_scrnaseq_sce[,1:100]
# ensdb <- EnsDb.Hsapiens.v86::EnsDb.Hsapiens.v86
# 
# #Preprocessing
# top_genes<-common_genes(small_sce)
# vcf_sub<-subset_vcf(commonvariants_1kgenomes_subset, top_genes, ensdb)
# small_sce<-high_conf_calls(small_sce)
# 
# #Use subsetted vcf with VarTrix in default 'consensus' mode to generate SNPs
# #matrix
# 
# small_sce<-add_snps(small_sce,vartrix_consensus_snps[,1:100])
# 
# small_sce<-reassign_centroid(small_sce,min_cells = 5)
# 
# table(small_sce$knn)

## ----eval=FALSE---------------------------------------------------------------
# sce <- reassign_centroid(sce,
#     train_cells = sce$train,
#     predict_cells = sce$predict,
#     min_cells=5
# )

## -----------------------------------------------------------------------------

data(multiplexed_scrnaseq_sce, 
     commonvariants_1kgenomes_subset, 
     vartrix_consensus_snps, 
     package = "demuxSNP")

class(multiplexed_scrnaseq_sce)
class(commonvariants_1kgenomes_subset)
class(vartrix_consensus_snps)

## ----echo=FALSE, warning=FALSE, fig.height=5,fig.width=8.5--------------------
htos <- as.data.frame(t(as.matrix(logcounts(altExp(multiplexed_scrnaseq_sce, "HTO")))))

x1 <- gghistogram(htos, x = "Hashtag1", fill = dittoColors(1)[1], palette = "lancet", xlim = c(0, 8), ylim = c(0, 750), alpha = 1)
x2 <- gghistogram(htos, x = "Hashtag2", fill = dittoColors(1)[2], palette = "lancet", xlim = c(0, 8), ylim = c(0, 750), alpha = 1)
x3 <- gghistogram(htos, x = "Hashtag3", fill = dittoColors(1)[3], palette = "lancet", xlim = c(0, 8), ylim = c(0, 750), alpha = 1)
x4 <- gghistogram(htos, x = "Hashtag4", fill = dittoColors(1)[4], palette = "lancet", xlim = c(0, 8), ylim = c(0, 750), alpha = 1)
x5 <- gghistogram(htos, x = "Hashtag5", fill = dittoColors(1)[5], palette = "lancet", xlim = c(0, 8), ylim = c(0, 750), alpha = 1)
x6 <- gghistogram(htos, x = "Hashtag6", fill = dittoColors(1)[6], palette = "lancet", xlim = c(0, 8), ylim = c(0, 750), alpha = 1)

plot <- ggarrange(x1, x2, x3, x4, x5, x6, align = "hv", ncol = 3, nrow = 2)

annotate_figure(plot, top = text_grob("CLR normalised HTO counts", size = 12))

## -----------------------------------------------------------------------------
logcounts(multiplexed_scrnaseq_sce) <- counts(multiplexed_scrnaseq_sce)
seurat <- as.Seurat(multiplexed_scrnaseq_sce)
seurat <- HTODemux(seurat)
seurat$hash.ID <- factor(as.character(seurat$hash.ID))
multiplexed_scrnaseq_sce$seurat <- seurat$hash.ID

multiplexed_scrnaseq_sce$seurat <- seurat$hash.ID

table(multiplexed_scrnaseq_sce$seurat)

## -----------------------------------------------------------------------------
dittoPlot(seurat, "nCount_HTO", group.by = "hash.ID")
dittoPlot(seurat, "nCount_RNA", group.by = "hash.ID")

## -----------------------------------------------------------------------------
top_genes <- common_genes(sce = multiplexed_scrnaseq_sce, n = 100)

top_genes[1:10]

## -----------------------------------------------------------------------------
ensdb <- EnsDb.Hsapiens.v86::EnsDb.Hsapiens.v86

genome(commonvariants_1kgenomes_subset)[1] == genome(ensdb)[1]

new_vcf <- subset_vcf(commonvariants_1kgenomes_subset, top_genes = top_genes, ensdb)
commonvariants_1kgenomes_subset
new_vcf

## -----------------------------------------------------------------------------
multiplexed_scrnaseq_sce <- high_conf_calls(multiplexed_scrnaseq_sce)

table(multiplexed_scrnaseq_sce$train)

table(multiplexed_scrnaseq_sce$predict)

table(multiplexed_scrnaseq_sce$labels)

## -----------------------------------------------------------------------------
dim(vartrix_consensus_snps)

multiplexed_scrnaseq_sce <- add_snps(multiplexed_scrnaseq_sce, vartrix_consensus_snps, thresh = 0.95)

altExp(multiplexed_scrnaseq_sce, "SNP")

## -----------------------------------------------------------------------------
hm <- Heatmap(counts(altExp(multiplexed_scrnaseq_sce, "SNP")),
    column_split = multiplexed_scrnaseq_sce$seurat,
    cluster_rows = FALSE,
    show_column_names = FALSE,
    cluster_column_slices = FALSE,
    column_title_rot = -45,
    row_title = "SNPs",
    show_row_names = FALSE,
    col = colors
)

draw(hm,
    column_title = "SNP profiles split by Seurat HTODemux call",
    padding = unit(c(2, 15, 2, 2), "mm")
)

## -----------------------------------------------------------------------------
set.seed(1)
multiplexed_scrnaseq_sce$labels<-as.character(multiplexed_scrnaseq_sce$labels)
multiplexed_scrnaseq_sce$knn <- reassign_centroid(multiplexed_scrnaseq_sce,
    train_cells = multiplexed_scrnaseq_sce$train,
    predict_cells = multiplexed_scrnaseq_sce$predict,
    min_cells = 5
)

table(multiplexed_scrnaseq_sce$knn)

## -----------------------------------------------------------------------------
hm <- Heatmap(counts(altExp(multiplexed_scrnaseq_sce, "SNP")),
    column_split = multiplexed_scrnaseq_sce$knn,
    cluster_rows = FALSE,
    show_column_names = FALSE,
    cluster_column_slices = FALSE,
    column_names_rot = 45,
    column_title_rot = -45,
    row_title = "SNPs",
    show_row_names = FALSE,
    col = colors
)

draw(hm,
    column_title = "SNP profiles split by updated knn classification",
    padding = unit(c(2, 15, 2, 2), "mm")
)

## -----------------------------------------------------------------------------
hm <- Heatmap(counts(altExp(multiplexed_scrnaseq_sce, "SNP"))[, multiplexed_scrnaseq_sce$knn == "Hashtag5"],
    column_split = multiplexed_scrnaseq_sce$seurat[multiplexed_scrnaseq_sce$knn == "Hashtag5"],
    cluster_rows = FALSE,
    show_column_names = FALSE,
    cluster_column_slices = FALSE,
    column_names_rot = 45,
    column_title_rot = -45,
    row_title = "SNPs",
    show_row_names = FALSE,
    col = colors
)

draw(hm,
    column_title = "knn Hashtag5 group split by Seurat HTODemux classification",
    padding = unit(c(2, 15, 2, 2), "mm")
)

## -----------------------------------------------------------------------------
sce_test <- multiplexed_scrnaseq_sce[, multiplexed_scrnaseq_sce$train == TRUE]
sce_test$knn <- NULL
#sce_test$labels <- droplevels(sce_test$labels)
sce_test

sce_test$train2 <- rep(FALSE, length(sce_test$train))
sce_test$train2[seq_len(500)] <- TRUE

sce_test$test <- sce_test$train2 == FALSE

## -----------------------------------------------------------------------------
sce_test$knn <- reassign_centroid(sce_test, train_cells = sce_test$train2, predict_cells = sce_test$test, min_cells = 5)

table(sce_test$labels[sce_test$test == TRUE], sce_test$knn[sce_test$test == TRUE])

## -----------------------------------------------------------------------------
sce_test$knn <- NULL

sce_test$labels2 <- sce_test$labels

table(sce_test$labels, sce_test$labels2)

## -----------------------------------------------------------------------------
sce_test$labels2[which(sce_test$labels2 == "Hashtag5")[1:25]] <- "Hashtag2"

table(sce_test$labels, sce_test$labels2)

sce_test$knn <- reassign_centroid(sce_test,
    train_cells = sce_test$train,
    predict_cells = sce_test$train,
    min_cells = 5
)

table(sce_test$labels, sce_test$knn)

## -----------------------------------------------------------------------------
hm <- Heatmap(counts(altExp(sce_test, "SNP"))[, sce_test$knn == "Hashtag6"],
    column_split = sce_test$labels[sce_test$knn == "Hashtag6"],
    cluster_rows = FALSE,
    show_column_names = FALSE,
    cluster_column_slices = FALSE,
    column_names_rot = 45,
    column_title_rot = -45,
    row_title = "SNPs",
    show_row_names = FALSE,
    col = colors
)

draw(hm,
    column_title = "knn Hashtag6 group split by demuxmix classification",
    padding = unit(c(2, 15, 2, 2), "mm")
)

## -----------------------------------------------------------------------------
sessionInfo()

