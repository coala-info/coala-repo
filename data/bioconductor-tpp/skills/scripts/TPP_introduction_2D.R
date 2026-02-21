# Code example from 'TPP_introduction_2D' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results='asis'--------------------
BiocStyle::latex()

## ----opts, include=FALSE, echo=FALSE---------------------------------------
knitr::opts_chunk$set(concordance = TRUE, 
                      eval = TRUE,
                      cache = FALSE,
                      resize.width="0.45\\textwidth",
                      fig.align='center',
                      tidy = FALSE,
                      message=FALSE, 
                      warning = FALSE)

## ----install, eval=FALSE---------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE)){
#     install.packages("BiocManager")
# }
# BiocManager::install("TPP")

## ----package---------------------------------------------------------------
library("TPP")

## ----load_2d_data----------------------------------------------------------
data(panobinostat_2DTPP_smallExample, package = "TPP")

## ----head_2d_data, eval=TRUE-----------------------------------------------
config_tpp2d <- panobinostat_2DTPP_config
data_tpp2d <- panobinostat_2DTPP_data

config_tpp2d
data_tpp2d %>% str(1)

## ----colnames_Pano, eval=TRUE----------------------------------------------
data_tpp2d$X020466 %>% colnames

## ----ttp2dworkflow, eval = TRUE, warning=FALSE-----------------------------
tpp2dResults <- analyze2DTPP(configTable = config_tpp2d, 
                             data = data_tpp2d,
                             compFc = TRUE,
                             idVar = "representative",
                             intensityStr = "sumionarea_protein_",
                             nonZeroCols = "qusm",
                             addCol = "clustername",
                             methods = "doseResponse", 
                             createReport = "none")

tpp2dResults %>% mutate_if(is.character, factor) %>% summary

## ----ttp2dDataImport2, eval=TRUE, warning=FALSE----------------------------
data2d <- tpp2dImport(configTable = config_tpp2d, 
                      data = data_tpp2d, 
                      idVar = "representative",
                      intensityStr = "sumionarea_protein_",
                      nonZeroCols = "qusm",
                      addCol = "clustername")
head(data2d)
attr(data2d, "importSettings")

## ----ttp2dComputeFC2, eval=TRUE--------------------------------------------
fcData2d <- tpp2dComputeFoldChanges(data = data2d)

## ----head_fold_changes2, eval=TRUE-----------------------------------------
head(fcData2d)

## ----ttp2dDoMedianNorm2, eval=TRUE-----------------------------------------
normData2d <- tpp2dNormalize(data = fcData2d)
head(normData2d)

## ----tpp2dRunTPPCCR2, eval=TRUE, warning=FALSE-----------------------------
ccr2dResults <- tpp2dCurveFit(data = normData2d)

## ----tpp2dPlotGoodCurves, eval=TRUE, warning=FALSE-------------------------
drPlots <- tpp2dCreateDRplots(data = ccr2dResults, type = "good")

## ----plotCurve2, eval=TRUE, fig.height=6, fig.width=7.5--------------------

# Find IPI id for HDAC2 (in column representative):
IPI_id_HDAC2 <- unique(filter(ccr2dResults, clustername == "HDAC2")$representative)

# Show corresponding plot:
drPlots[[IPI_id_HDAC2]]

## ----plotSingleCurves, eval=TRUE, fig.show='hide', fig.height=6, fig.width=7.5----
drPlotsByTemperature <- tpp2dCreateDRplots(data = ccr2dResults, type = "single")
drPlotsByTemperature[[IPI_id_HDAC2]][["54"]]

## ----result_path_2DTPP, eval = TRUE----------------------------------------
resultPath = file.path(getwd(), 'Panobinostat_Vignette_Example_2D')
if (!file.exists(resultPath)) dir.create(resultPath, recursive = TRUE)

## ----generateReferenceInputData, eval = FALSE, warning=FALSE---------------
# data("hdacTR_smallExample")
# trConfig <- hdacTR_config[1:2,] %>%
#     dplyr::select(-dplyr::matches("Comparison"))
# 
# trConfig

## ----generateReferenceOject, eval = FALSE, warning=FALSE-------------------
# tpp2dCreateTPPTRreference(trConfigTable = trConfig,
#                           trDat = hdacTR_data[1:2],
#                           resultPath = resultPath,
#                           outputName = "desired_file_name",
#                           createFCboxplots = FALSE)

## ----pE50plots, eval = TRUE, warning = FALSE-------------------------------
# set the system path for the HepG2 TR reference data set:
trRef <- file.path(system.file("data", package="TPP"), 
                   "TPPTR_reference_results_HepG2.RData") 

plotData <- ccr2dResults %>% filter(clustername == "HDAC2")

pEC50QC_HDAC1 <- tpp2dPlotQCpEC50(resultTable = plotData,
                                  resultPath = NULL,
                                  trRef = trRef,
                                  idVar = "representative")

pEC50QC_HDAC1[[1]]


## ----qcHists, eval = FALSE, warning=FALSE----------------------------------
# tpp2dPlotQChist(configFile = config_tpp2d,
#                 resultTable = ccr2dResults,
#                 resultPath = resultPath,
#                 trRef = trRef,
#                 idVar = "representative")

