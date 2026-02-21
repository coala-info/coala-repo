# Code example from 'scpdata' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----load_scp, message = FALSE------------------------------------------------
library("scpdata")

## ----EH, message = FALSE------------------------------------------------------
eh <- ExperimentHub()

## ----EH_query, message = FALSE------------------------------------------------
query(eh, "scpdata")

## ----scpdata_fun--------------------------------------------------------------
info <- scpdata()
knitr::kable(info[, c("title", "description")])

## ----download_EH--------------------------------------------------------------
scp <- eh[["EH3901"]]
scp

## ----download_scpdata---------------------------------------------------------
scp <- dou2019_lysates()
scp

## ----setup2, include = FALSE--------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "",
    crop = NULL
)

## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

