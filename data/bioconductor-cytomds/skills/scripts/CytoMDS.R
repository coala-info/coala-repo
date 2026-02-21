# Code example from 'CytoMDS' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'hide'------------------------------------
BiocStyle::markdown()

## -----------------------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("CytoMDS")

## ----rlibs, results=FALSE-----------------------------------------------------
suppressPackageStartupMessages(library(HDCytoData))
library(CytoMDS)
library(ggplot2)
library(patchwork)

## ----loadDataSet--------------------------------------------------------------
BCRXL_fs <- HDCytoData::Bodenmiller_BCR_XL_flowSet()
BCRXL_fs

## ----convertPhenoData---------------------------------------------------------
phenoData <- flowCore::pData(BCRXL_fs)
additionalPhenoData <- 
    keyword(BCRXL_fs[[1]], "EXPERIMENT_INFO")$EXPERIMENT_INFO
phenoData <- cbind(phenoData, additionalPhenoData)

flowCore::pData(BCRXL_fs) <- phenoData

## ----selectMarkers------------------------------------------------------------
markerInfo <- keyword(BCRXL_fs[[1]], "MARKER_INFO")$MARKER_INFO
chClass <- markerInfo$marker_class

table(chClass)

chLabels <- markerInfo$channel_name[chClass != "none"]
(chMarkers <- markerInfo$marker_name[chClass != "none"])

## ----scaleTransform-----------------------------------------------------------
trans <- arcsinhTransform(
    transformationId="ArcsinhTransform", 
    a = 0, 
    b = 1/5, 
    c = 0)

BCRXL_fs_trans <- transform(
    BCRXL_fs,
    transformList(chLabels, trans))

## ----distCalc-----------------------------------------------------------------
pwDist <- pairwiseEMDDist(
    BCRXL_fs_trans,
    channels = chMarkers,
    verbose = FALSE
)
pwDistMatrix <- as.matrix(pwDist)

## ----distShow-----------------------------------------------------------------
round(pwDistMatrix[1:10, 1:10], 2)

## ----distShowHist, fig.align='center', fig.wide = TRUE------------------------
distVec <- pwDistMatrix[upper.tri(pwDist)]
distVecDF <- data.frame(dist = distVec)
pHist <- ggplot(distVecDF, mapping = aes(x=dist)) + 
    geom_histogram(fill = "darkgrey", col = "black", bins = 15) + 
    theme_bw() + ggtitle("EMD distances for Bodenmiller2012 dataset")
pHist

## ----distByFeatureTable-------------------------------------------------------
DF <- distByFeature(pwDist)
DF[order(DF$percentage, decreasing = TRUE),]

## ----distByFeaturePlot, fig.align='center', fig.wide = TRUE-------------------
pBar <- ggplotDistFeatureImportance(pwDist)
pBar

## ----MDSCalc------------------------------------------------------------------
mdsObj <- computeMetricMDS(pwDist, seed = 0)
show(mdsObj)

## ----plotMDS1_simplest, fig.align='center', fig.asp = 1, fig.wide = TRUE------
ggplotSampleMDS(mdsObj)

## ----plotMDS_colours_shapes_1_2, fig.align='center', fig.asp = 0.9, fig.wide = TRUE----
p12 <- ggplotSampleMDS(
    mdsObj,
    pData = phenoData,
    projectionAxes = c(1,2),
    pDataForColour = "group_id",
    pDataForLabel = "patient_id"
)
p12

## ----plotMDS_colours_shapes_2_3_4, fig.align='center', fig.width = 9, fig.height = 12----
p23 <- ggplotSampleMDS(
    mdsObj,
    pData = phenoData,
    projectionAxes = c(2,3),
    pDataForColour = "group_id",
    pDataForLabel = "patient_id"
)

p34 <- ggplotSampleMDS(
    mdsObj,
    pData = phenoData,
    projectionAxes = c(3,4),
    pDataForColour = "group_id",
    pDataForLabel = "patient_id"
)
p23 / p34

## ----plotMDSShepard, fig.align='center', fig.wide = TRUE, fig.asp = 1---------
ggplotSampleMDSShepard(mdsObj)

## ----MDSCalc.nDim2, fig.align='center', fig.asp = 0.85, fig.wide = TRUE-------
 mdsObj2 <- CytoMDS::computeMetricMDS(pwDist, seed = 0, nDim = 2)
 ggplotSampleMDS(mdsObj2,
                 pData = phenoData,
                 projectionAxes = c(1,2),
                 pDataForColour = "group_id",
                 pDataForLabel = "patient_id",
                 flipYAxis = TRUE)

## ----MDSCalc.Rsq99, fig.align='center', fig.asp = 0.85, fig.wide = TRUE-------
mdsObj3 <- CytoMDS::computeMetricMDS(pwDist, seed = 0, targetPseudoRSq = 0.99)
ggplotSampleMDS(mdsObj3,
                 pData = phenoData,
                 projectionAxes = c(1,2),
                 pDataForColour = "group_id",
                 pDataForLabel = "patient_id")

## ----plotMDSShepard.Rsq99, fig.align='center', fig.wide = TRUE, fig.asp = 1----
ggplotSampleMDSShepard(mdsObj3)

## ----plotMDS_medians----------------------------------------------------------
medians <- channelSummaryStats(BCRXL_fs_trans, 
                               channels = chLabels, 
                               statFUNs = median)

## ----plotMDS_biplot, fig.align='center', fig.asp = 0.8, fig.wide = TRUE-------
ggplotSampleMDS(mdsObj,
                pData = phenoData,
                pDataForColour = "group_id",
                displayPointLabels = FALSE,
                displayArrowLabels = TRUE,
                repelArrowLabels = TRUE,
                biplot = TRUE,
                extVariables = medians)

## ----plotMDS_biplot_0.6, fig.align='center', fig.asp = 0.8, fig.wide = TRUE----
ggplotSampleMDS(mdsObj,
                pData = phenoData,
                pDataForColour = "group_id",
                displayPointLabels = FALSE,
                displayArrowLabels = TRUE,
                repelArrowLabels = TRUE,
                biplot = TRUE,
                extVariables = medians,
                arrowThreshold = 0.6)

## ----plotMarginalDensities, fig.align='center', fig.asp = 1.2, fig.wide = TRUE----
ggplotMarginalDensities(
    BCRXL_fs_trans, 
    channels = chLabels,
    pDataForColour = "group_id",
    pDataForGroup = "sample_id")

## ----plotMDS_stats------------------------------------------------------------
statFUNs = c("median" = stats::median,
             "Q25" = function(x, na.rm) {
                 stats::quantile(x, probs = 0.25)
             },
             "Q75" = function(x, na.rm) {
                 stats::quantile(x, probs = 0.75)
             },
             "standard deviation" = stats::sd)
chStats <- channelSummaryStats(BCRXL_fs_trans,
                               channels = chLabels, 
                               statFUNs = statFUNs)

## ----plotMDS_biplot_facetting, fig.align='center', fig.asp = 1, fig.wide = TRUE----
ggplotSampleMDSWrapBiplots(
    mdsObj,
    extVariableList = chStats,
    ncol = 2,
    pData = phenoData,
    pDataForColour = "group_id",
    displayPointLabels = FALSE,
    displayArrowLabels = TRUE,
    repelArrowLabels = TRUE,
    displayLegend = FALSE)

## ----plotMDS_biplot_stddev, fig.align='center', fig.asp = 1.0, fig.wide = TRUE----
stdDevs <- list(
    "std dev of channels 1 to 6" = chStats[["standard deviation"]][,1:6],
    "std dev of channels 7 to 12" = chStats[["standard deviation"]][,7:12],
    "std dev of channels 13 to 18" = chStats[["standard deviation"]][,13:18],
    "std dev of channels 19 to 24" = chStats[["standard deviation"]][,19:24]
)

ggplotSampleMDSWrapBiplots(
    mdsObj,
    ncol = 2,
    extVariableList = stdDevs,
    pData = phenoData,
    pDataForColour = "group_id",
    displayPointLabels = FALSE,
    displayArrowLabels = TRUE,
    repelArrowLabels = TRUE)

## ----temporary_store----------------------------------------------------------
storageLocation <- suppressMessages(base::tempdir())

nSample <- length(BCRXL_fs_trans)
fileNames <- file.path(
    storageLocation,
    paste0("BodenMiller2012_TransformedSample", 
           sprintf("%02d.rds", seq_len(nSample))))

for (i in seq_len(nSample)) {
    saveRDS(BCRXL_fs_trans[[i]],
            file = fileNames[i])
}

## ----distance_calc_loading_otf_parallel---------------------------------------
bp <- BiocParallel::SnowParam(
    stop.on.error = FALSE,
    progressbar = TRUE)
pwDistLast <- suppressWarnings(pairwiseEMDDist(
    x = nSample,
    channels = chMarkers,
    loadExprMatrixFUN  = function(exprMatrixIndex, files, channels, markers){
        ff <- readRDS(file = files[exprMatrixIndex ])
        exprMat <- flowCore::exprs(ff)[, channels, drop = FALSE]
        colnames(exprMat) <- markers
        exprMat
    },
    loadExprMatrixFUNArgs = list(
        files = fileNames, 
        channels = chLabels,
        markers = chMarkers),
    BPPARAM = bp))

## ----dist1ShowHistAgain, fig.align='center', fig.wide = TRUE------------------
pwDistLastMat <- as.matrix(pwDistLast)
distVecLast <- pwDistLastMat[upper.tri(pwDistLastMat)]
distVecDFLast <- data.frame(dist = distVecLast)
pHistLast <- ggplot(distVecDFLast, mapping = aes(x=dist)) +
    geom_histogram(fill = "darkgrey", col = "black", bins = 15) +
    theme_bw() + 
    ggtitle(
        "EMD distances for Bodenmiller2012 dataset", 
        subtitle =  "on the fly memory loading and parallel computation")
pHistLast

## ----simulExprMatrices--------------------------------------------------------
nSample <- 10
conditions <- factor(c(rep("conditionA", 5), rep("conditionB", 5)))
nRow <- 1000
nFeat <- 10
nDiffFeat <- 3
diffFeats = c(2, 3, 9)
stdDevFactor = 1.5

exprMatrixList <- mapply(
    seq(nSample),
    conditions,
    FUN = function(i, condition) {
        exprMatrix <- matrix(rnorm(nRow*nFeat), nrow = nRow)
        if (condition == "conditionB") {
            exprMatrix[, diffFeats] <- exprMatrix[, diffFeats] * stdDevFactor
        }
        colnames(exprMatrix) <- paste0("Feat", seq(nFeat))
        exprMatrix
    },
    SIMPLIFY = FALSE
)

names(exprMatrixList) <- paste0("sample", seq(nSample))


## ----distExprMatrices---------------------------------------------------------

pwDistExpr <-  pairwiseEMDDist(
    exprMatrixList
)

## ----distExprMatShowHist, fig.align='center', fig.wide = TRUE-----------------
pwDistExprmat <- as.matrix(pwDistExpr)
distVecExpr <- pwDistExprmat[upper.tri(pwDistExprmat)]
distVecDFExpr <- data.frame(dist = distVecExpr)
pHistExpr <- ggplot(distVecDFExpr, mapping = aes(x=dist)) +
    geom_histogram(fill = "darkgrey", col = "black", bins = 15) +
    theme_bw() + 
    ggtitle(
        "EMD distances for simulated expression matrices")
pHistExpr

## ----MDSCalcExprMat-----------------------------------------------------------
mdsObjExpr <- computeMetricMDS(pwDistExpr, seed = 0)
show(mdsObjExpr)

## ----plotMDSExprMat, fig.align='center', fig.asp = 0.9, fig.wide = TRUE-------
phenoDataExpr <- data.frame(sampleId = seq(nSample), cond = conditions)
p12 <- ggplotSampleMDS(
    mdsObjExpr,
    pData = phenoDataExpr,
    projectionAxes = c(1,2),
    pDataForColour = "cond",
    pDataForLabel = "sampleId"
)
p12

## ----biplotsMDSExprMat, fig.align='center', fig.asp = 0.9, fig.wide = TRUE----
statFunctions <- list(mean = base::mean,
                      std_dev = stats::sd)
chStatsExpr <- channelSummaryStats(exprMatrixList,
                                   statFUNs  = statFunctions)
p <- CytoMDS::ggplotSampleMDSWrapBiplots(
    mdsObj = mdsObjExpr,
    extVariableList = chStatsExpr,
    pData = phenoDataExpr,
    projectionAxes = c(1,2),
    pDataForColour = "cond",
    displayPointLabels = FALSE,
    repelArrowLabels = TRUE,
    ncol = 2,
    arrowThreshold = 0.9
)
p


## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

