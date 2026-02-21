# Code example from 'wasserstein_metric' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(waddR)

set.seed(24)
x <- rnorm(100,mean=0,sd=1)
y <- rnorm(100,mean=2,sd=1)

## ----wasserstein_exact--------------------------------------------------------
wasserstein_metric(x,y,p=2)

## ----sq_wasserstein_exact-----------------------------------------------------
wasserstein_metric(x,y,p=2)^2

## ----sq_wassersein_approx-----------------------------------------------------
squared_wass_approx(x,y)

## ----sq_wassersein_decomp-----------------------------------------------------
squared_wass_decomp(x,y)

## ----session-info-------------------------------------------------------------
sessionInfo()

