# Code example from 'MAIT_Vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'MAIT_Vignette.Rnw'

###################################################
### code chunk number 1: libraryMAIT
###################################################
library(MAIT)


###################################################
### code chunk number 2: sampleProcessing
###################################################
library(faahKO)
cdfFiles<-system.file("cdf", package="faahKO", mustWork=TRUE)
MAIT <- sampleProcessing(dataDir = cdfFiles, project = "MAIT_Demo", 
snThres=2,rtStep=0.03)


###################################################
### code chunk number 3: printMAIT1
###################################################
MAIT


###################################################
### code chunk number 4: summaryMAIT1
###################################################
summary(MAIT)


###################################################
### code chunk number 5: peakAnnotation
###################################################
MAIT <- peakAnnotation(MAIT.object = MAIT,corrWithSamp = 0.7, 
corrBetSamp = 0.75,perfwhm = 0.6)


###################################################
### code chunk number 6: rawData
###################################################
rawData(MAIT)


###################################################
### code chunk number 7: MAIT_Vignette.Rnw:266-269
###################################################
MAIT<- spectralSigFeatures(MAIT.object = MAIT,pvalue=0.05,
       p.adj="none",scale=FALSE)
summary(MAIT)


###################################################
### code chunk number 8: MAIT_Vignette.Rnw:282-283
###################################################
signTable <- sigPeaksTable(MAIT.object = MAIT, printCSVfile = FALSE)


###################################################
### code chunk number 9: MAIT_Vignette.Rnw:293-294
###################################################
MAIT


###################################################
### code chunk number 10: BoxHeatplots (eval = FALSE)
###################################################
## plotBoxplot(MAIT)
## plotHeatmap(MAIT)


###################################################
### code chunk number 11: PLSPCA
###################################################
MAIT<-plotPCA(MAIT,plot3d=FALSE)
MAIT<-plotPLS(MAIT,plot3d=FALSE)
PLSmodel <- model(MAIT, type = "PLS")
PCAmodel <- model(MAIT, type = "PCA")


###################################################
### code chunk number 12: showPLSmodel
###################################################
PLSmodel


###################################################
### code chunk number 13: showPLSscores
###################################################
pcaScores(MAIT)


###################################################
### code chunk number 14: resultsPath
###################################################
resultsPath(MAIT)


###################################################
### code chunk number 15: Biotransformations
###################################################
Biotransformations(MAIT.object = MAIT, peakPrecision = 0.005) 


###################################################
### code chunk number 16: myBiotransf
###################################################
data(MAITtables)
myBiotransformation<-c("custom_biotrans",105.0)
myBiotable<-biotransformationsTable
myBiotable[,1]<-as.character(myBiotable[,1])
myBiotable<-rbind(myBiotable,myBiotransformation)
myBiotable[,1]<-as.factor(myBiotable[,1]) 
tail(myBiotable) 


###################################################
### code chunk number 17: identifyMetabolites
###################################################
MAIT <- identifyMetabolites(MAIT.object = MAIT, peakTolerance = 0.005)


###################################################
### code chunk number 18: metaboliteTable
###################################################
metTable<-metaboliteTable(MAIT)
head(metTable)


###################################################
### code chunk number 19: validation
###################################################
 MAIT <- Validation(Iterations = 20, trainSamples= 3, 
MAIT.object = MAIT)


###################################################
### code chunk number 20: summaryMAIT2
###################################################
summary(MAIT)


###################################################
### code chunk number 21: classifRatioClasses
###################################################
classifRatioClasses(MAIT)


###################################################
### code chunk number 22: defData
###################################################
peaks <- scores(MAIT)
masses <- getPeaklist(MAIT)$mz
rt <- getPeaklist(MAIT)$rt/60


###################################################
### code chunk number 23: MAITbuilder
###################################################
importMAIT <- MAITbuilder(data = peaks, masses = masses, 
              rt = rt,significantFeatures = TRUE, 
              spectraEstimation = TRUE,rtRange=0.2,
              corThresh=0.7)


###################################################
### code chunk number 24: BiotransformationsBuilder
###################################################
importMAIT <- Biotransformations(MAIT.object = importMAIT, 
              adductAnnotation = TRUE, 
              peakPrecision = 0.005, adductTable = NULL)


###################################################
### code chunk number 25: identifyMetabolitesBuilder
###################################################
importMAIT <- identifyMetabolites(MAIT.object = importMAIT, 
              peakTolerance=0.005,polarity="positive")


