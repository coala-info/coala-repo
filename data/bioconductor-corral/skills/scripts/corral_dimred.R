# Code example from 'corral_dimred' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(gridExtra)

## ----message = FALSE----------------------------------------------------------
library(corral)
library(SingleCellExperiment)
library(ggplot2)
library(DuoClustering2018)
zm4eq.sce <- sce_full_Zhengmix4eq()
zm8eq <- sce_full_Zhengmix8eq()

## -----------------------------------------------------------------------------
zm4eq.sce
table(colData(zm4eq.sce)$phenoid)

## -----------------------------------------------------------------------------
zm4eq.sce <- corral(inp = zm4eq.sce, 
                    whichmat = 'counts')

zm4eq.sce

## -----------------------------------------------------------------------------
plot_embedding_sce(sce = zm4eq.sce,
                   which_embedding = 'corral',
                   plot_title = 'corral on Zhengmix4eq',
                   color_attr = 'phenoid',
                   color_title = 'cell type',
                   saveplot = FALSE)

## -----------------------------------------------------------------------------
library(scater)
library(gridExtra) # so we can arrange the plots side by side

zm4eq.sce <- runUMAP(zm4eq.sce,
                     dimred = 'corral',
                     name = 'corral_UMAP')
zm4eq.sce <- runTSNE(zm4eq.sce,
                     dimred = 'corral',
                     name = 'corral_TSNE')

ggplot_umap <- plot_embedding_sce(sce = zm4eq.sce,
                                  which_embedding = 'corral_UMAP',
                                  plot_title = 'Zhengmix4eq corral with UMAP',
                                  color_attr = 'phenoid',
                                  color_title = 'cell type',
                                  returngg = TRUE,
                                  showplot = FALSE,
                                  saveplot = FALSE)

ggplot_tsne <- plot_embedding_sce(sce = zm4eq.sce,
                                  which_embedding = 'corral_TSNE',
                                  plot_title = 'Zhengmix4eq corral with tSNE',
                                  color_attr = 'phenoid',
                                  color_title = 'cell type',
                                  returngg = TRUE,
                                  showplot = FALSE,
                                  saveplot = FALSE)

gridExtra::grid.arrange(ggplot_umap, ggplot_tsne, ncol = 2)


## -----------------------------------------------------------------------------
zm4eq.countmat <- assay(zm4eq.sce,'counts')
zm4eq.countcorral <- corral(zm4eq.countmat)

## -----------------------------------------------------------------------------
zm4eq.countcorral

## -----------------------------------------------------------------------------
celltype_vec <- zm4eq.sce$phenoid
plot_embedding(embedding = zm4eq.countcorral$v,
               plot_title = 'corral on Zhengmix4eq',
               color_vec = celltype_vec,
               color_title = 'cell type',
               saveplot = FALSE)

## -----------------------------------------------------------------------------
zm8eq.corral <- corral(zm8eq, fullout = TRUE)
zm8eq.corralsmooth <- corral(zm8eq, fullout = TRUE, smooth = TRUE)

## -----------------------------------------------------------------------------
gene_names <- rowData(zm4eq.sce)$symbol

biplot_corral(corral_obj = zm4eq.countcorral, color_vec = celltype_vec, text_vec = gene_names)

## -----------------------------------------------------------------------------
sessionInfo()

