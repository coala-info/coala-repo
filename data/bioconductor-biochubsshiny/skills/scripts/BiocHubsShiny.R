# Code example from 'BiocHubsShiny' vignette. See references/ for full tutorial.

## ----setup, include=FALSE,echo=FALSE------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    cache = TRUE,
    out.width = "100%"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("BiocHubsShiny")

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
library(BiocHubsShiny)

## ----eval=FALSE---------------------------------------------------------------
# BiocHubsShiny()

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/BiocHubsShiny.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/MusMusculus.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/MusMusculusSelection.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/MusMusculusCode.png")

## -----------------------------------------------------------------------------
sessionInfo()

