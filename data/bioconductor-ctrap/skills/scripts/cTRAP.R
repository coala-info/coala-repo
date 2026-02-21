# Code example from 'cTRAP' vignette. See references/ for full tutorial.

## ----load package-------------------------------------------------------------
library(cTRAP)

## ----load ENCODE samples, eval=FALSE------------------------------------------
# gene <- "EIF4G1"
# cellLine <- "HepG2"
# 
# ENCODEmetadata <- downloadENCODEknockdownMetadata(cellLine, gene)
# table(ENCODEmetadata$`Experiment target`)
# length(unique(ENCODEmetadata$`Experiment target`))
# 
# ENCODEsamples <- loadENCODEsamples(ENCODEmetadata)[[1]]
# counts <- prepareENCODEgeneExpression(ENCODEsamples)

## ----load data, include=FALSE-------------------------------------------------
data("ENCODEmetadata")
data("counts")

## ----differential gene expression, eval=FALSE---------------------------------
# # Remove low coverage (at least 10 counts shared across two samples)
# minReads   <- 10
# minSamples <- 2
# filter <- rowSums(counts[ , -c(1, 2)] >= minReads) >= minSamples
# counts <- counts[filter, ]
# 
# # Convert ENSEMBL identifier to gene symbol
# counts$gene_id <- convertGeneIdentifiers(counts$gene_id)
# 
# # Perform differential gene expression analysis
# diffExpr <- performDifferentialExpression(counts)

## ----t-statistics, eval=FALSE-------------------------------------------------
# # Get t-statistics of differential expression with respective gene names
# # (expected input for downstream analyses)
# diffExprStat <- diffExpr$t
# names(diffExprStat) <- diffExpr$Gene_symbol

## ----echo=FALSE---------------------------------------------------------------
data("diffExprStat")

## ----CMap metadata conditions-------------------------------------------------
# Load CMap metadata (automatically downloaded if not found)
cmapMetadata <- loadCMapData("cmapMetadata.txt", type="metadata")

# Summarise conditions for all CMap perturbations
getCMapConditions(cmapMetadata)

# Summarise conditions for CMap perturbations in HepG2 cell line
getCMapConditions(cmapMetadata, cellLine="HepG2")

# Summarise conditions for a specific CMap perturbation in HepG2 cell line
getCMapConditions(
    cmapMetadata, cellLine="HepG2",
    perturbationType="Consensus signature from shRNAs targeting the same gene")

## ----CMap knockdown perturbations, eval=FALSE---------------------------------
# # Filter CMap gene knockdown HepG2 data to be loaded
# cmapMetadataKD <- filterCMapMetadata(
#     cmapMetadata, cellLine="HepG2",
#     perturbationType="Consensus signature from shRNAs targeting the same gene")
# 
# # Load filtered data (data will be downloaded if not found)
# cmapPerturbationsKD <- prepareCMapPerturbations(
#     metadata=cmapMetadataKD, zscores="cmapZscores.gctx",
#     geneInfo="cmapGeneInfo.txt")

## ----CMap small molecule perturbations, eval=FALSE----------------------------
# # Filter CMap gene small molecule HepG2 data to be loaded
# cmapMetadataCompounds <- filterCMapMetadata(
#     cmapMetadata, cellLine="HepG2", perturbationType="Compound")
# 
# # Load filtered data (data will be downloaded if not found)
# cmapPerturbationsCompounds <- prepareCMapPerturbations(
#     metadata=cmapMetadataCompounds, zscores="cmapZscores.gctx",
#     geneInfo="cmapGeneInfo.txt", compoundInfo="cmapCompoundInfo.txt")

## ----load CMap perturbations, include=FALSE-----------------------------------
data("cmapPerturbationsKD")
data("cmapPerturbationsCompounds")
cmapPerturbationsCompounds <- cmapPerturbationsCompounds[
    , grep("HEPG2", colnames(cmapPerturbationsCompounds))]

## ----compare knockdown, message=FALSE-----------------------------------------
compareKD <- rankSimilarPerturbations(diffExprStat, cmapPerturbationsKD)

## ----compare small molecules, message=FALSE-----------------------------------
compareCompounds <- rankSimilarPerturbations(diffExprStat, 
                                             cmapPerturbationsCompounds)

## ----order knockdown perturbation comparison, fig.width=6, fig.asp=1----------
# Most positively associated perturbations (note that EIF4G1 knockdown is the
# 7th, 1st and 2nd most positively associated perturbation based on Spearman's
# correlation, Pearson's correlation and GSEA, respectively)
head(compareKD[order(spearman_rank)], n=10)
head(compareKD[order(pearson_rank)])
head(compareKD[order(GSEA_rank)])
head(compareKD[order(rankProduct_rank)])

# Most negatively associated perturbations
head(compareKD[order(-spearman_rank)])
head(compareKD[order(-pearson_rank)])
head(compareKD[order(-GSEA_rank)])
head(compareKD[order(-rankProduct_rank)])

# Plot list of compared pertubations
plot(compareKD, "spearman", n=c(10, 3))
plot(compareKD, "pearson")
plot(compareKD, "gsea")
plot(compareKD, "rankProduct")

## ----order small molecule perturbation comparison, fig.width=6, fig.asp=1-----
# Most positively and negatively associated perturbations
compareCompounds[order(rankProduct_rank)]
plot(compareCompounds, "rankProduct")

## ----perturbation info, fig.width=5, fig.asp=1--------------------------------
# Information on the EIF4G1 knockdown perturbation
EIF4G1knockdown <- grep("EIF4G1", compareKD[[1]], value=TRUE)
print(compareKD, EIF4G1knockdown)

# Information on the top 10 most similar compound perturbations (based on
# Spearman's correlation)
print(compareKD[order(rankProduct_rank)], 1:10)

# Get table with all information available (including ranks, metadata, compound
# information, etc.)
table <- as.table(compareKD)
head(table)

# Obtain available raw information from compared perturbations
names(attributes(compareKD)) # Data available in compared perturbations
attr(compareKD, "metadata")  # Perturbation metadata
attr(compareKD, "geneInfo")  # Gene information

## ----echo=FALSE---------------------------------------------------------------
attr(compareKD, "zscoresFilename") <- cmapPerturbationsKD

## ----plot knockdown comparison, message=FALSE, fig.width=5, fig.asp=1---------
# Plot relationship with EIF4G1 knockdown from CMap
plot(compareKD, EIF4G1knockdown, "spearman")
plot(compareKD, EIF4G1knockdown, "pearson")
plot(compareKD, EIF4G1knockdown, "gsea")

# Plot relationship with most negatively associated perturbation
plot(compareKD, compareKD[order(-spearman_rank)][1, 1], "spearman")
plot(compareKD, compareKD[order(-pearson_rank)][1, 1], "pearson")
plot(compareKD, compareKD[order(-GSEA_rank)][1, 1], "gsea")

## ----echo=FALSE---------------------------------------------------------------
attr(compareCompounds, "zscoresFilename") <- cmapPerturbationsCompounds

## ----plot small molecule comparison, message=FALSE, fig.width=5, fig.asp=1----
# Plot relationship with most positively associated perturbation
plot(compareCompounds, compareCompounds[order(spearman_rank)][1, 1], "spearman")
plot(compareCompounds, compareCompounds[order(pearson_rank)][1, 1], "pearson")
plot(compareCompounds, compareCompounds[order(GSEA_rank)][1, 1], "gsea")

# Plot relationship with most negatively associated perturbation
plot(compareCompounds, compareCompounds[order(-spearman_rank)][1,1], "spearman")
plot(compareCompounds, compareCompounds[order(-pearson_rank)][1, 1], "pearson")
plot(compareCompounds, compareCompounds[order(-GSEA_rank)][1, 1], "gsea")

## ----fig.width=5, fig.asp=1---------------------------------------------------
listExpressionDrugSensitivityAssociation()
ctrp      <- listExpressionDrugSensitivityAssociation()[[2]]
assoc     <- loadExpressionDrugSensitivityAssociation(ctrp)
predicted <- predictTargetingDrugs(diffExprStat, assoc)
plot(predicted, method="rankProduct")

# Plot results for a given drug
plot(predicted, predicted[[1, 1]], method="spearman")
plot(predicted, predicted[[1, 1]], method="gsea")

## ----fig.width=5, fig.asp=1---------------------------------------------------
# Label by compound name
plotTargetingDrugsVSsimilarPerturbations(
  predicted, compareCompounds, column="spearman_rank")
# Label by compound's gene target
plotTargetingDrugsVSsimilarPerturbations(
  predicted, compareCompounds, column="spearman_rank", labelBy="target")
# Label by compound's mechanism of action (MOA)
plotTargetingDrugsVSsimilarPerturbations(
  predicted, compareCompounds, column="spearman_rank", labelBy="moa")

## ----drug set enrichment analysis, fig.width=5, fig.asp=1---------------------
descriptors <- loadDrugDescriptors("CMap", "2D")
drugSets    <- prepareDrugSets(descriptors)
dsea        <- analyseDrugSetEnrichment(drugSets, predicted)
# Plot the 6 most significant drug set enrichment results
plotDrugSetEnrichment(drugSets, predicted,
                      selectedSets=head(dsea$descriptor, 6))

