# Code example from 'clinvar' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup, message = FALSE---------------------------------------------------
library(AlphaMissenseR)

## ----download_cv--------------------------------------------------------------
clinvar_data()

## ----plot_P37023, fig.width = 7-----------------------------------------------
clinvar_plot(uniprotId = "P37023")

## ----close_db-----------------------------------------------------------------
db_disconnect_all()

## -----------------------------------------------------------------------------
sessionInfo()

