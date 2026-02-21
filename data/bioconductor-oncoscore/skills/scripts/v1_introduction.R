# Code example from 'v1_introduction' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(
concordance = TRUE,
background = "#f3f3ff"
)

## ----eval=FALSE---------------------------------------------------------------
# # install OncoScore dependencies
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("biomaRt")
# 
# # install OncoScore library
# if (!require("devtools")) install.packages("devtools")
# library("devtools")
# install_github("danro9685/OncoScore", ref = "master")
# 
# # load OncoScore library
# library("OncoScore")

