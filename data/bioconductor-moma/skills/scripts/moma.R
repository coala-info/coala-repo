# Code example from 'moma' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message = FALSE, results="hide", warning=FALSE, eval=FALSE--------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("MOMA")

## ----load---------------------------------------------------------------------
library(MOMA)

## ----explore data, message = FALSE--------------------------------------------
example.gbm.mae

MultiAssayExperiment::assays(example.gbm.mae)$viper[1:3, 1:3]

## ----pathways-----------------------------------------------------------------
names(gbm.pathways)

gbm.pathways$cindy[1:3]

## ----moma object--------------------------------------------------------------
momaObj <- MomaConstructor(example.gbm.mae, gbm.pathways)

## ----interactions, results = "hide", message = FALSE--------------------------
momaObj$runDIGGIT()

momaObj$makeInteractions()

momaObj$Rank()

## ----clustering---------------------------------------------------------------
momaObj$Cluster()

# Explore the reliability scores
momaObj$clustering.results$all.cluster.reliability

# Save in the 3 cluster solution
momaObj$sample.clustering <- momaObj$clustering.results$`3clusters`$clustering


## ----saturation, message=FALSE, results="hide"--------------------------------
momaObj$saturationCalculation()

## ----checkpoints--------------------------------------------------------------
cluster1.checkpoint <- momaObj$checkpoints[[1]]
print (cluster1.checkpoint[1:5])

## ----make plots, warning=FALSE, include=FALSE---------------------------------
plots <- makeSaturationPlots(momaObj)

## ----visualize plots----------------------------------------------------------
library(ggplot2)
library(grid)
grid.draw(plots$oncoprint.plots[[3]])
plots$curve.plots[[3]] +
  ggtitle("Genomic Saturation Curve for GBM Subtype 3")
  

## ----saving data, eval=FALSE--------------------------------------------------
# momaObj$saveData(output.folder = "outputs", "hypotheses", "checkpoints")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

