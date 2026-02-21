# Code example from 'corralm_alignment' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(gridExtra)

## ----message = FALSE----------------------------------------------------------
library(corral)
library(SingleCellExperiment)
library(ggplot2)
library(CellBench)
library(MultiAssayExperiment)

scmix_dat <- load_all_data()[1:3]


## -----------------------------------------------------------------------------
scmix_dat

## -----------------------------------------------------------------------------
platforms <- c('10X','CELseq2','Dropseq')
for(i in seq_along(scmix_dat)) {
  colData(scmix_dat[[i]])$Method<- rep(platforms[i], ncol(scmix_dat[[i]]))
}

scmix_mae <- as(scmix_dat,'MultiAssayExperiment')
scmix_dat <- as.list(MultiAssayExperiment::experiments(MultiAssayExperiment::intersectRows(scmix_mae)))


## -----------------------------------------------------------------------------
colData(scmix_dat[[2]])$non_ERCC_percent <- NULL
# need to remove this column so the objects can be concatenated

scmix_sce <- SingleCellExperiment::cbind(scmix_dat[[1]],
                                         scmix_dat[[2]],
                                         scmix_dat[[3]])

## -----------------------------------------------------------------------------
scmix_sce <- corralm(scmix_sce, splitby = 'Method')

## -----------------------------------------------------------------------------
plot_embedding_sce(sce = scmix_sce, 
                   which_embedding = 'corralm', 
                   color_attr = 'Method', 
                   color_title = 'platform', 
                   ellipse_attr = 'cell_line', 
                   plot_title = 'corralm on scmix', 
                   saveplot = FALSE)

## -----------------------------------------------------------------------------
scmix_matlist <- sce2matlist(sce = scmix_sce, 
                             splitby = 'Method', 
                             whichmat = 'counts')

# for plotting purposes later, while we're here
platforms <- colData(scmix_sce)$Method
cell_lines <- colData(scmix_sce)$cell_line

## -----------------------------------------------------------------------------
scmix_corralm <- corralm(scmix_matlist)
scmix_corralm
plot_embedding(embedding = scmix_corralm$v, 
               plot_title = 'corralm on scmix', 
               color_vec = platforms, 
               color_title = 'platform', 
               ellipse_vec = cell_lines, 
               saveplot = FALSE)

## -----------------------------------------------------------------------------
scal_var(scmix_corralm)

## -----------------------------------------------------------------------------
sessionInfo()

