# Code example from 'rcellminerDataUsage' vignette. See references/ for full tutorial.

## ----knitrSetup, include=FALSE------------------------------------------------
library(knitr)
opts_chunk$set(out.extra='style="display:block; margin: auto"', fig.align="center", tidy=TRUE, eval=FALSE)

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("rcellminer")
# BiocManager::install("rcellminerData")

## ----loadLibrary, message=FALSE, warning=FALSE--------------------------------
# library(rcellminer)
# library(rcellminerData)

## ----searchHelp, eval=FALSE, tidy=FALSE---------------------------------------
# help.search("rcellminerData")

## ----getDataHelp, eval=FALSE, tidy=FALSE--------------------------------------
# help("drugData")
# help("molData")

## -----------------------------------------------------------------------------
# # Get the types of feature data in a MolData object.
# names(getAllFeatureData(molData))

## -----------------------------------------------------------------------------
# class(molData[["exp"]])
# 
# geneExpMat <- exprs(molData[["exp"]])

## -----------------------------------------------------------------------------
# getSampleData(molData)[1:10, "TissueType"]

## -----------------------------------------------------------------------------
# # Add data
# molData[["test"]] <- molData[["pro"]]
# 
# names(getAllFeatureData(molData))

## -----------------------------------------------------------------------------
# drugActMat <- exprs(getAct(drugData))
# dim(drugActMat)
# 
# drugRepeatActMat <- exprs(getRepeatAct(drugData))
# dim(drugRepeatActMat)

## -----------------------------------------------------------------------------
# drugAnnotDf <- as(featureData(getAct(drugData)), "data.frame")
# 
# colnames(drugAnnotDf)

## -----------------------------------------------------------------------------
# identical(getSampleData(molData), getSampleData(drugData))

## ----sessionInfo, eval=TRUE---------------------------------------------------
sessionInfo()

