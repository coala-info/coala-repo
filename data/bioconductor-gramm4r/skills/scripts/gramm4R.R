# Code example from 'gramm4R' vignette. See references/ for full tutorial.

## ----warning = FALSE,message = FALSE-------------------------------------
library("gramm4R")
data("metabolites")
data("microbes")
preGramm(metabolites,microbes)

## ----warning = FALSE,message = FALSE-------------------------------------
data("metabolites")
data("microbes")
data("covariates")
naiveGramm(metabolites,microbes,covariates)

## ----warning = FALSE,message = FALSE,results = "hide"--------------------
data("metabolites")
data("microbes")

nlfitGramm(metabolites,microbes)

## ----warning = FALSE,message = FALSE,results = "hide"--------------------
data("metabolites");data("microbes");data("covariates")
Gramm(metabolites,microbes,covariates)

