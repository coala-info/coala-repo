# Code example from 'rWikiPathways-and-BridgeDbR' vignette. See references/ for full tutorial.

## ----echo = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(
  eval=FALSE
)

## -----------------------------------------------------------------------------
# if(!"rWikiPathways" %in% installed.packages()){
#     if (!requireNamespace("BiocManager", quietly=TRUE))
#         install.packages("BiocManager")
#     BiocManager::install("rWikiPathways")
# }
# library(rWikiPathways)
# if(!"BridgeDbR" %in% installed.packages()){
#     if (!requireNamespace("BiocManager", quietly=TRUE))
#         install.packages("BiocManager")
#     BiocManager::install("BridgeDbR")
# }
# library(BridgeDbR)

## -----------------------------------------------------------------------------
#     orgNames <- listOrganisms()
#     orgNames

## -----------------------------------------------------------------------------
#     BridgeDbR::getOrganismCode(orgNames[1])

## -----------------------------------------------------------------------------
#     BridgeDbR::getSystemCode("Ensembl")

## -----------------------------------------------------------------------------
#     BridgeDbR::getSystemCode("Entrez Gene")

## -----------------------------------------------------------------------------
#     tnf.pathways <- findPathwayIdsByXref('TNF', BridgeDbR::getSystemCode('HGNC'))
#     tnf.pathways

## -----------------------------------------------------------------------------
#     getXrefList('WP554', BridgeDbR::getSystemCode('Ensembl'))

## -----------------------------------------------------------------------------
#     getXrefList('WP554', BridgeDbR::getSystemCode('ChEBI'))

## -----------------------------------------------------------------------------
#     BridgeDbR::getFullName('Ce')

