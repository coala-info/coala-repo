# Code example from 'PhenoGeneRanker' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(PhenoGeneRanker)

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("PhenoGeneRanker")
# library(PhenoGeneRanker)

## -----------------------------------------------------------------------------
inputDf <- read.table(system.file("extdata", "input_file.txt", package = "PhenoGeneRanker"), header=TRUE, sep="\t", stringsAsFactors = FALSE)
print(inputDf)

## -----------------------------------------------------------------------------
geneLayerDf <- read.table(system.file("extdata", inputDf$file_name[1], package = "PhenoGeneRanker"), header=TRUE, sep="\t", stringsAsFactors = FALSE)
print(head(geneLayerDf))

## -----------------------------------------------------------------------------
ptypeLayerDf <- read.table(system.file("extdata", inputDf$file_name[3], package = "PhenoGeneRanker"), header=TRUE, sep="\t", stringsAsFactors = FALSE)
print(head(ptypeLayerDf))

## -----------------------------------------------------------------------------
biLayerDf <- read.table(system.file("extdata", inputDf$file_name[5], package = "PhenoGeneRanker"), header=TRUE, sep="\t", stringsAsFactors = FALSE)
print(head(biLayerDf))

## -----------------------------------------------------------------------------
# Generate walk matrix for RandomWalkWithRestart function use
walkMatrix <- CreateWalkMatrix('input_file.txt')

## -----------------------------------------------------------------------------
# accesses the walk matrix itself
wm <- walkMatrix[["WM"]] 

# sorted genes in the final network
sortedGenes <- walkMatrix[["genes"]] 

# sorted phenotypes in the final network
sortedPhenotypes <- walkMatrix[["phenotypes"]] 

# the degree of genes in the final network
geneConnectivity <- walkMatrix[["gene_connectivity"]] 

# the degree of phenotypes in the final network
phenotypeConnectivity <- walkMatrix[["phenotype_connectivity"]] 

# the number of gene layers
numberOfGeneLayers <- walkMatrix[["LG"]] 
print(numberOfGeneLayers)

# the number of phenotype layers
numberOfPhenotypeLayers <- walkMatrix[["LP"]] 
print(numberOfPhenotypeLayers)

# the number of genes in the network 
numberOfGenes <- walkMatrix[["N"]] 
print(numberOfGenes)

# the number of phenotypes in the network
numberOfPhenotypes <- walkMatrix[["M"]] 
print(numberOfPhenotypes)

## -----------------------------------------------------------------------------
# utilizes only gene seeds and generates p-values for ranks using 50 runs with random seeds
ranks <- RandomWalkRestart(walkMatrix, c('g1', 'g5'), c("p1"), S=50) 

print(head(ranks))

# utilizes gene and phenotype seeds and does not generate p-values.
ranks <- RandomWalkRestart(walkMatrix, c('g1'), c('p1', 'p2'), generatePValue=FALSE) 
print(head(ranks))

# utilizes only gene seeds, custom values for parameters r, eta, tau and phi for a complex network with two gene layers and two phenotype layers.
ranks <- RandomWalkRestart(walkMatrix, c('g1'), c(), TRUE, r=0.8, eta=0.6, tau=c(0.5,  1.5), phi=c(1.5, 0.5)) 
print(head(ranks))


