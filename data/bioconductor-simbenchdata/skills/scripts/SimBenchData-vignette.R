# Code example from 'SimBenchData-vignette' vignette. See references/ for full tutorial.

## ----warning=FALSE, message=FALSE---------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("ExperimentHub")

library(ExperimentHub)
eh <- ExperimentHub()
alldata <- query(eh, "SimBenchData")
alldata 

## ----eval=FALSE, include=TRUE-------------------------------------------------
# data_1 <- alldata[["EH5384"]]

## -----------------------------------------------------------------------------
library(SimBenchData)

metadata <- showMetaData()
metadata[1:3, ]

additionaldetail <- showAdditionalDetail()
additionaldetail[1:3, ]

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

