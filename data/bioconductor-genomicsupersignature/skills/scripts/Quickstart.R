# Code example from 'Quickstart' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  comment = "#>", collapse = TRUE, message = FALSE, warning = FALSE,
  fig.align='center'
)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("GenomicSuperSignature")
# BiocManager::install("bcellViper")

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
library(GenomicSuperSignature)
library(bcellViper)

## ----load_model---------------------------------------------------------------
RAVmodel <- getModel("PLIERpriors", load=TRUE)
RAVmodel

version(RAVmodel)

## ----message=FALSE, warning=FALSE---------------------------------------------
data(bcellViper)
dset

## -----------------------------------------------------------------------------
val_all <- validate(dset, RAVmodel)
head(val_all)

## ----out.height="80%", out.width="80%", message=FALSE, warning=FALSE----------
heatmapTable(val_all, RAVmodel, num.out = 5, swCutoff = 0)

## ----out.height="75%", out.width="75%", plotValidate_function-----------------
plotValidate(val_all, interactive = FALSE)

## -----------------------------------------------------------------------------
validated_ind <- validatedSignatures(val_all, RAVmodel, num.out = 3, 
                                     swCutoff = 0, indexOnly = TRUE)
validated_ind

## ----out.height="60%", out.width="60%"----------------------------------------
set.seed(1) # only if you want to reproduce identical display of the same words
drawWordcloud(RAVmodel, validated_ind[1])
drawWordcloud(RAVmodel, validated_ind[2])
drawWordcloud(RAVmodel, validated_ind[3])

## -----------------------------------------------------------------------------
annotateRAV(RAVmodel, validated_ind[2]) # RAV1139

## -----------------------------------------------------------------------------
subsetEnrichedPathways(RAVmodel, validated_ind[2], include_nes = TRUE)

subsetEnrichedPathways(RAVmodel, validated_ind, include_nes = TRUE)

## -----------------------------------------------------------------------------
findSignature(RAVmodel, "Bcell")

## -----------------------------------------------------------------------------
findSignature(RAVmodel, "Bcell", k = 5)

## -----------------------------------------------------------------------------
findKeywordInRAV(RAVmodel, "Bcell", ind = 695)

## -----------------------------------------------------------------------------
## Chosen based on validation/MeSH terms
subsetEnrichedPathways(RAVmodel, ind = validated_ind[2], n = 3, both = TRUE)

## Chosen based on enriched pathways
subsetEnrichedPathways(RAVmodel, ind = 695, n = 3, both = TRUE)
subsetEnrichedPathways(RAVmodel, ind = 953, n = 3, both = TRUE)
subsetEnrichedPathways(RAVmodel, ind = 1994, n = 3, both = TRUE)

## -----------------------------------------------------------------------------
findStudiesInCluster(RAVmodel, validated_ind[2])

## -----------------------------------------------------------------------------
findStudiesInCluster(RAVmodel, validated_ind[2], studyTitle = TRUE)

## -----------------------------------------------------------------------------
sessionInfo()

