# Code example from 'GSE159526' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    
    crop = NULL 
    #https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
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
    GSE159526 = citation("GSE159526")[1]
)

## ----"citation"---------------------------------------------------------------
## Citation info
citation("GSE159526")

## ----"start", message=FALSE, eval=FALSE---------------------------------------
# eh <- ExperimentHub()
# query(eh, "GSE159526")
# 
# # raw rgset
# library(minfi)
# GSE159526_rgset <- eh[['EH6130']] # requires minfi
# 
# # normalized processed data matrix
# GSE159526_data <- eh[['EH6131']]
# 
# # sample information
# GSE159526_pdat <- eh[['EH6132']]

## ----createVignette, eval=FALSE-----------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render(here::here("vignettes", "GSE159526.Rmd"),
#                    "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("GSE159526.Rmd", tangle = TRUE)

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

## ----vignetteBiblio, results="asis", echo=FALSE, warning=FALSE, message=FALSE-----------------------------------------
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

