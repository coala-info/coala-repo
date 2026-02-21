# Code example from 'Installing_and_Using_BrainSABER' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ---- eval=FALSE--------------------------------------------------------------
#  # for R version >= 4.0
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("BrainSABER")

## ----loadpkg, message=FALSE, warning=FALSE, results='hide'--------------------
library(BrainSABER)

## ---- buildAIB----------------------------------------------------------------
# Extract dataset from online source or from local BiocCache
AIBSARNA <- buildAIBSARNA()

## ----getSampleData, message=FALSE, warning=FALSE, results='hide'--------------
# Obtain the sample indexes to use for subsetting (not random)
sample_idx <- 1:50 * 10 - 1
# Set the RNG seed for repeatable results
set.seed(8)
# Get the total number of genes available
totalGenes <- nrow(AIBSARNA)
# Sample the indices of 200 random genes
gene_idx <- sample.int(totalGenes, 200)

# Subset AIBSARNA
toy_exprs <- assay(AIBSARNA)[gene_idx, sample_idx]
toy_fd <- rowData(AIBSARNA)[gene_idx, ]
toy_pd <- colData(AIBSARNA)[sample_idx, ]

# Create toy CellScabbard
toySet <- CellScabbard(exprsData = toy_exprs, phenoData = toy_pd, 
                       featureData = toy_fd, AIBSARNA = AIBSARNA, 
                       autoTrim = TRUE)

## ----selectid1----------------------------------------------------------------
# Try comparing different identifiers
length(getExternalVector(toySet, index = 1, AIBSARNA = AIBSARNA, 
                         dataSetId = "gene_id", AIBSARNAid = "gene_id"))

## ----selectid2----------------------------------------------------------------
length(getExternalVector(toySet, index = 1, AIBSARNA = AIBSARNA, 
                         dataSetId = "ensembl_gene_id", 
                         AIBSARNAid = "ensembl_gene_id"))

## ----selectid3----------------------------------------------------------------
length(getExternalVector(toySet, index = 1, AIBSARNA = AIBSARNA, 
                         dataSetId = "gene_symbol", 
                         AIBSARNAid = "gene_symbol"))

## ----selectid4----------------------------------------------------------------
length(getExternalVector(toySet, index = 1, AIBSARNA = AIBSARNA, 
                         dataSetId = "entrez_id", AIBSARNAid = "entrez_id"))

## ----selectid5----------------------------------------------------------------
length(getExternalVector(toySet, index = 1, AIBSARNA = AIBSARNA, 
                         dataSetId = "refseq_ids", AIBSARNAid = "refseq_ids"))


## ----filterData---------------------------------------------------------------
trimmed_toySet <- getTrimmedExternalSet(dataSet = toySet, 
                                        dataSetId = "ensembl_gene_id",
                                        AIBSARNA = AIBSARNA, 
                                        AIBSARNAid = "ensembl_gene_id")

## ----getRelevantGenes---------------------------------------------------------
trimmed_AIBSARNA <- getRelevantGenes(data = toySet, 
                                     dataSetId = "ensembl_gene_id",
                                     AIBSARNA = AIBSARNA,
                                     AIBSARNAid = "ensembl_gene_id")

# Or extract the results directly from our toySet
autotrim_AIBSARNA <- relevantGenes(toySet)

## ----getSimScores-------------------------------------------------------------
# Using manually filtered data sets
euc_sim <- getSimScores(data = trimmed_toySet, 
                         relevantGenes = trimmed_AIBSARNA,
                         similarity_method = "euclidean")
cos_sim <- getSimScores(data = trimmed_toySet, 
                         relevantGenes = trimmed_AIBSARNA,
                         similarity_method = "cosine")

# Or using the auto-trimmed toySet
auto_euc_sim <- getSimScores(data = toySet, similarity_method = "euclidean")
auto_cos_sim <- getSimScores(data = toySet, similarity_method = "cosine")

## ----getAS, results = 'hide'--------------------------------------------------
# Using manually filtered data scores
euc_mats <- getSimMatrix(sim_score = euc_sim, relevantGenes = trimmed_AIBSARNA)
euc_df <- getSimDataFrame(sim_score = euc_sim, 
                          relevantGenes = trimmed_AIBSARNA,
                          similarity_method = "euclidean")
cos_mats <- getSimMatrix(sim_score = cos_sim, relevantGenes = trimmed_AIBSARNA)
cos_df <- getSimDataFrame(sim_score = cos_sim, 
                          relevantGenes = trimmed_AIBSARNA,
                          similarity_method = "cosine")

# Or using the auto-trimmed data scores
# first store the data in the toySet, then call the similarity functions
similarityScores(toySet) <- auto_euc_sim
auto_euc_mats <- getSimMatrix(data = toySet)
auto_euc_df <- getSimDataFrame(data = toySet, similarity_method = "euclidean")
# to determine cosine similarity, reset the similarityScores data and then call similarity functions
similarityScores(toySet) <- auto_cos_sim
auto_cos_mats <- getSimMatrix(data = toySet)
auto_cos_df <- getSimDataFrame(data = toySet, similarity_method = "cosine")

# Store results of euclidean testing in the toySet
similarityMatrices(toySet) <- auto_euc_mats
similarityDFs(toySet) <- auto_euc_df

## ----viewsimdf----------------------------------------------------------------
head(cos_df[[1]])

## ----genHeatmap---------------------------------------------------------------
library(heatmaply)
heatmaply(euc_mats[[1]])

## ----getundnum----------------------------------------------------------------
und_num <- getUNDmatrix(dataSet = trimmed_toySet, 
                        relevantGenes = trimmed_AIBSARNA, 
                        method = "log2fc",
                        matrix_type = "num")
und_num[[1]][1:10, 1:10]

## ----getundchar---------------------------------------------------------------
und_char <- getUNDmatrix(dataSet = trimmed_toySet, 
                        relevantGenes = trimmed_AIBSARNA, 
                        method = "log2fc",
                        matrix_type = "char")
und_char[[1]][1:10, 1:10]

# Or using the auto-trimmed toySet
auto_und_num <- getUNDmatrix(dataSet = toySet, method = "log2fc", matrix_type = "num")
auto_und_char <- getUNDmatrix(dataSet = toySet, method = "log2fc", matrix_type = "char")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

