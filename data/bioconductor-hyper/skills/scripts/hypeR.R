# Code example from 'hypeR' vignette. See references/ for full tutorial.

## ----include=FALSE, messages=FALSE, warnings=FALSE----------------------------
knitr::opts_chunk$set(comment="", fig.align="center", fig.width=8.75, cache=FALSE)
library(devtools)
library(tidyverse)
library(magrittr)
library(dplyr)
library(reactable)
devtools::load_all(".")

## -----------------------------------------------------------------------------
# Simply a character vector of symbols (hypergeometric)
signature <- c("GENE1", "GENE2", "GENE3")

# A ranked character vector of symbols (kstest)
ranked.signature <- c("GENE2", "GENE1", "GENE3")

# A ranked named numerical vector of symbols with ranking weights (gsea)
weighted.signature <- c("GENE2"=1.22, "GENE1"=0.94, "GENE3"=0.77)

## -----------------------------------------------------------------------------
genesets <- list("GSET1" = c("GENE1", "GENE2", "GENE3"),
                 "GSET2" = c("GENE4", "GENE5", "GENE6"),
                 "GSET3" = c("GENE7", "GENE8", "GENE9"))

## ----eval=FALSE---------------------------------------------------------------
# BIOCARTA <- msigdb_gsets(species="Homo sapiens", collection="C2", subcollection="CP:BIOCARTA")
# KEGG     <- msigdb_gsets(species="Homo sapiens", collection="C2", subcollection="CP:KEGG_LEGACY")
# REACTOME <- msigdb_gsets(species="Homo sapiens", collection="C2", subcollection="CP:REACTOME")

## -----------------------------------------------------------------------------
hyp_obj <- hypeR(signature, genesets)

## -----------------------------------------------------------------------------
hyp_obj$info

## ----eval=FALSE---------------------------------------------------------------
# # Show interactive table
# hyp_show(hyp_obj)
# 
# # Plot dots plot
# hyp_dots(hyp_obj)
# 
# # Plot enrichment map
# hyp_emap(hyp_obj)
# 
# # Plot hiearchy map (relational genesets)
# hyp_hmap(hyp_obj)
# 
# # Map enrichment to an igraph object (relational genesets)
# hyp_to_graph(hyp_obj)
# 
# # Save to excel
# hyp_to_excel(hyp_obj, file_path="hypeR.xlsx")
# 
# # Save to table
# hyp_to_table(hyp_obj, file_path="hypeR.txt")
# 
# # Generate markdown report
# hyp_to_rmd(hyp_obj,
#            file_path="hypeR.rmd",
#            title="Hyper Enrichment (hypeR)",
#            subtitle="YAP, TNF, and TAZ Knockout Experiments",
#            author="Anthony Federico, Stefano Monti")

