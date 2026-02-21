# Code example from 'RTCAtransformation' vignette. See references/ for full tutorial.

### R code from vignette source 'RTCAtransformation.Rnw'

###################################################
### code chunk number 1: lib
###################################################
library(xtable)
library(RTCA)


###################################################
### code chunk number 2: dataset
###################################################
ofile <-  system.file("extdata/testOutput.csv", package="RTCA")
pfile <- system.file("extdata/testOutputPhenoData.csv", package="RTCA")
pData <- read.csv(pfile, sep="\t", row.names="Well")
metaData <- data.frame(labelDescription=c(
                         "Rack number",
                         "siRNA catalogue number",
                         "siRNA gene symbol",
                         "siRNA EntrezGene ID",
                         "siRNA targeting accession"
                         ))
phData <- new("AnnotatedDataFrame", data=pData, varMetadata=metaData)
x <- parseRTCA(ofile, phenoData=phData)


###################################################
### code chunk number 3: dims
###################################################
xTimePointNo <- dim(x)[[1]]
xSampleNo <- dim(x)[[2]]


###################################################
### code chunk number 4: smoothTransform
###################################################
xSmooth <- smoothTransform(x)


###################################################
### code chunk number 5: interpolationTranform
###################################################
xInter <- interpolationTransform(x)


###################################################
### code chunk number 6: derivTransform
###################################################
xDeriv <- derivativeTransform(x)


###################################################
### code chunk number 7: rgrTransform
###################################################
xRgr <- rgrTransform(x)


###################################################
### code chunk number 8: sessionInfo
###################################################
toLatex(sessionInfo())


