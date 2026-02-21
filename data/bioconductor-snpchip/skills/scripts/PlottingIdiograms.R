# Code example from 'PlottingIdiograms' vignette. See references/ for full tutorial.

### R code from vignette source 'PlottingIdiograms.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: packages
###################################################
library(SNPchip)


###################################################
### code chunk number 2: chr1
###################################################
plotIdiogram("1", build="hg19", cex=0.8)


###################################################
### code chunk number 3: chr1NoLabels
###################################################
plotIdiogram("1", build="hg19", cex=0.8, label.cytoband=FALSE)


###################################################
### code chunk number 4: differentCoordinates
###################################################
plotIdiogram("1", build="hg19", cex=0.8, label.cytoband=FALSE, ylim=c(0,1), cytoband.ycoords=c(0.1, 0.3))


###################################################
### code chunk number 5: allchrom
###################################################
library(oligoClasses)
sl <- getSequenceLengths("hg19")[c(paste("chr", 1:22, sep=""), "chrX", "chrY")]
ybottom <- seq(0, 1, length.out=length(sl)) - 0.01
ytop <- seq(0, 1, length.out=length(sl)) + 0.01
for(i in seq_along(sl)){
	chr <- names(sl)[i]
	if(i == 1){
		plotIdiogram("1", build="hg19", cex=0.8, label.cytoband=FALSE, ylim=c(-0.05,1.05), cytoband.ycoords=c(ybottom[1], ytop[1]),
			     xlim=c(0, max(sl)))
	}
	if(i > 1){
		plotIdiogram(names(sl)[i], build="hg19", cex=0.8, label.cytoband=FALSE, cytoband.ycoords=c(ybottom[i], ytop[i]), new=FALSE)
	}
}
axis(1, at=pretty(c(0, max(sl)), n=10), labels=pretty(c(0, max(sl)), n=10)/1e6, cex.axis=0.8)
mtext("position (Mb)", 1, line=2)
par(las=1)
axis(2, at=ybottom+0.01, names(sl), cex.axis=0.6)


###################################################
### code chunk number 6: PlottingIdiograms.Rnw:85-86
###################################################
toLatex(sessionInfo())


