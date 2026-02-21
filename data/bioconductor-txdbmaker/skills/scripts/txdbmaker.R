# Code example from 'txdbmaker' vignette. See references/ for full tutorial.

## ----installtxdbmaker, eval=FALSE---------------------------------------------
# if (!require("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("txdbmaker")

## ----loadtxdbmaker------------------------------------------------------------
suppressPackageStartupMessages(library(txdbmaker))

## ----supportedUCSCtables------------------------------------------------------
supportedUCSCtables(genome="mm9")

mm9KG_txdb <- makeTxDbFromUCSC(genome="mm9", tablename="knownGene")
mm9KG_txdb

## ----makeTxDbFromBiomart, eval=FALSE------------------------------------------
# mmusculusEnsembl <- makeTxDbFromBiomart(dataset="mmusculus_gene_ensembl")

## ----saveDb, results="hide"---------------------------------------------------
saveDb(mm9KG_txdb, file="mm9KG_txdb.sqlite")

## ----loadDb-------------------------------------------------------------------
mm9KG_txdb <- loadDb("mm9KG_txdb.sqlite")

## ----SessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

