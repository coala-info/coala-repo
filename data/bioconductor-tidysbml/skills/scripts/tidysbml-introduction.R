# Code example from 'tidysbml-introduction' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----installation, eval = FALSE-----------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("tidysbml")

## -----------------------------------------------------------------------------
library(tidysbml)

## -----------------------------------------------------------------------------
filepath <- system.file("extdata", "R-HSA-8937144.sbml", package = "tidysbml")
sbml_list <- sbml_as_list(filepath)

## -----------------------------------------------------------------------------
list_species <- sbml_as_list(filepath, component = "species")

## -----------------------------------------------------------------------------
list_of_dfs <- as_dfs(filepath, type = "file")

## -----------------------------------------------------------------------------
list_of_dfs <- as_dfs(sbml_list, type = "list")

## -----------------------------------------------------------------------------
list_species <- sbml_as_list(filepath, component = "species")
df_species <- as_df(list_species)

## -----------------------------------------------------------------------------
list_react <- sbml_as_list(filepath, component = "reactions")
dfs_about_reactions <- as_df(list_react)

## -----------------------------------------------------------------------------
dfs_about_reactions[[1]]

## -----------------------------------------------------------------------------
dfs_about_reactions[[2]]

## ----eval=FALSE---------------------------------------------------------------
# library(dplyr)
# edgelist <- df_species_in_reactions %>% select("reaction_id", "species") %>% `colnames<-`(c("source", "target"))
# RCy3::createNetworkFromDataFrames(edges = edgelist) # while running Cytoscape

## -----------------------------------------------------------------------------
vec_uri <- na.omit( unlist(
  lapply(X = list_of_dfs[[2]]$annotation_hasPart, FUN = function(x){
    unlist(strsplit(x, "||", fixed = TRUE))
  })
))

## -----------------------------------------------------------------------------
vec_uniprot <- na.omit( unlist(
  lapply( X = vec_uri, FUN = function(x){
    if( all(unlist(gregexpr("uniprot", x)) > -1) ){
      x
    } else {
      NA
    }
  })
))

## -----------------------------------------------------------------------------
vec_ids <- vapply(vec_uniprot, function(x){
  chr <- "/"
  first <- max(unlist(gregexpr(chr, x)))
  substr(x, first + 1, nchar(x))
}, FUN.VALUE = character(1))

## ----biomaRt------------------------------------------------------------------
library(biomaRt)
mart <- useEnsembl(biomart = "ensembl", dataset = "hsapiens_gene_ensembl")
df_mart_uniprot <- getBM( attributes = c("uniprot_gn_id", "uniprot_gn_symbol",   "description"),
                          filters = "uniprot_gn_id",
                          values = vec_ids,
                          mart = mart)
df_mart_uniprot

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

