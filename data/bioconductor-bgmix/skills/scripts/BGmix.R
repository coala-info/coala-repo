# Code example from 'BGmix' vignette. See references/ for full tutorial.

### R code from vignette source 'BGmix.Rnw'

###################################################
### code chunk number 1: BGmix.Rnw:197-199
###################################################
library(BGmix)
data(ybar,ss)


###################################################
### code chunk number 2: BGmix.Rnw:208-209
###################################################
outdir <- BGmix(ybar, ss, nreps=c(8,8),niter=1000,nburn=1000)


###################################################
### code chunk number 3: BGmix.Rnw:235-236
###################################################
params <- ccParams(file=outdir)


###################################################
### code chunk number 4: BGmix.Rnw:246-247
###################################################
plotBasic(params,ybar,ss)


###################################################
### code chunk number 5: BGmix.Rnw:252-255
###################################################
par(mfrow=c(1,2))
fdr <- calcFDR(params)
plotFDR(fdr)


###################################################
### code chunk number 6: BGmix.Rnw:264-265
###################################################
pred <- ccPred(file=outdir)


###################################################
### code chunk number 7: BGmix.Rnw:270-273
###################################################
par(mfrow=c(1,2))
hist(pred$pval.ss.mix[,1])
hist(pred$pval.ss.mix[,2])


###################################################
### code chunk number 8: BGmix.Rnw:279-281
###################################################
par(mfrow=c(2,3))
plotPredChecks(pred$pval.ybar.mix2,params$pc,probz=0.8)


###################################################
### code chunk number 9: BGmix.Rnw:292-296
###################################################
nreps <- c(8,8)
outdir2 <- BGmix(ybar, ss, nreps=nreps, jstar=-1, niter=1000,nburn=1000)
params2 <- ccParams(outdir2)
res2 <-  ccTrace(outdir2)


###################################################
### code chunk number 10: BGmix.Rnw:299-300
###################################################
tpp.res <- TailPP(res2, nreps=nreps, params2, p.cut = 0.7, plots  = F)


###################################################
### code chunk number 11: BGmix.Rnw:314-317
###################################################
FDR.res <- FDRforTailPP(tpp.res$tpp, a1 = params2$maa[1], a2
= params2$maa[2], n.rep1=nreps[1], n.rep2=nreps[2], p.cut = 0.8)
pi0 <- EstimatePi0(tpp.res$tpp, tpp.res$pp0)


###################################################
### code chunk number 12: BGmix.Rnw:324-327
###################################################
par(mfrow=c(1,2))
histTailPP(tpp.res)
FDRplotTailPP(tpp.res)


###################################################
### code chunk number 13: BGmix.Rnw:379-381
###################################################
unlink("run.1", recursive=TRUE)
unlink("run.2", recursive=TRUE)


