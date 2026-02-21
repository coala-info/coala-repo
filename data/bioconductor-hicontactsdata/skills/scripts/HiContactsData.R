# Code example from 'HiContactsData' vignette. See references/ for full tutorial.

## ----eval = TRUE, echo=FALSE, results="hide", message = FALSE, warning = FALSE----
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)
suppressPackageStartupMessages({
    library(HiContactsData)
})

## -----------------------------------------------------------------------------
library(HiContactsData)

## -----------------------------------------------------------------------------
cool_file <- HiContactsData()
cool_file <- HiContactsData(sample = 'yeast_wt', format = 'cool')
cool_file

## -----------------------------------------------------------------------------
sessionInfo()

