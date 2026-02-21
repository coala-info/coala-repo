# Code example from 'MANOR' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(
echo=FALSE, fig.width=6, fig.height=6, eval=TRUE
)

## -----------------------------------------------------------------------------
citation("MANOR")

## ----echo=FALSE, include=FALSE------------------------------------------------
library(MANOR)

## ----echo=TRUE----------------------------------------------------------------
SNR.FUN <- function(arrayCGH, var.FG, var.BG, snr.thr) {
  which(arrayCGH$arrayValues[[var.FG]] < arrayCGH$arrayValues[[var.BG]]*snr.thr)
}
SNR.char <- "B"
SNR.label <- "Low signal to noise ratio"
SNR.flag <- to.flag(SNR.FUN, SNR.char, args=alist(var.FG="REF_F_MEAN", var.BG="REF_B_MEAN", snr.thr=3))

## ----echo=TRUE----------------------------------------------------------------
global.spatial.FUN <- function(arrayCGH, var)
  {
    if (!is.null(arrayCGH$arrayValues$Flag))
        arrayCGH$arrayValues$LogRatio[which(arrayCGH$arrayValues$Flag!="")] <- NA
##     Trend <- arrayTrend(arrayCGH, var, span=0.03, degree=1, iterations=3, family="symmetric")
    Trend <- arrayTrend(arrayCGH, var, span=0.03, degree=1, iterations=3)
    arrayCGH$arrayValues[[var]] <- Trend$arrayValues[[var]]-Trend$arrayValues$Trend
    arrayCGH
  }
global.spatial.flag <- to.flag(global.spatial.FUN, args=alist(var="LogRatio"))

## ----echo=TRUE----------------------------------------------------------------
chromosome.FUN <- function(arrayCGH, var) {
  var.rep <- arrayCGH$id.rep
  w <- which(!is.na(match(as.character(arrayCGH$cloneValues[[var]]), c("X", "Y"))))
  l <- arrayCGH$cloneValues[w, var.rep]
  which(!is.na(match(arrayCGH$arrayValues[[var.rep]], as.character(l))))
}

chromosome.char <- "X"
chromosome.label <- "Sexual chromosome"
chromosome.flag <- to.flag(chromosome.FUN, chromosome.char, type="temp.flag", args=alist(var="Chromosome"), label=chromosome.label)

## ----echo=TRUE----------------------------------------------------------------
args(to.flag)

## ----echo=TRUE----------------------------------------------------------------
args(flag.arrayCGH)

## ----echo=TRUE----------------------------------------------------------------
args(flag.summary.arrayCGH)

## ----echo=TRUE----------------------------------------------------------------
args(flag.summary.default)

## ----echo=TRUE----------------------------------------------------------------
pct.spot.FUN <- function(arrayCGH, var) {
  100*sum(!is.na(arrayCGH$arrayValues[[var]]))/dim(arrayCGH$arrayValues)[1]
}
pct.spot.name <- "SPOT_PCT"
pct.spot.label <- "Proportion of spots after normalization"
pct.spot.qscore <- to.qscore(pct.spot.FUN, name=pct.spot.name, args=alist(var="LogRatioNorm"), label=pct.spot.label)

## ----echo=TRUE----------------------------------------------------------------
args(to.qscore)

## ----echo=TRUE----------------------------------------------------------------
args(qscore.arrayCGH)

## ----echo=TRUE----------------------------------------------------------------
args(qscore.summary.arrayCGH)

## ----echo=TRUE----------------------------------------------------------------
data(spatial)

## ----echo=TRUE, fig.cap="Array with local spatial effects"--------------------
data(spatial)

## edge: example of array with local spatial effects
GLAD::arrayPlot(edge, "LogRatio", main="Local spatial effects", zlim=c(-1,1), mediancenter=TRUE, bar="h")

## ----echo=TRUE, fig.cap="Example of array with spatial gradient"--------------
data(spatial)
GLAD::arrayPlot(gradient, "LogRatio", main="Spatial gradient" , zlim=c(-2,2), mediancenter=TRUE, bar="h")

## ----echo=TRUE, fig.cap="Pan-genomic profile of the array. Colors are proportional to log-ratio values"----
data(spatial)
#par(mfrow=c(7,5), mar=par("mar")/2)
genome.plot(edge.norm, chrLim="LimitChr", cex=1)

## ----echo=TRUE, fig.cap="Pan-genomic profile of the array. Colors correspond to the values of the variable 'ZoneGNL'"----
data(spatial)
edge.norm$cloneValues$ZoneGNL <- as.factor(edge.norm$cloneValues$ZoneGNL)
#par(mfrow=c(7,5), mar=par("mar")/2)
genome.plot(edge.norm, col.var="ZoneGNL", chrLim="LimitChr", cex=1)

## ----echo=TRUE, fig.cap="{report.plot}: array image and pan-genomic profile after normalization."----
data(spatial)
report.plot(edge.norm, chrLim="LimitChr", zlim=c(-1,1), cex=1)

## ----echo=TRUE----------------------------------------------------------------
dir.in <- system.file("extdata", package="MANOR")

## import from 'spot' files
spot.names <- c("LogRatio", "RefFore", "RefBack", "DapiFore", "DapiBack", "SpotFlag", "ScaledLogRatio")
clone.names <- c("PosOrder", "Chromosome")
edge <- import(paste(dir.in, "/edge.txt", sep=""), type="spot",
spot.names=spot.names, clone.names=clone.names, add.lines=TRUE)

## ----echo=TRUE----------------------------------------------------------------
data(flags)
data(spatial)

## local.spatial.flag$args <- alist(var="ScaledLogRatio", by.var=NULL, nk=5, prop=0.25, thr=0.15, beta=1, family="symmetric")
local.spatial.flag$args <- alist(var="ScaledLogRatio", by.var=NULL, nk=5, prop=0.25, thr=0.15, beta=1, family="gaussian")
flag.list <- list(spatial=local.spatial.flag, spot=spot.corr.flag, ref.snr=ref.snr.flag, dapi.snr=dapi.snr.flag, rep=rep.flag, unique=unique.flag)

edge.norm <- norm(edge, flag.list=flag.list, FUN=median, na.rm=TRUE)
edge.norm <- sort(edge.norm, position.var="PosOrder")

## ----echo=TRUE, fig.cap="array 'edge' after normalization"--------------------
report.plot(edge.norm, chrLim="LimitChr", zlim=c(-1,1), cex=1)

## ----echo=TRUE----------------------------------------------------------------
##DNA copy number assessment: GLAD
profileCGH <- GLAD::as.profileCGH(edge.norm$cloneValues)

profileCGH <- GLAD::daglad(profileCGH, smoothfunc="lawsglad", lkern="Exponential", model="Gaussian", qlambda=0.999,  bandwidth=10, base=FALSE, round=2, lambdabreak=6, lambdaclusterGen=20, param=c(d=6), alpha=0.001, msize=2, method="centroid", nmin=1, nmax=8, amplicon=1, deletion=-5, deltaN=0.10,  forceGL=c(-0.15,0.15), nbsigma=3, MinBkpWeight=0.35, verbose=FALSE)

edge.norm$cloneValues <- as.data.frame(profileCGH)
edge.norm$cloneValues$ZoneGNL <- as.factor(edge.norm$cloneValues$ZoneGNL)

data(qscores)
## list of relevant quality scores
qscore.list <- list(smoothness=smoothness.qscore,
                    var.replicate=var.replicate.qscore,
                    dynamics=dynamics.qscore)
edge.norm$quality <- qscore.summary.arrayCGH(edge.norm, qscore.list)
edge.norm$quality

## ----echo=TRUE----------------------------------------------------------------
html.report(edge.norm, dir.out=".", array.name="an array with local bias", chrLim="LimitChr", light=FALSE, pch=20, zlim=c(-2,2), file.name="edge")

## ----echo=TRUE----------------------------------------------------------------
## import from 'gpr' files
spot.names <- c("Clone", "FLAG", "TEST_B_MEAN", "REF_B_MEAN", "TEST_F_MEAN", "REF_F_MEAN", "ChromosomeArm")
clone.names <- c("Clone", "Chromosome", "Position", "Validation")

ac <- import(paste(dir.in, "/gradient.gpr", sep=""), type="gpr", spot.names=spot.names, clone.names=clone.names, sep="\t", comment.char="@", add.lines=TRUE)

## compute log-ratio
ac$arrayValues$F1 <- log(ac$arrayValues[["TEST_F_MEAN"]], 2)
ac$arrayValues$F2 <- log(ac$arrayValues[["REF_F_MEAN"]], 2)
ac$arrayValues$B1 <- log(ac$arrayValues[["TEST_B_MEAN"]], 2)
ac$arrayValues$B2 <- log(ac$arrayValues[["REF_B_MEAN"]], 2)

Ratio <- (ac$arrayValues[["TEST_F_MEAN"]]-ac$arrayValues[["TEST_B_MEAN"]])/
    (ac$arrayValues[["REF_F_MEAN"]]-ac$arrayValues[["REF_B_MEAN"]])
Ratio[(Ratio<=0)|(abs(Ratio)==Inf)] <- NA
ac$arrayValues$LogRatio <- log(Ratio, 2)
gradient <- ac

## ----echo=TRUE----------------------------------------------------------------
data(spatial)
data(flags)

flag.list <- list(local.spatial=local.spatial.flag, spot=spot.flag, SNR=SNR.flag, global.spatial=global.spatial.flag, val.mark=val.mark.flag, position=position.flag, unique=unique.flag, amplicon=amplicon.flag, chromosome=chromosome.flag, replicate=replicate.flag)

gradient.norm <- norm(gradient, flag.list=flag.list, FUN=median, na.rm=TRUE)
gradient.norm <- sort(gradient.norm)

## ----echo=TRUE, fig.cap="Array {gradient` after normalization"----------------
genome.plot(gradient.norm, chrLim="LimitChr", cex=1)

## ----echo=TRUE----------------------------------------------------------------
##DNA copy number assessment: GLAD
profileCGH <- GLAD::as.profileCGH(gradient.norm$cloneValues)

profileCGH <- GLAD::daglad(profileCGH, smoothfunc="lawsglad", lkern="Exponential", model="Gaussian", qlambda=0.999,  bandwidth=10, base=FALSE, round=2, lambdabreak=6, lambdaclusterGen=20, param=c(d=6), alpha=0.001, msize=2, method="centroid", nmin=1, nmax=8, amplicon=1, deletion=-5, deltaN=0.10,  forceGL=c(-0.15,0.15), nbsigma=3, MinBkpWeight=0.35, verbose=FALSE)

gradient.norm$cloneValues <- as.data.frame(profileCGH)
gradient.norm$cloneValues$ZoneGNL <- as.factor(gradient.norm$cloneValues$ZoneGNL)

data(qscores)
## list of relevant quality scores
qscore.list <- list(smoothness=smoothness.qscore, var.replicate=var.replicate.qscore, dynamics=dynamics.qscore)
gradient.norm$quality <- qscore.summary.arrayCGH(gradient.norm, qscore.list)
gradient.norm$quality

## ----echo=TRUE----------------------------------------------------------------
html.report(gradient.norm, dir.out=".", array.name="an array with spatial gradient", chrLim="LimitChr", light=FALSE, pch=20, zlim=c(-2,2), file.name="gradient")

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
sessionInfo()

## ----echo=FALSE---------------------------------------------------------------
Sys.sleep(20)

