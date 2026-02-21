# Code example from 'MSstatsQCgui' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("MSstatsQCgui")

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# deps <- c("devtools")
# BiocManager::install("devtools", dependencies = TRUE)
# devtools::install_github("eralpdogu/MSstatsQCgui")

## ----eval = FALSE-------------------------------------------------------------
# library(MSstatsQCgui)
# RunMSstatsQC()

## ----si-----------------------------------------------------------------------
sessionInfo()

