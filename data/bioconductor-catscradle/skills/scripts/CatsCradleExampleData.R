# Code example from 'CatsCradleExampleData' vignette. See references/ for full tutorial.

## ----setup, include = FALSE, warning = FALSE----------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    fig.dim = c(6,6),
    comment = "#>"
)

## ----[Ex1], message=FALSE-----------------------------------------------------
library(CatsCradle,quietly=TRUE)
library(tictoc)
getExample = make.getExample()
tic()
STranspose = getExample('STranspose')
toc()

## ----[Ex2]--------------------------------------------------------------------
tic()
STranspose = getExample('STranspose')
toc()

## ----[Ex3], message=FALSE-----------------------------------------------------
smallXenium = getExample('smallXenium')

## ----[Ex4], message=FALSE-----------------------------------------------------
exSeuratObj = getExample('exSeuratObj')
toySeurat = getExample('exSeuratObj',toy=TRUE)
dim(exSeuratObj)
dim(toySeurat)
toyXenium = getExample('smallXenium',toy=TRUE)
dim(smallXenium)
dim(toyXenium)

## ----[Ex5]--------------------------------------------------------------------
sessionInfo()

