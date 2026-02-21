# Code example from 'AgiMicroRna' vignette. See references/ for full tutorial.

### R code from vignette source 'AgiMicroRna.Rnw'

###################################################
### code chunk number 1: data
###################################################
library("AgiMicroRna")
data(targets.micro)
print(targets.micro)


###################################################
### code chunk number 2: data
###################################################
data(dd.micro)
class(dd.micro)
dim(dd.micro)


###################################################
### code chunk number 3: AgiMicroRna.Rnw:237-238
###################################################
print(names(dd.micro))


###################################################
### code chunk number 4: qcPlots
###################################################
qcPlots(dd.micro,offset=5,
        MeanSignal=TRUE,
        ProcessedSignal=FALSE,
        TotalProbeSignal=FALSE,
        TotalGeneSignal=FALSE,
        BGMedianSignal=FALSE,
        BGUsed=FALSE,
        targets.micro)



###################################################
### code chunk number 5: BoxPlot
###################################################
boxplotMicroRna(log2(dd.micro$meanS),
	maintitle='log2 Mean Signal',
	colorfill= 'orange')


###################################################
### code chunk number 6: plotDensity
###################################################
plotDensityMicroRna(log2(dd.micro$meanS),
	maintitle='log2 Mean Signal')


###################################################
### code chunk number 7: MA
###################################################
ddaux=dd.micro
ddaux$G=log2(dd.micro$meanS)
mvaMicroRna(ddaux,
	maintitle='log2 Mean Signal',
	verbose=FALSE)
rm(ddaux)



###################################################
### code chunk number 8: RLE
###################################################
RleMicroRna(log2(dd.micro$meanS),
	maintitle='log2 Mean Signal - RLE')


###################################################
### code chunk number 9: hclust
###################################################
hierclusMicroRna(log2(dd.micro$meanS),targets.micro$GErep,
		methdis="euclidean",
                methclu="complete",
		sel=TRUE,100)


###################################################
### code chunk number 10: cvArray
###################################################
cvArray(dd.micro,
        "MeanSignal",
        targets.micro,
	verbose=TRUE)



###################################################
### code chunk number 11: tgsMicroRna
###################################################
ddTGS=tgsMicroRna(dd.micro,
    half=TRUE,
    makePLOT=FALSE,
    verbose=FALSE)



###################################################
### code chunk number 12: tgsNormalization
###################################################
ddNORM=tgsNormalization(ddTGS,
                "quantile",
                makePLOTpre=FALSE,
                makePLOTpost=FALSE,
                targets.micro,
		verbose=TRUE)


###################################################
### code chunk number 13: rmaMicroRna (eval = FALSE)
###################################################
## ddTGS.rma=rmaMicroRna(dd.micro,
## 		normalize=TRUE,
## 		background=TRUE)
## 


###################################################
### code chunk number 14: filterMicroRna
###################################################

ddPROC=filterMicroRna(ddNORM,
                    dd.micro,
                    control=TRUE,
                    IsGeneDetected=TRUE,
                    wellaboveNEG=FALSE,
                    limIsGeneDetected=75,
                    limNEG=25,
                    makePLOT=FALSE,
                    targets.micro,
		    verbose=TRUE,
                    writeout=FALSE)


###################################################
### code chunk number 15: esetMicroRna
###################################################
esetPROC=esetMicroRna(ddPROC,
          targets.micro,
          makePLOT=FALSE,
	  verbose=TRUE)


###################################################
### code chunk number 16: writeEset (eval = FALSE)
###################################################
## writeEset(esetPROC,
##             ddPROC,
##             targets.micro,
## 	    verbose=TRUE)


###################################################
### code chunk number 17: AgiMicroRna.Rnw:695-699
###################################################
levels.treatment=levels(factor(targets.micro$Treatment))
        treatment=factor(as.character(targets.micro$Treatment),
                levels=levels.treatment)



###################################################
### code chunk number 18: AgiMicroRna.Rnw:701-704
###################################################
levels.subject=levels(factor(targets.micro$Subject))
        subject=factor(as.character(targets.micro$Subject),
                levels=levels.subject)


###################################################
### code chunk number 19: AgiMicroRna.Rnw:725-727
###################################################
design=model.matrix(~ -1 + treatment + subject)
print(design)


###################################################
### code chunk number 20: AgiMicroRna.Rnw:734-737
###################################################
fit=lmFit(esetPROC,design)
names(fit)
print(head(fit$coeff))


###################################################
### code chunk number 21: AgiMicroRna.Rnw:743-746
###################################################
CM=cbind(MSC_AvsMSC_B=c(1,-1,0,0),
        MSC_AvsMSC_C=c(1,0,-1,0))
print(CM)


###################################################
### code chunk number 22: AgiMicroRna.Rnw:753-756
###################################################
fit2=contrasts.fit(fit,CM)
names(fit2)
print(head(fit2$coeff))


###################################################
### code chunk number 23: AgiMicroRna.Rnw:762-764
###################################################
fit2=eBayes(fit2)
names(fit2)


###################################################
### code chunk number 24: basicLimma (eval = FALSE)
###################################################
## fit2=basicLimma(esetPROC,design,CM,verbose=TRUE)


###################################################
### code chunk number 25: getDecideTests
###################################################
DE=getDecideTests(fit2,
        DEmethod="separate",
        MTestmethod="BH",
        PVcut=0.10,
	verbose=TRUE)


###################################################
### code chunk number 26: pvalHistogram (eval = FALSE)
###################################################
## pvalHistogram(fit2,
##         DE,
##         PVcut=0.10,
##         DEmethod="separate",
##         MTestmethod="BH",
##         CM,
## 	verbose=TRUE)


###################################################
### code chunk number 27: significantMicroRna (eval = FALSE)
###################################################
## significantMicroRna(esetPROC,
##         ddPROC,
##         targets.micro,
##         fit2,
##         CM,
##         DE,
##         DEmethod="separate",
##         MTestmethod="BH",
##         PVcut=0.10,
##         Mcut=0,
## 	verbose=TRUE)


