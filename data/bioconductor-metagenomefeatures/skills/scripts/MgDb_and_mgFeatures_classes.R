# Code example from 'MgDb_and_mgFeatures_classes' vignette. See references/ for full tutorial.

## ----setup, include = FALSE------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
suppressPackageStartupMessages(library(metagenomeFeatures)) 

## --------------------------------------------------------------------------
library(metagenomeFeatures)
gg85 <- get_gg13.8_85MgDb()

## --------------------------------------------------------------------------
taxa_keytypes(gg85)

taxa_columns(gg85)

head(taxa_keys(gg85, keytype = c("Kingdom")))

## --------------------------------------------------------------------------
## Only returns taxa
mgDb_select(gg85, type = "taxa",
            keys = c("Vibrionaceae", "Enterobacteriaceae"),
            keytype = "Family")

## Only returns seq
mgDb_select(gg85, type = "seq",
            keys = c("Vibrionaceae", "Enterobacteriaceae"),
            keytype = "Family")

## Returns taxa, seq, and tree
mgDb_select(gg85, type = "all",
            keys = c("Vibrionaceae", "Enterobacteriaceae"),
            keytype = "Family")

## --------------------------------------------------------------------------
ve_select <- mgDb_select(gg85, type = "all",
               keys = c("Vibrionaceae", "Enterobacteriaceae"),
               keytype = "Family")

mgFeatures(taxa = ve_select$taxa, 
           tree = ve_select$tree, 
           seq = ve_select$seq,
           metadata = list("gg85 subset Vibrionaceae and Enterobacteriaceae Family"))

## --------------------------------------------------------------------------
annotateFeatures(gg85, query = ve_select$taxa$Keys)

## ----sessionInfo, echo=FALSE-----------------------------------------------
sessionInfo()

