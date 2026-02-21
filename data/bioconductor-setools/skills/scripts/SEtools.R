# Code example from 'SEtools' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(BiocStyle)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("SEtools")

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("plger/SEtools")

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
  library(SummarizedExperiment)
  library(SEtools)
})
data("SE", package="SEtools")
SE

## -----------------------------------------------------------------------------
se1 <- SE[,1:10]
se2 <- SE[,11:20]
se3 <- mergeSEs( list(se1=se1, se2=se2) )
se3

## -----------------------------------------------------------------------------
se3 <- mergeSEs( list(se1=se1, se2=se2), do.scale=FALSE)

## -----------------------------------------------------------------------------
se3 <- mergeSEs( list(se1=se1, se2=se2), use.assays=c("counts", "logcpm"), do.scale=c(FALSE, TRUE))

## ----merging------------------------------------------------------------------
rowData(se1)$metafeature <- sample(LETTERS,nrow(se1),replace = TRUE)
rowData(se2)$metafeature <- sample(LETTERS,nrow(se2),replace = TRUE)
se3 <- mergeSEs( list(se1=se1, se2=se2), do.scale=FALSE, mergeBy="metafeature", aggFun=median)
sechm::sechm(se3, features=row.names(se3))

## ----aggregating--------------------------------------------------------------
se1b <- aggSE(se1, by = "metafeature")
se1b

## -----------------------------------------------------------------------------
SE <- log2FC(SE, fromAssay="logcpm", controls=SE$Condition=="Homecage")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

