# Code example from 'EDIRquery' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("EDIRquery")

## ----message = FALSE, warning = FALSE-----------------------------------------
library("EDIRquery")

## -----------------------------------------------------------------------------
# Summary of results (printed to console)
gene_lookup("GAA", length = 7, mismatch = TRUE)

## -----------------------------------------------------------------------------
# Summary of results (printed to console)
gene_lookup("GAA", mismatch = TRUE)

## -----------------------------------------------------------------------------
# Database output of query
results <- gene_lookup("GAA", length = 7, mismatch = TRUE)
head(results)

## -----------------------------------------------------------------------------
# Database output of query
results <- gene_lookup("GAA", length = 7, format = "GInteractions", mismatch = TRUE)
head(results)

## -----------------------------------------------------------------------------
# Database output of query
sessionInfo()

