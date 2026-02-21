# Code example from 'pairadise' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----getPackage, eval=FALSE---------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("PAIRADISE")

## ----getDevel, eval=FALSE-----------------------------------------------------
# BiocManager::install("hubentu/PAIRADISE")

## ----Load, message=FALSE------------------------------------------------------
library(PAIRADISE)

## -----------------------------------------------------------------------------
library(abind)
icount <- matrix(1:4, 1)
scount <- matrix(5:8, 1)
acount <- abind(icount, scount, along = 3)
acount
design <- data.frame(sample = rep(c("s1", "s2"), 2),
                     group = rep(c("T", "N"), each = 2))
lens <- data.frame(sLen=1L, iLen=2L)
PDseDataSet(acount, design, lens)

## -----------------------------------------------------------------------------
data("sample_dataset")
sample_dataset

## -----------------------------------------------------------------------------
data("sample_dataset_CEU")

data("sample_dataset_LUSC")

## -----------------------------------------------------------------------------
pdat <- PDseDataSetFromMat(sample_dataset)
pdat

## -----------------------------------------------------------------------------
pairadise_output <- pairadise(pdat, numCluster = 2)

## -----------------------------------------------------------------------------
res <- results(pairadise_output, p.adj = "BH", sig.level = 0.01)
res

## -----------------------------------------------------------------------------
res <- results(pairadise_output, details = TRUE)
colnames(res)
res$latent[3,]

## -----------------------------------------------------------------------------
sessionInfo()

