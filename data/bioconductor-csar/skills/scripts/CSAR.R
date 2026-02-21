# Code example from 'CSAR' vignette. See references/ for full tutorial.

### R code from vignette source 'CSAR.Rnw'

###################################################
### code chunk number 1: setup
###################################################
options(width=60)
options(continue=" ")
options(prompt="R> ")


###################################################
### code chunk number 2: loadData
###################################################
library(CSAR)
data("CSAR-dataset");
head(sampleSEP3_test)
head(controlSEP3_test)
nhitsS<-mappedReads2Nhits(sampleSEP3_test,file="sampleSEP3_test",chr=c("CHR1v01212004"),chrL=c(10000))
nhitsC<-mappedReads2Nhits(controlSEP3_test,file="controlSEP3_test",chr=c("CHR1v01212004"),chrL=c(10000))
nhitsC$filenames
nhitsS$filenames


###################################################
### code chunk number 3: runScore
###################################################
test<-ChIPseqScore(control=nhitsC,sample=nhitsS,file="test",times=10000)
test$filenames
win<-sigWin(test)
head(win)
score2wig(test,file="test.wig",times=10000)
d<-distance2Genes(win=win,gff=TAIR8_genes_test)
d
genes<-genesWithPeaks(d)
head(genes)


###################################################
### code chunk number 4: runPermutation
###################################################
permutatedWinScores(nn=1,sample=sampleSEP3_test,control=controlSEP3_test,fileOutput="test",chr=c("CHR1v01212004"),chrL=c(100000))
permutatedWinScores(nn=2,sample=sampleSEP3_test,control=controlSEP3_test,fileOutput="test",chr=c("CHR1v01212004"),chrL=c(100000))
nulldist<-getPermutatedWinScores(file="test",nn=1:2)
getThreshold(winscores=values(win)$score,permutatedScores=nulldist,FDR=.05)


###################################################
### code chunk number 5: CSAR.Rnw:98-99
###################################################
sessionInfo()


