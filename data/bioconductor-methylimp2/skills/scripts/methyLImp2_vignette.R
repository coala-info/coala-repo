# Code example from 'methyLImp2_vignette' vignette. See references/ for full tutorial.

## ----knitr options, include = FALSE-------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message = FALSE---------------------------------------------------
library(methyLImp2)
library(SummarizedExperiment)
library(BiocParallel)

## ----installation, eval = FALSE-----------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("methyLImp2")

## ----load the dataset---------------------------------------------------------
data(beta, package = "methyLImp2")
print(dim(beta))

## ----generate artificial NAs--------------------------------------------------
with_missing_data <- generateMissingData(beta, lambda = 3.5)
beta_with_nas <- with_missing_data$beta_with_nas
na_positions <- with_missing_data$na_positions

## ----construct SE-------------------------------------------------------------
data(beta_meta)
beta_SE <- SummarizedExperiment(assays = SimpleList(beta = t(beta_with_nas)), 
                                colData = beta_meta)

## ----user annotation example, echo = FALSE------------------------------------
data(custom_anno_example)
knitr::kable(custom_anno_example)

## ----run methyLImp------------------------------------------------------------
time <- system.time(beta_SE_imputed <- methyLImp2(input = beta_SE, 
                                               type = "EPIC", 
                                               BPPARAM = SnowParam(exportglobals = FALSE),
                                               minibatch_frac = 0.5))
print(paste0("Runtime was ", round(time[3], digits = 2), " seconds."))

## ----evaluate performance-----------------------------------------------------
performance <- evaluatePerformance(beta, t(assays(beta_SE_imputed)[[1]]), 
                                   na_positions)
print(performance)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

