# Code example from 'RpsiXMLApp' vignette. See references/ for full tutorial.

### R code from vignette source 'RpsiXMLApp.Rnw'

###################################################
### code chunk number 1: lib
###################################################
library(RpsiXML)
library(ppiStats)
library(Rgraphviz)
library(RBGL)


###################################################
### code chunk number 2: parse
###################################################
xmlDir <- system.file("/extdata/psi25files",package="RpsiXML")
intactxml <- file.path(xmlDir, "intact_2008_test.xml")
x <- psimi25XML2Graph(intactxml, INTACT.PSIMI25, verbose=FALSE)


###################################################
### code chunk number 3: visGraph
###################################################
nA <- makeNodeAttrs(x, label="", fillcolor="lightblue", width=0.4, height=0.4)
plot(x, "neato", nodeAttrs=nA)


###################################################
### code chunk number 4: removeSelfLoop
###################################################
xn <- removeSelfLoops(x)
nA <- makeNodeAttrs(xn, label="", fillcolor="lightblue", width=0.4, height=0.4)
plot(xn, "neato", nodeAttrs=nA)


###################################################
### code chunk number 5: detectSelfLoop
###################################################
isSelf <- function(g) {
  ns <- nodes(g)
  sapply(ns, function(x) x %in% adj(g, x)[[1]])
}
isSelfLoop <- isSelf(x)
selfCount <- sum(isSelfLoop)
print(selfCount)


###################################################
### code chunk number 6: outdHist
###################################################
opar <- par(mar=c(4,4,0,1))
ds <- degree(xn)
hist(ds[[2]], xlab="", main="")


###################################################
### code chunk number 7: indHist
###################################################
opar <- par(mar=c(4,4,0,1))
hist(ds[[1]], xlab="", main="")


###################################################
### code chunk number 8: findClique
###################################################
xu <- ugraph(xn)
cls <- maxClique(xu)$maxCliques
cs <- sapply(cls,length)
cls[cs==max(cs)]


###################################################
### code chunk number 9: countClique
###################################################
cc <- table(cs)
c4 <- cc[["4"]]
c3 <- cc[["3"]]


###################################################
### code chunk number 10: visClique
###################################################
c4ns <- cls[cs==max(cs)]
c4a <- c4ns[[1]]
c4b <- c4ns[[2]]
ns <- nodes(xn); ncols <- rep("lightblue", length(ns))
ncols[ns %in% c4a] <- "#FF0033"
ncols[ns %in% c4b] <- "#FFFF33"
ncols[ns %in% intersect(c4a,c4b)] <- "#FF8033"
nA <- makeNodeAttrs(xn, fillcolor=ncols, label="",width=0.4, height=0.4)
plot(xn, "neato", nodeAttrs=nA)


###################################################
### code chunk number 11: visCliqueAlone
###################################################
c4nodes <- unique(c(c4a, c4b))
c4sub <- subGraph(c4nodes, xn)
ns <- nodes(c4sub); ncols <- rep("lightblue", length(ns))
ncols[ns %in% c4a] <- "#FF0033"
ncols[ns %in% c4b] <- "#FFFF33"
ncols[ns %in% intersect(c4a,c4b)] <- "#FF8033"
nA <- makeNodeAttrs(c4sub, fillcolor=ncols)
plot(c4sub, "neato", nodeAttrs=nA)


###################################################
### code chunk number 12: assessSym
###################################################
sym <- assessSymmetry(xn, bpGraph=TRUE)
head(sym$deg)


###################################################
### code chunk number 13: symStat
###################################################
deg <- sym[[1]]
outR <- deg[,2]==0
inR <- deg[,3]==0
nrCount <- outR & inR


###################################################
### code chunk number 14: est
###################################################
nint <- 49:56
nrec <- sum(deg[,1])
nunr <- sum(deg[,2])
ntot <- nrow(deg)
est <- estErrProbMethodOfMoments(nint=nint, nrec=nrec, nunr=nunr, ntot=ntot)
plot(est[, c("pfp2", "pfn2")], type="l", col="orange", lwd=2,
     xlab=expression(p[FP]), ylab=expression(p[FN]), 
     xlim=c(-0.001, 0.005), ylim=c(-0.001, 0.045))
abline(h=0, v=0, lty=2)


###################################################
### code chunk number 15: unload
###################################################
library(RpsiXML)


###################################################
### code chunk number 16: sessionInfo
###################################################
sessionInfo()


