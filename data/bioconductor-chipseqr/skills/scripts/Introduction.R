# Code example from 'Introduction' vignette. See references/ for full tutorial.

### R code from vignette source 'Introduction.Rnw'

###################################################
### code chunk number 1: distances
###################################################
	set.seed(1)
	dist <- sample(c(170:300, 400), 10100, prob=c(dnbinom(0:130, mu=30, size=5), 0.2), replace=TRUE)
	pos <- cumsum(dist)
	pos <- pos[pos < 2e6 - 200]


###################################################
### code chunk number 2: readPos1
###################################################
	fwdRegion <- unlist(lapply(pos, function(x) (x-88):(x-68)))
	revRegion <- unlist(lapply(pos, function(x) (x+68):(x+88)))


###################################################
### code chunk number 3: readPos2
###################################################
	fwd <- sample(fwdRegion, 5e4, replace=TRUE)
	rev <- sample(revRegion, 5e4, replace=TRUE)


###################################################
### code chunk number 4: readPos3
###################################################
	fwd <- c(fwd, sample(25:(2e6-25), 2e5, replace=TRUE))
	rev <- c(rev, sample(25:(2e6-25), 2e5, replace=TRUE))


###################################################
### code chunk number 5: formatData
###################################################
	reads <- data.frame(chromosome="chr1", position=c(fwd, rev), length=25, 
			strand=rep(c("+", "-"), each=250000))


###################################################
### code chunk number 6: library
###################################################
	library(ChIPseqR)


###################################################
### code chunk number 7: simple
###################################################
	counts <- strandPileup(reads, chrLen=2e6, extend=1, plot=FALSE)
	nucs <- simpleNucCall(counts, bind=147, support=15, plot=FALSE)


###################################################
### code chunk number 8: plotNucPrint (eval = FALSE)
###################################################
## 	plot(nucs, type="density")
## 	plot(nucs, type="qqplot")


###################################################
### code chunk number 9: plotNuc
###################################################
	par(mfrow=c(1,2))
	plot(nucs, type="density")
	plot(nucs, type="qqplot")


###################################################
### code chunk number 10: plotWindowPrint (eval = FALSE)
###################################################
## 	predicted <- peaks(nucs)[[1]][911]
## 	plot(counts, chr="chr1", center=predicted, score=nucs, width=1000, type="window")


###################################################
### code chunk number 11: plotWindowPrint2 (eval = FALSE)
###################################################
## 	abline(v=pos[pos < predicted + 1000 & pos > predicted - 1000], col=3, lty=3)


###################################################
### code chunk number 12: plotWindow
###################################################
	predicted <- peaks(nucs)[[1]][911]
	plot(counts, chr="chr1", center=predicted, score=nucs, width=1000, type="window")
	abline(v=pos[pos < predicted + 1000 & pos > predicted - 1000], col=3, lty=3)


###################################################
### code chunk number 13: noOver
###################################################
	calls <- peaks(nucs)[[1]][c(1,which(diff(peaks(nucs)[[1]]) >= 170)+1)]
	length(calls)


###################################################
### code chunk number 14: spec
###################################################
	table(sapply(calls, function(x) any((x-20):(x+20) %in% pos)))


###################################################
### code chunk number 15: getBindLen
###################################################
	bLen <- getBindLen(counts, bind = c(100,200), support = c(5, 50))


###################################################
### code chunk number 16: getBindLenPrint (eval = FALSE)
###################################################
## 	bLen <- getBindLen(counts, bind = c(100,200), support = c(5, 50))


###################################################
### code chunk number 17: decompress
###################################################
	counts2 <- decompress(counts)


###################################################
### code chunk number 18: sessionInfo
###################################################
	sessionInfo()


