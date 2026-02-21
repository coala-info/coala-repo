# Code example from 'maskBAD' vignette. See references/ for full tutorial.

### R code from vignette source 'maskBAD.Rnw'

###################################################
### code chunk number 1: AffyBatch
###################################################
library("maskBAD")
data(AffyBatch, package="maskBAD")
data(exmask, package="maskBAD")
## load(system.file("data/AffyBatch.rda", package="maskBAD"))
## load(system.file("data/exmask.rda", package="maskBAD"))


###################################################
### code chunk number 2: AffyBatch
###################################################
## data available by loading data(AffyBatch)
newAffyBatch
exmask <- mask(newAffyBatch,ind=rep(1:2,each=10),verbose=FALSE,useExpr=F)


###################################################
### code chunk number 3: quantile
###################################################
quantile(exmask[[1]]$quality.score,0.22)


###################################################
### code chunk number 4: quantile
###################################################
## add rownames containing x and y coordinates of each probe
rownames(exmask[[1]]) <-apply(exmask[[1]][,c("x","y")],1,
                              function(x)paste(x[1],x[2],sep="."))
## filtering for probes around the choosen cutoff
probesToSee = rownames(exmask[[1]][exmask[[1]]$quality.score<0.03 
  & exmask[[1]]$quality.score >0.028,])
## select a random probe and plot it against 
## all other probes of its probe set
plotProbe(affy=newAffyBatch,probeset=as.character(exmask[[1]][ probesToSee[1],"probeset"]),
          probeXY=probesToSee[1],scan=TRUE,ind=rep(1:2,each=10),
          exmask=exmask$probes,names=FALSE)


###################################################
### code chunk number 5: quantile
###################################################
head(exmask$probes)
head(sequenceMask)
rownames(sequenceMask) <- paste(sequenceMask$x,sequenceMask$y,sep="_")
rownames(exmask$probes)<- paste(exmask$probes$x,exmask$probes$y,sep="_") 

cutoff=0.029
table((exmask$probes[rownames(sequenceMask),"quality.score"]>cutoff)+0,
      sequenceMask$match) 


###################################################
### code chunk number 6: quantile
###################################################
head(exmask$probes[,1:3])
head(sequenceMask[,c(1,2,4)])


###################################################
### code chunk number 7: Err
###################################################
overlapExSeq <- overlapExprExtMasks(exmask$probes[,1:3],
                                    sequenceMask[,c(1,2,4)],verbose=FALSE,
                                    cutoffs=quantile(exmask$probes[,3],seq(0,1,0.05))) 


###################################################
### code chunk number 8: figErr
###################################################
overlapExSeq <- overlapExprExtMasks(exmask$probes[,1:3],
                                    sequenceMask[,c(1,2,4)],verbose=FALSE,
                                    cutoffs=quantile(exmask$probes[,3],seq(0,1,0.05)))


###################################################
### code chunk number 9: Err
###################################################
overlapTests <- overlapExprExtMasks(exmask$probes[,1:3],verbose=FALSE,
                                    sequenceMask[,c(1,2,4)],
                                    wilcox.ks=T,sample=100)


###################################################
### code chunk number 10: figWil1
###################################################
plot(overlapTests$testCutoff[[1]],overlapTests$ksBoot,col="lightgrey",
     main="Kolmogorov-Smirnov Test",xlab="Quality score cutoff", 
     ylab="p value (Kolmogorov-Smirnov Test)",ylim=c(0,1),pch=16,xaxt="n",cex=1.5)
axis(1,at=seq(1,length(unique(overlapTests$testCutoff[[2]])),2),
     labels=signif(unique(overlapTests$testCutoff[[2]]),2)[seq(1,length(unique(overlapTests$testCutoff[[2]])),2)],
     las=3)
lines(which(unique(overlapTests$testCutoff[[2]]) %in% overlapTests$testCutoff[[2]]),
      overlapTests$ksP[!is.na(overlapTests$ksP)],type="p",pch=16,col="red")


###################################################
### code chunk number 11: figWil2
###################################################
plot(overlapTests$testCutoff[[1]],overlapTests$wilcoxonBoot,col="lightgrey",
     main="Wilcoxon Rank Sum Test",xlab="Quality score cutoff",
     ylab="p value (Wilcoxon Rank Sum Test)",ylim=c(0,1),pch=16,xaxt="n",cex=1.5)
axis(1,at=seq(1,length(unique(overlapTests$testCutoff[[2]])),2),
     labels=signif(unique(overlapTests$testCutoff[[2]]),2)[seq(1,length(unique(overlapTests$testCutoff[[2]])),2)],
     las=3)
lines(which(unique(overlapTests$testCutoff[[2]]) %in% overlapTests$testCutoff[[2]]),
      overlapTests$wilcoxonP[!is.na(overlapTests$wilcoxonP)],type="p",pch=16,col="red")


###################################################
### code chunk number 12: figHist
###################################################
hist(exmask[[1]]$quality.score,breaks=100,xlab="mask quality score",main="") 


###################################################
### code chunk number 13: affbs
###################################################
affyBatchAfterMasking <-
  prepareMaskedAffybatch(affy=newAffyBatch,exmask=exmask$probes,
                         cutoff=quantile(exmask[[1]]$quality.score,0.22))

newAffyBatch
affyBatchAfterMasking


###################################################
### code chunk number 14: cdf
###################################################
cdfName(affyBatchAfterMasking[[1]])


###################################################
### code chunk number 15: rmaEx
###################################################
new_cdf=affyBatchAfterMasking[[2]]
head(exprs(rma(affyBatchAfterMasking[[1]])))


###################################################
### code chunk number 16: grmaEx1
###################################################
library(gcrma)
library(hgu95av2probe)
affy.affinities=compute.affinities("hgu95av2",verbose=FALSE)


###################################################
### code chunk number 17: grmaEx2
###################################################
affy.affinities.m=prepareMaskedAffybatch(affy=affy.affinities,
  exmask=exmask$probes,cdfName="MaskedAffinitesCdf")


###################################################
### code chunk number 18: grmaEx2
###################################################
head(exprs(gcrma(affyBatchAfterMasking[[1]],affy.affinities.m)))


