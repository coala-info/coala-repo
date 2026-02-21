# Code example from 'tracktables' vignette. See references/ for full tutorial.

## ----knitr, echo=FALSE, results="hide"----------------------------------------
library("knitr")
opts_chunk$set(tidy=FALSE,dev="png",fig.show="hide",
               fig.width=4,fig.height=4.5,
               message=FALSE)

## ----style, eval=TRUE, echo=FALSE, results="asis"--------------------------
BiocStyle::latex()

## ----include=FALSE---------------------------------------------------------
library(knitr)
opts_chunk$set(
concordance=TRUE
)

## ----options, results="hide", echo=FALSE--------------------------------------
options(digits=3, width=80, prompt=" ", continue=" ")

## ----inputdata, eval=TRUE-----------------------------------------------------
library(tracktables)

fileLocations <- system.file("extdata",package="tracktables")

bigwigs <- dir(fileLocations,pattern="*.bw",full.names=TRUE)
intervals <- dir(fileLocations,pattern="*.bed",full.names=TRUE)
bigWigMat <- cbind(gsub("_Example.bw","",basename(bigwigs)),
                   bigwigs)
intervalsMat <- cbind(gsub("_Peaks.bed","",basename(intervals)),
                      intervals)

FileSheet <- merge(bigWigMat,intervalsMat,all=TRUE)
FileSheet <- as.matrix(cbind(FileSheet,NA))
colnames(FileSheet) <- c("SampleName","bigwig","interval","bam")

SampleSheet <- cbind(as.vector(FileSheet[,"SampleName"]),
                     c("EBF","H3K4me3","H3K9ac","RNAPol2"),
                     c("ProB","ProB","ProB","ProB"))
colnames(SampleSheet) <- c("SampleName","Antibody","Species")


## ----head_samplesheet, eval=TRUE----------------------------------------------
head(SampleSheet)

## ----head_filesheet, eval=FALSE-----------------------------------------------
# head(FileSheet)

## ----Filesheet, eval=TRUE,echo=FALSE------------------------------------------
FileSheetEdited <- FileSheet
FileSheetEdited[,2] <- file.path("pathTo",basename(FileSheetEdited[,2]))
FileSheetEdited[1,3] <- file.path("pathTo",basename(FileSheetEdited[1,3]))
head(FileSheetEdited)

## ----IGVsessionAndSample, eval=FALSE------------------------------------------
# 
# MakeIGVSession(SampleSheet,FileSheet,igvdirectory=getwd(),"Example","mm9")

## ----maketracktable, eval=FALSE-----------------------------------------------
#   HTMLreport <- maketracktable(fileSheet=FileSheet,
#                                SampleSheet=SampleSheet,
#                                filename="IGVExample.html",
#                                basedirectory=getwd(),
#                                genome="mm9")

## ----maketracktable_WithColoursAndScales, eval=FALSE--------------------------
# 
#   igvDisplayParams <- igvParam(bigwig.autoScale = "false",
#                               bigwig.minimum = 1,
#                               bigwig.maximum = 5)
# 
# 
#   HTMLreport <- maketracktable(FileSheet,SampleSheet,"IGVex2.html",getwd(),"mm9",
#                                colourBy="Antibody",
#                                igvParam=igvDisplayParams)

## ----sessionInfo, results='asis', eval=TRUE-----------------------------------
toLatex(sessionInfo())

