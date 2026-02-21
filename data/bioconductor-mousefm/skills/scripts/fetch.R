# Code example from 'fetch' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup, eval=FALSE--------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("MouseFM")

## -----------------------------------------------------------------------------
library(MouseFM)

## -----------------------------------------------------------------------------
df = fetch("chr1", start=5000000, end=6000000)

df[1:10,]

## -----------------------------------------------------------------------------
comment(df)

## -----------------------------------------------------------------------------
sessionInfo()

