# Code example from 'dar' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  message = FALSE,
  digits = 3,
  collapse = TRUE,
  comment = "#>"
)
options(digits = 3)

## ----data---------------------------------------------------------------------
library(dar)

data("metaHIV_phy", package = "dar")

metaHIV_phy

## ----first_rec----------------------------------------------------------------
rec_obj <- recipe(metaHIV_phy, var_info = "RiskGroup2", tax_info = "Species") 
rec_obj

## ----step_code, eval=FALSE----------------------------------------------------
# rec_obj <- step_{X}(rec_obj, arguments)
# ## or
# rec_obj <- rec_obj |> step_{X}(arguments)

## ----prepro_steps-------------------------------------------------------------
rec_obj <- rec_obj |>
  step_subset_taxa(tax_level = "Kingdom", taxa = c("Bacteria", "Archaea")) |>
  step_filter_by_prevalence(0.03)
  
rec_obj

## ----da_steps-----------------------------------------------------------------
rec_obj <- rec_obj |>
  step_deseq() |>
  step_metagenomeseq(rm_zeros = 0.01) |>
  step_maaslin()

rec_obj

## ----da_steps_list------------------------------------------------------------
grep(
  "_new|_to_expr|filter|subset|rarefaction",
  grep("^step_", ls("package:dar"), value = TRUE),
  value = TRUE,
  invert = TRUE
)

## ----prep---------------------------------------------------------------------
da_results <- prep(rec_obj, parallel = TRUE)
da_results

## ----bake---------------------------------------------------------------------
## Number of used methods
count <- steps_ids(da_results, type = "da") |> length()

## Define the bake 
da_results <- bake(da_results, count_cutoff = count)

## ----cool---------------------------------------------------------------------
cool(da_results)

## -----------------------------------------------------------------------------
devtools::session_info()

