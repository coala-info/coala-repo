# Code example from 'creating-LRBaseDbs' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----install, eval=FALSE------------------------------------------------------
#  if(!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("AHLRBaseDbs")

## ----load-lib, message = FALSE------------------------------------------------
library(AnnotationHub)
ah <- AnnotationHub()

## ----list-LRBaseDb------------------------------------------------------------
query(ah, "LRBaseDb")

## ----confirm-metadata---------------------------------------------------------
mcols(query(ah, "LRBaseDb"))

## ----query-mouse--------------------------------------------------------------
qr <- query(ah, c("LRBaseDb", "Mus musculus"))
# filepath_mmu <- qr[[1]]

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

