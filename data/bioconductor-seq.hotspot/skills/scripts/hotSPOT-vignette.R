# Code example from 'hotSPOT-vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("seq.hotSPOT")

## -----------------------------------------------------------------------------
library(seq.hotSPOT)

## ----load data----------------------------------------------------------------
data("mutation_data")
head(mutation_data)

## ----run amp finder, include = TRUE-------------------------------------------
amps <- amp_pool(data = mutation_data, amp = 100)
head(amps)

## ----fw binning---------------------------------------------------------------
fw_bins <- fw_hotspot(bins = amps, data = mutation_data, amp = 100, len = 1000, include_genes = TRUE)
head(fw_bins)

## ----com bins-----------------------------------------------------------------
com_bins <- com_hotspot(fw_panel = fw_bins, bins = amps, data = mutation_data, 
                        amp = 100, len = 1000, size = 3, include_genes = TRUE)
head(com_bins)

## ----session info-------------------------------------------------------------
sessionInfo()

