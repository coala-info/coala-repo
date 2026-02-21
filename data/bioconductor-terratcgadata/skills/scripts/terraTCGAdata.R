# Code example from 'terraTCGAdata' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, cache = TRUE)
isAnVILWS <- function() {
    AnVILGCP::gcloud_exists() &&
    identical(AnVILBase::avplatform_namespace(), "AnVILGCP")
}

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("terraTCGAdata")

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
library(AnVIL)
library(terraTCGAdata)

## -----------------------------------------------------------------------------
gcloud_exists()

## ----eval=isAnVILWS()---------------------------------------------------------
# gcloud_project()

## ----eval=isAnVILWS()---------------------------------------------------------
# selectTCGAworkspace()

## ----eval=isAnVILWS()---------------------------------------------------------
# terraTCGAworkspace("TCGA_COAD_OpenAccess_V1-0_DATA")
# getOption("terraTCGAdata.workspace")

## ----eval=isAnVILWS()---------------------------------------------------------
# ct <- getClinicalTable(workspace = "TCGA_COAD_OpenAccess_V1-0_DATA")
# ct
# names(ct)

## ----eval=isAnVILWS()---------------------------------------------------------
# column_name <- "clin__bio__nationwidechildrens_org__Level_1__biospecimen__clin"
# clin <- getClinical(
#     columnName = column_name,
#     participants = TRUE,
#     workspace = "TCGA_COAD_OpenAccess_V1-0_DATA"
# )
# clin[, 1:6]
# dim(clin)

## ----eval=isAnVILWS()---------------------------------------------------------
# at <- getAssayTable(workspace = "TCGA_COAD_OpenAccess_V1-0_DATA")
# at
# names(at)

## ----eval=isAnVILWS()---------------------------------------------------------
# sampleTypesTable(workspace = "TCGA_COAD_OpenAccess_V1-0_DATA")

## ----eval=isAnVILWS()---------------------------------------------------------
# prot <- getAssayData(
#     assayName = "protein_exp__mda_rppa_core__mdanderson_org__Level_3__protein_normalization__data",
#     sampleCode = c("01", "10"),
#     workspace = "TCGA_COAD_OpenAccess_V1-0_DATA",
#     sampleIdx = 1:4
# )
# head(prot)

## ----eval=isAnVILWS()---------------------------------------------------------
# mae <- terraTCGAdata(
#     clinicalName = "clin__bio__nationwidechildrens_org__Level_1__biospecimen__clin",
#     assays =
#         c("protein_exp__mda_rppa_core__mdanderson_org__Level_3__protein_normalization__data",
#         "rnaseqv2__illuminahiseq_rnaseqv2__unc_edu__Level_3__RSEM_genes_normalized__data"),
#     sampleCode = NULL,
#     split = FALSE,
#     sampleIdx = 1:4,
#     workspace = "TCGA_COAD_OpenAccess_V1-0_DATA"
# )
# mae

## -----------------------------------------------------------------------------
sessionInfo()

