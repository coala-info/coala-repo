# Code example from 'ConvertingPharmacoSetToGDR' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(PharmacoGx)
library(gDRimport)

## ----eval = FALSE-------------------------------------------------------------
# pset <- getPSet("Tavor_2020")
# pset

## ----include = FALSE----------------------------------------------------------
read_mocked_PSets <- function(canonical = FALSE) {
  qs::qread(
    system.file("extdata", "data_for_unittests", "PSets.qs", package = "gDRimport")
  )
}
pset <- testthat::with_mocked_bindings(
    availablePSets = read_mocked_PSets,
    .package = "PharmacoGx",
    suppressMessages(getPSet(
      "Tavor_2020", psetDir = system.file("extdata/pset", package = "gDRimport")
    ))
)
pset

## -----------------------------------------------------------------------------
# Store treatment response data in df_ 
dt <- convert_pset_to_df(pharmacoset = pset)
str(dt)

## -----------------------------------------------------------------------------
# example subset using only 1 cell line
subset_cl <- dt$Clid[1]
x <- dt[Clid == subset_cl]
x

## ----eval = FALSE-------------------------------------------------------------
# # RUN DRUG RESPONSE PROCESSING PIPELINE
# se <- gDRcore::runDrugResponseProcessingPipeline(x)
# se

## ----eval = FALSE-------------------------------------------------------------
# # Convert Summarized Experiments to data.table
# # Available SEs : "RawTreatred", "Controls", "Normalized", "Averaged", "Metrics"
# 
# str(gDRutils::convert_se_assay_to_dt(se[[1]], "Averaged"))
# str(gDRutils::convert_se_assay_to_dt(se[[1]], "Metrics"))

## ----include = FALSE----------------------------------------------------------
gDRutils::reset_env_identifiers()

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

