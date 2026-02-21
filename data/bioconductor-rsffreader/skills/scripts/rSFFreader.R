# Code example from 'rSFFreader' vignette. See references/ for full tutorial.

### R code from vignette source 'rSFFreader.Rnw'

###################################################
### code chunk number 1: options
###################################################
options(width=60)


###################################################
### code chunk number 2: preliminaries
###################################################
library("rSFFreader")
library("xtable")


###################################################
### code chunk number 3: Reads454
###################################################
sff <- readSff(system.file("extdata","Small454Test.sff",package="rSFFreader"))


###################################################
### code chunk number 4: x1
###################################################
sread(sff)
quality(sff)
header(sff)


###################################################
### code chunk number 5: ReadLengths
###################################################
hist(width(sff), xlab="Read Lengths", 
     main=paste("Histogram of read lengths using", clipMode(sff), "clip mode."), 
     breaks=100)


###################################################
### code chunk number 6: clipmode
###################################################
availableClipModes(sff)
clipMode(sff)
clipMode(sff) <- "raw"
hist(width(sff), xlab="Read Lengths", 
     main=paste("Histogram of read lengths using", clipMode(sff), "clip mode."), 
     breaks=100)


###################################################
### code chunk number 7: IR
###################################################
customClip(sff) <- IRanges(start = 1, end = 15)
clipMode(sff) <- "custom"
t = table(counts=as.character(sread(sff)))


###################################################
### code chunk number 8: texTable
###################################################
xtable(as.table(table(counts=as.character(sread(sff)))[table(as.character(sread(sff)))>2]))


###################################################
### code chunk number 9: qa
###################################################
## Generate some QA plots:
## Read length histograms:
par(mfrow=c(2,2))
clipMode(sff) <- "raw"
hist(width(sff),breaks=500,col="grey",xlab="Read Length",main="Raw Read Length")

clipMode(sff) <- "full"
hist(width(sff),breaks=500,col="grey",xlab="Read Length",main="Clipped Read Length")

## Base by position plots:
clipMode(sff) <- "raw"
ac <- alphabetByCycle(sread(sff),alphabet=c("A","C","T","G","N"))
ac.reads <- apply(ac,2,sum)
acf <- sweep(ac,MARGIN=2,FUN="/",STATS=apply(ac,2,sum))

matplot(cbind(t(acf),ac.reads/ac.reads[1]),col=c("green","blue","black","red","darkgrey","purple"),
          type="l",lty=1,xlab="Base Position",ylab="Base Frequency",
          main="Base by position")
cols <- c("green","blue","black","red","darkgrey","purple")
leg <-  c("A","C","T","G","N","% reads")
legend("topright", col=cols, legend=leg, pch=18, cex=.8)

clipMode(sff) <- "full"
ac <- alphabetByCycle(sread(sff),alphabet=c("A","C","T","G","N"))
ac.reads <- apply(ac,2,sum)
acf <- sweep(ac,MARGIN=2,FUN="/",STATS=apply(ac,2,sum))

matplot(cbind(t(acf),ac.reads/ac.reads[1]),col=c("green","blue","black","red","darkgrey","purple"),
          type="l",lty=1,xlab="Base Position",ylab="Base Frequency",
          main="Base by position")
legend("topright", col=cols, legend=leg, pch=18, cex=.8)



