# Code example from 'BCRANK' vignette. See references/ for full tutorial.

### R code from vignette source 'BCRANK.Rnw'

###################################################
### code chunk number 1: load
###################################################
library(BCRANK) 


###################################################
### code chunk number 2: loadFasta
###################################################
fastaFile <- system.file("Exfiles/USF1_small.fa", package="BCRANK")


###################################################
### code chunk number 3: loadResult
###################################################
data(BCRANKout)


###################################################
### code chunk number 4: viewBCRANKresult
###################################################
BCRANKout


###################################################
### code chunk number 5: viewTopMotif
###################################################
topMotif <- toptable(BCRANKout,1)
topMotif


###################################################
### code chunk number 6: viewWM
###################################################
weightMatrix <- pwm(topMotif, normalize=FALSE)
weightMatrix


###################################################
### code chunk number 7: fig1
###################################################
weightMatrixNormalized <- pwm(topMotif, normalize=TRUE)
library(seqLogo)
seqLogo(weightMatrixNormalized)


###################################################
### code chunk number 8: fig2
###################################################
plot(topMotif)


###################################################
### code chunk number 9: reportSites
###################################################
topConsensus <- as.character(toptable(BCRANKout)[1,"Consensus"])
print(topConsensus)
bindingSites <- matchingSites(fastaFile,topConsensus)
nrSites <- nrow(bindingSites)
cat("Number predicted binding sites:",nrSites,"\n")
print(bindingSites[1:15,])


