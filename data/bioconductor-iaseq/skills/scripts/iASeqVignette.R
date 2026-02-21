# Code example from 'iASeqVignette' vignette. See references/ for full tutorial.

### R code from vignette source 'iASeqVignette.Rnw'

###################################################
### code chunk number 1: iASeqVignette.Rnw:21-25
###################################################
library(iASeq)
data(sampleASE)
colnames(sampleASE_exprs)
sampleASE_studyid


###################################################
### code chunk number 2: iASeqVignette.Rnw:31-32
###################################################
sampleASE_repid


###################################################
### code chunk number 3: iASeqVignette.Rnw:39-40
###################################################
sampleASE_refid


###################################################
### code chunk number 4: iASeqVignette.Rnw:46-48
###################################################
motif.fitted<-iASeqmotif(sampleASE_exprs,sampleASE_studyid,sampleASE_repid,
	sampleASE_refid,K=1:5,iter.max=5,tol=1e-3)


###################################################
### code chunk number 5: iASeqVignette.Rnw:53-58
###################################################

motif.fitted$bic

plotBIC(motif.fitted)



###################################################
### code chunk number 6: iASeqVignette.Rnw:73-75
###################################################
plotMotif(motif.fitted$bestmotif,cutoff=0.9)



###################################################
### code chunk number 7: iASeqVignette.Rnw:83-86
###################################################

head(motif.fitted$bestmotif$p.post)



