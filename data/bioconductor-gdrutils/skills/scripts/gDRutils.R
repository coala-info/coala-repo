# Code example from 'gDRutils' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(gDRutils)
suppressPackageStartupMessages(library(MultiAssayExperiment))

## -----------------------------------------------------------------------------
mae <- get_synthetic_data("finalMAE_combo_matrix_small")
MAEpply(mae, dim)

## -----------------------------------------------------------------------------
MAEpply(mae, rowData)

## -----------------------------------------------------------------------------
MAEpply(mae, rowData, unify = TRUE)

## -----------------------------------------------------------------------------
mdt <- convert_mae_assay_to_dt(mae, "Metrics")
head(mdt, 3)

## -----------------------------------------------------------------------------
se <- mae[[1]]
sdt <- convert_se_assay_to_dt(se, "Metrics")
head(sdt, 3)

## -----------------------------------------------------------------------------
get_env_identifiers()

## -----------------------------------------------------------------------------
set_env_identifier("concentration", "Dose")

## -----------------------------------------------------------------------------
get_env_identifiers("concentration")

## -----------------------------------------------------------------------------
reset_env_identifiers()

## -----------------------------------------------------------------------------
get_env_identifiers("concentration")

## -----------------------------------------------------------------------------
# Example data.table
dt <- data.table::data.table(
  Barcode = c("A1", "A2", "A3"),
  Duration = c(24, 48, 72),
  Template = c("T1", "T2", "T3"),
  clid = c("C1", "C2", "C3")
)

# Validate identifiers
validated_identifiers <- validate_identifiers(
  dt,
  req_ids = c("barcode", "duration", "template", "cellline")
)

print(validated_identifiers)

## -----------------------------------------------------------------------------
# Example of prettifying identifiers
x <- c("CellLineName", "Tissue", "Concentration_2")
prettified_names <- prettify_flat_metrics(x, human_readable = TRUE)
print(prettified_names)

## -----------------------------------------------------------------------------
validate_MAE(mae)

## -----------------------------------------------------------------------------
validate_SE(se)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

