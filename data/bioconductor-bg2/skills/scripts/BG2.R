# Code example from 'BG2' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  tidy = FALSE
)

## ----warning=FALSE,message=FALSE----------------------------------------------
library(BG2)

## -----------------------------------------------------------------------------
data("Y_poisson")
Y_poisson[1:5]

## -----------------------------------------------------------------------------
data("Y_binary")
Y_binary[1:5]

## -----------------------------------------------------------------------------
data("SNPs")
SNPs[1:5,1:5]

## -----------------------------------------------------------------------------
data("kinship")
kinship[1:5,1:5]

## -----------------------------------------------------------------------------
n <- length(Y_poisson)
covariance <- list()
covariance[[1]] <- kinship
covariance[[2]] <- diag(1, nrow = n, ncol = n)

## -----------------------------------------------------------------------------
set.seed(1330)
output_poisson <- BG2(Y=Y_poisson, SNPs=SNPs, Fixed = NULL, 
                      Covariance=covariance, Z=NULL, family="poisson", 
                      replicates=4, Tau="uniform",FDR_Nominal = 0.05, 
                      maxiterations = 4000, runs_til_stop = 400)
output_poisson

## -----------------------------------------------------------------------------
covariance <- list()
covariance[[1]] <- kinship

## -----------------------------------------------------------------------------
set.seed(1330)
output_binary <- BG2(Y=Y_binary, SNPs=SNPs, Fixed = NULL, 
                     Covariance=covariance, Z=NULL, family="bernoulli", 
                     replicates=NULL, Tau="IG",FDR_Nominal = 0.05, 
                     maxiterations = 4000, runs_til_stop = 400)
output_binary

## -----------------------------------------------------------------------------
sessionInfo()

