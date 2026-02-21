# Code example from 'vignette_scShapes' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(scShapes)
library(BiocParallel)
set.seed(0xBEEF)

## ----example, results='hide', message=FALSE, warning=FALSE--------------------

# Loading and preparing data for input 

data(scData)

## ----filtered-----------------------------------------------------------------

scData_filt <- filter_counts(scData$counts, perc.zero = 0.1)

## ----message=FALSE, warning=FALSE---------------------------------------------
scData_KS <- ks_test(counts=scData$counts, cexpr=scData$covariates, lib.size=scData$lib_size, BPPARAM=SnowParam(workers=8,type="SOCK"))

# Select genes significant from the KS test.
# By default the 'ks_sig' function performs Benjamini-Hochberg correction for multiple   hypothese testing
# and selects genes significant at p-value of 0.01

scData_KS_sig <- ks_sig(scData_KS)

# Subset UMI counts corresponding to the genes significant from the KS test
scData.sig.genes <- scData$counts[rownames(scData$counts) %in% names(scData_KS_sig$genes),]

## ----message=FALSE, warning=FALSE---------------------------------------------
scData_models <- fit_models(counts=scData.sig.genes, cexpr=scData$covariates, lib.size=scData$lib_size, BPPARAM=SnowParam(workers=8,type="SOCK"))

## ----message=FALSE, warning=FALSE---------------------------------------------
scData_bicvals <- model_bic(scData_models)

# select model with least bic value
scData_least.bic <- lbic_model(scData_bicvals, scData$counts)

## ----message=FALSE, warning=FALSE---------------------------------------------
scData_gof <- gof_model(scData_least.bic, cexpr=scData$covariates, lib.size=scData$lib_size, BPPARAM=SnowParam(workers=8,type="SOCK"))

## ----message=FALSE, warning=FALSE---------------------------------------------
scData_fit <- select_model(scData_gof)

## ----message=FALSE, warning=FALSE---------------------------------------------
scData_params <- model_param(scData_models, scData_fit, model=NULL)

## ----eval=FALSE---------------------------------------------------------------
# ifnb.DD.genes <- change_shape(ifnb.distr)

## -----------------------------------------------------------------------------
sessionInfo()

