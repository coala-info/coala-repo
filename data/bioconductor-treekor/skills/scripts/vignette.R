# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
# Load required packages
suppressPackageStartupMessages({
  library(treekoR)
  library(SingleCellExperiment)
  library(ggtree)
})

## ----eval=F-------------------------------------------------------------------
# # Install the development version from GitHub:
# # install.packages("devtools")
# devtools::install_github("adam2o1o/treekoR")
# library(treekoR)

## -----------------------------------------------------------------------------
data(COVIDSampleData)

sce <- DeBiasi_COVID_CD8_samp

## -----------------------------------------------------------------------------
exprs <- t(assay(sce, "exprs"))
clusters <- colData(sce)$cluster_id
classes <- colData(sce)$condition
samples <- colData(sce)$sample_id

## -----------------------------------------------------------------------------
clust_tree <- getClusterTree(exprs,
                             clusters,
                             hierarchy_method="hopach")

## -----------------------------------------------------------------------------
tested_tree <- testTree(phylo=clust_tree$clust_tree,
                      clusters=clusters,
                      samples=samples,
                      classes=classes,
                      pos_class_name=NULL)

## -----------------------------------------------------------------------------
res_df <- getTreeResults(tested_tree)

head(res_df, 10)

## -----------------------------------------------------------------------------
plotInteractiveHeatmap(tested_tree,
                       clust_med_df = clust_tree$median_freq,
                       clusters=clusters)

## -----------------------------------------------------------------------------
clust_tree <- getClusterTree(exprs,
                             clusters,
                             hierarchy_method="average")

tested_tree <- testTree(clust_tree$clust_tree,
                      clusters=clusters,
                      samples=samples,
                      classes=classes,
                      pos_class_name=NULL)

plotInteractiveHeatmap(tested_tree,
                       clust_med_df = clust_tree$median_freq,
                       clusters=clusters)

## -----------------------------------------------------------------------------
clust_tree <- getClusterTree(exprs,
                             clusters,
                             hierarchy_method="hopach")

tested_tree_edgeR <- testTree(clust_tree$clust_tree,
                      clusters=clusters,
                      samples=samples,
                      classes=classes,
                      sig_test="edgeR",
                      pos_class_name="COV")

plotInteractiveHeatmap(tested_tree_edgeR,
                       clust_med_df = clust_tree$median_freq,
                       clusters=clusters)

## -----------------------------------------------------------------------------
head(tested_tree_edgeR$data[,c("parent", "node", "isTip", "clusters", "FDR_parent", "FDR_total")])

## -----------------------------------------------------------------------------
prop_df <- getCellProp(phylo=clust_tree$clust_tree,
                       clusters=clusters,
                       samples=samples,
                       classes=classes)

head(prop_df[,1:8])

## -----------------------------------------------------------------------------
means_df <- getCellGMeans(clust_tree$clust_tree,
                          exprs=exprs,
                          clusters=clusters,
                          samples=samples,
                          classes=classes)

head(means_df[,1:8])

## -----------------------------------------------------------------------------
sessionInfo()

