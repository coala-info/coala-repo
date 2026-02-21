# Code example from 'XDE' vignette. See references/ for full tutorial.

### R code from vignette source 'XDE.Rnw'

###################################################
### code chunk number 1: XDE.Rnw:47-48
###################################################
options(width=60)


###################################################
### code chunk number 2: data
###################################################
library(XDE)
data(expressionSetList)
xlist <- expressionSetList
class(xlist)


###################################################
### code chunk number 3: validObject
###################################################
validObject(xlist)


###################################################
### code chunk number 4: covariate
###################################################
stopifnot(all(sapply(xlist, function(x, label){ label %in% varLabels(x)}, label="adenoVsquamous")))


###################################################
### code chunk number 5: initializeList
###################################################
params <- new("XdeParameter", esetList=xlist, phenotypeLabel="adenoVsquamous")
params


###################################################
### code chunk number 6: initializeList2 (eval = FALSE)
###################################################
## params <- new("XdeParameter", esetList=xlist,
## 	      phenotypeLabel="adenoVsquamous", one.delta=FALSE)


###################################################
### code chunk number 7: empiricalStart (eval = FALSE)
###################################################
## params <- new("XdeParameter", esetList=xlist, phenotypeLabel="adenoVsquamous", one.delta=FALSE)
## empirical <- empiricalStart(xlist, phenotypeLabel="adenoVsquamous")
## firstMcmc(params) <- empirical


###################################################
### code chunk number 8: burnin (eval = FALSE)
###################################################
## iterations(params) <- 3
## burnin(params) <- TRUE
## fit <- xde(params, xlist)


###################################################
### code chunk number 9: moreIterations (eval = FALSE)
###################################################
## iterations(params) <- 2
## fit2 <- xde(params, xlist, fit)


###################################################
### code chunk number 10: firstMcmc (eval = FALSE)
###################################################
## firstMcmc(params) <- lastMcmc(fit)
## seed(params) <- seed(fit)
## fit2 <- xde(params, xlist)


###################################################
### code chunk number 11: runMoreIterations (eval = FALSE)
###################################################
## burnin(params) <- FALSE
## iterations(params) <- 2000
## output(params)[c("potential", "acceptance",
## 		 "diffExpressed",
## 		 "nu", ##"DDelta",
##                  ##"delta",
## 		 "probDelta",
## 		 ##"sigma2",
## 		 "phi")] <- 0
## thin(params) <- 2
## directory(params) <- "logFiles"
## xmcmc <- xde(params, xlist)


###################################################
### code chunk number 12: savexmcmc (eval = FALSE)
###################################################
## ##this function should work
## postAvg <- calculatePosteriorAvg(xmcmc, NCONC=2, NDIFF=1)
## save(postAvg, file="~/madman/Rpacks/XDE/inst/logFiles/postAvg.rda")
## ##put browser in .standardizedDelta to fix tau2R, ...
## BES <- calculateBayesianEffectSize(xmcmc)
## save(BES, file="~/madman/Rpacks/XDE/inst/logFiles/BES.rda")
## save(xmcmc, file="~/madman/Rpacks/XDE/data/xmcmc.RData")
## q("no")


###################################################
### code chunk number 13: loadObject
###################################################
data(xmcmc, package="XDE")


###################################################
### code chunk number 14: savedParams
###################################################
output(xmcmc)[2:22][output(xmcmc)[2:22] == 1]


###################################################
### code chunk number 15: extractc2
###################################################
pathToLogFiles <- system.file("logFiles", package="XDE")
xmcmc@directory <- pathToLogFiles
c2 <- xmcmc$c2


###################################################
### code chunk number 16: c2
###################################################
par(las=1)
plot.ts(c2, ylab="c2", xlab="iterations", plot.type="single")


###################################################
### code chunk number 17: retrieveLogs
###################################################
getLogs <- function(object){
	params <- output(object)[output(object) == 1]
	params <- params[!(names(params) %in% c("nu", "phi", "DDelta", "delta", "sigma2", "diffExpressed"))]
	names(params)
}
param.names <- getLogs(xmcmc)
params <- lapply(lapply(as.list(param.names), function(name, object) eval(substitute(object$NAME_ARG, list(NAME_ARG=name))), object=xmcmc), as.ts)
names(params) <- param.names
tracefxn <- function(x, name)  plot(x, plot.type="single", col=1:ncol(x), ylab=name)
mapply(tracefxn, params, name=names(params))


###################################################
### code chunk number 18: bayesianEffectSize (eval = FALSE)
###################################################
## bayesianEffectSize(xmcmc) <- calculateBayesianEffectSize(xmcmc)


###################################################
### code chunk number 19: bes
###################################################
load(file.path(pathToLogFiles, "BES.rda"))
load(file.path(pathToLogFiles, "postAvg.rda"))


###################################################
### code chunk number 20: postAvgFig_conc
###################################################
par(las=1)
hist(postAvg[, "concordant"], breaks=50, xlim=c(0, 1), main="",
     xlab="posterior probability of concordant differential expression")


###################################################
### code chunk number 21: postAvgFig_disc
###################################################
par(las=1)
hist(postAvg[, "discordant"], breaks=50, xlim=c(0, 1), main="",
     xlab="posterior probability of discordant differential expression")


###################################################
### code chunk number 22: setPar
###################################################
op.conc <- symbolsInteresting(rankingStatistic=postAvg[, "concordant"])
op.disc <- symbolsInteresting(rankingStatistic=postAvg[, "discordant"])


###################################################
### code chunk number 23: conc
###################################################
par(las=1)
graphics:::pairs(BES[op.conc$order, ], pch=op.conc$pch, col=op.conc$col,
                 bg=op.conc$bg, upper.panel=NULL, cex=op.conc$cex)


###################################################
### code chunk number 24: disc
###################################################
graphics:::pairs(BES[op.disc$order, ], pch=op.disc$pch, col=op.disc$col, bg=op.disc$bg,
		 upper.panel=NULL, cex=op.disc$cex)


###################################################
### code chunk number 25: ssAlternatives (eval = FALSE)
###################################################
## ##t <- ssStatistic(statistic="t", phenotypeLabel="adenoVsquamous", esetList=xlist)
## tt <- rowttests(xlist, "adenoVsquamous", tstatOnly=TRUE)
## if(require(siggenes)){
##   sam <- ssStatistic(statistic="sam", phenotypeLabel="adenoVsquamous", esetList=xlist)
## }
## if(require(GeneMeta)){
##   z <- ssStatistic(statistic="z", phenotypeLabel="adenoVsquamous", esetList=xlist)
## }


###################################################
### code chunk number 26: tstatConc (eval = FALSE)
###################################################
## graphics:::pairs(tt[op.conc$order, ], pch=op.conc$pch, col=op.conc$col,
##                  bg=op.conc$bg, upper.panel=NULL, cex=op.conc$cex)
## 


###################################################
### code chunk number 27: zConc (eval = FALSE)
###################################################
## graphics:::pairs(tt[op.conc$order, ], pch=op.conc$pch, col=op.conc$col,
##                  bg=op.conc$bg, upper.panel=NULL, cex=op.conc$cex)
## 


###################################################
### code chunk number 28: tstatDisc (eval = FALSE)
###################################################
## graphics:::pairs(tt[op.disc$order, ], pch=op.disc$pch, col=op.disc$col,
##                  bg=op.disc$bg, upper.panel=NULL, cex=op.disc$cex)


###################################################
### code chunk number 29: pca (eval = FALSE)
###################################################
## tScores <- xsScores(tt, N=nSamples(xlist))
## samScores <- xsScores(sam, nSamples(xlist))
## zScores <- xsScores(z[, match(names(xlist), colnames(z))], N=nSamples(xlist))
## ##Concordant differential expression, we use the combined score from the random effects model directly
## zScores[, "concordant"] <- z[, "zSco"]


###################################################
### code chunk number 30: sessionInfo
###################################################
toLatex(sessionInfo())


