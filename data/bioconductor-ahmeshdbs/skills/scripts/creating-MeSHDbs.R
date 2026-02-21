# Code example from 'creating-MeSHDbs' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----install, eval=FALSE------------------------------------------------------
#  if(!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("AHMeSHDbs")

## ----load-lib, message = FALSE------------------------------------------------
library(AnnotationHub)
ah <- AnnotationHub()

## ----list-MeSHDb--------------------------------------------------------------
query(ah, "MeSHDb")

## ----confirm-metadata---------------------------------------------------------
mcols(query(ah, "MeSHDb"))

## ----query-mouse--------------------------------------------------------------
qr <- query(ah, c("MeSHDb", "Mus musculus"))
# filepath_mmu <- qr[[1]]

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

