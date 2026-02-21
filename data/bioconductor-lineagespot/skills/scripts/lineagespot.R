# Code example from 'lineagespot' vignette. See references/ for full tutorial.

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## For links
library("BiocStyle")
## Bib setup
library("RefManageR")
## Write bibliography information
bib <- c(
    R = citation(),
    BiocStyle = citation("BiocStyle")[1],
    data.table = citation("data.table")[1],
    stringr = citation("stringr")[1]
)

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
    comment = "#>",
    error = FALSE,
    warning = FALSE,
    message = FALSE,
    crop = NULL
)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("lineagespot")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----setup--------------------------------------------------------------------
library(lineagespot)

## ----eval=TRUE----------------------------------------------------------------
results <- lineagespot(vcf_folder = system.file("extdata", "vcf-files", 
                                                package = "lineagespot"),

                      gff3_path = system.file("extdata", 
                                              "NC_045512.2_annot.gff3", 
                                              package = "lineagespot"),

                      ref_folder = system.file("extdata", "ref", 
                                               package = "lineagespot"))

## -----------------------------------------------------------------------------
# overall table
head(results$variants.table)

## -----------------------------------------------------------------------------
# lineages' hits
head(results$lineage.hits)

## -----------------------------------------------------------------------------
# lineagespot report
head(results$lineage.report)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

