# Code example from 'Contents' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE, comment = "#>" 
)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("GenomicSuperSignature")

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
library(GenomicSuperSignature)

## ----load_model---------------------------------------------------------------
RAVmodel <- getModel("C2", load=TRUE)

## -----------------------------------------------------------------------------
RAVmodel

version(RAVmodel)
geneSets(RAVmodel)

## -----------------------------------------------------------------------------
class(RAVindex(RAVmodel))
dim(RAVindex(RAVmodel))
RAVindex(RAVmodel)[1:4, 1:4]

## -----------------------------------------------------------------------------
names(metadata(RAVmodel))

## -----------------------------------------------------------------------------
head(metadata(RAVmodel)$cluster)
head(metadata(RAVmodel)$size)
metadata(RAVmodel)$k
metadata(RAVmodel)$n
geneSets(RAVmodel)
head(metadata(RAVmodel)$MeSH_freq)
updateNote(RAVmodel)  
metadata(RAVmodel)$version

## -----------------------------------------------------------------------------
length(studies(RAVmodel))
studies(RAVmodel)[1:3]

## -----------------------------------------------------------------------------
PCinRAV(RAVmodel, 2)

## -----------------------------------------------------------------------------
x <- silhouetteWidth(RAVmodel)
head(x)   # average silhouette width of the first 6 RAVs

## -----------------------------------------------------------------------------
class(gsea(RAVmodel))
class(gsea(RAVmodel)[[1]])
length(gsea(RAVmodel))
gsea(RAVmodel)[1]

## -----------------------------------------------------------------------------
length(mesh(RAVmodel))
mesh(RAVmodel)[1]

## -----------------------------------------------------------------------------
length(PCAsummary(RAVmodel))
PCAsummary(RAVmodel)[1]

## -----------------------------------------------------------------------------
sessionInfo()

