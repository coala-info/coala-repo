# Code example from 'VarCon' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::opts_chunk$set(tidy = FALSE,
                      cache = FALSE,
                      dev = "png")

## ----eval=TRUE----------------------------------------------------------------
library(VarCon)
## Defining exemplary input data
transcriptTable <- transCoord
transcriptID <- "pseudo_ENST00000650636"
variation <- "c.412T>G/p.(T89M)"

## ----eval=TRUE----------------------------------------------------------------
library(VarCon)
results <- getSeqInfoFromVariation(referenceDnaStringSet, transcriptID,
variation, ntWindow=20, transcriptTable)
results

## ----eval=TRUE----------------------------------------------------------------
## Define gene 2 transcript table
geneName <- "Example_gene"
gene2transcript <- data.frame(gene_name = "Example_gene",
gene_ID = "pseudo_ENSG00000147099", transcriptID = "pseudo_ENST00000650636")

## ----eval=TRUE----------------------------------------------------------------
## Use function with gene name
results <- getSeqInfoFromVariation(referenceDnaStringSet, geneName,
variation, ntWindow=20, transcriptTable, gene2transcript=gene2transcript)
results

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

