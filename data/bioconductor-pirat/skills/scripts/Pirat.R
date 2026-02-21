# Code example from 'Pirat' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  echo = TRUE,
  warning = FALSE,
  message = FALSE
)

## ----install_dev, eval = FALSE------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("Pirat")

## ----load_data, echo = TRUE---------------------------------------------------
library(Pirat)
library(utils)
data(subbouyssie)

## ----setseed------------------------------------------------------------------
set.seed(12345)

## ----impute-------------------------------------------------------------------
imp.res <- my_pipeline_llkimpute(subbouyssie)

## ----test1--------------------------------------------------------------------
head(imp.res$data.imputed[ ,seq(5)])

## ----params-------------------------------------------------------------------
imp.res$params

## ----correlations-------------------------------------------------------------
data(ropers)
plot_pep_correlations(ropers, titlename = "Ropers2021")

## ----pipeline_llkimpute-------------------------------------------------------
data(subropers)
imp.res = pipeline_llkimpute(subropers, extension = "2")

## ----impute4------------------------------------------------------------------
mask.sing.pg = colSums(subropers$adj) == 1
mask.sing.pep = rowSums(subropers$adj[, mask.sing.pg]) >= 1
imp.res$data.imputed[, mask.sing.pep]

## ----my_pipeline_llkimpute2---------------------------------------------------
imp.res = my_pipeline_llkimpute(subropers, extension = "S")

## ----impute2------------------------------------------------------------------
mask.sing.pg = colSums(subropers$adj) == 1
mask.sing.pep = rowSums(subropers$adj[, mask.sing.pg]) >= 1
imp.res$data.imputed[, mask.sing.pep]

## ----my_pipeline_llkimpute3---------------------------------------------------
imp.res = my_pipeline_llkimpute(subropers,
    extension = "T",
    rna.cond.mask = seq(nrow(subropers$peptides_ab)),
    pep.cond.mask = seq(nrow(subropers$peptides_ab)),
    max.pg.size.pirat.t = 1)

## ----data.imputed3------------------------------------------------------------
mask.sing.pg = colSums(subropers$adj) == 1
mask.sing.pep = rowSums(subropers$adj[, mask.sing.pg]) >= 1
imp.res$data.imputed[, mask.sing.pep]

## ----my_pipeline_llkimpute_T--------------------------------------------------
imp.res = my_pipeline_llkimpute(subropers,
                             extension = "T",
                             rna.cond.mask = rep(seq(6), each = 3),
                             pep.cond.mask = rep(seq(6), each = 3),
                             max.pg.size.pirat.t = 1)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

