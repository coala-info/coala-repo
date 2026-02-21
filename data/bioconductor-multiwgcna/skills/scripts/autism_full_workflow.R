# Code example from 'autism_full_workflow' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("multiWGCNA")

## ----eval=FALSE---------------------------------------------------------------
# if (!require("devtools", quietly = TRUE))
#     install.packages("devtools")
# 
# devtools::install_github("fogellab/multiWGCNA")

## -----------------------------------------------------------------------------
library(multiWGCNA)

## -----------------------------------------------------------------------------
# Download data from the ExperimentHub
library(ExperimentHub)
eh = ExperimentHub()

# Note: this requires the SummarizedExperiment package to be installed
eh_query = query(eh, c("multiWGCNAdata"))
autism_se = eh_query[["EH8219"]]

# Collect the metadata in the sampleTable
sampleTable = colData(autism_se)

# Randomly sample 1500 genes from the expression matrix
set.seed(1)
autism_se = autism_se[sample(rownames(autism_se), 1500),]

# Check the data
assays(autism_se)[[1]][1:5, 1:5]
# sampleTable$Status = paste0("test_", sampleTable$Status, "_test")
# sampleTable$Sample = paste0(sampleTable$Sample, "_test")
sampleTable

# Define our conditions for trait 1 (disease) and 2 (brain region)
conditions1 = unique(sampleTable[,2])
conditions2 = unique(sampleTable[,3])

## -----------------------------------------------------------------------------
# Construct the combined networks and all the sub-networks (autism only, controls only, FC only, and TC only)
autism_networks = constructNetworks(autism_se, sampleTable, conditions1, conditions2,
                                  networkType = "unsigned", power = 10,
                                  minModuleSize = 40, maxBlockSize = 25000,
                                  reassignThreshold = 0, minKMEtoStay = 0.7,
                                  mergeCutHeight = 0.10, numericLabels = TRUE,
                                  pamRespectsDendro = FALSE, verbose=3,
                                  saveTOMs = TRUE)

## ----fig.height = 4, fig.width = 7--------------------------------------------
# Save results to a list
results=list()
results$overlaps=iterate(autism_networks, overlapComparisons, plot=TRUE)

# Check the reciprocal best matches between the autism and control networks
head(results$overlaps$autism_vs_controls$bestMatches)

## ----fig.height=6, fig.width=4------------------------------------------------
networks = c("autism", "controls")
toms = lapply(networks, function(x) {
  load(paste0(x, '-block.1.RData'))
  get("TOM")
})

# Check module autism_005
TOMFlowPlot(autism_networks, 
            networks, 
            toms, 
            genes_to_label = topNGenes(autism_networks$autism, "autism_005"), 
            color = 'black', 
            alpha = 0.1, 
            width = 0.05)

## ----fig.height = 6, fig.width = 7--------------------------------------------
# Run differential module expression analysis (DME) on combined networks
results$diffModExp = runDME(autism_networks[["combined"]], 
                            sampleTable, 
                            p.adjust="fdr", 
                            refCondition="Tissue", 
                            testCondition="Status") 
                            # plot=TRUE, 
                            # out="combined_DME.pdf")

# to run PERMANNOVA
# library(vegan)
# results$diffModExp = runDME(autism_networks[["combined"]], p.adjust="fdr", refCondition="Tissue", 
#                          testCondition="Status", plot=TRUE, test="PERMANOVA", out="PERMANOVA_DME.pdf")

# Check adjusted p-values for the two sample traits
results$diffModExp

# You can check the expression of a specific module like this. Note that the values reported in the bottom panel title are p-values and not FDR-adjusted like in results$diffModExp
diffModuleExpression(autism_networks[["combined"]], 
                     geneList = topNGenes(autism_networks[["combined"]], "combined_004"), 
                     design = sampleTable,
                     test = "ANOVA",
                     plotTitle = "combined_004",
                     plot = TRUE)

## ----fig.height = 3, fig.width = 7--------------------------------------------
# To enable multi-threading
# library(doParallel)
# library(WGCNA)
# nCores = 8
# registerDoParallel(cores = nCores)
# enableWGCNAThreads(nThreads = nCores)

# Calculate preservation statistics
results$preservation=iterate(autism_networks[conditions1], # this does autism vs control; change to "conditions2" to perform comparison between FC and TC
                             preservationComparisons, 
                             write=FALSE, 
                             plot=TRUE, 
                             nPermutations=10)

## -----------------------------------------------------------------------------
# Print a summary of the results
summarizeResults(autism_networks, results)

## -----------------------------------------------------------------------------
sessionInfo()

