# Code example from 'CreatingPharmacoSet' vignette. See references/ for full tutorial.

## ----setup, include=FALSE, cache=FALSE, message = FALSE-----------------------
library("knitr")

## Text results
opts_chunk$set(echo = TRUE, warning = TRUE, message = TRUE, include = TRUE)

## Code decoration
opts_chunk$set(tidy = FALSE, comment = NA, highlight = TRUE)


## ----knitcitation, include=FALSE----------------------------------------------
library(knitcitations)

cleanbib()
cite_options(citation_format = "pandoc")

## -----------------------------------------------------------------------------
sample <- data.frame(
  sampleid = c("A549", "MCF7", "PC3"),
  tissueid = c("lung", "breast", "prostate"),
  cellosaurus.accession = c("CVCL_0023", "CVCL_0031", "CVCL_0035"),
  row.names = c("A549", "MCF7", "PC3"))

sample

## -----------------------------------------------------------------------------
treatment <- data.frame(
  treatmentid = c("Doxorubicin", "Tamoxifen", "Docetaxel"),
  chembl.MechanismOfAction = c("DNA topoisomerase II inhibitor", "Estrogen receptor antagonist", "Microtubule inhibitor"),
  row.names = c("Doxorubicin", "Tamoxifen", "Docetaxel"))

treatment

## ----eval=FALSE---------------------------------------------------------------
# SE@annotation <- "rna"

## ----eval=FALSE---------------------------------------------------------------
# PharmacoGx::PharmacoSet2(
#   name = "emptySet",
#   treatment = data.frame(),
#   sample = data.frame(),
#   molecularProfiles = MultiAssayExperiment::MultiAssayExperiment(),
#   treatmentResponse = CoreGx::TreatmentResponseExperiment(),
#   perturbation = list(),
#   curation = list(
#     sample = data.frame(),
#     treatment = data.frame(),
#     tissue = data.frame()),
#   datasetType = "sensitivity"
# )
# 
# 

## ----eval=FALSE---------------------------------------------------------------
# PharmacoGx::PharmacoSet(
#   name,
#   molecularProfiles=list(),
#   sample=data.frame(),
#   treatment=data.frame(),
#   sensitivityInfo=data.frame(),
#   sensitivityRaw=array(dim=c(0,0,0)),
#   sensitivityProfiles=matrix(),
#   curationTreatment=data.frame(),
#   curationSample=data.frame(),
#   curationTissue=data.frame(),
#   datasetType=c("sensitivity", "perturbation", "both"),
#   verify = TRUE)

