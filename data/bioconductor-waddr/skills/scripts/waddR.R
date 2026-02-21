# Code example from 'waddR' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----install, eval=FALSE, echo=TRUE-------------------------------------------
# if (!requireNamespace("BiocManager"))
#  install.packages("BiocManager")
# BiocManager::install("waddR")

## ----install-github, eval=FALSE, echo=TRUE------------------------------------
# BiocManager::install("goncalves-lab/waddR")

## ----load-package-------------------------------------------------------------
library("waddR")

## ----session-info-------------------------------------------------------------
sessionInfo()

