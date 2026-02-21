# Code example from 'SFEData' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace(BiocManager, quietly = TRUE)) install.packages("BiocManager")
# BiocManager::install("SFEData")

## ----setup--------------------------------------------------------------------
library(SFEData)

## -----------------------------------------------------------------------------
sfe <- McKellarMuscleData(dataset = "small")

## -----------------------------------------------------------------------------
(fp <- CosMXOutput(file_path = "foo"))

## -----------------------------------------------------------------------------
unlink("foo", recursive = TRUE)

## -----------------------------------------------------------------------------
sessionInfo()

