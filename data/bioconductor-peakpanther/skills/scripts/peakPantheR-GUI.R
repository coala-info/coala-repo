# Code example from 'peakPantheR-GUI' vignette. See references/ for full tutorial.

## ----biocstyle, echo = FALSE, results = "asis"--------------------------------
BiocStyle::markdown()

## ----echo = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----init, message = FALSE, echo = FALSE, results = "hide"--------------------
## Silently loading all packages
library(BiocStyle)
library(peakPantheR)
library(faahKO)
library(pander)

## ----eval = FALSE-------------------------------------------------------------
# library(peakPantheR)
# 
# peakPantheR_start_GUI(browser = TRUE)
# #  To exit press ESC in the command line

## ----out.width = "700px", echo = FALSE----------------------------------------
knitr::include_graphics("figures/01-import_RData.png")

## ----out.width = "700px", echo = FALSE----------------------------------------
knitr::include_graphics("figures/02-import_CSV.png")

## ----out.width = "700px", echo = FALSE----------------------------------------
knitr::include_graphics("figures/03-Run_annotation.png")

## ----out.width = "700px", echo = FALSE----------------------------------------
knitr::include_graphics("figures/04-Diagnostic_statistics.png")

## ----out.width = "700px", echo = FALSE----------------------------------------
knitr::include_graphics("figures/05-Diagnostic_updateUROIFIR.png")

## ----out.width = "700px", echo = FALSE----------------------------------------
knitr::include_graphics("figures/06-Diagnostic_plot.png")

## ----out.width = "700px", echo = FALSE----------------------------------------
knitr::include_graphics("figures/07-Results_Overall.png")

## ----out.width = "700px", echo = FALSE----------------------------------------
knitr::include_graphics("figures/08-Results_byFeature.png")

## ----out.width = "700px", echo = FALSE----------------------------------------
knitr::include_graphics("figures/09-Results_bySample.png")

## ----out.width = "700px", echo = FALSE----------------------------------------
knitr::include_graphics("figures/10-Export.png")

## ----echo = FALSE-------------------------------------------------------------
devtools::session_info()

