# Code example from 'basecallQC' vignette. See references/ for full tutorial.

## ----cleaning, fig.show='hold',warning=FALSE,message=FALSE--------------------
library(basecallQC)
fileLocations <- system.file("extdata",package="basecallQC")
config <- dir(fileLocations,pattern="config.ini",full.names=TRUE)
fileLocations <- system.file(file.path("extdata","testSampleSheets"),package="basecallQC")
runXML <- dir(fileLocations,pattern="runParameters.xml",full.names=TRUE)
sampleSheet <- dir(fileLocations,pattern="*\\.csv",full.names=TRUE)
read.delim(sampleSheet[1],sep=",",header = TRUE,comment.char = "[")


## ----cleaning2, fig.show='hold',warning=FALSE,message=FALSE-------------------

bcl2fastqparams <- BCL2FastQparams(runXML,config,runDir=getwd(),verbose=FALSE)
cleanedSampleSheet <- validateBCLSheet(sampleSheet[1],param=bcl2fastqparams)
head(cleanedSampleSheet)


## ----updating, fig.show='hold',warning=FALSE,message=FALSE--------------------
library(basecallQC)
fileLocations <- system.file("extdata",package="basecallQC")
config <- dir(fileLocations,pattern="config.ini",full.names=TRUE)
fileLocations <- system.file(file.path("extdata","testSampleSheets"),package="basecallQC")
runXML <- dir(fileLocations,pattern="runParameters.xml",full.names=TRUE)
sampleSheet <- dir(fileLocations,pattern="*\\.csv",full.names=TRUE)
read.delim(sampleSheet[2],sep=",",header = TRUE,comment.char = "[")


## ----updating2, fig.show='hold',warning=FALSE,message=FALSE-------------------

bcl2fastqparams <- BCL2FastQparams(runXML,config,runDir=getwd(),verbose=FALSE)
cleanedSampleSheet <- validateBCLSheet(sampleSheet[2],param=bcl2fastqparams)
head(cleanedSampleSheet)


## ----basemasks, fig.show='hold',warning=FALSE,message=FALSE-------------------
fileLocations <- system.file("extdata",package="basecallQC")
runXML <- dir(fileLocations,pattern="runParameters.xml",full.names=TRUE)
config <- dir(fileLocations,pattern="config.ini",full.names=TRUE)
sampleSheet <- dir(fileLocations,pattern="*\\.csv",full.names=TRUE)
bcl2fastqparams <- BCL2FastQparams(runXML,config,runDir=getwd(),verbose=FALSE)
cleanedSampleSheet <- validateBCLSheet(sampleSheet,param=bcl2fastqparams)
baseMasks <- createBasemasks(cleanedSampleSheet,param=bcl2fastqparams)
baseMasks$index1Mask

## ----submitCommand, fig.show='hold',warning=FALSE,message=FALSE---------------
toSubmit <- createBCLcommand(bcl2fastqparams,cleanedSampleSheet,baseMasks)
toSubmit

## ----basecallQCforMetrics, fig.show='hold',eval=T,echo=F,warning=FALSE,message=FALSE----
fileLocations <- system.file("extdata",package="basecallQC")
runXML <- dir(fileLocations,pattern="runParameters.xml",full.names=TRUE)
config <- dir(fileLocations,pattern="config.ini",full.names=TRUE)
sampleSheet <- dir(fileLocations,pattern="*\\.csv",full.names=TRUE)
outDir <- file.path(fileLocations,"Runs/161105_D00467_0205_AC9L0AANXX/C9L0AANXX/")
bcl2fastqparams <- BCL2FastQparams(runXML,config,runDir=getwd(),outDir,verbose=FALSE)
bclQC <- basecallQC(bcl2fastqparams,RunMetaData=NULL,sampleSheet)

## ----bclSummary, fig.show='hold',warning=FALSE,message=FALSE------------------
bclMetrics <- baseCallMetrics(bcl2fastqparams)
head(bclMetrics[[1]])

## ----demuxSummary, fig.show='hold',warning=FALSE,message=FALSE----------------
demuxMetrics <- demultiplexMetrics(bcl2fastqparams)
head(demuxMetrics[[1]])


## ----basecallQC, fig.show='hold',eval=F,warning=FALSE,message=FALSE-----------
# fileLocations <- system.file("extdata",package="basecallQC")
# runXML <- dir(fileLocations,pattern="runParameters.xml",full.names=TRUE)
# config <- dir(fileLocations,pattern="config.ini",full.names=TRUE)
# sampleSheet <- dir(fileLocations,pattern="*\\.csv",full.names=TRUE)
# outDir <- file.path(fileLocations,"Runs/161105_D00467_0205_AC9L0AANXX/C9L0AANXX/")
# bcl2fastqparams <- BCL2FastQparams(runXML,config,runDir=getwd(),outDir,verbose=FALSE)
# bclQC <- basecallQC(bcl2fastqparams,RunMetaData=NULL,sampleSheet)
# class(bclQC)

## ----basecallQC2, fig.show='hold',eval=F,eval=T,echo=F,warning=FALSE,message=FALSE----
class(bclQC)

## ----tables, fig.show='hold',warning=FALSE,message=FALSE----------------------
summaryConvStatsTable(bclQC,output = "html")
summaryDemuxTable(bclQC,output = "html")

## ----plots1, fig.show='hold',warning=FALSE,message=FALSE, fig.width=5, fig.height=5----
passFilterBar(bclQC,groupBy="Sample",metricToPlot = "Yield")


## ----plots2, fig.show='hold',warning=FALSE,message=FALSE, fig.width=5, fig.height=5----

passFilterTilePlot(bclQC,metricToPlot = "Yield")


## ----plots3, fig.show='hold',warning=FALSE,message=FALSE, fig.width=5, fig.height=5----

demuxBarplot(bclQC,groupBy="Sample")

## ----plots4, eval=F, warning=FALSE,message=FALSE------------------------------
# reportBCL(bclQC)

## ----sessionInfo,echo=F,fig.height=30,fig.width=15----------------------------
sessionInfo()

