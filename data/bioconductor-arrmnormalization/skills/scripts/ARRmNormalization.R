# Code example from 'ARRmNormalization' vignette. See references/ for full tutorial.

### R code from vignette source 'ARRmNormalization.Rnw'

###################################################
### code chunk number 1: dataLoading
###################################################
library(ARRmData)
data(greenControlMatrix)
data(redControlMatrix)
data(betaMatrix)
data(sampleNames)


###################################################
### code chunk number 2: printBetaMatrix
###################################################
betaMatrix[1:5,1:3]


###################################################
### code chunk number 3: printControlMatrices
###################################################
greenControlMatrix[1:5,1:3]
redControlMatrix[1:5,1:3]


###################################################
### code chunk number 4: probesLoading
###################################################
library(ARRmNormalization)
data(ProbesType)
head(ProbesType)


###################################################
### code chunk number 5: printSampleNames
###################################################
head(sampleNames)


###################################################
### code chunk number 6: packageLoading
###################################################
library(ARRmNormalization)


###################################################
### code chunk number 7: dataPackageLoading
###################################################
library(ARRmData)


###################################################
### code chunk number 8: dataLoading2
###################################################
data(betaMatrix)
data(greenControlMatrix)
data(redControlMatrix)
data(sampleNames)


###################################################
### code chunk number 9: getBackground
###################################################
backgroundInfo <- getBackground(greenControlMatrix, redControlMatrix)


###################################################
### code chunk number 10: printBackground
###################################################
head(backgroundInfo)


###################################################
### code chunk number 11: printSampleNames
###################################################
head(sampleNames)


###################################################
### code chunk number 12: getDesignInfo
###################################################
designInfo <- getDesignInfo(sampleNames)
head(designInfo)


###################################################
### code chunk number 13: explicitDesign
###################################################
myChipVector <- c(rep(1,12), rep(2, 12), rep(3, 12))
myPositionVector <- rep(seq(1:12), 3)


###################################################
### code chunk number 14: getExplicitDesign
###################################################
designInfo <- getDesignInfo(sampleNames=NULL, 
                  positionVector=myPositionVector, chipVector=myChipVector)
head(designInfo)


###################################################
### code chunk number 15: firstNorm (eval = FALSE)
###################################################
## normMatrix <- 
##     normalizeARRm(betaMatrix=betaMatrix, designInfo=designInfo,
##         backgroundInfo=backgroundInfo, outliers.perc=0.1)


###################################################
### code chunk number 16: goodProbes
###################################################
data(ProbesType) 
goodProbes <- as.character(unlist(ProbesType$Probe_Name))[seq(1,485577,2)]


###################################################
### code chunk number 17: normGoodProbes (eval = FALSE)
###################################################
## normMatrix <- 
##     normalizeARRm(betaMatrix=betaMatrix, designInfo=designInfo,
##         backgroundInfo=backgroundInfo, outliers.perc=0, goodProbes=goodProbes)


###################################################
### code chunk number 18: normWOChip (eval = FALSE)
###################################################
## normMatrix <- 
##     normalizeARRm(betaMatrix=betaMatrix, designInfo=designInfo,
##         backgroundInfo=backgroundInfo, outliers.perc=0, chipCorrection=F)


###################################################
### code chunk number 19: getQuantiles
###################################################
quantiles=getQuantiles(betaMatrix)
attributes(quantiles)


###################################################
### code chunk number 20: printQuantiles
###################################################
quantiles=getQuantiles(betaMatrix, goodProbes=goodProbes)
attributes(quantiles)


###################################################
### code chunk number 21: printQuantiles2
###################################################
quantiles$II[1:5,1:4]


###################################################
### code chunk number 22: quantilesPlots
###################################################
quantilePlots(quantiles, backgroundInfo, designInfo)


###################################################
### code chunk number 23: plot1
###################################################
myColors=rep(c("black","red"),10)
	cex=1
	pch=rep(c(20,18),10)
	lwd=1.5
	percentilesI=seq(1,100,5)
	percentilesII=seq(1,100,10)
	y<-seq(from=-0.1,to=1,by=11/100)
	quantilesList=list(quantiles$green, quantiles$red, quantiles$II)
backgroundList = 
  list(log(backgroundInfo$green), log(backgroundInfo$red), log(backgroundInfo$red*backgroundInfo$green))
	titles=c("Background effects on different percentiles - Inf I Green",
           "Background effects on different percentiles - Inf I Red",
           "Background effects on different percentiles - Infinium II")
j=3
if (j==1 || j==2){percentiles=percentilesI} else {percentiles=percentilesII}
		currentQuantiles=quantilesList[[j]]
    	background=backgroundList[[j]]
		x<-seq(from=min(background), 
           to=max(background)+0.5, 
               by=(max(background+0.5)-min(background))/10)


###################################################
### code chunk number 24: fig1plot
###################################################
plot(x,y,type="n",xlab="Log Background intensity",ylab="Beta value",main=titles[j])
		for (i in 1:length(percentiles)){
			currentP=percentiles[i]
			points(unlist(background), 
                 unlist(currentQuantiles[currentP,]),
                     col=myColors[i],
                         pch=pch[i],
                             cex=cex)
			abline(lm(unlist(currentQuantiles[currentP,])~background),col="black",lwd=lwd)
		}	


###################################################
### code chunk number 25: fig1
###################################################
plot(x,y,type="n",xlab="Log Background intensity",ylab="Beta value",main=titles[j])
		for (i in 1:length(percentiles)){
			currentP=percentiles[i]
			points(unlist(background), 
                 unlist(currentQuantiles[currentP,]),
                     col=myColors[i],
                         pch=pch[i],
                             cex=cex)
			abline(lm(unlist(currentQuantiles[currentP,])~background),col="black",lwd=lwd)
		}	


###################################################
### code chunk number 26: plotDyeBias
###################################################
myColors=rep(c("black","red"),10)
	cex=1
	pch=rep(c(20,18),10)
	lwd=1.5
	percentilesI=seq(1,100,5)
	percentilesII=seq(1,100,10)
	y<-seq(from=-0.1,to=1,by=11/100)
	quantilesList=list(quantiles$green,quantiles$red,quantiles$II)

	## Dye bias plot
	dyebias=log(backgroundInfo$green/backgroundInfo$red)
	currentQuantile=quantilesList[[3]]
	percentiles=percentilesII
	x <- seq(from=min(dyebias),
           to=max(dyebias)+0.5,
               by=(max(dyebias+0.5)-min(dyebias))/10)


###################################################
### code chunk number 27: fig2plot
###################################################
plot(x,y,type="n",xlab="Dye bias",ylab="Beta value",main="Dye bias effects on different percentiles - Infinium II" )
		for (i in 1:length(percentiles)){
			currentP=percentiles[i]
			points(unlist(dyebias), 
             unlist(currentQuantile[currentP,]), 
                 col=myColors[i],pch=pch[i],cex=cex)
			abline(lm(unlist(currentQuantile[currentP,])~dyebias),col="black",lwd=lwd)
		}	


###################################################
### code chunk number 28: fig2
###################################################
plot(x,y,type="n",xlab="Dye bias",ylab="Beta value",main="Dye bias effects on different percentiles - Infinium II" )
		for (i in 1:length(percentiles)){
			currentP=percentiles[i]
			points(unlist(dyebias), 
             unlist(currentQuantile[currentP,]), 
                 col=myColors[i],pch=pch[i],cex=cex)
			abline(lm(unlist(currentQuantile[currentP,])~dyebias),col="black",lwd=lwd)
		}	


###################################################
### code chunk number 29: positionPlots
###################################################
positionPlots(quantiles, designInfo, percentiles=c(25, 50, 75))


###################################################
### code chunk number 30: examplePositionPlots
###################################################
	quantilesList= list(quantiles$green, quantiles$red, quantiles$II)
	percentiles=c(75)
	#### To look at the position deviations from the mean
	grandMeansList<-list()
	centeredQuantiles<-list()
	for (i in 1:3){grandMeansList[[i]]=apply(quantiles[[i]],1,mean)}
	for (i in 1:3){centeredQuantiles[[i]]=quantiles[[i]]-grandMeansList[[i]]}
	chipCenteredQuantiles=centeredQuantiles
	chipInfo=as.numeric(designInfo$chipInfo)
	chipIndices=unique(as.numeric(designInfo$chipInfo))
	for (i in 1:3){
		currentQuantiles=chipCenteredQuantiles[[i]]
		for (j in 1:length(chipInfo)){
			chipQuantiles=currentQuantiles[,which(chipInfo==chipIndices[j])]
			mean=apply(chipQuantiles,1,mean)
			chipQuantiles=chipQuantiles-mean
			currentQuantiles[,which(chipInfo==chipIndices[j])]=chipQuantiles
		}
		chipCenteredQuantiles[[i]]=currentQuantiles
	}

	### Position lines
	order=order(designInfo$positionInfo)
	for (i in 1:3){
    chipCenteredQuantiles[[i]]= chipCenteredQuantiles[[i]][,order]
	}
	newpositions= designInfo$positionInfo[order]
	lines=c()
	for (i in 1:(length(newpositions)-1)){
	if (newpositions[i+1]!=newpositions[i]){lines=c(lines,i+0.5)}
	}

	## Tick marks for position axis
	ticks=c()
	tick1=lines[1]/2
	lastTick=(nrow(designInfo)+lines[11])/2
	ticks=tick1
	for (i in 2:11){ticks=c(ticks,(lines[i]+lines[i-1])/2)}
	ticks=c(ticks,lastTick)


###################################################
### code chunk number 31: fig3plot
###################################################
	for (percIndex in 1:length(percentiles)){
		currentPerc=percentiles[percIndex]
		percStr=paste("Positions Variations - ",currentPerc,"th Percentile")
		titles=c(paste(percStr,"Inf I Green"), 
                 paste(percStr,"Inf I Red"), 
                     paste(percStr,"Inf II"))
    
		for (k in 3:3){
			plot(chipCenteredQuantiles[[k]][currentPerc,], 
           xaxt='n',ylab="Beta value deviations",xlab="Chip Positions",
               cex=1,pch=20,main=titles[k])
    
			axis (1, at = ticks,labels=1:12)
			abline(h=0)
			for (j in 1:length(lines)){abline(v=lines[j],lty=2)}
		}
	}


###################################################
### code chunk number 32: fig3
###################################################
	for (percIndex in 1:length(percentiles)){
		currentPerc=percentiles[percIndex]
		percStr=paste("Positions Variations - ",currentPerc,"th Percentile")
		titles=c(paste(percStr,"Inf I Green"), 
                 paste(percStr,"Inf I Red"), 
                     paste(percStr,"Inf II"))
    
		for (k in 3:3){
			plot(chipCenteredQuantiles[[k]][currentPerc,], 
           xaxt='n',ylab="Beta value deviations",xlab="Chip Positions",
               cex=1,pch=20,main=titles[k])
    
			axis (1, at = ticks,labels=1:12)
			abline(h=0)
			for (j in 1:length(lines)){abline(v=lines[j],lty=2)}
		}
	}


###################################################
### code chunk number 33: getCoefficients
###################################################
coefficients <- getCoefficients(quantiles, designInfo, backgroundInfo, outliers.perc=0.02)
attributes(coefficients)


###################################################
### code chunk number 34: printCoefficients
###################################################
attributes(coefficients$II)


