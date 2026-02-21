# Code example from 'issues' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup, message = FALSE---------------------------------------------------
library(AlphaMissenseR)

## ----eval = FALSE-------------------------------------------------------------
# am_rids <-
#     bfcinfo() |>
#     dplyr::filter(
#         grepl("zenodo", rname) |
#         startsWith(rname, "AlphaMissense_")
#     ) |>
#     pull(rid)

## ----eval = FALSE-------------------------------------------------------------
# BiocFileCache::bfcremove(rids = am_rids)

## -----------------------------------------------------------------------------
am_data("gene_hg38")

## ----db_disconnect_all--------------------------------------------------------
db_disconnect_all()

## -----------------------------------------------------------------------------
sessionInfo()

