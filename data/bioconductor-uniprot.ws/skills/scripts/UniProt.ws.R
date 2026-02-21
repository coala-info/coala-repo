# Code example from 'UniProt.ws' vignette. See references/ for full tutorial.

## ----include=FALSE,results="hide",message=FALSE,warning=FALSE-----------------
library(BiocStyle)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("UniProt.ws")

## ----loadPkg------------------------------------------------------------------
suppressPackageStartupMessages({
    library(UniProt.ws)
})
up <- UniProt.ws(taxId=9606)

## ----help,eval=FALSE----------------------------------------------------------
# help("UniProt.ws")

## ----show---------------------------------------------------------------------
up

## ----availSpecies-------------------------------------------------------------
availableUniprotSpecies(pattern="musculus")

## ----setTaxID-----------------------------------------------------------------
mouseUp <- UniProt.ws(10090)
mouseUp

## ----columns------------------------------------------------------------------
head(keytypes(up))

## ----keytypes-----------------------------------------------------------------
head(columns(up))

## ----keys,eval=FALSE----------------------------------------------------------
# egs <- keys(up, "GeneID")

## ----select-------------------------------------------------------------------
keys <- c("1","2")
columns <- c("xref_pdb", "xref_hgnc", "sequence")
kt <- "GeneID"
res <- select(up, keys, columns, kt)
res

## ----<sessionInfo-------------------------------------------------------------
sessionInfo()

