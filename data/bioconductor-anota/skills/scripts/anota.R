# Code example from 'anota' vignette. See references/ for full tutorial.

### R code from vignette source 'anota.Rnw'

###################################################
### code chunk number 1: anota.Rnw:135-142
###################################################
##Loading the library and data set, perform quality control and identify significant translational regulation. No RVM is applied in the example.
 library("anota")
 data(anotaDataSet)
 anotaQcOut <- anotaPerformQc(dataT=anotaDataT[1:200,], dataP=anotaDataP[1:200,], phenoVec=anotaPhenoVec, nDfbSimData=500, useProgBar=FALSE)
 anotaResidOut <- anotaResidOutlierTest(anotaQcObj=anotaQcOut, useProgBar=FALSE)
 anotaSigOut <- anotaGetSigGenes(dataT=anotaDataT[1:200,], dataP=anotaDataP[1:200,], phenoVec=anotaPhenoVec, anotaQcObj=anotaQcOut, useRVM=FALSE, useProgBar=FALSE)
anotaSelected <- anotaPlotSigGenes(anotaSigObj=anotaSigOut, selContr=1, maxP=0.1, minSlope=(-0.5), maxSlope=1.5, selDeltaPT=0.5)


