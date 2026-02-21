# Code example from 'basic' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
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

## ----eval=!exists("SCREENSHOT"), include=FALSE--------------------------------
SCREENSHOT <- function(x, ...) knitr::include_graphics(x, dpi = NA)

## ----library------------------------------------------------------------------
library(iSEE)

## ----demostart, eval=FALSE----------------------------------------------------
# iSEE(se)

## ----quickstart, eval=FALSE---------------------------------------------------
# example(iSEE, ask=FALSE)

## ----allen-dataset------------------------------------------------------------
library(scRNAseq)
sce <- ReprocessedAllenData(assays = "tophat_counts")   # specifying the assays to speed up the example
sce

## ----colData_sce--------------------------------------------------------------
colnames(colData(sce))

## -----------------------------------------------------------------------------
library(scater)
sce <- logNormCounts(sce, exprs_values="tophat_counts")

## ----allen-dataset-2----------------------------------------------------------
set.seed(1000)
sce <- runPCA(sce)
sce <- runTSNE(sce)
reducedDimNames(sce)

## -----------------------------------------------------------------------------
rowData(sce)$mean_log <- rowMeans(logcounts(sce))
rowData(sce)$var_log <- apply(logcounts(sce), 1, var)

## ----echo=FALSE, results="hide"-----------------------------------------------
# Saving and reloading so we don't have to run it again later.
# This requires that NO OTHER VIGNETTE is alphabetically ordered before this one.
saveRDS(file="sce.rds", sce)

## ----allen-dataset-4----------------------------------------------------------
app <- iSEE(sce)

## ----runApp, eval=FALSE-------------------------------------------------------
# shiny::runApp(app)

## ----citation-----------------------------------------------------------------
citation("iSEE")

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

