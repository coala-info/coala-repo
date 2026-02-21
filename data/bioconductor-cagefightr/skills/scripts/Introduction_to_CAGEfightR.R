# Code example from 'Introduction_to_CAGEfightR' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----bioconductor, eval=FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("CAGEfightR")

## ----library, results='hide', message=FALSE-----------------------------------
library(CAGEfightR)

## ----github, eval=FALSE-------------------------------------------------------
# devtools::install_github("MalteThodberg/CAGEfightR")

## ----citation, eval=TRUE------------------------------------------------------
citation("CAGEfightR")

## ----BigWig_files, results="hide", tidy=FALSE---------------------------------
# Load the example data
data("exampleDesign")
head(exampleDesign)

# Locate files on your harddrive
bw_plus <- system.file("extdata", 
                       exampleDesign$BigWigPlus, 
                       package = "CAGEfightR")
bw_minus <- system.file("extdata", 
                        exampleDesign$BigWigMinus,
                        package = "CAGEfightR")

# Create two named BigWigFileList-objects:
bw_plus <- BigWigFileList(bw_plus)
bw_minus <- BigWigFileList(bw_minus)
names(bw_plus) <- exampleDesign$Name
names(bw_minus) <- exampleDesign$Name

## ----quickCTSSs, tidy=FALSE---------------------------------------------------
# Get genome information
genomeInfo <- SeqinfoForUCSCGenome("mm9")

# Quantify CTSSs
CTSSs <- quantifyCTSSs(plusStrand=bw_plus,
                       minusStrand=bw_minus,
                       design=exampleDesign,
                       genome=genomeInfo)

## ----quickTSSs, tidy=FALSE----------------------------------------------------
TSSs <- quickTSSs(CTSSs)

## ----quickEnhancers, tidy=FALSE-----------------------------------------------
enhancers <- quickEnhancers(CTSSs)

## ----quickAnnotate, tidy=FALSE------------------------------------------------
# Use the built in annotation for mm9
library(TxDb.Mmusculus.UCSC.mm9.knownGene)
txdb <- TxDb.Mmusculus.UCSC.mm9.knownGene

# Annotate both TSSs and enhancers
TSSs <- assignTxType(TSSs, txModels=txdb)
enhancers <- assignTxType(enhancers, txModels=txdb)

## ----quickFilter, tidy=FALSE--------------------------------------------------
enhancers <- subset(enhancers, txType %in% c("intergenic", "intron"))

## ----quickCombine, tidy=FALSE-------------------------------------------------
# Add an identifier column
rowRanges(TSSs)$clusterType <- "TSS"
rowRanges(enhancers)$clusterType <- "enhancer"

# Combine TSSs and enhancers, discarding TSSs if they overlap enhancers
RSE <- combineClusters(TSSs, enhancers, removeIfOverlapping="object1")

## ----quickSupport, tidy=FALSE-------------------------------------------------
# Only keep features with more than 0 counts in more than 1 sample:
RSE <- subsetBySupport(RSE,
                       inputAssay = "counts",
                       outputColumn = "support",
                       unexpressed = 0,
                       minSamples = 1)

## ----quickGenes, tidy=FALSE---------------------------------------------------
gene_level <- quickGenes(RSE, geneModels = txdb)

## ----quickLinks, tidy=FALSE---------------------------------------------------
# Set TSSs as reference points
rowRanges(RSE)$clusterType <- factor(rowRanges(RSE)$clusterType,
                                     levels=c("TSS", "enhancer"))

# Find pairs and calculate kendall correlation between them
links <- findLinks(RSE, 
                   inputAssay="counts", 
                   maxDist=5000, 
                   directional="clusterType",
                   method="kendall")

## ----exampleCTSSs, tidy=FALSE-------------------------------------------------
data(exampleCTSSs)
exampleCTSSs

## ----dgCMatrix, tidy=FALSE----------------------------------------------------
head(assay(exampleCTSSs))

## ----GPos, tidy=FALSE---------------------------------------------------------
rowRanges(exampleCTSSs)

## ----calc, tidy=FALSE---------------------------------------------------------
exampleCTSSs <- calcTPM(exampleCTSSs, inputAssay="counts", outputAssay="TPM", outputColumn="subsetTags")

## ----libSizes, tidy=FALSE-----------------------------------------------------
# Library sizes
colData(exampleCTSSs)

# TPM values
head(assay(exampleCTSSs, "TPM"))

## ----preCalcTPM, tidy=FALSE---------------------------------------------------
exampleCTSSs <- calcTPM(exampleCTSSs, 
                        inputAssay="counts", 
                        totalTags="totalTags", 
                        outputAssay="TPM")
head(assay(exampleCTSSs, "TPM"))

## ----pooled, tidy=FALSE-------------------------------------------------------
# Library sizes
exampleCTSSs <- calcPooled(exampleCTSSs, inputAssay="TPM")
rowRanges(exampleCTSSs)

## ----support, tidy=FALSE------------------------------------------------------
# Count number of samples with MORE ( > ) than 0 counts:
exampleCTSSs <- calcSupport(exampleCTSSs, 
                            inputAssay="counts", 
                            outputColumn="support", 
                            unexpressed=0)
table(rowRanges(exampleCTSSs)$support)

## ----subset, tidy=FALSE-------------------------------------------------------
supportedCTSSs <- subset(exampleCTSSs, support > 1)
supportedCTSSs <- calcTPM(supportedCTSSs, totalTags="totalTags")
supportedCTSSs <- calcPooled(supportedCTSSs)

## ----naiveTC, tidy=FALSE------------------------------------------------------
simple_TCs <- clusterUnidirectionally(exampleCTSSs, 
                                     pooledCutoff=0, 
                                     mergeDist=20)

## ----tuning, tidy=FALSE-------------------------------------------------------
# Use a higher cutoff for clustering
higher_TCs <- clusterUnidirectionally(exampleCTSSs, 
                                     pooledCutoff=0.1, 
                                     mergeDist=20)

# Use CTSSs pre-filtered on support. 
prefiltered_TCs <- clusterUnidirectionally(supportedCTSSs, 
                                     pooledCutoff=0, 
                                     mergeDist=20)

## ----TCanatomy, tidy=FALSE----------------------------------------------------
simple_TCs

## ----bidirectionalClustering, tidy=FALSE--------------------------------------
BCs <- clusterBidirectionally(exampleCTSSs, balanceThreshold=0.95)

## ----enhancerAnatomy, tidy=FALSE----------------------------------------------
BCs

## ----bidirectionality, tidy=FALSE---------------------------------------------
# Calculate number of bidirectional samples
BCs <- calcBidirectionality(BCs, samples=exampleCTSSs)

# Summarize
table(BCs$bidirectionality)

## ----subsetBidirectionality, tidy=FALSE---------------------------------------
enhancers <- subset(enhancers, bidirectionality > 0)

## ----exampleClusters, tidy=FALSE----------------------------------------------
# Load the example datasets
data(exampleCTSSs)
data(exampleUnidirectional)
data(exampleBidirectional)

## ----quantifyClusters, tidy=FALSE---------------------------------------------
requantified_TSSs <- quantifyClusters(exampleCTSSs,
                                      clusters=rowRanges(exampleUnidirectional),
                                      inputAssay="counts")
requantified_enhancers <- quantifyClusters(exampleCTSSs,
                                           clusters=rowRanges(exampleBidirectional),
                                           inputAssay="counts")

## ----supportOnCounts, tidy=FALSE----------------------------------------------
# Only keep BCs expressed in more than one sample
supported_enhancers <- subsetBySupport(exampleBidirectional,
                                       inputAssay="counts",
                                       unexpressed=0,
                                       minSamples=1)

## ----supportOnTPM, tidy=FALSE-------------------------------------------------
# Calculate TPM using pre-calculated total tags:
exampleUnidirectional <- calcTPM(exampleUnidirectional, 
                                 totalTags = "totalTags")

# Only TSSs expressed at more than 1 TPM in more than 2 samples
exampleUnidirectional <- subsetBySupport(exampleUnidirectional,
                                         inputAssay="TPM",
                                         unexpressed=1,
                                         minSamples=2)

## ----txdb, tidy=FALSE---------------------------------------------------------
library(TxDb.Mmusculus.UCSC.mm9.knownGene)
txdb <- TxDb.Mmusculus.UCSC.mm9.knownGene
txdb

## ----assignTxID, tidy=FALSE---------------------------------------------------
exampleUnidirectional <- assignTxID(exampleUnidirectional,
                                    txModels=txdb,
                                    outputColumn="txID")

## ----multipleTxs, tidy=FALSE--------------------------------------------------
rowRanges(exampleUnidirectional)[5:6]

## ----assignTxType, tidy=FALSE-------------------------------------------------
exampleUnidirectional <- assignTxType(exampleUnidirectional,
                                      txModels=txdb,
                                      outputColumn="txType")

## ----swappedTxType, tidy=FALSE------------------------------------------------
exampleUnidirectional <- assignTxType(exampleUnidirectional,
                                      txModels=txdb,
                                      outputColumn="peakTxType",
                                      swap="thick")

## ----enhancerTxType, tidy=FALSE-----------------------------------------------
# Annotate with TxTypes
exampleBidirectional <- assignTxType(exampleBidirectional,
                                     txModels=txdb,
                                     outputColumn="txType")

# Only keep intronic and intergenic enhancers
exampleBidirectional <- subset(exampleBidirectional,
                               txType %in% c("intron", "intergenic"))

## ----calcIQR, tidy=FALSE------------------------------------------------------
# Recalculate pooled signal
exampleCTSSs <- calcTPM(exampleCTSSs, totalTags = "totalTags")
exampleCTSSs <- calcPooled(exampleCTSSs)

# Calculate shape
exampleUnidirectional <- calcShape(exampleUnidirectional,
                                   pooled=exampleCTSSs,
                                   outputColumn = "IQR",
                                   shapeFunction = shapeIQR,
                                   lower=0.25, upper=0.75)

## ----histIQR, tidy=FALSE------------------------------------------------------
hist(rowRanges(exampleUnidirectional)$IQR,
     breaks=max(rowRanges(exampleUnidirectional)$IQR),
     xlim=c(0,100), 
     xlab = "IQR", 
     col="red")

## ----customShape, tidy=FALSE--------------------------------------------------
# Write a function that quantifies the lean of a TSS
shapeLean <- function(x, direction){
	# Coerce to normal vector
	x <- as.vector(x)
	
	# Find highest position:
	i <- which.max(x)
	
	# Calculate sum
	i_total <- sum(x)
	
	# Calculate lean fraction
	if(direction == "right"){
		i_lean <- sum(x[i:length(x)])
	}else if(direction == "left"){
		i_lean <- sum(x[1:i])
	}else{
		stop("direction must be left or right!")
	}
	
	# Calculate lean
	o <- i_lean / i_total
	
	# Return
	o
}

# Calculate lean statistics, 
# additional arguments can be passed to calcShape via "..."
exampleUnidirectional <- calcShape(exampleUnidirectional, 
                                   exampleCTSSs,
                                   outputColumn="leanRight", 
                                   shapeFunction=shapeLean,
                                   direction="right")

exampleUnidirectional <- calcShape(exampleUnidirectional, 
                                   exampleCTSSs,
                                   outputColumn="leanLeft", 
                                   shapeFunction=shapeLean,
                                   direction="left")

## ----naiveLinks, tidy=FALSE---------------------------------------------------
library(InteractionSet)
TC_pairs <- findLinks(exampleUnidirectional, 
                      inputAssay="TPM", 
                      maxDist=10000, 
                      method="kendall")

TC_pairs

## ----TCBClinks, tidy=FALSE----------------------------------------------------
# Mark the type of cluster
rowRanges(exampleUnidirectional)$clusterType <- "TSS"
rowRanges(exampleBidirectional)$clusterType <- "enhancer"

# Merge the dataset
colData(exampleBidirectional) <- colData(exampleUnidirectional)
SE <- combineClusters(object1=exampleUnidirectional, 
                      object2=exampleBidirectional,
                      removeIfOverlapping="object1")

# Mark that we consider TSSs as the reference points
rowRanges(SE)$clusterType <- factor(rowRanges(SE)$clusterType,
                                    levels=c("TSS", "enhancer"))

# Recalculate TPM values
SE <- calcTPM(SE, totalTags="totalTags")

# Find link between the groups:
TCBC_pairs <- findLinks(SE, 
                      inputAssay="TPM",
                      maxDist=10000, 
                      directional="clusterType",
                      method="kendall")

TCBC_pairs

## ----superEnhancersGR, tidy=FALSE---------------------------------------------
stretches <- findStretches(exampleBidirectional, 
              inputAssay="counts",
              minSize=3,
              mergeDist=10000,
              method="spearman")
stretches

## ----superEnhancersGRL, tidy=FALSE--------------------------------------------
extractList(rowRanges(exampleBidirectional), stretches$revmap)

## ----geneSetup, tidy=FALSE----------------------------------------------------
# Load example TSS 
data(exampleUnidirectional)

# Keep only TCs expressed at more than 1 TPM in more than 2 samples:
exampleUnidirectional <- calcTPM(exampleUnidirectional, 
                                 totalTags = "totalTags")
exampleUnidirectional <- subsetBySupport(exampleUnidirectional,
                                         inputAssay="TPM",
                                         unexpressed=1,
                                         minSamples=2)

# Use the Bioconductor mm9 UCSC TxXb 
library(TxDb.Mmusculus.UCSC.mm9.knownGene)
txdb <- TxDb.Mmusculus.UCSC.mm9.knownGene

## ----geneModels, tidy=FALSE---------------------------------------------------
exampleUnidirectional <- assignGeneID(exampleUnidirectional,
                                      geneModels=txdb,
                                      outputColumn="geneID")

## ----symbols, tidy=FALSE------------------------------------------------------
# Use Bioconductor OrgDb package
library(org.Mm.eg.db)
odb <- org.Mm.eg.db

# Match IDs to symbols
symbols <- mapIds(odb,
                  keys=rowRanges(exampleUnidirectional)$geneID,
                  keytype="ENTREZID",
                  column="SYMBOL")

# Add to object
rowRanges(exampleUnidirectional)$symbol <- as.character(symbols)

## ----assignMissing, tidy=FALSE------------------------------------------------
exampleUnidirectional <- assignMissingID(exampleUnidirectional,
                                         outputColumn="symbol")

## ----quantifyGenes, tidy=FALSE------------------------------------------------
genelevel <- quantifyGenes(exampleUnidirectional, 
                           genes="geneID", 
                           inputAssay="counts")

## ----geneGRangesList, tidy=FALSE----------------------------------------------
rowRanges(genelevel)

## ----rowData, tidy=FALSE------------------------------------------------------
rowData(genelevel)

## ----calcComposition, tidy=FALSE----------------------------------------------
# Remove TSSs not belonging to any genes
intragenicTSSs <- subset(exampleUnidirectional, !is.na(geneID))

# Calculate composition: 
# The number of samples expressing TSSs above 10% of the total gene expression.
intragenicTSSs <- calcComposition(intragenicTSSs,
                                  outputColumn="composition",
                                  unexpressed=0.1,
                                  genes="geneID")

# Overview of composition values:
table(rowRanges(intragenicTSSs)$composition)

## ----subsetComposition, tidy=FALSE--------------------------------------------
# Remove TSSs with a composition score less than 3
intragenicTSSs <- subset(intragenicTSSs, composition > 2)

## ----GViz, tidy=FALSE---------------------------------------------------------
library(Gviz)

data("exampleCTSSs")
data("exampleUnidirectional")
data("exampleBidirectional")

## ----builtCTSStrack, tidy=FALSE-----------------------------------------------
# Calculate pooled CTSSs
exampleCTSSs <- calcTPM(exampleCTSSs, totalTags="totalTags")
exampleCTSSs <- calcPooled(exampleCTSSs)

# Built the track
pooled_track <- trackCTSS(exampleCTSSs, name="CTSSs")

## ----plotCTSStrack, tidy=FALSE------------------------------------------------
# Plot the main TSS of the myob gene
plotTracks(pooled_track, from=74601950, to=74602100, chromosome="chr18")

## ----clusterTrack, tidy=FALSE-------------------------------------------------
# Remove columns
exampleUnidirectional$totalTags <- NULL
exampleBidirectional$totalTags <- NULL

# Combine TSSs and enhancers, discarding TSSs if they overlap enhancers
CAGEclusters <- combineClusters(object1=exampleUnidirectional, 
                                object2=exampleBidirectional, 
                                removeIfOverlapping="object1")

# Only keep features with more than 0 counts in more than 2 samples
CAGEclusters <- subsetBySupport(CAGEclusters, 
                                inputAssay = "counts", 
                                unexpressed=0, 
                                minSamples=2)

# Build track
cluster_track <- trackClusters(CAGEclusters, name="Clusters", col=NA)

## ----plotClustertrack, tidy=FALSE---------------------------------------------
# Plot the main TSS of the myob gene
plotTracks(cluster_track, from=74601950, to=74602100, chromosome="chr18")

## ----prettybrowser, tidy=FALSE------------------------------------------------
# Genome axis tracks
axis_track <- GenomeAxisTrack()

# Transcript model track
library(TxDb.Mmusculus.UCSC.mm9.knownGene)
txdb <- TxDb.Mmusculus.UCSC.mm9.knownGene
tx_track <- GeneRegionTrack(txdb,
                            chromosome = "chr18",
                            name="Gene Models", 
                            col=NA, 
                            fill="bisque4", 
                            shape="arrow")

# Merge all tracks
all_tracks <- list(axis_track, tx_track, cluster_track, pooled_track)

# Plot the Hdhd2 gene
plotTracks(all_tracks, from=77182700, to=77184000, chromosome="chr18")

# Plot an intergenic enhancer
plotTracks(all_tracks, from=75582473, to=75582897, chromosome="chr18")

## ----prepareLinks, tidy=FALSE-------------------------------------------------
# Unstranded clusters are enhancers
rowRanges(CAGEclusters)$clusterType <- factor(ifelse(strand(CAGEclusters)=="*",
                                              "enhancer", "TSS"),
                                              levels=c("TSS", "enhancer"))

# Find links
links <- findLinks(CAGEclusters, 
                   inputAssay="counts", 
                   directional="clusterType",
                   method="kendall")

# Only look at positive correlation
links <- subset(links, estimate > 0)

## ----plotLinks, tidy=FALSE----------------------------------------------------
# Save as a track
all_tracks$links_track <- trackLinks(links, 
                          name="TSS-enhancer", 
                          col.interactions="black",
                          col.anchors.fill ="dimgray",
                          col.anchors.line = NA,
                          interaction.measure="p.value",
                          interaction.dimension.transform="log",
                          col.outside="grey")

# Plot region around 
plotTracks(all_tracks, 
           from=84255991-1000, 
           to=84255991+1000, 
           chromosome="chr18",
           sizes=c(1, 1, 1, 1, 2))

## ----parallel, tidy=FALSE, eval=FALSE-----------------------------------------
# library(BiocParallel)
# 
# # Setup for parallel execution with 3 threads:
# register(MulticoreParam(workers=3))
# 
# # Disable parallel execution
# register(SerialParam())

## ----sessionInfo, tidy=FALSE--------------------------------------------------
sessionInfo()

