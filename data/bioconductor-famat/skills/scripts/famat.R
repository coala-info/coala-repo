# Code example from 'famat' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("famat")

## ----load_famat, message=FALSE, warning=FALSE---------------------------------
library(famat)
library(mgcv)

## ----pathenrich---------------------------------------------------------------
data(genes)
data(meta)

listr=path_enrich("REAC", meta, genes)

## ----interactions-------------------------------------------------------------
data(listk)
data(listr)
data(listw)
data(all_compounds_chebi)
interactions_result = interactions(listk, listr, listw)

## ----compldata, message = FALSE-----------------------------------------------
data(interactions_result)

compl_data_result <- compl_data(interactions_result)

## ----eval=FALSE---------------------------------------------------------------
# data(compl_data_result)
# 
# rshiny(compl_data_result)

## ----famat, eval=FALSE--------------------------------------------------------
# data(genes)
# data(meta)
# data(all_compounds_chebi)
# 
# listk <- path_enrich("KEGG", meta, genes)
# listr <- path_enrich("REAC", meta, genes)
# listw <- path_enrich("WP", meta, genes)
# 
# interactions_result <- interactions(listk, listr, listw)
# 
# compl_data_result <- compl_data(interactions_result)
# 
# rshiny(compl_data_result)

## -----------------------------------------------------------------------------
sessionInfo()

