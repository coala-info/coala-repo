# Code example from 'filtering_subsetting' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  message = FALSE,
  digits = 3,
  collapse = TRUE,
  comment = "#>"
)
options(digits = 3)

## ----step_filter_taxa---------------------------------------------------------
library(dar)
data("metaHIV_phy")

rec <- recipe(metaHIV_phy, "RiskGroup2", "Species")
rec <- 
  step_filter_taxa(rec, .f = "function(x) sum(x > 0) >= (0 * length(x))") |> 
  prep()

## ----step_filter_by_abundance-------------------------------------------------
rec <- recipe(metaHIV_phy, "RiskGroup2", "Species")
rec <- 
  step_filter_by_abundance(rec, threshold = 0.01) |> 
  prep()

## ----step_filter_by_prevalence------------------------------------------------
rec <- recipe(metaHIV_phy, "RiskGroup2", "Species")
rec <- 
  step_filter_by_prevalence(rec, threshold = 0.01) |> 
  prep()

## ----step_filter_by_rarity----------------------------------------------------
rec <- recipe(metaHIV_phy, "RiskGroup2", "Species")
rec <- 
  step_filter_by_rarity(rec, threshold = 0.01) |> 
  prep()

## ----step_filter_by_variance--------------------------------------------------
rec <- recipe(metaHIV_phy, "RiskGroup2", "Species")
rec <- 
  step_filter_by_variance(rec, threshold = 0.01) |> 
  prep()

## ----subset_taxa--------------------------------------------------------------
rec <- recipe(metaHIV_phy, "RiskGroup2", "Species")
rec <-
  step_subset_taxa(rec, tax_level = "Kingdom", taxa = c("Bacteria", "Archaea")) |>
  prep()

## -----------------------------------------------------------------------------
devtools::session_info()

