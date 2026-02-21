# Code example from 'v1_introduction' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(
concordance = TRUE,
background = "#f3f3ff"
)

## ----eval=FALSE---------------------------------------------------------------
# # install SIMLR dependencies
# if (!require("Matrix")) install.packages("Matrix")
# if (!require("Rcpp")) install.packages("Rcpp")
# if (!require("RcppAnnoy")) install.packages("RcppAnnoy")
# if (!require("RSpectra")) install.packages("RSpectra")
# if (!require("pracma")) install.packages("pracma")
# 
# # install SIMLR library
# if (!require("devtools")) install.packages("devtools")
# library("devtools")
# install_github("BatzoglouLabSU/SIMLR", ref = "master")
# 
# # load SIMLR library
# library("SIMLR")

