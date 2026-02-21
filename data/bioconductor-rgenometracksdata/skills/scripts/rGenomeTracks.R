# Code example from 'rGenomeTracks' vignette. See references/ for full tutorial.

## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----install, eval = FALSE----------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("ObMiTi")

## ----setup--------------------------------------------------------------------
# loading required libraries
library(rGenomeTracksData)
library(AnnotationHub)

## -----------------------------------------------------------------------------
ah <- AnnotationHub()
query(ah, "rGenomeTracksData")

## -----------------------------------------------------------------------------
# locate the file you want for loading from the track
bigwig_file <-  ah[["AH95891"]]

## ----session_info-------------------------------------------------------------
sessionInfo()

