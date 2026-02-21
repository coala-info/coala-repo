# Code example from 'AnVILBaseIntroduction' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("AnVILBase")

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
library(AnVILBase)

## ----eval=FALSE---------------------------------------------------------------
# cloud_platform()

## -----------------------------------------------------------------------------
avplatform_namespace()

## -----------------------------------------------------------------------------
sessionInfo()

