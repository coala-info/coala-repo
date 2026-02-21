# Code example from 'HCAMatrix' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE)
#      install.packages("BiocManager")
#  
#  BiocManager::install("HCAMatrixBrowser")

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
library(HCAMatrixBrowser)
library(rapiclient)
library(AnVIL)

## -----------------------------------------------------------------------------
(hca <- HCAMatrix())

## -----------------------------------------------------------------------------
schemas(hca)

## -----------------------------------------------------------------------------
available_filters(hca)

## -----------------------------------------------------------------------------
filter_detail(hca, "genes_detected")

## -----------------------------------------------------------------------------
available_formats(hca)

## ----eval=FALSE---------------------------------------------------------------
#  format_detail(hca, "mtx")

## -----------------------------------------------------------------------------
available_features(hca)

## -----------------------------------------------------------------------------
feature_detail(hca, "gene")

## -----------------------------------------------------------------------------
bundle_fqids <-
    c("980b814a-b493-4611-8157-c0193590e7d9.2018-11-12T131442.994059Z",
    "7243c745-606d-4827-9fea-65a925d5ab98.2018-11-07T002256.653887Z")
req <- schemas(hca)$v0_MatrixRequest(
    bundle_fqids = bundle_fqids, format = "loom"
)
req

## -----------------------------------------------------------------------------
jsonlite::fromJSON(
    txt = '{"filter": {"op": "and", "value": [ {"op": "=", "value": "Single cell transcriptome analysis of human pancreas", "field": "project.project_core.project_short_name"}, {"op": ">=", "value": 300, "field": "genes_detected"} ] }}'
)

## -----------------------------------------------------------------------------
hca$matrix.lambdas.api.v1.core.post_matrix

## -----------------------------------------------------------------------------
hcafilt <- filter(hca,
    project.project_core.project_short_name ==
        "Single cell transcriptome analysis of human pancreas" &
        genes_detected >= 300)

## -----------------------------------------------------------------------------
filters(hcafilt)

## -----------------------------------------------------------------------------
(loomex <- loadHCAMatrix(hcafilt, format = "loom"))

## -----------------------------------------------------------------------------
(mtmat <- loadHCAMatrix(hcafilt, format = "mtx"))

## -----------------------------------------------------------------------------
(tib <- loadHCAMatrix(hcafilt, format = "csv"))

## -----------------------------------------------------------------------------
hca$matrix.lambdas.api.v0.core.post_matrix

