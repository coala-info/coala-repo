# Code example from 'Supplement4-Methods_Walkthrough' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE,
                      cache = FALSE,
                      comment = "#>")

## ----packLoad, message=FALSE--------------------------------------------------
library(parallel)
library(tidyverse)
library(pathwayPCA)

## ----data_setup, echo = FALSE, message = FALSE--------------------------------
data("colonSurv_df")
data("colon_pathwayCollection")

colon_OmicsSurv <- CreateOmics(
  assayData_df = colonSurv_df[, -(2:3)],
  pathwayCollection_ls = colon_pathwayCollection,
  response = colonSurv_df[, 1:3],
  respType = "surv"
)

## ----data_show----------------------------------------------------------------
colon_OmicsSurv

## -----------------------------------------------------------------------------
names(getPathwayCollection(colon_OmicsSurv)$pathways)

## -----------------------------------------------------------------------------
getTrimPathwayCollection(colon_OmicsSurv)$n_tested

## -----------------------------------------------------------------------------
getPathwayCollection(colon_OmicsSurv)$TERMS

## ----aes_surv_pvals-----------------------------------------------------------
colonSurv_aespcOut <- AESPCA_pVals(
  object = colon_OmicsSurv,
  numReps = 0,
  numPCs = 2,
  parallel = TRUE,
  numCores = 2,
  adjustpValues = TRUE,
  adjustment = c("Hoch", "SidakSD")
)

## ----aes_reg_pvals, eval=FALSE------------------------------------------------
# colonReg_aespcOut <- AESPCA_pVals(
#   object = colon_OmicsReg,
#   numReps = 0,
#   numPCs = 2,
#   parallel = TRUE,
#   numCores = 2,
#   adjustpValues = TRUE,
#   adjustment = c("Holm", "BH")
# )

## ----aes_categ_pvals, eval=FALSE----------------------------------------------
# colonCateg_aespcOut <- AESPCA_pVals(
#   object = colon_OmicsCateg,
#   numReps = 0,
#   numPCs = 2,
#   parallel = TRUE,
#   numCores = 2,
#   adjustpValues = TRUE,
#   adjustment = c("SidakSS", "BY")
# )

## ----super_surv_pvals, eval=FALSE---------------------------------------------
# colonSurv_superpcOut <- SuperPCA_pVals(
#   object = colon_OmicsSurv,
#   numPCs = 2,
#   parallel = TRUE,
#   numCores = 2,
#   adjustpValues = TRUE,
#   adjustment = c("Hoch", "SidakSD")
# )

## ----super_reg_pvals, eval=FALSE----------------------------------------------
# colonReg_superpcOut <- SuperPCA_pVals(
#   object = colon_OmicsReg,
#   numPCs = 2,
#   parallel = TRUE,
#   numCores = 2,
#   adjustpValues = TRUE,
#   adjustment = c("Holm", "BH")
# )

## ----super_categ_pvals, eval=FALSE--------------------------------------------
# colonCateg_superpcOut <- SuperPCA_pVals(
#   object = colon_OmicsCateg,
#   numPCs = 2,
#   parallel = TRUE,
#   numCores = 2,
#   adjustpValues = TRUE,
#   adjustment = c("SidakSS", "BY")
# )

## ----viewPathwayRanks---------------------------------------------------------
getPathpVals(colonSurv_aespcOut)

## ----getPathPCLs--------------------------------------------------------------
PCLs_ls <- getPathPCLs(colonSurv_aespcOut, "KEGG_ASTHMA")
PCLs_ls

## ----HLARDA-------------------------------------------------------------------
PCLs_ls$Loadings %>% 
  filter(PC1 != 0) %>% 
  select(-PC2) %>% 
  arrange(desc(PC1))

## ----sessionDetails-----------------------------------------------------------
sessionInfo()

