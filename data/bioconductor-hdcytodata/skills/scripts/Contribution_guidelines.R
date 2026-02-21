# Code example from 'Contribution_guidelines' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----results="hide", message=FALSE--------------------------------------------
library(HDCytoData)

# example: SummarizedExperiment
d_SE <- Levine_32dim_SE()

d_SE
length(assays(d_SE))
dim(d_SE)
head(assay(d_SE))
rowData(d_SE)
colData(d_SE)
metadata(d_SE)

# example: flowSet
d_flowSet <- Levine_32dim_flowSet()

d_flowSet
length(d_flowSet)
fsApply(d_flowSet, dim)
head(exprs(d_flowSet[[1]]))
parameters(d_flowSet[[1]])@data
colnames(d_flowSet)
description(d_flowSet[[1]])

