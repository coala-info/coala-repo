# Code example from 'tenXplore' vignette. See references/ for full tutorial.

## ----setupp,echo=FALSE,results="hide"-----------------------------------------
suppressWarnings({
suppressPackageStartupMessages({
library(tenXplore)
library(org.Mm.eg.db)
library(org.Hs.eg.db)
})
})

## ----doont--------------------------------------------------------------------
library(ontoProc)
data(allGOterms)
cellTypeToGO("serotonergic neuron", gotab=allGOterms)
cellTypeToGenes("serotonergic neuron", gotab=allGOterms, orgDb=org.Mm.eg.db)
cellTypeToGenes("serotonergic neuron", gotab=allGOterms, orgDb=org.Hs.eg.db)

