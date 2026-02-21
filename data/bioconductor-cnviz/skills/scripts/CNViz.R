# Code example from 'CNViz' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(CNViz)

## -----------------------------------------------------------------------------
data(meta_data)
head(meta_data)

## -----------------------------------------------------------------------------
data(probe_data)
head(probe_data)

## -----------------------------------------------------------------------------
data(gene_data)
head(gene_data)

## -----------------------------------------------------------------------------
data(segment_data)
head(segment_data)

## -----------------------------------------------------------------------------
data(variant_data)
head(variant_data)

## ----eval = FALSE-------------------------------------------------------------
# launchCNViz(sample_name = "sample123", meta_data = meta_data, probe_data = probe_data, gene_data = gene_data, segment_data = segment_data, variant_data = variant_data)

