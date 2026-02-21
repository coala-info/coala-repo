# Code example from 'gDR' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----echo=TRUE, results='asis'------------------------------------------------
library(gDR)
# get test data from gDRimport package
# i.e. paths to manifest, templates and results files
td <- get_test_data()
manifest_path(td)
template_path(td)
result_path(td)

## ----echo=TRUE, results='asis', warning=FALSE, results='hide', message=FALSE----
# Import data
imported_data <- 
  import_data(manifest_path(td), template_path(td), result_path(td))
head(imported_data)

## -----------------------------------------------------------------------------
inl <- prepare_input(imported_data)
detected_data_types <- names(inl$exps)
detected_data_types
se <- create_and_normalize_SE(
  inl$df_list[["single-agent"]],
  data_type = "single-agent",
  nested_confounders = inl$nested_confounders)
se

## ----echo=TRUE, results='asis', warning=FALSE, results='hide', message=FALSE----
se <- average_SE(se, data_type = "single-agent")
se <- fit_SE(se, data_type = "single-agent")

## ----echo=TRUE----------------------------------------------------------------
se

## ----echo=TRUE, results='asis', warning=FALSE, results='hide', message=FALSE----
# Run gDR pipeline
mae <- runDrugResponseProcessingPipeline(imported_data)

## ----echo=TRUE----------------------------------------------------------------
mae

## ----echo=TRUE----------------------------------------------------------------
names(mae)
SummarizedExperiment::assayNames(mae[[1]])

## ----echo=TRUE----------------------------------------------------------------
library(kableExtra)
se <- mae[["single-agent"]]
head(convert_se_assay_to_dt(se, "Metrics"))

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

