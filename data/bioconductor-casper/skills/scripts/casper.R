# Code example from 'casper' vignette. See references/ for full tutorial.

### R code from vignette source 'casper.Rnw'

###################################################
### code chunk number 1: process1
###################################################
library(casper)
data(K562.r1l1)
names(K562.r1l1)
data(hg19DB)
hg19DB
head(sapply(hg19DB@transcripts,length))


###################################################
### code chunk number 2: process2
###################################################
bam0 <- rmShortInserts(K562.r1l1, isizeMin=100)
distrs <- getDistrs(hg19DB,bam=bam0,readLength=75)


###################################################
### code chunk number 3: plotprocess1
###################################################
plot(distrs, "fragLength")


###################################################
### code chunk number 4: plotprocess2
###################################################
plot(distrs, "readSt")


###################################################
### code chunk number 5: plotprocess1
###################################################
plot(distrs, "fragLength")


###################################################
### code chunk number 6: plotprocess2
###################################################
plot(distrs, "readSt")


###################################################
### code chunk number 7: procBam
###################################################
pbam0 <- procBam(bam0)
pbam0
head(getReads(pbam0))


###################################################
### code chunk number 8: pathCounts
###################################################
pc <- pathCounts(pbam0, DB=hg19DB)
pc
head(pc@counts[[1]])


###################################################
### code chunk number 9: calcExp
###################################################
eset <- calcExp(distrs=distrs, genomeDB=hg19DB, pc=pc, readLength=75, rpkm=FALSE)
eset
head(exprs(eset))
head(fData(eset))


###################################################
### code chunk number 10: relIsoformExpr
###################################################
eset <- calcExp(distrs=distrs, genomeDB=hg19DB, pc=pc, readLength=75, rpkm=TRUE)
head(exprs(eset))


###################################################
### code chunk number 11: plot1
###################################################
transcripts(hg19DB)
tx <- transcripts(hg19DB, txid='NM_005158')
tx
getChr(txid='NM_005158',genomeDB=hg19DB)
islandid <- getIsland(txid='NM_005158',genomeDB=hg19DB)
islandid
transcripts(hg19DB, islandid=islandid)
getChr(islandid=islandid,genomeDB=hg19DB)


###################################################
### code chunk number 12: plot2
###################################################
genePlot(islandid=islandid,genomeDB=hg19DB)


###################################################
### code chunk number 13: plot2
###################################################
genePlot(islandid=islandid,genomeDB=hg19DB)


###################################################
### code chunk number 14: plot3
###################################################
genePlot(islandid=islandid,genomeDB=hg19DB,reads=pbam0,exp=eset)


###################################################
### code chunk number 15: plot3
###################################################
genePlot(islandid=islandid,genomeDB=hg19DB,reads=pbam0,exp=eset)


