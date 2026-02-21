# Code example from 'PanomiR' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----installation_bioc, eval = FALSE------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("PanomiR")

## ----installation_git, eval = FALSE-------------------------------------------
# devtools::install_github("pouryany/PanomiR")

## ----load_package-------------------------------------------------------------
library(PanomiR)

# Pathway reference from the PanomiR package
data("path_gene_table")
data("miniTestsPanomiR")
# Generating pathway summary statistics 

summaries <- pathwaySummary(miniTestsPanomiR$mini_LIHC_Exp,
                            path_gene_table, method = "x2",
                            zNormalize = TRUE, id = "ENSEMBL")

head(summaries)[,1:2]

## ----differential-------------------------------------------------------------

output0 <- differentialPathwayAnalysis(
                        geneCounts = miniTestsPanomiR$mini_LIHC_Exp,
                        pathways =  path_gene_table,
                        covariates = miniTestsPanomiR$mini_LIHC_Cov,
                        condition = 'shortLetterCode')

de.paths <- output0$DEP

head(de.paths,3)

## ----pcxn---------------------------------------------------------------------


# using an updated version of pcxn 

set.seed(2)
pathwayClustsLIHC <- mappingPathwaysClusters(
                            pcxn = miniTestsPanomiR$miniPCXN, 
                            dePathways = de.paths[1:300,],
                            topPathways = 200,
                            outDir=".",
                            plot = FALSE,
                            subplot = FALSE,
                            prefix='',
                            clusteringFunction = "cluster_louvain",
                            correlationCutOff = 0.1)


head(pathwayClustsLIHC$Clustering)


## ----miRNA--------------------------------------------------------------------

set.seed(1)
output2 <- prioritizeMicroRNA(enriches0 = miniTestsPanomiR$miniEnrich,
                    pathClust = miniTestsPanomiR$miniPathClusts$Clustering,
                    topClust = 1,
                    sampRate = 50, 
                    method = c("aggInv"),
                    outDir = "Output/",
                    dataDir = "outData/",
                    saveSampling = FALSE,
                    runJackKnife = FALSE,
                    numCores = 1,
                    prefix = "outmiR",
                    saveCSV = FALSE)

head(output2$Cluster1)


## ----customized_mir, eval = FALSE---------------------------------------------
# 
# 
# # using an updated version of pcxn
# data("msigdb_c2")
# data("targetScan_03")
# 
# 
# customeTableEnrich <- miRNAPathwayEnrichment(mirSets = targetScan_03,
#                                               pathwaySets = msigdb_c2,
#                                               geneSelection = yourGenes,
#                                               mirSelection = yourMicroRNAs,
#                                               fromID = "ENSEMBL",
#                                               toID = "ENTREZID",
#                                               minPathSize = 9,
#                                               numCores = 1,
#                                               outDir = ".",
#                                               saveOutName = NULL)
# 

## ----customized_mir2----------------------------------------------------------

# using an updated version of pcxn 
data("msigdb_c2")
data("targetScan_03")

tempEnrich <-miRNAPathwayEnrichment(targetScan_03[1:30],msigdb_c2[1:30])

head(reportEnrichment(tempEnrich))

## ----customized_gsc-----------------------------------------------------------
data("gscExample")

newPathGeneTable <-tableFromGSC(gscExample)


## ----customized_gsc2, eval = FALSE--------------------------------------------
# 
# library(GSEABase)
# 
# yourGeneSetCollection <- getGmt("YOUR GMT FILE")
# newPathGeneTable      <- tableFromGSC(yourGeneSetCollection)
# 

## ----sessionInfo--------------------------------------------------------------
sessionInfo()


