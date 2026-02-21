# Code example from 'DupChecker' vignette. See references/ for full tutorial.

## ----quick, echo=TRUE, message=FALSE, warning=FALSE, tidy=FALSE----------
library(DupChecker)

## Create a "DupChecker" directory under temporary directory
rootDir<-paste0(dirname(tempdir()), "/DupChecker")
dir.create(rootDir, showWarnings = FALSE)
message(paste0("Downloading data to  ", rootDir, " ..."))

geoDownload(datasets=c("GSE1478"), targetDir=rootDir)
arrayExpressDownload(datasets=c("E-MEXP-3872"), targetDir=rootDir)

datafile<-buildFileTable(rootDir=rootDir, filePattern="cel$")
result<-validateFile(datafile)
if(result$hasdup){
  duptable<-result$duptable
  write.csv(duptable, file=paste0(rootDir, "/duptable.csv"))
}

## ----download, echo=TRUE, message=FALSE, warning=FALSE, tidy=FALSE-------
datatable<-geoDownload(datasets = c("GSE1478"), targetDir=rootDir)
datatable

datatable<-arrayExpressDownload(datasets=c("E-MEXP-3872"), targetDir=rootDir)
datatable

## ----buildFileTable, message=FALSE, warning=FALSE------------------------
datafile<-buildFileTable(rootDir=rootDir, filePattern="cel$")

## ----validateFile, message=FALSE, warning=FALSE--------------------------
result<-validateFile(datafile)
if(result$hasdup){
  duptable<-result$duptable
  write.csv(duptable, file=paste0(rootDir, "/duptable.csv"))
}

## ----realexample, eval=FALSE, tidy=FALSE---------------------------------
#  library(DupChecker)
#  
#  rootDir<-paste0(dirname(tempdir()), "/DupChecker_RealExample")
#  dir.create(rootDir, showWarnings = FALSE)
#  
#  geoDownload(datasets = c("GSE14333", "GSE13067",
#                           "GSE17538"), targetDir=rootDir)
#  datafile<-buildFileTable(rootDir=rootDir, filePattern="cel$")
#  result<-validateFile(datafile)
#  if(result$hasdup){
#    duptable<-result$duptable
#    write.csv(duptable, file=paste0(rootDir, "/duptable.csv"))
#  }

## ----sessInfo, echo=FALSE, results="asis"--------------------------------
toLatex(sessionInfo())

