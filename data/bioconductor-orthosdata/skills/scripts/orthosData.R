# Code example from 'orthosData' vignette. See references/ for full tutorial.

## ----setup, include = FALSE, echo=FALSE, results="hide", message=FALSE--------
require(knitr)

knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    error = FALSE,
    warning = FALSE,
    message = FALSE,
    crop = NULL
)
stopifnot(requireNamespace("htmltools"))
htmltools::tagList(rmarkdown::html_dependency_font_awesome())


## ----library------------------------------------------------------------------
library(orthosData)

## ----eval=F, echo=T-----------------------------------------------------------
# # Check the path to the user's ExperimentHub directory:
# ExperimentHub::getExperimentHubOption("CACHE")
# # Download and cache the models for a specific organism:
# GetorthosModels(organism = "Mouse")
# 

## ----eval=F, echo=T-----------------------------------------------------------
# # Check the path to the user's ExperimentHub directory:
# ExperimentHub::getExperimentHubOption("CACHE")
# 
# # Download and cache the contrast database for a specific organism.
# # Note: mode="DEMO" caches a small "toy" database for the queries for demonstration purposes
# # To download the full db use mode = "ANALYSIS" (this is time and space consuming)
# GetorthosContrastDB(organism = "Mouse", mode="DEMO")
# 
# # Load the HDF5SummarizedExperiment:
# se <- HDF5Array::loadHDF5SummarizedExperiment(dir = ExperimentHub::getExperimentHubOption("CACHE"),
# prefix = "mouse_v212_NDF_c100_DEMO")

## -----------------------------------------------------------------------------
sessionInfo()

