# Code example from 'GLAD' vignette. See references/ for full tutorial.

### R code from vignette source 'GLAD.Rnw'

###################################################
### code chunk number 1: GLAD.Rnw:113-114
###################################################
require(GLAD)


###################################################
### code chunk number 2: GLAD.Rnw:118-133
###################################################
data(snijders)

profileCGH <- as.profileCGH(gm13330)


res <- glad(profileCGH, mediancenter=FALSE,
                smoothfunc="lawsglad", bandwidth=10, round=1.5,
                model="Gaussian", lkern="Exponential", qlambda=0.999,
                base=FALSE,
                lambdabreak=8, lambdacluster=8, lambdaclusterGen=40,
                type="tricubic", param=c(d=6),
                alpha=0.001, msize=2,
                method="centroid", nmax=8,
                verbose=FALSE)



###################################################
### code chunk number 3: GLAD.Rnw:141-143
###################################################
data(cytoband)
plotProfile(res, unit=3, Bkp=TRUE, labels=FALSE, plotband=FALSE, Smoothing="Smoothing", cytoband = cytoband)


###################################################
### code chunk number 4: GLAD.Rnw:155-168
###################################################
data(veltman)

profileCGH <- as.profileCGH(P9)

profileCGH <- daglad(profileCGH, mediancenter=FALSE, normalrefcenter=FALSE, genomestep=FALSE,
                     smoothfunc="lawsglad", lkern="Exponential", model="Gaussian",
                     qlambda=0.999,  bandwidth=10, base=FALSE, round=1.5,
                     lambdabreak=8, lambdaclusterGen=40, param=c(d=6), alpha=0.001, msize=2,
                     method="centroid", nmin=1, nmax=8,
                     amplicon=1, deletion=-5, deltaN=0.2,  forceGL=c(-0.3,0.3), nbsigma=3,
                     MinBkpWeight=0.35, CheckBkpPos=TRUE)




###################################################
### code chunk number 5: GLAD.Rnw:174-177
###################################################
plotProfile(profileCGH, Smoothing="Smoothing", Bkp=TRUE, plotband=FALSE, cytoband = cytoband)
abline(h=c(-0.3,-0.2,0.2,0.3),col=c("green","black","black","red"))
axis(2,at=c(-0.3,-0.2,0.2,0.3), labels=c("forceGL[1]","-deltaN","+deltaN","forceGL[2]"), las=2)


###################################################
### code chunk number 6: GLAD.Rnw:196-209
###################################################
data(veltman)

profileCGH <- as.profileCGH(P9)

profileCGH <- daglad(profileCGH, mediancenter=FALSE, normalrefcenter=FALSE, genomestep=FALSE,
                     smoothfunc="lawsglad", lkern="Exponential", model="Gaussian",
                     qlambda=0.999,  bandwidth=10, base=FALSE, round=1.5,
                     lambdabreak=8, lambdaclusterGen=40, param=c(d=6), alpha=0.001, msize=2,
                     method="centroid", nmin=1, nmax=8,
                     amplicon=1, deletion=-5, deltaN=0.10,  forceGL=c(-0.15,0.15), nbsigma=3,
                     MinBkpWeight=0.35, CheckBkpPos=TRUE)




###################################################
### code chunk number 7: GLAD.Rnw:215-218
###################################################
plotProfile(profileCGH, Smoothing="Smoothing", Bkp=TRUE, plotband=FALSE, cytoband = cytoband)
abline(h=c(-0.15,-0.1,0.1,0.15),col=c("green","black","black","red"))
axis(2,at=c(-0.15,-0.1,0.1,0.15), labels=c("forceGL[1]","-deltaN","+deltaN","forceGL[2]"), las=2)


###################################################
### code chunk number 8: GLAD.Rnw:252-258
###################################################
data(arrayCGH)

# object of class arrayCGH

array <- list(arrayValues=array2, arrayDesign=c(4,4,21,22))
class(array) <- "arrayCGH"


###################################################
### code chunk number 9: GLAD.Rnw:266-267
###################################################
arrayPlot(array,"Log2Rat", bar="none")


###################################################
### code chunk number 10: GLAD.Rnw:277-278
###################################################
arrayPersp(array,"Log2Rat", box=FALSE, theta=110, phi=40, bar=FALSE)


###################################################
### code chunk number 11: GLAD.Rnw:287-302
###################################################
data(snijders)

profileCGH <- as.profileCGH(gm13330)


res <- glad(profileCGH, mediancenter=FALSE,
                smoothfunc="lawsglad", bandwidth=10, round=2,
                model="Gaussian", lkern="Exponential", qlambda=0.999,
                base=FALSE,
                lambdabreak=8, lambdacluster=8, lambdaclusterGen=40,
                type="tricubic", param=c(d=6),
                alpha=0.001, msize=2,
                method="centroid", nmax=8,
                verbose=FALSE)



###################################################
### code chunk number 12: GLAD.Rnw:309-310
###################################################
plotProfile(res, unit=3, Bkp=TRUE, labels=FALSE, Smoothing="Smoothing", plotband=FALSE, cytoband = cytoband)


###################################################
### code chunk number 13: GLAD.Rnw:319-320
###################################################
plotProfile(res, unit=3, Bkp=TRUE, labels=FALSE, Smoothing="Smoothing", cytoband = cytoband)


###################################################
### code chunk number 14: GLAD.Rnw:328-331
###################################################
text <- list(x=c(90000,200000),y=c(0.15,0.3),labels=c("NORMAL","GAIN"), cex=2)
plotProfile(res, unit=3, Bkp=TRUE, labels=TRUE, Chromosome=1,
Smoothing="Smoothing", plotband=FALSE, text=text, cytoband = cytoband)


###################################################
### code chunk number 15: GLAD.Rnw:339-342
###################################################
text <- list(x=c(90000,200000),y=c(0.15,0.3),labels=c("NORMAL","GAIN"), cex=2)
plotProfile(res, unit=3, Bkp=TRUE, labels=TRUE, Chromosome=1,
Smoothing="Smoothing", text=text, main="Chromosome 1", cytoband = cytoband)


