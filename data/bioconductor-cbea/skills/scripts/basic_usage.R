# Code example from 'basic_usage' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    R = citation(),
    BiocStyle = citation("BiocStyle")[1],
    knitr = citation("knitr")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    sessioninfo = citation("sessioninfo")[1],
    testthat = citation("testthat")[1],
    phyloseq = citation("phyloseq")[1],
    treesummarizedexperiment = citation("TreeSummarizedExperiment")[1],
    tidyverse = citation("tidyverse")[1],
    mixtools = citation("mixtools")[1],
    fitdistrplus = citation("fitdistrplus")[1],
    CBEA = citation("CBEA")[1],
    broom = citation("broom")[1], 
    BiocParallel = citation("BiocParallel")[1]
)

## ----"install", eval = FALSE--------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE)) {
#        install.packages("BiocManager")
#    }
#  
#  BiocManager::install("CBEA")
#  
#  ## Check that you have a valid Bioconductor installation
#  BiocManager::valid()

## ----"start", message=FALSE---------------------------------------------------
library("CBEA")
library(BiocSet)
library(tidyverse)
set.seed(1020)

## ----load_data----------------------------------------------------------------
data("hmp_gingival")
abun <- hmp_gingival$data
metab_sets <- hmp_gingival$set
abun # this is a TreeSummarizedExperiment object 

## ----load_sets----------------------------------------------------------------
metab_sets

## ----run_cbea, eval = TRUE----------------------------------------------------
results <- cbea(abun, set = metab_sets, abund_values = "16SrRNA",
              output = "cdf", distr = "mnorm", adj = TRUE, thresh = 0.05, n_perm = 10)
results

## ----results_obj, eval = TRUE-------------------------------------------------
names(results)

## ----results_obj_2, eval = TRUE-----------------------------------------------
str(results$R)

## ----tidy_functions, eval = TRUE----------------------------------------------
tidy(results)
glance(results, "fit_comparison")
glance(results, "fit_diagnostic")

## ----check_backend, eval= TRUE------------------------------------------------
BiocParallel::registered()

## ----parallel_computing, eval=FALSE-------------------------------------------
#  cbea(abun, set = metab_sets, abund_values = "16SrRNA",
#       output = "cdf", distr = "mnorm", adj = TRUE, thresh = 0.05, n_perm = 10,
#       parallel_backend = MulticoreParam(workers = 2))

## ----"citation"---------------------------------------------------------------
## Citation info
citation("CBEA")

## ----createVignette, eval=FALSE-----------------------------------------------
#  ## Create the vignette
#  library("rmarkdown")
#  system.time(render("basic_usage.Rmd", "BiocStyle::html_document"))
#  
#  ## Extract the R code
#  library("knitr")
#  knit("basic_usage.Rmd", tangle = TRUE)

## ----reproduce1, echo=FALSE---------------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE---------------------------------------------------
## Processing time in seconds
totalTime <- diff(c(startTime, Sys.time()))
round(totalTime, digits = 3)

## ----reproduce3, echo=FALSE-------------------------------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 120)
session_info()

## ----vignetteBiblio, results = "asis", echo = FALSE, warning = FALSE, message = FALSE---------------------------------
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

