# Code example from 'TPP_introduction_1D' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results='asis'--------------------
BiocStyle::latex()

## ----opts, include=FALSE, echo=FALSE---------------------------------------
knitr::opts_chunk$set(concordance=TRUE, 
                      eval = TRUE,
                      cache = TRUE,
                      resize.width="0.45\\textwidth",
                      fig.align='center',
                      tidy = FALSE,
                      message=FALSE)

## ----install, eval=FALSE---------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE)){
#     install.packages("BiocManager")
# }
# BiocManager::install("TPP")

## ----package---------------------------------------------------------------
library("TPP")

## ----load_tr_data----------------------------------------------------------
data("hdacTR_smallExample")
ls()

## ----locate_example_data---------------------------------------------------
system.file('example_data', package = 'TPP')

## ----tr_config_table-------------------------------------------------------
print(hdacTR_config)

## ----dataSummaryTP---------------------------------------------------------
summary(hdacTR_data)

## ----dataStatsTP-----------------------------------------------------------
data.frame(Proteins = sapply(hdacTR_data, nrow))

## ----datahead--------------------------------------------------------------
hdacVehicle1 <- hdacTR_data[["Vehicle_1"]]
head(hdacVehicle1)

## ----result_path_TR--------------------------------------------------------
resultPath = file.path(getwd(), 'Panobinostat_Vignette_Example')

## ----analyzeTR-------------------------------------------------------------
TRresults <- analyzeTPPTR(configTable = hdacTR_config, 
                          methods = "meltcurvefit",
                          data = hdacTR_data, 
                          nCores = 2,
                          resultPath = resultPath, 
                          plotCurves = FALSE) 

## ----trTargets-------------------------------------------------------------
tr_targets <- subset(TRresults, fulfills_all_4_requirements)$Protein_ID
print(tr_targets)

## ----trHDACTargets---------------------------------------------------------
hdac_targets <- grep("HDAC", tr_targets, value=TRUE)
print(hdac_targets)

## ----trImport, message=TRUE------------------------------------------------
trData <- tpptrImport(configTable = hdacTR_config, data = hdacTR_data)

## ----trData_vehicle1-------------------------------------------------------
trData[["Vehicle_1"]]

## ----trDefaultNormReqs-----------------------------------------------------
print(tpptrDefaultNormReqs())

## ----trNormalization, message = TRUE---------------------------------------
normResults <- tpptrNormalize(data=trData)
trDataNormalized <- normResults[["normData"]]

## ----trSelectHDACs---------------------------------------------------------
trDataHDAC <- lapply(trDataNormalized, function(d) 
  d[Biobase::featureNames(d) %in% hdac_targets,])

## ----trFitHDAC, message = TRUE---------------------------------------------
trDataHDAC <- tpptrCurveFit(data = trDataHDAC, resultPath = resultPath, nCores = 1)

## ----fittedMeltPars--------------------------------------------------------
Biobase::pData(Biobase::featureData(trDataHDAC[["Vehicle_1"]]))[,1:5]

## ----loadTRfitResultss-----------------------------------------------------
load(file.path(resultPath, "dataObj", "fittedData.RData"), verbose=TRUE)

## ----trPvals, message=TRUE, cache=TRUE-------------------------------------
minR2New <- 0.5 # instead of 0.8
maxPlateauNew <- 0.7 # instead of 0.3
newFilters <- list(minR2 = minR2New, 
                   maxPlateau = maxPlateauNew)
TRresultsNew <- tpptrAnalyzeMeltingCurves(data = trDataFitted, 
                                          pValFilter = newFilters)

## ----compBWidth------------------------------------------------------------
tr_targetsNew <- subset(TRresultsNew, fulfills_all_4_requirements)$Protein_ID
targetsGained <- setdiff(tr_targetsNew, tr_targets)
targetsLost <- setdiff(tr_targets, tr_targetsNew)
print(targetsGained)
print(targetsLost)

## ----nparcVignette, eval = FALSE-------------------------------------------
# browseVignettes("TPP")

## ----trExport, message=TRUE, eval=FALSE------------------------------------
# tppExport(tab = TRresultsNew,
#           file = file.path(resultPath, "targets_newFilters.xlsx"))

## ----newNormReqs-----------------------------------------------------------
trNewReqs <- tpptrDefaultNormReqs()
print(trNewReqs)
trNewReqs$otherRequirements[1,"colName"] <- "mycolName"
trNewReqs$fcRequirements[,"fcColumn"] <- c(6,8,9)
print(trNewReqs)

## ----load_ccr_data---------------------------------------------------------
data("hdacCCR_smallExample")

## ----analyzeCCR, cache=TRUE------------------------------------------------
CCRresults <- analyzeTPPCCR(configTable = hdacCCR_config[1,], 
                            data = hdacCCR_data[[1]],
                            resultPath = resultPath, 
                            plotCurves = FALSE,
                            nCores = 2) 

## ----ccrTargets------------------------------------------------------------
ccr_targets <- subset(CCRresults, passed_filter_Panobinostat_1)$Protein_ID
print(ccr_targets)

## ----ccrHDACTargets--------------------------------------------------------
hdac_targets <- grep("HDAC", ccr_targets, value = TRUE)
print(hdac_targets)

## ----ccrImport, message=TRUE-----------------------------------------------
ccrData <- tppccrImport(configTable = hdacCCR_config[1,], data = hdacCCR_data[[1]])

## ----ccrNormalization, message=TRUE----------------------------------------
ccrDataNormalized <- tppccrNormalize(data = ccrData)

## ----ccrTransform, message=TRUE--------------------------------------------
ccrDataTransformed <- tppccrTransform(data = ccrDataNormalized)[[1]]

## ----ccrSelectHDACs--------------------------------------------------------
ccrDataHDAC <- ccrDataTransformed[match(hdac_targets, Biobase::featureNames(ccrDataTransformed)),]

## ----ccrFitHDAC, message=TRUE, cache=TRUE----------------------------------
ccrDataFittedHDAC <- tppccrCurveFit(data=list(Panobinostat_1 = ccrDataHDAC), nCores = 1)
tppccrPlotCurves(ccrDataFittedHDAC, resultPath = resultPath, nCores = 1)

## ----fittedDRPars----------------------------------------------------------
ccrResultsHDAC <- tppccrResultTable(ccrDataFittedHDAC)
print(ccrResultsHDAC[,c(1, 22:25)])

