# Code example from 'TMExplorer' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(TMExplorer)

## -----------------------------------------------------------------------------
res = queryTME(metadata_only = TRUE)

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(head(res[[1]][,1:5]))

## -----------------------------------------------------------------------------
res = queryTME(tumour_type = 'Breast cancer', metadata_only = TRUE)[[1]]

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(head(res[,1:5]))

## -----------------------------------------------------------------------------
res = queryTME(geo_accession = "GSE81861")

## ----eval=FALSE---------------------------------------------------------------
# View(counts(res[[1]]))

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(head(counts(res[[1]])[,1:2]))

## -----------------------------------------------------------------------------
metadata(res[[1]])$pmid

## ----eval=FALSE---------------------------------------------------------------
# res = queryTME(has_truth = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# View(colData(res[[1]]))

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(head(colData(res[[1]])))

## ----eval=FALSE---------------------------------------------------------------
# res = queryTME(has_truth = TRUE, has_signatures = TRUE)
# View(metadata(res[[1]])$signatures)

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(metadata(res[[1]])$signatures[,1:3])

## ----eval=FALSE---------------------------------------------------------------
# res = queryTME(geo_accession = "GSE72056")[[1]]
# saveTME(res, '~/Downloads/GSE72056')

## -----------------------------------------------------------------------------
sessionInfo()

