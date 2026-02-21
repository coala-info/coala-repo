# Code example from 'data_vignette' vignette. See references/ for full tutorial.

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
    synaptome.data = citation("synaptome.data")[1]
)

## ----"install", eval = FALSE--------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE)) {
#        install.packages("BiocManager")
#    }
#  
#  BiocManager::install("synaptome.data")
#  
#  ## Check that you have a valid Bioconductor installation
#  BiocManager::valid()

## ----"citation"---------------------------------------------------------------
## Citation info
citation("synaptome.data")

## ----"start", message=FALSE, eval=FALSE---------------------------------------
#  library("synaptome.data")
#  ahub <- AnnotationHub::AnnotationHub(hub='http://127.0.0.1:9393/')
#  sdb<-AnnotationHub::query(ahub,'SynaptomeDB')

## ----createVignette, eval=FALSE-----------------------------------------------
#  ## Create the vignette
#  library("rmarkdown")
#  system.time(render("data_vignette.Rmd", "BiocStyle::html_document"))
#  
#  ## Extract the R code
#  library("knitr")
#  knit("data_vignette.Rmd", tangle = TRUE)

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

