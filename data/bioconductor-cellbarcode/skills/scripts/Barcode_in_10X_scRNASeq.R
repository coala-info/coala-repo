# Code example from 'Barcode_in_10X_scRNASeq' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  message = FALSE,
  error = FALSE,
  warn = FALSE,
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(data.table)
library(ggplot2)
library(CellBarcode)

## -----------------------------------------------------------------------------
sam_file <- system.file("extdata", "scRNASeq_10X.sam", package = "CellBarcode")

d = bc_extract_sc_sam(
   sam = sam_file,
   pattern = "AGATCAG(.*)TGTGGTA",
   cell_barcode_tag = "CR",
   umi_tag = "UR"
)

d

## -----------------------------------------------------------------------------
sessionInfo()

