# Code example from 'DEsingle' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  echo = TRUE,
  collapse = TRUE,
  comment = "#>"
)

## ----Installation from Bioconductor, eval = FALSE-----------------------------
# if(!require(BiocManager)) install.packages("BiocManager")
# BiocManager::install("DEsingle")

## ----Installation from GitHub, eval = FALSE-----------------------------------
# if(!require(devtools)) install.packages("devtools")
# devtools::install_github("miaozhun/DEsingle", build_vignettes = TRUE)

## ----Load DEsingle, eval = FALSE----------------------------------------------
# library(DEsingle)

## ----Load TestData------------------------------------------------------------
library(DEsingle)
data(TestData)

## ----counts-------------------------------------------------------------------
dim(counts)
counts[1:6, 1:6]

## ----group--------------------------------------------------------------------
length(group)
summary(group)

## ----demo1, eval = FALSE------------------------------------------------------
# # Load library and the test data for DEsingle
# library(DEsingle)
# data(TestData)
# 
# # Specifying the two groups to be compared
# # The sample number in group 1 and group 2 is 50 and 100 respectively
# group <- factor(c(rep(1,50), rep(2,100)))
# 
# # Detecting the DE genes
# results <- DEsingle(counts = counts, group = group)
# 
# # Dividing the DE genes into 3 categories at threshold of FDR < 0.05
# results.classified <- DEtype(results = results, threshold = 0.05)

## ----demo2, eval = FALSE------------------------------------------------------
# # Load library and the test data for DEsingle
# library(DEsingle)
# library(SingleCellExperiment)
# data(TestData)
# 
# # Convert the test data in DEsingle to SingleCellExperiment data representation
# sce <- SingleCellExperiment(assays = list(counts = as.matrix(counts)))
# 
# # Specifying the two groups to be compared
# # The sample number in group 1 and group 2 is 50 and 100 respectively
# group <- factor(c(rep(1,50), rep(2,100)))
# 
# # Detecting the DE genes with SingleCellExperiment input sce
# results <- DEsingle(counts = sce, group = group)
# 
# # Dividing the DE genes into 3 categories at threshold of FDR < 0.05
# results.classified <- DEtype(results = results, threshold = 0.05)

## ----extract DE, eval = FALSE-------------------------------------------------
# # Extract DE genes at threshold of FDR < 0.05
# results.sig <- results.classified[results.classified$pvalue.adj.FDR < 0.05, ]

## ----extract subtypes, eval = FALSE-------------------------------------------
# # Extract three types of DE genes separately
# results.DEs <- results.sig[results.sig$Type == "DEs", ]
# results.DEa <- results.sig[results.sig$Type == "DEa", ]
# results.DEg <- results.sig[results.sig$Type == "DEg", ]

## ----demo3, eval = FALSE------------------------------------------------------
# # Load library
# library(DEsingle)
# 
# # Detecting the DE genes in parallelization
# results <- DEsingle(counts = counts, group = group, parallel = TRUE)

## ----demo4, eval = FALSE------------------------------------------------------
# # Load library
# library(DEsingle)
# library(BiocParallel)
# 
# # Set the parameters and register the back-end to be used
# param <- MulticoreParam(workers = 18, progressbar = TRUE)
# register(param)
# 
# # Detecting the DE genes in parallelization with 18 cores
# results <- DEsingle(counts = counts, group = group, parallel = TRUE, BPPARAM = param)

## ----demo5, eval = FALSE------------------------------------------------------
# # Load library
# library(DEsingle)
# library(BiocParallel)
# 
# # Set the parameters and register the back-end to be used
# param <- SnowParam(workers = 8, type = "SOCK", progressbar = TRUE)
# register(param)
# 
# # Detecting the DE genes in parallelization with 8 cores
# results <- DEsingle(counts = counts, group = group, parallel = TRUE, BPPARAM = param)

## ----help1, eval = FALSE------------------------------------------------------
# # Documentation for DEsingle
# ?DEsingle

## ----help2, eval = FALSE------------------------------------------------------
# # Documentation for DEtype
# ?DEtype

## ----help3, eval = FALSE------------------------------------------------------
# # Documentation for TestData
# ?TestData
# ?counts
# ?group

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

