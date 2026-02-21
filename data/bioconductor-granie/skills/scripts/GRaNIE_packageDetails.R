# Code example from 'GRaNIE_packageDetails' vignette. See references/ for full tutorial.

## ----<knitr, echo=FALSE, message=FALSE, results="hide", class.output="scroll-200"----
library("knitr")
opts_chunk$set(
  tidy = TRUE,
  cache = FALSE,
  message = FALSE,
  fig.align="center")

## ----eval = FALSE-------------------------------------------------------------
#  GRN = loadExampleObject()

## ----tidy=FALSE, eval = FALSE-------------------------------------------------
# 
# > GRN@config$functionParameters$add_TF_gene_correlation$`2023-01-23_21:50:52`
# 
# $call
# add_TF_gene_correlation(GRN = GRN, nCores = 5)
# 
# $parameters
# 
# $parameters$GRN
# GRN
# 
# $parameters$nCores
# [1] 5
# 
# $parameters$corMethod
# [1] "pearson"
# 
# $parameters$forceRerun
# [1] FALSE
# 

