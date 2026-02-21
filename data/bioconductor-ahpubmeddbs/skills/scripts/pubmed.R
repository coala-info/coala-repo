# Code example from 'pubmed' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----install, eval=FALSE------------------------------------------------------
#  if(!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("AHPubMedDbs")

## ----load-lib, message = FALSE------------------------------------------------
library(AnnotationHub)
ah <- AnnotationHub()

## ----list-PubMedDb------------------------------------------------------------
query(ah, "PubMed")

## ----confirm-metadata---------------------------------------------------------
mcols(query(ah, "PubMed"))

## ----query-mouse--------------------------------------------------------------
qr <- query(ah, c("PubMedDb"))
# pubmed_tibble <- qr[[1]]

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

