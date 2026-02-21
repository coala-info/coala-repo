# Code example from 'custom_data' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# # Change working directory to where the STAR output is
# setwd("/path/to/aligned/output/")
# 
# library(psichomics)
# prepareGeneQuant(
#     "SRR6368612ReadsPerGene.out.tab", "SRR6368613ReadsPerGene.out.tab",
#     "SRR6368614ReadsPerGene.out.tab", "SRR6368615ReadsPerGene.out.tab",
#     "SRR6368616ReadsPerGene.out.tab", "SRR6368617ReadsPerGene.out.tab")
# prepareJunctionQuant("SRR6368612SJ.out.tab", "SRR6368613SJ.out.tab",
#                      "SRR6368614SJ.out.tab", "SRR6368615SJ.out.tab",
#                      "SRR6368616SJ.out.tab", "SRR6368617SJ.out.tab")

## ----eval=FALSE---------------------------------------------------------------
# library(psichomics)
# data <- loadLocalFiles("/path/to/psichomics/input")
# names(data)
# names(data[[1]])
# 
# junctionQuant  <- data[[1]]$`Junction quantification`
# sampleInfo     <- data[[1]]$`Sample metadata`
# # Both gene read counts and cRPKMs are loaded as separate data frames
# geneReadCounts <- data[[1]]$`Gene expression (read counts)`
# cRPKM          <- data[[1]]$`Gene expression (cRPKM)`

## ----eval=FALSE---------------------------------------------------------------
# library(psichomics)
# psichomics()

## ----eval=FALSE---------------------------------------------------------------
# library(psichomics)
# data <- loadLocalFiles("/path/to/psichomics/input")
# names(data)
# names(data[[1]])
# 
# geneExpr      <- data[[1]]$`Gene expression`
# junctionQuant <- data[[1]]$`Junction quantification`
# sampleInfo    <- data[[1]]$`Sample metadata`

