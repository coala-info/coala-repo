# Code example from 'MACSr' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(MACSr)

## -----------------------------------------------------------------------------
eh <- ExperimentHub::ExperimentHub()
eh <- AnnotationHub::query(eh, "MACSdata")
CHIP <- eh[["EH4558"]]
CTRL <- eh[["EH4563"]]

## -----------------------------------------------------------------------------
cp1 <- callpeak(CHIP, CTRL, gsize = 5.2e7, store_bdg = TRUE,
                name = "run_callpeak_narrow0", outdir = tempdir(),
                cutoff_analysis = TRUE)
cp2 <- callpeak(CHIP, CTRL, gsize = 5.2e7, store_bdg = TRUE,
                name = "run_callpeak_broad", outdir = tempdir(),
                broad = TRUE)

## -----------------------------------------------------------------------------
cp1
cp2

## -----------------------------------------------------------------------------
cp1$arguments

## -----------------------------------------------------------------------------
cp1$outputs

## -----------------------------------------------------------------------------
cat(paste(cp1$log, collapse="\n"))

## -----------------------------------------------------------------------------
sessionInfo()

