# Code example from 'TSRchitect' vignette. See references/ for full tutorial.

## ----eval=TRUE-----------------------------------------------------------
library(TSRchitect)

## ----eval=FALSE----------------------------------------------------------
#  TSRchitectUsersGuide()

## ----eval=TRUE-----------------------------------------------------------
extdata.dir <- system.file("extdata", package="TSRchitect") 

tssObjectExample <- loadTSSobj(experimentTitle="Vignette Example",
inputDir=extdata.dir, isPairedBAM=TRUE,
sampleNames=c("sample1-rep1", "sample1-rep2","sample2-rep1",
"sample2-rep2"), replicateIDs=c(1,1,2,2)) #datasets 1-2 and 3-4 are replicates

## ----eval=FALSE----------------------------------------------------------
#  tssObjectExample

## ----eval=TRUE-----------------------------------------------------------
tssObjectExample <- inputToTSS(experimentName=tssObjectExample)

tssObjectExample <- processTSS(experimentName=tssObjectExample, n.cores=1,
tssSet="all", writeTable=FALSE)

## ----eval=TRUE-----------------------------------------------------------
tssObjectExample <- determineTSR(experimentName=tssObjectExample, n.cores=1,
tsrSetType="replicates", tssSet="all", tagCountThreshold=25, clustDist=20,
writeTable=FALSE)

## ----eval=TRUE-----------------------------------------------------------
tssObjectExample <- mergeSampleData(experimentName=tssObjectExample)

tssObjectExample <- determineTSR(experimentName=tssObjectExample, n.cores=1,
tsrSetType="merged", tssSet="all", tagCountThreshold=25, clustDist=20,
writeTable=FALSE)

tssObjectExample <- addTagCountsToTSR(experimentName=tssObjectExample,
tsrSetType="merged", tsrSet=1, tagCountThreshold=25, writeTable=FALSE)

## ----eval=TRUE-----------------------------------------------------------
sample_1_1_tsrs <- getTSRdata(experimentName=tssObjectExample,
slotType="replicates", slot=1)

print(sample_1_1_tsrs)

## ----eval=TRUE-----------------------------------------------------------
tssObjectExample <- importAnnotationExternal(experimentName=tssObjectExample,
fileType="gff3",
annotFile=paste(extdata.dir,"gencode.v19.chr22.transcript.gff3",sep="/"))

tssObjectExample <- addAnnotationToTSR(experimentName=tssObjectExample,
tsrSetType="merged", tsrSet=1, upstreamDist=2000, downstreamDist=500,
feature="transcript", featureColumnID="ID", writeTable=FALSE)

## ----eval=FALSE----------------------------------------------------------
#  save(tssObjectExample, file="tssObjectExample_vignette.RData")

