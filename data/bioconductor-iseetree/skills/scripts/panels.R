# Code example from 'panels' vignette. See references/ for full tutorial.

## ----include=FALSE----------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----screenfun, eval=!exists("SCREENSHOT"), include=FALSE-------------------------------------------------------------
# SCREENSHOT <- function(x, ...) knitr::include_graphics(x)

## ----abundance_density_plot, echo=FALSE, out.width="60%"--------------------------------------------------------------
SCREENSHOT("screenshots/AbundancePlot.png", delay=20)

## ----abundance_plot, echo=FALSE, out.width="60%"----------------------------------------------------------------------
SCREENSHOT("screenshots/AbundanceDensityPlot.png", delay=20)

## ----prevalence_plot, echo=FALSE, out.width="60%"---------------------------------------------------------------------
SCREENSHOT("screenshots/PrevalencePlot.png", delay=20)

## ----rda_plot, echo=FALSE, out.width="60%"----------------------------------------------------------------------------
SCREENSHOT("screenshots/RDAPlot.png", delay=20)

## ----scree_plot, echo=FALSE, out.width="60%"--------------------------------------------------------------------------
SCREENSHOT("screenshots/ScreePlot.png", delay=20)

## ----loading_plot, echo=FALSE, out.width="60%"------------------------------------------------------------------------
SCREENSHOT("screenshots/LoadingPlot.png", delay=20)

## ----tree_plot, echo=FALSE, out.width="60%"---------------------------------------------------------------------------
SCREENSHOT("screenshots/RowTreePlot.png", delay=20)

## ----graph_plot, echo=FALSE, out.width="60%"--------------------------------------------------------------------------
SCREENSHOT("screenshots/RowGraphPlot.png", delay=20)

## ----reproduce, echo=FALSE--------------------------------------------------------------------------------------------
## Session info
options(width = 120)
sessionInfo()

