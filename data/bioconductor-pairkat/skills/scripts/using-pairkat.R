# Code example from 'using-pairkat' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# # install from bioconductor
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
# BiocManager::install("pairkat")

## ----message=F, warning = F, results='hide'-----------------------------------
# load pairkat library
library(pairkat)
data("smokers")

## ----message=F, warning = F---------------------------------------------------
phenotype <- SummarizedExperiment::colData(smokers)
head(phenotype)

## -----------------------------------------------------------------------------
pathways <- SummarizedExperiment::rowData(smokers)
head(pathways)[, 1:2]

## -----------------------------------------------------------------------------
metabolome <- SummarizedExperiment::assays(smokers)$metabolomics
head(metabolome)[, 1:3]

## -----------------------------------------------------------------------------
smokers <-
  SummarizedExperiment::SummarizedExperiment(
    assays = list(metabolomics = metabolome),
    rowData = pathways,
    colData = phenotype
  )

## -----------------------------------------------------------------------------
head(KEGGREST::keggList("organism"))[, 2:3]

## -----------------------------------------------------------------------------
networks <- GatherNetworks(
  SE = smokers,
  keggID = "kegg_id",
  species = "hsa",
  minPathwaySize = 5
)

## ----message = F, warning = F-------------------------------------------------
# run PaIRKAT
output <- PaIRKAT(log_FEV1_FVC_ratio ~ age, 
                  networks = networks)


## -----------------------------------------------------------------------------
# view formula call
output$call

# view results
results <- dplyr::arrange(output$results, p.value)
head(results)

## -----------------------------------------------------------------------------
plotNetworks(networks = networks, 
             pathway = "Glycerophospholipid metabolism")

## -----------------------------------------------------------------------------
sessionInfo()

