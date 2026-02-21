# Code example from 'Imputation' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", message = TRUE, warning = FALSE,
  fig.width=8,
  fig.height =6
)

## ----setup, message = FALSE---------------------------------------------------
library(PRONE)

## ----load_real_tmt------------------------------------------------------------
data("tuberculosis_TMT_se")
se <- tuberculosis_TMT_se

## -----------------------------------------------------------------------------
se <- remove_samples_manually(se, "Label", c("1.HC_Pool1", "1.HC_Pool2"))

## ----impute-------------------------------------------------------------------
se <- impute_se(se, ain = NULL)

## -----------------------------------------------------------------------------
utils::sessionInfo()

