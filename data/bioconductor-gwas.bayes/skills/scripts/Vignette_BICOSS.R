# Code example from 'Vignette_BICOSS' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  tidy = FALSE
)

## ----warning=FALSE,message=FALSE----------------------------------------------
library(GWAS.BAYES)

## -----------------------------------------------------------------------------
Y[1:5]

## -----------------------------------------------------------------------------
SNPs[1:5,1:5]

## -----------------------------------------------------------------------------
kinship[1:5,1:5]

## -----------------------------------------------------------------------------
BICOSS_P3D <- BICOSS(Y = Y, SNPs = SNPs, 
                     kinship = kinship,FDR_Nominal = 0.05,P3D = TRUE,
                     maxiterations = 400,runs_til_stop = 40)
BICOSS_P3D$best_model

## -----------------------------------------------------------------------------
BICOSS_Exact <- BICOSS(Y = Y, SNPs = SNPs, 
                       kinship = kinship,FDR_Nominal = 0.05,P3D = FALSE,
                       maxiterations = 400,runs_til_stop = 40)
BICOSS_Exact$best_model

## -----------------------------------------------------------------------------
## The true causal SNPs in this example are
True_Causal_SNPs <- c(450,1350,2250,3150,4050,4950,5850,6750,7650,8550)
## Thus, the number of true positives is
sum(BICOSS_P3D$best_model %in% True_Causal_SNPs)
## The number of false positives is
sum(!(BICOSS_P3D$best_model %in% True_Causal_SNPs))

## -----------------------------------------------------------------------------
sessionInfo()

