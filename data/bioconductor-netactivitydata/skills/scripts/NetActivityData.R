# Code example from 'NetActivityData' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("NetActivityData")

## ----eval = FALSE-------------------------------------------------------------
# # install.packages("devtools")
# devtools::install_github("yocra3/NetActivityData")

## -----------------------------------------------------------------------------
library(NetActivityData)

## -----------------------------------------------------------------------------
data(gtex_gokegg)
gtex_gokegg[1:5, c(1:4, 554)]

## -----------------------------------------------------------------------------
data(gtex_gokegg_annot)
head(gtex_gokegg_annot)

## -----------------------------------------------------------------------------
data(tcga_gokegg)
tcga_gokegg[1:5, c(1:4, 554)]

## -----------------------------------------------------------------------------
data(tcga_gokegg_annot)
head(tcga_gokegg_annot)

## -----------------------------------------------------------------------------
tcga_gokegg_annot$Weights[[1]]
tcga_gokegg_annot$Weights_SYMBOL[[1]]

## -----------------------------------------------------------------------------
sessionInfo()

