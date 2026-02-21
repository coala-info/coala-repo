# Code example from 'adductomicsRWorkflow' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# #ensure you have mzR installed
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("mzR", version = "3.8")
# 
# # install the package directly from Github
# library(devtools)
# devtools::install_github("JosieLHayes/adductomicsR")
# 
# #install the data package containing the data
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("ExperimentHub", version = "3.9")
# 
# #or download the packages and install from source
# library(devtools)
# devtools::install("path_to_dir/adductomicsR")
# devtools::install("path_to_dir/adductData")
# 

## ----eval=FALSE---------------------------------------------------------------
# # load the package
# library(adductomicsR)
# library(adductData)
# library(ExperimentHub)

## ----echo=FALSE---------------------------------------------------------------
suppressMessages(suppressWarnings(library(adductomicsR)))
suppressMessages(suppressWarnings(library(ExperimentHub)))


## ----quiet=TRUE, error = TRUE-------------------------------------------------
try({
eh  = suppressMessages(suppressWarnings(ExperimentHub::ExperimentHub()))
temp = suppressMessages(suppressWarnings(
AnnotationHub::query(eh, 'adductData')))
})

## ----quiet=TRUE, error = TRUE-------------------------------------------------
try({
suppressMessages(suppressWarnings(temp[['EH1957']])) #first mzXML file
file.rename(cache(temp["EH1957"]), file.path(hubCache(temp),
                                             'ORB35017.mzXML'))

temp[['EH1958']] #second mzXML file
file.rename(cache(temp["EH1958"]), file.path(hubCache(temp), 'ORB35022.mzXML'))
})

## ----quiet=TRUE, eval=FALSE---------------------------------------------------
# rtDevModelling(
#   MS2Dir = hubCache(temp),
#   nCores=4,
#   runOrder =paste0(system.file("extdata",
#                                package ="adductomicsR"),'/runOrder.csv')
#   )

## ----quiet=TRUE, eval=FALSE---------------------------------------------------
# specSimPepId(
#   MS2Dir = hubCache(temp),
#   nCores=4,
#   rtDevModels =paste0(hubCache(temp),'/rtDevModels.RData')
#   )

## ----quiet=TRUE, error=TRUE---------------------------------------------------
try({

generateTargTable(
  allresultsFile=paste0(system.file("extdata",package =
  "adductomicsR"),'/allResults_ALVLIAFAQYLQQCPFEDHVK_example.csv'),
  csvDir=tempdir(check = FALSE)
  )
})

## ----quiet=TRUE, eval=FALSE---------------------------------------------------
# adductQuant(
#   nCores=2,
#   targTable=paste0(system.file("extdata",
#                                package="adductomicsR"),
#                                '/exampletargTable2.csv'),
#   intStdRtDrift=30,
#   rtDevModels= paste0(hubCache(temp),'/rtDevModels.RData'),
#   filePaths=list.files(hubCache(temp),pattern=".mzXML",
#                        all.files=FALSE,full.names=TRUE),
#   quantObject=NULL,
#   indivAdduct=NULL,
#   maxPpm=5,
#   minSimScore=0.8,
#   spikeScans=1,
#   minPeakHeight=100,
#   maxRtDrift=20,
#   maxRtWindow=240,
#   isoWindow=80,
#   hkPeptide='LVNEVTEFAK',
#   gaussAlpha=16
#   )
# 

## ----quiet=TRUE, eval=FALSE, error=TRUE---------------------------------------
try({
# #load the adductquantif object
# load(paste0(hubCache(temp),"/adductQuantResults.Rda"))
# 
# #produce a peakTable from the Adductquantif object and save to a temporary
# #directory
# suppressMessages(suppressWarnings(outputPeakTable(object=
#     object, outputDir=tempdir(check = FALSE))))
})

## ----quiet=TRUE,eval=FALSE, error=TRUE----------------------------------------
try({
# filterAdductTable(
#   paste0(tempdir(check = FALSE),"/adductQuantif_peakList_", Sys.Date(), ".csv")
#   )
})

## ----quiet=TRUE, error=TRUE---------------------------------------------------
try({
#session info
sessionInfo()
})

