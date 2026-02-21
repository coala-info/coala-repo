# Code example from 'LineagePulse_Tutorial' vignette. See references/ for full tutorial.

## ----de analysis-----------------------------------------------------------
library(LineagePulse)
lsSimulatedData <- simulateContinuousDataSet(
  scaNCells = 100,
  scaNConst = 10,
  scaNLin = 10,
  scaNImp = 10,
  scaMumax = 100,
  scaSDMuAmplitude = 3,
  vecNormConstExternal=NULL,
  vecDispExternal=rep(20, 30),
  vecGeneWiseDropoutRates = rep(0.1, 30))
objLP <- runLineagePulse(
  counts = lsSimulatedData$counts,
  dfAnnotation = lsSimulatedData$annot)
head(objLP$dfResults)

## ----plot-genes------------------------------------------------------------
# plot the gene with the lowest p-value of differential expression
gplotExprProfile <- plotGene(
objLP = objLP, boolLogPlot = FALSE,
strGeneID = objLP$dfResults[which.min(objLP$dfResults$p),]$gene,
boolLineageContour = FALSE)
gplotExprProfile

## ----manual-analysis-parameter-fits----------------------------------------
# extract the mean parameter fits per cell of the gene with the lowest p-value.
matMeanParamFit <- getFitsMean(
    lsMuModel = lsMuModelH1(objLP),
    vecGeneIDs = objLP$dfResults[which.min(objLP$dfResults$p),]$gene)
cat("Minimum fitted mean parameter: ", round(min(matMeanParamFit),1) )
cat("Mean fitted mean parameter: ", round(mean(matMeanParamFit),1) )

## ----lfc-trajector---------------------------------------------------------
# first, extract the model fits for a given gene again
vecMeanParamFit <- getFitsMean(
    lsMuModel = lsMuModelH1(objLP),
    vecGeneIDs = objLP$dfResults[which.min(objLP$dfResults$p),]$gene)
# compute log2-fold change from first to last cell on trajectory
idxFirstCell <- which.min(dfAnnotationProc(objLP)$pseudotime)
idxLastCell <- which.max(dfAnnotationProc(objLP)$pseudotime)
cat("LFC first to last cell on trajectory: ",
    round( (log(vecMeanParamFit[idxLastCell]) - 
                log(vecMeanParamFit[idxFirstCell])) / log(2) ,1) )
# compute log2-fold change from minimum to maximum value of expression trajectory
cat("LFC minimum to maximum expression value of model fit: ", 
    round( (log(max(vecMeanParamFit)) - 
                log(min(vecMeanParamFit))) / log(2),1) )

## ----heatmap---------------------------------------------------------------
# create heatmap with all differentially expressed genes
lsHeatmaps <- sortGeneTrajectories(
    vecIDs = objLP$dfResults[which(objLP$dfResults$padj < 0.01),]$gene,
    lsMuModel = lsMuModelH1(objLP),
    dirHeatmap=NULL)
print(lsHeatmaps$hmGeneSorted)

## ----session---------------------------------------------------------------
sessionInfo()

