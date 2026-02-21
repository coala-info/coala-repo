# Code example from 'astrocyte_map_v2' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(multiWGCNA)

## -----------------------------------------------------------------------------
# Download data from the ExperimentHub
library(ExperimentHub)
eh = ExperimentHub()

# Note: this requires the SummarizedExperiment package to be installed
eh_query = query(eh, c("multiWGCNAdata"))
astrocyte_se = eh_query[["EH8223"]]

# Collect the metadata in the sampleTable; the first column must be named "Sample"
sampleTable = colData(astrocyte_se)

# Check the data
assays(astrocyte_se)[[1]][1:5, 1:5]
sampleTable

# Define our conditions for trait 1 (disease) and 2 (brain region)
conditions1 = unique(sampleTable[,2])
conditions2 = unique(sampleTable[,3])

## ----eval = FALSE-------------------------------------------------------------
# # Construct the combined networks and all the sub-networks (EAE, WT, and each region)
# # Same parameters as Tommasini and Fogel. BMC Bioinformatics
# astrocyte_networks = constructNetworks(astrocyte_se, sampleTable, conditions1, conditions2,
#                                   networkType = "signed", TOMType = "unsigned",
#                                   power = 12, minModuleSize = 100, maxBlockSize = 25000,
#                                   reassignThreshold = 0, minKMEtoStay = 0, mergeCutHeight = 0,
#                                   numericLabels = TRUE, pamRespectsDendro = FALSE,
#                                   deepSplit = 4, verbose = 3)
# 

## -----------------------------------------------------------------------------
# Load pre-computed astrocyte networks
astrocyte_networks = eh_query[["EH8222"]] 

# Check one of the WGCNA objects
astrocyte_networks[["combined"]]

## ----fig.height = 5, fig.width = 8--------------------------------------------
# Save results to a list
results = list()
results$overlaps = iterate(astrocyte_networks, overlapComparisons, plot=FALSE)

# Check the overlaps, ie between the EAE and wildtype networks
head(results$overlaps$EAE_vs_WT$overlap)

## ----fig.height = 6, fig.width = 7--------------------------------------------
# Run differential module expression analysis (DME) on combined networks
results$diffModExp = runDME(astrocyte_networks[["combined"]], 
                            sampleTable,
                            p.adjust = "fdr", 
                            refCondition = "Region", 
                            testCondition = "Disease") 
                            # plot=TRUE, 
                            # out="ANOVA_DME.pdf")

# Check results sorted by disease association FDR
results$diffModExp[order(results$diffModExp$Disease),]

# You can check the expression of module M13 from Tommasini and Fogel. BMC Bioinformatics. 2023 like this. Note that the values reported in the bottom panel title are p-values and not adjusted for multiple comparisons like in results$diffModExp
diffModuleExpression(astrocyte_networks[["combined"]], 
                     geneList = topNGenes(astrocyte_networks[[1]], "combined_013"), 
                     design = sampleTable,
                     test = "ANOVA",
                     plotTitle = "combined_013",
                     plot = TRUE)


## ----fig.height = 6, fig.width = 7--------------------------------------------
drawMultiWGCNAnetwork(astrocyte_networks, 
                      results$overlaps, 
                      "combined_013", 
                      design = sampleTable, 
                      overlapCutoff = 0, 
                      padjCutoff = 1, 
                      removeOutliers = TRUE, 
                      alpha = 1e-50, 
                      layout = NULL, 
                      hjust = 0.4, 
                      vjust = 0.3, 
                      width = 0.5)

## ----fig.height = 8, fig.width = 10-------------------------------------------
bidirectionalBestMatches(results$overlaps$combined_vs_EAE)

## ----fig.height=5, fig.width=7------------------------------------------------
# Get expression data for top 20 genes in EAE_015 module
datExpr = GetDatExpr(astrocyte_networks[[1]], 
                     genes = topNGenes(astrocyte_networks$EAE, "EAE_015", 20))

# Plot
coexpressionLineGraph(datExpr, splitBy = 1.5, fontSize = 2.5) + 
  geom_vline(xintercept = 20.5, linetype='dashed')

## ----eval = FALSE, fig.height = 3, fig.width = 7------------------------------
# # To enable multi-threading
# # library(doParallel)
# # library(WGCNA)
# # nCores = 2
# # registerDoParallel(cores = nCores)
# # enableWGCNAThreads(nThreads = nCores)
# 
# # Turn off multi-threading
# # registerDoSEQ()
# # disableWGCNAThreads()
# 
# # Calculate preservation statistics
# results$preservation=iterate(astrocyte_networks[c("EAE", "WT")],
#                              preservationComparisons,
#                              write=FALSE,
#                              plot=TRUE,
#                              nPermutations=2)

## ----eval = FALSE-------------------------------------------------------------
# options(paged.print = FALSE)
# results$permutation.test = PreservationPermutationTest(astrocyte_networks$combined@datExpr[sample(17000,3000),],
#                                                        sampleTable,
#                                                        constructNetworksIn = "EAE", # Construct networks using EAE samples
#                                                        testPreservationIn = "WT", # Test preservation of disease samples in WT samples
#                                                        nPermutations = 10, # Number of permutations for permutation test
#                                                        nPresPermutations = 10, # Number of permutations for modulePreservation function
# 
#                                                        # WGCNA parameters for re-sampled networks (should be the same as used for network construction)
#                                                        networkType = "signed", TOMType = "unsigned",
#                                                        power = 12, minModuleSize = 100, maxBlockSize = 25000,
#                                                        reassignThreshold = 0, minKMEtoStay = 0, mergeCutHeight = 0,
#                                                        numericLabels = TRUE, pamRespectsDendro = FALSE,
#                                                        deepSplit = 4, verbose = 3
#                                                        )

## ----eval = TRUE--------------------------------------------------------------
# Load pre-computed results
data(permutationTestResults) 

# Remove outlier modules
permutationTestResultsFiltered = lapply(permutationTestResults, function(x) x[!x$is.outlier.module,])

# Extract the preservation score distribution
results$scores.summary = PreservationScoreDistribution(permutationTestResultsFiltered, 
                                                       moduleOfInterestSize = 303 # The size of the module of interest (dM15)
                                                       )

# Observed preservation score of dM15
observed.score = 9.16261490617938

# How many times did we observe a score lower than or equal to this observed score?
z.summary.dist = results$scores.summary$z.summary
below=length(z.summary.dist[z.summary.dist <= observed.score])
probability= below/100
message("Probability of observing a score of ", round(observed.score, 2), " is ", probability)

## ----eval = TRUE--------------------------------------------------------------
# Plot on a histogram
ggplot(results$scores.summary, aes(x=z.summary)) + 
      geom_histogram(color="black", fill="white", bins = 15)+
      xlab("Preservation score")+
      ylab("Frequency")+
      geom_vline(xintercept=observed.score, color="red3", linetype="solid")+
      scale_y_continuous(expand = c(0,0))+
      theme_classic()+
      theme(plot.title = element_text(hjust = 0.5))

## -----------------------------------------------------------------------------
sessionInfo()

