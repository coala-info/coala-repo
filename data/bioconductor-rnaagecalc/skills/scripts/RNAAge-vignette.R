# Code example from 'RNAAge-vignette' vignette. See references/ for full tutorial.

## ----echo = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(comment = "", message=FALSE, warning = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("RNAAgeCalc")

## -----------------------------------------------------------------------------
library(RNAAgeCalc)

## -----------------------------------------------------------------------------
data(fpkmExample)
head(fpkm)

## ----message = TRUE-----------------------------------------------------------
chronage = data.frame(sampleid = colnames(fpkm), age = c(30,50))
res = predict_age(exprdata = fpkm, tissue = "brain", exprtype = "FPKM", 
                  chronage = chronage)
head(res)

## -----------------------------------------------------------------------------
# This example is just for illustration purpose. It does not represent any 
# real data. 
# construct a large gene expression data
fpkm_large = cbind(fpkm, fpkm+1, fpkm+2, fpkm+3)   
fpkm_large = cbind(fpkm_large, fpkm_large, fpkm_large, fpkm_large)
colnames(fpkm_large) = paste0("sample",1:32)
# construct the samples' chronological age
chronage2 = data.frame(sampleid = colnames(fpkm_large), age = 31:62)
res2 = predict_age(exprdata = fpkm_large, exprtype = "FPKM",
                  chronage = chronage2)
head(res2)

## ----message = FALSE----------------------------------------------------------
library(SummarizedExperiment)
colData = data.frame(age = c(40, 50))
se = SummarizedExperiment(assays=list(FPKM=fpkm), colData=colData)
res3 = predict_age_fromse(se = se, exprtype = "FPKM")
head(res3)

## -----------------------------------------------------------------------------
makeplot(res2)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

