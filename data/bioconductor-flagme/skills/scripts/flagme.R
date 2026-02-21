# Code example from 'flagme' vignette. See references/ for full tutorial.

### R code from vignette source 'flagme.Rnw'

###################################################
### code chunk number 1: libraries
###################################################
require(gcspikelite)
library(flagme)


###################################################
### code chunk number 2: rawdata
###################################################
gcmsPath <- paste(find.package("gcspikelite"), "data", sep="/")
data(targets)
cdfFiles <- paste(gcmsPath, targets$FileName, sep="/")
eluFiles <- gsub("CDF", "ELU", cdfFiles)
pd <- peaksDataset(cdfFiles, mz=seq(50,550), rtrange=c(7.5,8.5))
pd <- addAMDISPeaks(pd, eluFiles)
pd


###################################################
### code chunk number 3: addXCMS
###################################################
pd.2 <- peaksDataset(cdfFiles[1:3], mz = seq(50, 550), rtrange = c(7.5, 8.5))
mfp <- xcms::MatchedFilterParam(fwhm = 10, snthresh = 5)
pd.2 <- addXCMSPeaks(cdfFiles[1:3], pd.2, settings = mfp)
pd.2


###################################################
### code chunk number 4: plotexample1
###################################################
plotChrom(pd, rtrange=c(7.5,8.5), plotPeaks=TRUE, plotPeakLabels=TRUE,
     max.near=8, how.near=0.5, col=rep(c("blue","red","black"), each=3))


###################################################
### code chunk number 5: plotexample2
###################################################
r <- 1
plotImage(pd, run=r, rtrange=c(7.5,8.5), main="")
v <- which(pd@peaksdata[[r]] > 0, arr.ind=TRUE) # find detected peaks
abline(v=pd@peaksrt[[r]])
points(pd@peaksrt[[r]][v[,2]], pd@mz[v[,1]], pch=19, cex=.6, col="white")


###################################################
### code chunk number 6: pairwisealignexample
###################################################
Ds <- c(0.1, 10, 0.1, 0.1)
gaps <- c(0.5, 0.5, 0.1, 0.9)
par(mfrow=c(2,2), mai=c(0.8466,0.4806,0.4806,0.1486))
for(i in 1:4){
  pa <- peaksAlignment(pd@peaksdata[[1]], pd@peaksdata[[2]],
                       pd@peaksrt[[1]], pd@peaksrt[[2]], D=Ds[i],
                       gap=gaps[i], metric=1, type=1, compress = FALSE) 
  plotAlignment(pa, xlim=c(0, 17), ylim=c(0, 16), matchCol="yellow",
       main=paste("D=", Ds[i], " gap=", gaps[i], sep=""))
}


###################################################
### code chunk number 7: multiplealignment
###################################################
print(targets)
ma <- multipleAlignment(pd, group=targets$Group, wn.gap=0.5, wn.D=.05,
                        bw.gap=.6, bw.D=0.05, usePeaks=TRUE, filterMin=1, 
                        df=50, verbose=FALSE, metric = 1, type = 1) # bug
ma


###################################################
### code chunk number 8: multiplealignmentfig
###################################################
plotChrom(pd, rtrange=c(7.5,8.5), runs=ma@betweenAlignment@runs,
     mind=ma@betweenAlignment@ind, plotPeaks=TRUE,
     plotPeakLabels=TRUE, max.near=8, how.near=.5,
     col=rep(c("blue","red","black"), each=3))


###################################################
### code chunk number 9: correlationAlignment (eval = FALSE)
###################################################
## mp <- correlationAlignment(object=pd.2, thr=0.85, D=20, penality=0.2,
##                            normalize=TRUE, minFilter=1)
## mp


###################################################
### code chunk number 10: multiplealignmentres
###################################################
ma@betweenAlignment@runs
ma@betweenAlignment@ind


###################################################
### code chunk number 11: alignmentres
###################################################
outList <- gatherInfo(pd,ma)
outList[[8]]
rtmat <- matrix(unlist(lapply(outList,.subset,"rt"), use.names=FALSE),
                nr=length(outList), byrow=TRUE)
colnames(rtmat) <- names(outList[[1]]$rt); rownames(rtmat) <- 1:nrow(rtmat)
round(rtmat, 3)


###################################################
### code chunk number 12: session
###################################################
sessionInfo()
date()


