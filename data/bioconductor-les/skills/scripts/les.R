# Code example from 'les' vignette. See references/ for full tutorial.

### R code from vignette source 'les.Rnw'

###################################################
### code chunk number 1: les.Rnw:44-46
###################################################
set.seed(1)
options(width=65, SweaveHooks=list(fig=function() par(mar=c(5.1, 5.1, 2.1, 1.1))))


###################################################
### code chunk number 2: loadData
###################################################
library(les)
data(spikeInData)
head(exprs)
dim(exprs)
pos <- as.integer(rownames(exprs))
condition <- as.integer(colnames(exprs))
reference
region <- as.vector(reference[ ,c("start", "end")])


###################################################
### code chunk number 3: estimateProbeLevelStatistics
###################################################
library(limma)
design <- cbind(offset=1, diff=condition)
fit <- lmFit(exprs, design)
fit <- eBayes(fit)
pval <- fit$p.value[, "diff"]


###################################################
### code chunk number 4: plotProbeLevelStatistics
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(pos, pval, pch=20, xlab="Probe position", ylab=expression(p))
abline(v=region)


###################################################
### code chunk number 5: constructLes
###################################################
res <- Les(pos, pval)


###################################################
### code chunk number 6: estimateLes
###################################################
res <- estimate(res, win=200)


###################################################
### code chunk number 7: showPlotLes
###################################################
getOption("SweaveHooks")[["fig"]]()
res
summary(res)
plot(res)
abline(v=region)


###################################################
### code chunk number 8: showPlotLes2
###################################################
getOption("SweaveHooks")[["fig"]]()
res2 <- estimate(res, win=200, weighting=rectangWeight)
res2
plot(res2)
abline(v=region)


###################################################
### code chunk number 9: threshold
###################################################
res2 <- threshold(res2, grenander=TRUE, verbose=TRUE)


###################################################
### code chunk number 10: regions
###################################################
res2 <- regions(res2, verbose=TRUE)
res2
res2["regions"]


###################################################
### code chunk number 11: plotRegions
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(res2, region=TRUE)
abline(v=region)


###################################################
### code chunk number 12: plotCi
###################################################
getOption("SweaveHooks")[["fig"]]()
subset <- pos >= 5232400 & pos <= 5233100
res2 <- ci(res2, subset, nBoot=50, alpha=0.1)
plot(res2, error="ci", region=TRUE)


###################################################
### code chunk number 13: plotOptions
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(res2, error="ci", region=TRUE, rug=TRUE, xlim=c(5232000, 5233000), sigArgs=list(col="firebrick4"), plotArgs=list(main="LES results", yaxp=c(0, 1, 2)), limitArgs=list(lty=2, lwd=3), regionArgs=list(col="black", density=20), probeArgs=list(col="dodgerblue4", type="p"))


###################################################
### code chunk number 14: export
###################################################
bedFile <- paste(tempfile(), "bed", sep=".")
gffFile <- paste(tempfile(), "gff", sep=".")
wigFile <- paste(tempfile(), "wig", sep=".")
export(res2, bedFile)
export(res2, gffFile, format="gff")
export(res2, wigFile, format="wig")


###################################################
### code chunk number 15: customWeightingFunction
###################################################
weightFoo <- function(distance, win) {
weight <- 1 - distance/win
return(weight)
}
resFoo <- estimate(res, 200, weighting=weightFoo)


###################################################
### code chunk number 16: chi2 (eval = FALSE)
###################################################
## regions <- res["regions"]
## winsize <- seq(100, 300, by=20)
## res2 <- chi2(res2, winsize, regions, offset=2500)
## plot(winsize, x["chi2"], type="b")


###################################################
### code chunk number 17: sessionInfo
###################################################
toLatex(sessionInfo(), locale=FALSE)


