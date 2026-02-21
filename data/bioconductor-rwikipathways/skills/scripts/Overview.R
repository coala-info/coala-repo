# Code example from 'Overview' vignette. See references/ for full tutorial.

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

## -----------------------------------------------------------------------------
#     listOrganisms()

## -----------------------------------------------------------------------------
#     hs.pathways <- listPathways('Homo sapiens')
#     hs.pathways

## -----------------------------------------------------------------------------
#     ?listPathways
#     length(hs.pathways)

## -----------------------------------------------------------------------------
#     ?listPathwayIds
#     ?listPathwayNames
#     ?listPathwayUrls

## -----------------------------------------------------------------------------
#     tnf.pathways <- findPathwaysByXref('TNF','H')
#     tnf.pathways

## -----------------------------------------------------------------------------
#     ?findPathwayIdsByXref
#     ?findPathwayNamesByXref
#     ?findPathwayUrlsByXref

## -----------------------------------------------------------------------------
#     getPathwayInfo('WP554')

## -----------------------------------------------------------------------------
#     getXrefList('WP554','L')

## -----------------------------------------------------------------------------
#     getXrefList('WP554', 'En')

## -----------------------------------------------------------------------------
#     getXrefList('WP554', 'Ce')
#     getXrefList('WP554', 'Ik')

## -----------------------------------------------------------------------------
#     gpml <- getPathway('WP554')

## -----------------------------------------------------------------------------
#     downloadPathwayArchive()

## -----------------------------------------------------------------------------
#     downloadPathwayArchive(organism="Mus musculus", format="gmt")

## -----------------------------------------------------------------------------
#     downloadPathwayArchive(date="20171010", organism="Mus musculus", format="gmt")

## -----------------------------------------------------------------------------
#     browseVignettes('rWikiPathways')
#     help(package='rWikiPathways')

