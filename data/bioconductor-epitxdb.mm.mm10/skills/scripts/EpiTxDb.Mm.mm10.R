# Code example from 'EpiTxDb.Mm.mm10' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown(css.files = c('custom.css'))

## ---- echo=FALSE--------------------------------------------------------------
suppressPackageStartupMessages({
  library(EpiTxDb.Mm.mm10)
})

## ---- eval=FALSE--------------------------------------------------------------
#  library(EpiTxDb.Mm.mm10)

## -----------------------------------------------------------------------------
etdb <- EpiTxDb.Mm.mm10.tRNAdb()
etdb

## -----------------------------------------------------------------------------
modifications(etdb)

## -----------------------------------------------------------------------------
sessionInfo()

