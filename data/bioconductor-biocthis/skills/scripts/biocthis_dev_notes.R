# Code example from 'biocthis_dev_notes' vignette. See references/ for full tutorial.

## ----setup, include = FALSE-------------------------------------------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE--------------------------------------------------------
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    R = citation(),
    BiocStyle = citation("BiocStyle")[1],
    biocthis = citation("biocthis")[1],
    covr = citation("covr")[1],
    devtools = citation("devtools")[1],
    fs = citation("fs")[1],
    glue = citation("glue")[1],
    knitr = citation("knitr")[1],
    pkgdown = citation("pkgdown")[1],
    rlang = citation("rlang")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    sessioninfo = citation("sessioninfo")[1],
    styler = citation("styler")[1],
    testthat = citation("testthat")[1],
    usethis = citation("usethis")[1]
)

## ----bioccheck_example, eval = FALSE----------------------------------------------------------------------------------
# ## Use the following for the latest options
# BiocCheck::usage()
# ## Disable formatting checks
# BiocCheck::BiocCheck(`--no-check-formatting` = TRUE)

## ----createVignette, eval=FALSE---------------------------------------------------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("biocthis_dev_notes.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("biocthis_dev_notes.Rmd", tangle = TRUE)

## ----reproduce1, echo=FALSE-------------------------------------------------------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE-------------------------------------------------------------------------------------------
## Processing time in seconds
totalTime <- diff(c(startTime, Sys.time()))
round(totalTime, digits = 3)

## ----reproduce3, echo=FALSE-------------------------------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 120)
session_info()

## ----vignetteBiblio, results = 'asis', echo = FALSE, warning = FALSE, message = FALSE---------------------------------
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

