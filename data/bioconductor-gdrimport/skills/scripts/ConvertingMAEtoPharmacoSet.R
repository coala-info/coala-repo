# Code example from 'ConvertingMAEtoPharmacoSet' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE
)

## ----setup, include=FALSE-----------------------------------------------------
library(PharmacoGx)
library(gDRimport)
library(MultiAssayExperiment)

## ----loadMae------------------------------------------------------------------
(mae <- qs::qread(
    system.file("extdata", "kyung2022mae", "MAE_E2.qs", package = "gDRimport")
  )
)

## ----viewAssays---------------------------------------------------------------
gDRutils::MAEpply(mae, assays)

## ----warning=FALSE------------------------------------------------------------
pset <- convert_MAE_to_PSet(mae, pset_name="Kyung2022")

## ----viewPharmacoSet----------------------------------------------------------
pset

## -----------------------------------------------------------------------------
head(treatmentInfo(pset))

head(sampleInfo(pset))


## ----rownames, echo=TRUE------------------------------------------------------
tre <- treatmentResponse(pset)
head(rownames(tre))
head(rowData(tre))

## ----colnames, echo=TRUE------------------------------------------------------
head(colnames(tre))
head(colData(tre))

## ----echo=TRUE----------------------------------------------------------------
tre[
  .(treatmentid=="G02967907_GDC-0077_PI3K-A_168"), # query on row
  .(sampleid=="CL131891_EFM-19_Breast_EFM-19_unknown_64") # query on column
]

## ----echo=TRUE----------------------------------------------------------------
tre[
  .(treatmentid!="G02967907_GDC-0077_PI3K-A_168"), # query on row
  .(sampleid!="CL131891_EFM-19_Breast_EFM-19_unknown_64") # query on column
]

## ----viewTREAssays------------------------------------------------------------
lapply(assays(tre), head)

## ----viewAssayNames-----------------------------------------------------------
assayNames(tre)

## ----viewAssay----------------------------------------------------------------
head(assay(tre, "Metrics"),3)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

