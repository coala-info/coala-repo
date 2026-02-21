# Code example from 'example' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,
                      message = FALSE,
                      warning = FALSE,
                      comment = NA,
                      fig.width = 6,
                      fig.height = 4)
library(HIPPO)
library(SingleCellExperiment)

## ----eval=FALSE---------------------------------------------------------------
# devtools::install_github("tk382/HIPPO", build_vignettes = TRUE)

## -----------------------------------------------------------------------------
data(toydata)
data(ensg_hgnc)

## ----eval = FALSE-------------------------------------------------------------
# # X = readRDS("zhengmix4eq_counts.rds")
# # toydata = SingleCellExperiment(assays = list(counts = X))

## ----warning = FALSE----------------------------------------------------------
hippo_diagnostic_plot(toydata, 
                      show_outliers = TRUE, 
                      zvalue_thresh = 2)

## ----warning = FALSE----------------------------------------------------------
set.seed(20200321)
toydata = hippo(toydata, K = 10, 
                z_threshold = 2, outlier_proportion = 0.00001)

## ----warning = FALSE----------------------------------------------------------
toydata = hippo_dimension_reduction(toydata, method="umap")
hippo_umap_plot(toydata)

## -----------------------------------------------------------------------------
toydata = hippo_dimension_reduction(toydata, method="tsne")
hippo_tsne_plot(toydata)

## ----fig.width = 6, fig.height = 3--------------------------------------------
data(ensg_hgnc)
zero_proportion_plot(toydata, 
                     switch_to_hgnc = TRUE, 
                     ref = ensg_hgnc)
hippo_feature_heatmap(toydata, k = 3, 
                      switch_to_hgnc = TRUE, 
                      ref = ensg_hgnc, 
                      top.n = 20)

## -----------------------------------------------------------------------------
toydata = hippo_diffexp(toydata, 
                  top.n = 5, 
                  switch_to_hgnc = TRUE, 
                  ref = ensg_hgnc)

## -----------------------------------------------------------------------------
head(get_hippo_diffexp(toydata, 1))

## -----------------------------------------------------------------------------
sessionInfo()

