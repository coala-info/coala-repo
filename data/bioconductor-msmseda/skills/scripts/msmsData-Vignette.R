# Code example from 'msmsData-Vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'msmsData-Vignette.Rnw'

###################################################
### code chunk number 1: msmsData-Vignette.Rnw:87-88
###################################################
options(continue=" ")


###################################################
### code chunk number 2: Chunk0
###################################################
  library(msmsEDA)
  data(msms.dataset)
  msms.dataset
  dim(msms.dataset)
  head(pData(msms.dataset))
  table(pData(msms.dataset)$treat)
  table(pData(msms.dataset)$batch)
  table(pData(msms.dataset)$treat, pData(msms.dataset)$batch)


###################################################
### code chunk number 3: Chunk1
###################################################
e <- pp.msms.data(msms.dataset)
processingData(e)
dim(e)  
setdiff(featureNames(msms.dataset), featureNames(e))


###################################################
### code chunk number 4: Chunk2
###################################################
tfvnm <- count.stats(e)  
{ cat("\nSample statistics after removing NAs and -R:\n\n")
  cat("SpC matrix dimension:",dim(e),"\n\n")
  print(tfvnm)
}


###################################################
### code chunk number 5: msmsData-Vignette.Rnw:160-164
###################################################
layout(mat=matrix(1:2,ncol=1),widths=1,heights=c(0.35,0.65))
spc.barplots(exprs(e),fact=pData(e)$treat)
spc.boxplots(exprs(e),fact=pData(e)$treat,minSpC=2,
             main="UPS1 200fm vs 600fm")


###################################################
### code chunk number 6: msmsData-Vignette.Rnw:172-174
###################################################
spc.densityplots(exprs(e),fact=pData(e)$treat,minSpC=2,
                 main="UPS1 200fm vs 600fm")


###################################################
### code chunk number 7: msmsData-Vignette.Rnw:189-196
###################################################
facs <- pData(e)
snms <- substr(as.character(facs$treat),1,2)
snms <- paste(snms,as.integer(facs$batch),sep=".")
par(mar=c(4,4,0.5,2)+0.1)
par(mfrow=c(2,1))
counts.pca(e, facs = pData(e)[, "treat", drop = FALSE],snms=snms)
counts.pca(e, facs = pData(e)[, "batch", drop = FALSE],snms=snms)


###################################################
### code chunk number 8: ChunkPCA
###################################################
facs <- pData(e)
snms <- substr(as.character(facs$treat),1,2)
snms <- paste(snms,as.integer(facs$batch),sep=".")
pcares <- counts.pca(e)
smpl.pca <- pcares$pca
{ cat("Principal components analisis on the raw SpC matrix\n")
  cat("Variance of the first four principal components:\n\n")
  print(summary(smpl.pca)$importance[,1:4])
}


###################################################
### code chunk number 9: msmsData-Vignette.Rnw:230-231
###################################################
counts.hc(e,facs=pData(e)[, "treat", drop = FALSE])


###################################################
### code chunk number 10: msmsData-Vignette.Rnw:240-241
###################################################
counts.hc(e,facs=pData(e)[, "batch", drop = FALSE])


###################################################
### code chunk number 11: msmsData-Vignette.Rnw:261-262
###################################################
counts.heatmap(e,etit="UPS1",fac=pData(e)[, "treat"])


###################################################
### code chunk number 12: ChunkMC
###################################################
data(msms.dataset)
msnset <- pp.msms.data(msms.dataset)
spcm <- exprs(msnset)
fbatch <- pData(msnset)$batch
spcm2 <- batch.neutralize(spcm, fbatch, half=TRUE, sqrt.trans=TRUE)


###################################################
### code chunk number 13: msmsData-Vignette.Rnw:299-307
###################################################
###  Plot the PCA on the two first PC, and colour by treatment level
###  to visualize the improvement.
exprs(msnset) <- spcm2
facs <- pData(e)
snms <- substr(as.character(facs$treat),1,2)
snms <- paste(snms,as.integer(facs$batch),sep=".")
par(mar=c(4,4,0.5,2)+0.1)
counts.pca(msnset, facs=facs$treat, do.plot=TRUE, snms=snms)


###################################################
### code chunk number 14: ChunkMC2
###################################################
###  Incidence of the correction
summary(as.vector(spcm-spcm2))
plot(density(as.vector(spcm-spcm2)))


###################################################
### code chunk number 15: ChunkPCA
###################################################
dsp <- disp.estimates(e)
signif(dsp,4)


###################################################
### code chunk number 16: msmsData-Vignette.Rnw:361-364
###################################################
par(mar=c(5,4,0.5,2)+0.1,cex.lab=0.8,cex.axis=0.8,cex.main=1.2)
par(mfrow=c(2,1))
disp.estimates(e,facs=pData(e)[, "batch", drop = FALSE])


###################################################
### code chunk number 17: msmsData-Vignette.Rnw:385-387
###################################################
spc.scatterplot(spcm2,facs$treat,trans="sqrt",minSpC=2,minLFC=1,
                main="UPS1 200fm vs 600fm")


