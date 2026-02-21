# Code example from 'tricycle' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----echo=FALSE---------------------------------------------------------------
htmltools::img(src = knitr::image_uri(file.path("../man/figures", "logo.png")),
               alt = 'logo',
               style = 'position:absolute; top:50px; right:5px; padding:10px;height:200px')

## ----setup, message = FALSE---------------------------------------------------
library(tricycle)

## ----example, message=FALSE---------------------------------------------------
data(neurosphere_example)

## ----project, message = TRUE--------------------------------------------------
neurosphere_example <- project_cycle_space(neurosphere_example)
neurosphere_example

## ----plot_projection, message = FALSE-----------------------------------------
library(ggplot2)
library(scattermore)
library(scater)
scater::plotReducedDim(neurosphere_example, dimred = "tricycleEmbedding") +
    labs(x = "Projected PC1", y = "Projected PC2") +
    ggtitle(sprintf("Projected cell cycle space (n=%d)",
                    ncol(neurosphere_example))) +
    theme_bw(base_size = 14)

## ----tricyclePosition, message = TRUE-----------------------------------------
neurosphere_example <- estimate_cycle_position(neurosphere_example)
names(colData(neurosphere_example))

## ----loess, message = TRUE----------------------------------------------------
top2a.idx <- which(rowData(neurosphere_example)$Gene == 'Top2a')
fit.l <- fit_periodic_loess(neurosphere_example$tricyclePosition,
                            assay(neurosphere_example, 'logcounts')[top2a.idx,],
                            plot = TRUE,
                       x_lab = "Cell cycle position \u03b8", y_lab = "log2(Top2a)",
                       fig.title = paste0("Expression of Top2a along \u03b8 (n=",
                                          ncol(neurosphere_example), ")"))
names(fit.l)
fit.l$fig + theme_bw(base_size = 14)

## ----stage, message = TRUE----------------------------------------------------
neurosphere_example <- estimate_Schwabe_stage(neurosphere_example,
                                            gname.type = 'ENSEMBL',
                                            species = 'mouse')
scater::plotReducedDim(neurosphere_example, dimred = "tricycleEmbedding",
                       colour_by = "CCStage") +
  labs(x = "Projected PC1", y = "Projected PC2",
       title = paste0("Projected cell cycle space (n=", ncol(neurosphere_example), ")")) +
  theme_bw(base_size = 14)

## ----density, message = TRUE--------------------------------------------------
plot_ccposition_den(neurosphere_example$tricyclePosition,
                    neurosphere_example$sample, 'sample',
                    bw = 10, fig.title = "Kernel density of \u03b8") +
  theme_bw(base_size = 14)

plot_ccposition_den(neurosphere_example$tricyclePosition,
                    neurosphere_example$sample, 'sample', type = "circular",
                    bw = 10,  fig.title = "Kernel density of \u03b8") +
  theme_bw(base_size = 14)

## ----cyclic, message = TRUE, fig.width = 10, fig.height = 7-------------------
library(cowplot)
p <- plot_emb_circle_scale(neurosphere_example, dimred = 1,
                           point.size = 3.5, point.alpha = 0.9) +
  theme_bw(base_size = 14)
legend <- circle_scale_legend(text.size = 5, alpha = 0.9)
plot_grid(p, legend, ncol = 2, rel_widths = c(1, 0.4))

## ----newRef, message = TRUE---------------------------------------------------
set.seed(100)
gocc_sce.o <- run_pca_cc_genes(neurosphere_example,
                               exprs_values = "logcounts", species = "mouse")
new.ref <- attr(reducedDim(gocc_sce.o, 'PCA'), 'rotation')[, seq_len(2)]
head(new.ref)
new_sce <- estimate_cycle_position(neurosphere_example, ref.m  = new.ref,
                                   dimred = 'tricycleEmbedding2')


## ----cor, message = TRUE------------------------------------------------------
cor(neurosphere_example$tricyclePosition, new_sce$tricyclePosition)
CircStats::circ.cor(neurosphere_example$tricyclePosition, new_sce$tricyclePosition)
qplot(x = neurosphere_example$tricyclePosition,y = new_sce$tricyclePosition) +
  labs(x = "Original \u03b8", y = "New \u03b8",
       title = paste0("Comparison of two \u03b8 (n=", ncol(neurosphere_example), ")")) +
  theme_bw(base_size = 14)

## ----batch, eval = FALSE, echo = TRUE-----------------------------------------
# # suppose we have a count matrix containing all cells across batches; we first subset the matrix to GO cell cycle genes
# library(org.Mm.eg.db)
# library(AnnotationDbi)
# cc.genes <- AnnotationDbi::select(org.Mm.eg.db, keytype = "GOALL",
#                                   keys = "GO:0007049",
#                                   columns = "ENSEMBL")[, "ENSEMBL"]
# count_cc.m <- count.m[ensembl.ids %in% cc.genes, ]  # ensembl.ids is the ensembl.ids for each row of count.m
# 
# # we then construct a Seurat object using the subset matrix and set the batch variable
# library(Seurat)
# seurat.o <- CreateSeuratObject(counts = count_cc.m)
# seurat.o[["batch"]] <- batch.v
# 
# # make a Seurat list and normalize for each batch separately
# # variable features definition is required for FindIntegrationAnchors function
# seurat.list <- lapply(SplitObject(seurat.o, split.by = "batch"),
#                       function(x) FindVariableFeatures(NormalizeData(x)))
# 
# # find anchors and merge data
# seurat.anchors <- FindIntegrationAnchors(object.list = seurat.list)
# seurat.integrated <- IntegrateData(anchorset = seurat.anchors)
# corrected.m <- seurat.integrated@assays$integrated@data
# 
# # run PCA on the batch effects corrected matrix and get the rotaions scores for the top 2 PCs
# pca.m <- scater::calculatePCA(corrected.m, ntop = 500)
# new.ref <- attr(pca.m, 'rotation')[, seq_len(2)]
# 

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

## ----ref, message = FALSE-----------------------------------------------------
data(neuroRef)
head(neuroRef)

