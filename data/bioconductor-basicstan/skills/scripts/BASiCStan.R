# Code example from 'BASiCStan' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
suppressPackageStartupMessages(library("BASiCStan"))
set.seed(42)
sce <- BASiCS_MockSCE()

## ----basics, results = "hide"-------------------------------------------------
amwg_fit <- BASiCS_MCMC(
    sce,
    N = 200,
    Thin = 10,
    Burn = 100,
    Regression = TRUE
)
stan_fit <- BASiCStan(sce, Method = "sampling", iter = 10)

## -----------------------------------------------------------------------------
BASiCS_ShowFit(amwg_fit)
BASiCS_ShowFit(stan_fit)

## -----------------------------------------------------------------------------
stan_obj <- BASiCStan(sce, ReturnBASiCS = FALSE, Method = "sampling", iter = 10)
head(summary(stan_obj)$summary)

## -----------------------------------------------------------------------------
Stan2BASiCS(stan_obj)

## -----------------------------------------------------------------------------
sessionInfo()

