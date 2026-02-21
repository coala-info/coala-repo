# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, results = 'hide')
library(veloviz)

## ----eval = FALSE-------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("veloviz")
# 

## -----------------------------------------------------------------------------
data(vel)

curr <- vel$current #observed current transcriptional state
proj <- vel$projected #predicted future transcriptional state


## -----------------------------------------------------------------------------
veloviz <-  veloviz::buildVeloviz(curr = curr, proj = proj,
                         normalize.depth = TRUE,
                         use.ods.genes = FALSE,  
                         pca = TRUE, nPCs = 3,
                         center = TRUE, scale = TRUE,
                         k = 10, similarity.threshold = -1,
                         distance.weight = 1, distance.threshold = 1,
                         weighted = TRUE, verbose = FALSE)

## -----------------------------------------------------------------------------
emb.veloviz <- veloviz$fdg_coords
plot(emb.veloviz)

## -----------------------------------------------------------------------------
sessionInfo()

