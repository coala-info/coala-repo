# Code example from 'rWikiPathways-and-RCy3' vignette. See references/ for full tutorial.

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
# 
# if(!"RCy3" %in% installed.packages()){
#     if (!requireNamespace("BiocManager", quietly=TRUE))
#         install.packages("BiocManager")
#     BiocManager::install("RCy3")
# }
# library(RCy3)
# 
# # Use install.packages() for the following, if necessary:
# library(magrittr)

## -----------------------------------------------------------------------------
# cytoscapePing()

## -----------------------------------------------------------------------------
# gbm.pathways <- findPathwaysByText('Glioblastoma') # many pathways returned
# human.gbm.pathways <- gbm.pathways %>%
#   dplyr::filter(species == "Homo sapiens") # just the human gbm  pathways

## -----------------------------------------------------------------------------
# human.gbm.wpids <- human.gbm.pathways$id

## -----------------------------------------------------------------------------
# commandsRun(paste0('wikipathways import-as-pathway id=',human.gbm.wpids[1]))

## -----------------------------------------------------------------------------
# openSession()
# net.data <- getTableColumns(columns=c('name','degree.layout','COMMON'))
# max.gene <- net.data[which.max(unlist(net.data['degree.layout'])),]
# max.gene

## -----------------------------------------------------------------------------
# mcm1.pathways <-unique(findPathwayIdsByXref('YMR043W','En'))
# commandsRun(paste0('wikipathways import-as-pathway id=', mcm1.pathways[1]))

## -----------------------------------------------------------------------------
# selectNodes('MCM1','name')

