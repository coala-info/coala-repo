# Code example from 'prio' vignette. See references/ for full tutorial.

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
avail_strains()

## -----------------------------------------------------------------------------
df = prio("chr1", start=5000000, end=6000000, strain1="C57BL_6J", strain2="AKR_J")

## -----------------------------------------------------------------------------
comment(df)

## -----------------------------------------------------------------------------
get_top(df$reduction, n_top=3)

## -----------------------------------------------------------------------------
plots = vis_reduction_factors(df$genotypes, df$reduction, 2)
plots[[1]]
plots[[2]]

## -----------------------------------------------------------------------------
sessionInfo()

