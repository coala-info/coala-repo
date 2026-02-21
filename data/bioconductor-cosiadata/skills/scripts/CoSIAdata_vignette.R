# Code example from 'CoSIAdata_vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----installation, eval = FALSE-----------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("CoSIAdata")
# library(CoSIAdata)

## ----download-c.elegan_data, eval = FALSE-------------------------------------
# c_elegans_vst_counts <- CoSIAdata::Caenorhabditis_elegans()

## ----behind_CoSIAdata, eval = FALSE-------------------------------------------
# eh <- ExperimentHub()
# query(eh, "CoSIAdata")
# head(eh[["EH7863"]])

## ----query_CoSIAdata----------------------------------------------------------
eh <- ExperimentHub::ExperimentHub()
AnnotationHub::query(eh, "CoSIAdata")

## -----------------------------------------------------------------------------
sessionInfo()

