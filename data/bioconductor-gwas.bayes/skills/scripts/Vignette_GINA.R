# Code example from 'Vignette_GINA' vignette. See references/ for full tutorial.

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
GINA_Result <- GINA(Y = Y, SNPs = SNPs, 
                     kinship = kinship,FDR_Nominal = 0.05,
                     maxiterations = 400,runs_til_stop = 40)
GINA_Result$best_model

## -----------------------------------------------------------------------------
## The true causal SNPs in this example are
True_Causal_SNPs <- c(450,1350,2250,3150,4050,4950,5850,6750,7650,8550)
## Thus, the number of true positives is
sum(GINA_Result$best_model %in% True_Causal_SNPs)
## The number of false positives is
sum(!(GINA_Result$best_model %in% True_Causal_SNPs))

## -----------------------------------------------------------------------------
sessionInfo()

