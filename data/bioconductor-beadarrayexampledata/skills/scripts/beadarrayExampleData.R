# Code example from 'beadarrayExampleData' vignette. See references/ for full tutorial.

### R code from vignette source 'beadarrayExampleData.Rnw'

###################################################
### code chunk number 1: beadarrayExampleData.Rnw:30-31
###################################################
options(width=70)


###################################################
### code chunk number 2: beadarrayExampleData.Rnw:43-50
###################################################
library(beadarrayExampleData)
data(exampleBLData)
exampleBLData

data(exampleSummaryData)
exampleSummaryData
pData(exampleSummaryData)


###################################################
### code chunk number 3: beadarrayExampleData.Rnw:58-86 (eval = FALSE)
###################################################
## 
## require(BeadArrayUseCases)
## 
## targets <- read.table(system.file("extdata/BeadLevelBabFiles/targetsHT12.txt", package = "BeadArrayUseCases"), header=TRUE, sep="\t", as.is=TRUE)
## sn <- paste(targets[,3], targets[,4], sep="_")
## 
## babFilePath <- system.file("extdata/BeadLevelBabFiles", package = "BeadArrayUseCases")
## 
## exampleBLData <- readIllumina(dir=babFilePath, sectionNames=sn[c(1,12)], useImages=FALSE, illuminaAnnotation="Humanv3")
## 
## bsh <- BASH(exampleBLData,array=c(1,2))
## 
## exampleBLData <- setWeights(exampleBLData, wts = bsh$wts, array=1:2)
## 
## data <- readIllumina(dir=babFilePath, sectionNames=sn, useImages=FALSE, illuminaAnnotation="Humanv3")
## 
## 
## grnchannel <- new("illuminaChannel", transFun = logGreenChannelTransform, outlierFun = illuminaOutlierMethod, exprFun = function(x) mean(x,na.rm=TRUE),  varFun= function(x) sd(x, na.rm=TRUE),channelName= "G")
## 
## 
## grnchannel.unlogged <- new("illuminaChannel", transFun = greenChannelTransform, outlierFun = illuminaOutlierMethod, exprFun = function(x) mean(x,na.rm=TRUE),  varFun= function(x) sd(x, na.rm=TRUE),channelName= "G.ul")
## 
## exampleSummaryData <- summarize(data, list(grnchannel, grnchannel.unlogged), useSampleFac=FALSE)
## 
## 
## pData(exampleSummaryData)[,2] <- targets[,2]
## 
## 


