# Code example from 'linking' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
require(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)

## -----------------------------------------------------------------------------
# Mocking up some kind of matrix-like object.
library(Matrix)
x <- round(rsparsematrix(1000, 10, 0.2))

# Initializing it in C++.
library(beachmat)
init <- initializeCpp(x)

## ----eval=FALSE---------------------------------------------------------------
# browseURL(system.file("include", "Rtatami.h", package="beachmat"))

## -----------------------------------------------------------------------------
column_sums(init)

## ----results="hide"-----------------------------------------------------------
# .onLoad <- function(libname, pkgname) {
    setup_parallel_executor(beachmat::getExecutor())
# }

## -----------------------------------------------------------------------------
parallel_column_sums(init, 2)

## -----------------------------------------------------------------------------
sessionInfo()

