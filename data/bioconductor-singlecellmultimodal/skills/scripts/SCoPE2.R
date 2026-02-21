# Code example from 'SCoPE2' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("SingleCellMultiModal")

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
library(SingleCellMultiModal)
library(MultiAssayExperiment)

## -----------------------------------------------------------------------------
SCoPE2("macrophage_differentiation",
       mode = "*",
       version = "1.0.0",
       dry.run = TRUE)

## -----------------------------------------------------------------------------
SCoPE2("macrophage_differentiation")

## ----message=FALSE------------------------------------------------------------
scope2 <- SCoPE2("macrophage_differentiation",
                 modes = "rna|protein",
                 dry.run = FALSE)
scope2

## -----------------------------------------------------------------------------
colData(scope2)

## -----------------------------------------------------------------------------
scope2[["rna"]]

## -----------------------------------------------------------------------------
assay(scope2[["rna"]])[1:5, 1:5]

## -----------------------------------------------------------------------------
scope2[["protein"]]

## -----------------------------------------------------------------------------
assay(scope2[["protein"]])[1:5, 1:5]

## -----------------------------------------------------------------------------
sessionInfo()

