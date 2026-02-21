# Code example from 'OUTRIDER' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, cache=FALSE, results="asis"-------
BiocStyle::latex()

## ----knitr, echo=FALSE, cache=FALSE, results="hide"------------------------
library(knitr)
opts_chunk$set(
    tidy=FALSE,
    dev="png",
    fig.width=7,
    fig.height=7,
    dpi=300,
    message=FALSE,
    warning=FALSE,
    cache=TRUE
)

## ----include=FALSE---------------------------------------------------------
opts_chunk$set(concordance=TRUE)

## ----hiden_config, echo=FALSE----------------------------------------------
suppressPackageStartupMessages({
    library(OUTRIDER)
    library(beeswarm)
})
if(!is(bpparam(), "SerialParam")){
    bp <- bpparam()
    bpworkers(bp) <- min(4, bpworkers(bp))
    register(bp)
}

## ----deVsOutlier, echo=FALSE, fig.height=5, fig.cap="Scheme of workflow differences. Differences between differential gene expression analysis and outlier detection."----
par.old <- par(no.readonly=TRUE)
par(mfrow=c(1,2), cex=1.2)
ylim <- c(80, 310)
a <- rnorm(10, 250, 10)
b <- rnorm(10, 120, 10)
c <- rnorm(100, 250, 20)
c[1] <- 105
beeswarm(list(A=a, B=b), 
        main="Differential\nexpression analysis\n(DESeq2/edgeR)",
        xlab="Condition", ylab="Expression", ylim=ylim, pch=20, 
        col=c("darkblue", "firebrick"))
beeswarm(c, main="Outlier\ndetection\n(OUTRIDER)", ylim=ylim, pch=20, 
        xlab="Population", ylab="Expression", col="firebrick")

par(par.old)

## ----quick_guide, fig.height=5---------------------------------------------
library(OUTRIDER)

# get data
ctsFile <- system.file('extdata', 'KremerNBaderSmall.tsv', 
        package='OUTRIDER')
ctsTable <- read.table(ctsFile, check.names=FALSE)
ods <- OutriderDataSet(countData=ctsTable)

# filter out non expressed genes
ods <- filterExpression(ods, minCounts=TRUE, filterGenes=TRUE)

# run full OUTRIDER pipeline (control, fit model, calculate P-values)
ods <- OUTRIDER(ods)

# results (only significant)
res <- results(ods)
head(res)

# example of a Q-Q plot for the most significant outlier
plotQQ(ods, res[1, geneID])

## ----GetDataSet------------------------------------------------------------
# small testing data set
odsSmall <- makeExampleOutriderDataSet(dataset="Kremer")

# full data set from Kremer et al.
baseURL <- paste0("https://static-content.springer.com/esm/", 
        "art%3A10.1038%2Fncomms15824/MediaObjects/")
count_URL <- paste0(baseURL, "41467_2017_BFncomms15824_MOESM390_ESM.txt")
anno_URL  <- paste0(baseURL, "41467_2017_BFncomms15824_MOESM397_ESM.txt")

ctsTable <- read.table(count_URL, sep="\t")
annoTable <- read.table(anno_URL, sep="\t", header=TRUE)
annoTable$sampleID <- annoTable$RNA_ID

# create OutriderDataSet object
ods <- OutriderDataSet(countData=ctsTable, colData=annoTable)

## ----Preprocessing, fig.height=5-------------------------------------------
# get annotation
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(org.Hs.eg.db)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
map <- select(org.Hs.eg.db, keys=keys(txdb, keytype = "GENEID"), 
        keytype="ENTREZID", columns=c("SYMBOL"))

## ----create txdb, eval=FALSE-----------------------------------------------
# try({
#     library(RMariaDB)
#     library(AnnotationDbi)
#     con <- dbConnect(MariaDB(), host='genome-mysql.cse.ucsc.edu',
#             dbname="hg19", user='genome')
#     map <- dbGetQuery(con, 'select kgId AS TXNAME, geneSymbol from kgXref')
# 
#     txdbUrl <- paste0("https://cmm.in.tum.de/public/",
#             "paper/mitoMultiOmics/ucsc.knownGenes.db")
#     download.file(txdbUrl, "ucsc.knownGenes.db")
#     txdb <- loadDb("ucsc.knownGenes.db")
# 
# })

## ----filtering, fig.height=5-----------------------------------------------
# calculate FPKM values and label not expressed genes
ods <- filterExpression(ods, txdb, mapping=map, 
        filterGenes=FALSE, savefpkm=TRUE)

# display the FPKM distribution of counts.
plotFPKM(ods)

# display gene filter summary statistics 
plotExpressedGenes(ods)

# do the actual subsetting based on the filtering labels
ods <- ods[mcols(ods)$passedFilter,]

## ----plotting_between_sample_correlations----------------------------------

# Heatmap of the sample correlation
# it can also annotate the clusters resulting from the dendrogram
ods <- plotCountCorHeatmap(ods, colGroups=c("SEX", "RNA_HOX_GROUP"),
        normalized=FALSE, nRowCluster=4)

# Heatmap of the gene/sample expression
ods <- plotCountGeneSampleHeatmap(ods, colGroups=c("SEX", "RNA_HOX_GROUP"),
        normalized=FALSE, nRowCluster=4)


## ----controlling_for_confounders-------------------------------------------

# automatically control for confounders
# we use only 3 iterations to make the vignette faster. The default is 15. 
ods <- estimateSizeFactors(ods)
ods <- controlForConfounders(ods, q=21, iterations=3)

# Heatmap of the sample correlation after controlling
ods <- plotCountCorHeatmap(ods, normalized=TRUE, 
        colGroups=c("SEX", "RNA_HOX_GROUP"))


## ----estimateBestQ, eval=FALSE---------------------------------------------
# # Optimal Hard Thresholding (default)
# ods <- estimateBestQ(ods)
# 
# # Hyperparameter Optimization
# ods <- estimateBestQ(ods, useOHT=FALSE)
# 
# # visualize the estimation of the optimal encoding dimension
# plotEncDimSearch(ods)
# 

## ----maskSamples-----------------------------------------------------------

# set exclusion mask
sampleExclusionMask(ods) <- FALSE
sampleExclusionMask(ods[,"MUC1365"]) <- TRUE

# check which samples are excluded from the autoencoder fit
sampleExclusionMask(ods)


## ----fitting, eval=FALSE---------------------------------------------------
# 
# # fit the model when alternative methods where used in the control step
# ods <- fit(ods)
# hist(theta(ods))
# 

## ----pValue_computation----------------------------------------------------
# compute P-values (nominal and adjusted)
ods <- computePvalues(ods, alternative="two.sided", method="BY")

## ----zScore_computation----------------------------------------------------
# compute the Z-scores
ods <- computeZscores(ods)

## ----results fun-----------------------------------------------------------
# get results (default only significant, padj < 0.05)
res <- results(ods)
head(res)
dim(res)

# setting a different significance level and filtering by Z-scores
res <- results(ods, padjCutoff=0.1, zScoreCutoff=2)
head(res)
dim(res)

## ----aberrantperSample, fig.height=5---------------------------------------
# number of aberrant genes per sample
tail(sort(aberrant(ods, by="sample")))
tail(sort(aberrant(ods, by="gene", zScoreCutoff=1)))

# plot the aberrant events per sample
plotAberrantPerSample(ods, padjCutoff=0.05)

## ----volcano, fig.height=5-------------------------------------------------
# MUC1344 is a diagnosed sample from Kremer et al.
plotVolcano(ods, "MUC1344", basePlot=TRUE)

## ----visualization2, fig.height=5------------------------------------------
# expression rank of a gene with outlier events
plotExpressionRank(ods, "TIMMDC1", basePlot=TRUE)

## ----visualization3, fig.height=5------------------------------------------
## QQ-plot for a given gene
plotQQ(ods, "TIMMDC1")

## ----visualization4, fig.height=5------------------------------------------
## Observed versus expected gene expression
plotExpectedVsObservedCounts(ods, "TIMMDC1", basePlot=TRUE)

## ----peer_function, eval=FALSE---------------------------------------------
# #'
# #' PEER implementation
# #'
# peer <- function(ods, maxFactors=NA, maxItr=1000){
# 
#     # check for PEER
#     if(!require(peer)){
#         stop("Please install the 'peer' package from GitHub to use this ",
#                 "functionality.")
#     }
# 
#     # default and recommendation by PEER: min(0.25*n, 100)
#     if(is.na(maxFactors)){
#         maxFactors <- min(as.integer(0.25* ncol(ods)), 100)
#     }
# 
#     # log counts
#     logCts <- log2(t(t(counts(ods)+1)/sizeFactors(ods)))
# 
#     # prepare PEER model
#     model <- PEER()
#     PEER_setNmax_iterations(model, maxItr)
#     PEER_setNk(model, maxFactors)
#     PEER_setPhenoMean(model, logCts)
#     PEER_setAdd_mean(model, TRUE)
# 
#     # run fullpeer pipeline
#     PEER_update(model)
# 
#     # extract PEER data
#     peerResiduals <- PEER_getResiduals(model)
#     peerMean <- t(t(2^(logCts - peerResiduals)) * sizeFactors(ods))
# 
#     # save model in object
#     normalizationFactors(ods) <- pmax(peerMean, 1E-8)
#     metadata(ods)[["PEER_model"]] <- list(
#             alpha     = PEER_getAlpha(model),
#             residuals = PEER_getResiduals(model),
#             W         = PEER_getW(model))
# 
#     return(ods)
# }

## ----how to run peer, eval=FALSE-------------------------------------------
# # Control for confounders with PEER
# ods <- estimateSizeFactors(ods)
# ods <- peer(ods)
# ods <- fit(ods)
# ods <- computeZscores(ods, peerResiduals=TRUE)
# ods <- computePvalues(ods)
# 
# # Heatmap of the sample correlation after controlling
# ods <- plotCountCorHeatmap(ods, normalized=TRUE)

## ----visualizationSigLevels, fig.height=5----------------------------------
## P-values versus Mean Count
plotPowerAnalysis(ods)

## ----sessionInfo, echo=FALSE-----------------------------------------------
sessionInfo()

