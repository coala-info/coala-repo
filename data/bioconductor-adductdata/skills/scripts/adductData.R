# Code example from 'adductData' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# 
# msconvert ORB35017raw.RAW --mzXML
# msconvert ORB35017raw.RAW --mzXML
# 

## ----eval=FALSE---------------------------------------------------------------
# # load the package
# library(adductData)

## ----quiet=T, eval=FALSE------------------------------------------------------
# 
# rtDevModelling(MS2Dir = system.file("extdata", package = "adductData"),
# nCores=4, runOrder = paste0(system.file("extdata", package = "adductomicsR"),
# '/runOrder.csv'))
# 
# #access the files using ExperimentHub
# library(ExperimentHub)
# eh  = ExperimentHub()
# temp = query(eh, 'adductData')
# temp
# 

## ----quiet=T, eval=FALSE------------------------------------------------------
# 
# adductQuant(nCores=4, targTable=paste0(system.file("extdata",
# package = "adductomicsR"),'/exampletargTable2.csv'), intStdRtDrift=30,
# rtDevModels=paste0(system.file("extdata", package = "adductData"),
# '/rtDevModels.RData'),
# filePaths=list.files(system.file("extdata", package = "adductData"),
#     pattern=".mzXML", all.files=FALSE,full.names=TRUE),
# quantObject=NULL,indivAdduct=NULL,maxPpm=5,minSimScore=0.8,spikeScans=1,
# minPeakHeight=100,maxRtDrift=20,maxRtWindow=240,isoWindow=80,
# hkPeptide='LVNEVTEFAK', gaussAlpha=16)
# 
# #access the files using ExperimentHub
# library(ExperimentHub)
# eh  = ExperimentHub()
# temp = query(eh, 'adductData')
# temp
# 

