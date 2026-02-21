# Code example from 'EpiTxDb.Sc.sacCer3' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown(css.files = c('custom.css'))

## ---- echo=FALSE--------------------------------------------------------------
suppressPackageStartupMessages({
  library(EpiTxDb.Sc.sacCer3)
})

## ---- eval=FALSE--------------------------------------------------------------
#  library(EpiTxDb.Sc.sacCer3)

## -----------------------------------------------------------------------------
etdb <- EpiTxDb.Sc.sacCer3.tRNAdb()
etdb

## -----------------------------------------------------------------------------
modifications(etdb)

## -----------------------------------------------------------------------------
sessionInfo()

