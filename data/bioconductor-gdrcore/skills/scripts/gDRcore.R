# Code example from 'gDRcore' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, echo = FALSE------------------------------------------------------
library(gDRtestData)
library(gDRcore)
log_level <- futile.logger::flog.threshold("ERROR")

## -----------------------------------------------------------------------------
td <- gDRimport::get_test_data()

## ----include=FALSE------------------------------------------------------------
loaded_data <-
  suppressMessages(
    gDRimport::load_data(
      gDRimport::manifest_path(td),
      gDRimport::template_path(td),
      gDRimport::result_path(td)
    )
  )
input_df <- merge_data(loaded_data$manifest, loaded_data$treatments, loaded_data$data)
head(input_df)

## ----message = FALSE, results = FALSE, warning = FALSE------------------------
mae <- runDrugResponseProcessingPipeline(input_df)

## -----------------------------------------------------------------------------
mae

## -----------------------------------------------------------------------------
mae[["single-agent"]]

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

