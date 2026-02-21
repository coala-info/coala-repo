# Code example from 'qpcrNorm' vignette. See references/ for full tutorial.

### R code from vignette source 'qpcrNorm.Rnw'

###################################################
### code chunk number 1: loadlib
###################################################
library(qpcrNorm)
data(qpcrBatch.object)


###################################################
### code chunk number 2: demoS4
###################################################
slotNames(qpcrBatch.object)


###################################################
### code chunk number 3: normR
###################################################
mynormRI.data <- normQpcrRankInvariant(qpcrBatch.object, 1)


###################################################
### code chunk number 4: normRgenes
###################################################
mynormRI.data@normGenes


###################################################
### code chunk number 5: normQ
###################################################
mynormQuant.data <- normQpcrQuantile(qpcrBatch.object) 


###################################################
### code chunk number 6: normH
###################################################
mynormHK.data <- normQpcrHouseKeepingGenes(qpcrBatch.object, c("Gpx4"))


###################################################
### code chunk number 7: normZ
###################################################
mynormQuant.data <- normalize(qpcrBatch.object, "quantile") 
mynormHK.data <- normalize(qpcrBatch.object, "housekeepinggenes", c("Gpx4"))


###################################################
### code chunk number 8: qbox
###################################################
boxplot(data.frame(mynormQuant.data@exprs), names=paste("Time", 1:13, sep=""), col="darkgreen", ylab="Ct Value")


###################################################
### code chunk number 9: normHist
###################################################
par(mfrow=c(2,2))
xr <- range(c(qpcrBatch.object@exprs, mynormHK.data@exprs, mynormQuant.data@exprs, mynormRI.data@exprs))
hist(qpcrBatch.object@exprs, breaks=30, prob=T, col="steelblue", main="Raw Data", xlab="Ct value", xlim=xr)
hist(mynormHK.data@exprs, breaks=30, prob=T, col="orange", main="HK-Gene-Normalized Data", xlab="Ct value", xlim=xr) 
hist(mynormQuant.data@exprs, breaks=30, prob=T, col="gold", main="Quantile-Normalized Data", xlab="Ct value", xlim=xr) 
hist(mynormRI.data@exprs, breaks=30, prob=T, col="orchid4", main="Rank-Invariant-Normalized Data", xlab="Ct value", xlim=xr) 


###################################################
### code chunk number 10: cvCalc
###################################################
cvVals <- c(calcCV(qpcrBatch.object), calcCV(mynormHK.data), calcCV(mynormQuant.data), calcCV(mynormRI.data))


###################################################
### code chunk number 11: plotCV
###################################################
barplot(cvVals*100, col=c("steelblue", "orange", "gold", "orchid4"), ylab="Average CV(%)", beside=TRUE, 
	names=c("Raw", "HK", "Quantile", "Rank-Invariant"))
	text(c(.75, 1.9, 3.1, 4.3), rep(2,4), round(cvVals*100, 2))


###################################################
### code chunk number 12: qpcrNorm.Rnw:214-215
###################################################
plotVarMean(mynormQuant.data, mynormHK.data, normTag1="Quantile", normTag2="HK-Gene")


