# Code example from 'dexus' vignette. See references/ for full tutorial.

### R code from vignette source 'dexus.Rnw'

###################################################
### code chunk number 1: dexus.Rnw:103-107
###################################################
options(width=75)
set.seed(0)
library(dexus)
dexusVersion <- packageDescription("dexus")$Version


###################################################
### code chunk number 2: dexus.Rnw:169-170
###################################################
library(dexus)


###################################################
### code chunk number 3: dexus.Rnw:179-181
###################################################
data(dexus)
ls()


###################################################
### code chunk number 4: dexus.Rnw:191-193 (eval = FALSE)
###################################################
## result <- dexus(countsBottomly[1:1000, ])
## plot(result)


###################################################
### code chunk number 5: dexus.Rnw:197-201
###################################################
result <- dexus(countsBottomly[1:1000, ])
pdf("001.pdf")
plot(result,cexSamples=1)
dev.off()


###################################################
### code chunk number 6: dexus.Rnw:223-226 (eval = FALSE)
###################################################
## resultSupervised <- dexus(countsBottomly[1:1000, ],
## 		labels=substr(colnames(countsBottomly),1,2))
## plot(resultSupervised)


###################################################
### code chunk number 7: dexus.Rnw:229-234
###################################################
resultSupervised <- dexus(countsBottomly[1:1000, ],
		labels=substr(colnames(countsBottomly),1,2))
pdf("002.pdf")
plot(resultSupervised,cexSamples=1)
dev.off()


###################################################
### code chunk number 8: dexus.Rnw:280-282
###################################################
data(dexus)
countsBottomly[1:10,1:5]


###################################################
### code chunk number 9: dexus.Rnw:287-288 (eval = FALSE)
###################################################
## result <- dexus(countsBottomly)


###################################################
### code chunk number 10: dexus.Rnw:296-300 (eval = FALSE)
###################################################
## library(DESeq)
## cds <-  newCountDataSet(countData=countsBottomly, 
## 		conditions=substr(colnames(countsBottomly),1,2) )
## result <- dexus(cds)


###################################################
### code chunk number 11: dexus.Rnw:316-317
###################################################
resultMontgomery <- dexus(countsMontgomery[1:1000, ])


###################################################
### code chunk number 12: dexus.Rnw:321-322
###################################################
resultMontgomery


###################################################
### code chunk number 13: dexus.Rnw:334-335 (eval = FALSE)
###################################################
## sort(resultMontgomery)


###################################################
### code chunk number 14: dexus.Rnw:342-343
###################################################
informativeTranscripts <- INI(resultMontgomery,threshold=0.2)


###################################################
### code chunk number 15: dexus.Rnw:348-349 (eval = FALSE)
###################################################
## plot(informativeTranscripts)


###################################################
### code chunk number 16: dexus.Rnw:353-356
###################################################
pdf("004.pdf",width=12,height=6)
plot(informativeTranscripts)
dev.off()


###################################################
### code chunk number 17: dexus.Rnw:377-378
###################################################
resultMontgomery["ENSG00000007038"]


###################################################
### code chunk number 18: dexus.Rnw:382-383 (eval = FALSE)
###################################################
## as.data.frame(resultMontgomery["ENSG00000007038"])


###################################################
### code chunk number 19: dexus.Rnw:385-386
###################################################
as.data.frame(resultMontgomery["ENSG00000007038"])[,1:12]


###################################################
### code chunk number 20: dexus.Rnw:393-394 (eval = FALSE)
###################################################
## as.data.frame(sort(resultMontgomery))


###################################################
### code chunk number 21: dexus.Rnw:418-421
###################################################
resultSupervised <- dexus(countsBottomly[1:1000, ],
		labels=substr(colnames(countsBottomly),1,2),
		normalization="upperquartile")


###################################################
### code chunk number 22: dexus.Rnw:427-428
###################################################
resultSupervised


###################################################
### code chunk number 23: dexus.Rnw:434-435
###################################################
resultSupervised <- sort(resultSupervised)


###################################################
### code chunk number 24: dexus.Rnw:439-440 (eval = FALSE)
###################################################
## plot(resultSupervised)


###################################################
### code chunk number 25: dexus.Rnw:447-448 (eval = FALSE)
###################################################
## as.data.frame(resultSupervised)


###################################################
### code chunk number 26: dexus.Rnw:467-469
###################################################
resultMultipleGroups <- dexus(countsGilad[1:1000, ],
		labels=substr(colnames(countsGilad),1,2))


###################################################
### code chunk number 27: dexus.Rnw:474-475
###################################################
resultMultipleGroups


###################################################
### code chunk number 28: dexus.Rnw:481-482
###################################################
resultMultipleGroups <- sort(resultMultipleGroups)


###################################################
### code chunk number 29: dexus.Rnw:488-489 (eval = FALSE)
###################################################
## plot(resultMultipleGroups)


###################################################
### code chunk number 30: dexus.Rnw:492-495
###################################################
pdf("003.pdf")
plot(resultMultipleGroups,cexSamples=1)
dev.off()


###################################################
### code chunk number 31: dexus.Rnw:515-516 (eval = FALSE)
###################################################
## as.data.frame(resultMultipleGroups)


###################################################
### code chunk number 32: dexus.Rnw:538-539
###################################################
informativeTranscripts2 <- INI(resultMontgomery,threshold=0.25)


###################################################
### code chunk number 33: dexus.Rnw:553-555 (eval = FALSE)
###################################################
## #plots the top 8 transcripts
## plot(sort(informativeTranscripts2), idx=1:8)


###################################################
### code chunk number 34: dexus.Rnw:558-561
###################################################
pdf("005.pdf",width=12,height=6)
plot(sort(informativeTranscripts2),idx=1:8)
dev.off()


###################################################
### code chunk number 35: dexus.Rnw:751-754 (eval = FALSE)
###################################################
## trueSizeParameter <- 2
## x <- rnbinom(n=5, size=trueSizeParameter, mu=40)
## (sizeML <- getSizeNB(x,eta=0))


###################################################
### code chunk number 36: dexus.Rnw:756-759
###################################################
trueSizeParameter <- 2
x <- c(38,40,30,55,36)
(sizeML <- getSizeNB(x,eta=0))


###################################################
### code chunk number 37: dexus.Rnw:761-762
###################################################
(sizeMAP <- getSizeNB(x,eta=1))


###################################################
### code chunk number 38: dexus.Rnw:764-765
###################################################
(trueDispersion <- 1/trueSizeParameter)


###################################################
### code chunk number 39: dexus.Rnw:767-768
###################################################
(dispersionML <- 1/getSizeNB(x,eta=0))


###################################################
### code chunk number 40: dexus.Rnw:770-771
###################################################
(dispersionMAP <- 1/getSizeNB(x,eta=1))


