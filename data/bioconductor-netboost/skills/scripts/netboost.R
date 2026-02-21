# Code example from 'netboost' vignette. See references/ for full tutorial.

## ----setup, cache = F, echo = FALSE-------------------------------------------
knitr::opts_chunk$set(error = TRUE)

## ----load_data----------------------------------------------------------------
require("netboost")
data("tcga_aml_meth_rna_chr18", package = "netboost")
dim(tcga_aml_meth_rna_chr18)

## ----netboost_run-------------------------------------------------------------
results <- netboost(datan = tcga_aml_meth_rna_chr18, stepno = 20L, 
soft_power = 3L, min_cluster_size = 10L, n_pc = 2, scale = TRUE, ME_diss_thres = 0.25) 

## ----results------------------------------------------------------------------
names(results)
colnames(results$MEs)

## ----variance-----------------------------------------------------------------
results$var_explained[,1:5]

## ----module_members-----------------------------------------------------------
results$names[results$colors==8]

## ----plot---------------------------------------------------------------------
set.seed(123)
nb_plot_dendro(nb_summary = results, labels = FALSE, colorsrandom = TRUE)

## ----transfer-----------------------------------------------------------------
    ME_transfer <- nb_transfer(nb_summary = results, 
    new_data = tcga_aml_meth_rna_chr18, scale = TRUE)
    all(round(results$MEs, 10) == round(ME_transfer, 10))

## ----robust_netboost_run------------------------------------------------------
#results <- netboost(datan = tcga_aml_meth_rna_chr18,cores=10L,
#soft_power = 3L, min_cluster_size = 10L, n_pc = 2, qc_plot = FALSE,
#filter_method = "spearman", robust_PCs = TRUE, method = "spearman")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()
warnings()

