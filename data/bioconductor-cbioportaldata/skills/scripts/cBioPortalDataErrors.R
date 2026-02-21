# Code example from 'cBioPortalDataErrors' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(cache = TRUE)

## ----load_libs, include=TRUE,results="hide",message=FALSE,warning=FALSE-------
library(cBioPortalData)
library(AnVIL)
library(jsonlite)

## ----load_api_errs------------------------------------------------------------
api_errs <- system.file(
    "extdata", "api", "err_api_info.json",
    package = "cBioPortalData", mustWork = TRUE
)
err_api_info <- fromJSON(api_errs)

## ----inspect_api_errs---------------------------------------------------------
class(err_api_info)
length(err_api_info)
lengths(err_api_info)

## ----api_err_names------------------------------------------------------------
names(err_api_info)

## ----inconsistent_build-------------------------------------------------------
err_api_info[['Inconsistent build numbers found']]

## ----all_api_errs-------------------------------------------------------------
err_api_info

## ----load_pack_errs-----------------------------------------------------------
pack_errs <- system.file(
    "extdata", "pack", "err_pack_info.json",
    package = "cBioPortalData", mustWork = TRUE
)
err_pack_info <- fromJSON(pack_errs)

## ----inspect_pack_errs--------------------------------------------------------
length(err_pack_info)
lengths(err_pack_info)

## ----pack_err_names-----------------------------------------------------------
names(err_pack_info)

## ----all_pack_errs------------------------------------------------------------
err_pack_info

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

