# Code example from 'LMGene' vignette. See references/ for full tutorial.

### R code from vignette source 'LMGene.Rnw'

###################################################
### code chunk number 1: LMGene.Rnw:49-52
###################################################
library(LMGene)
library(Biobase)
library(tools)


###################################################
### code chunk number 2: LMGene.Rnw:56-57
###################################################
data(sample.eS)


###################################################
### code chunk number 3: LMGene.Rnw:62-67
###################################################
slotNames(sample.eS)
dim(exprs(sample.eS))
exprs(sample.eS)[1:3,]
phenoData(sample.eS)
slotNames(phenoData(sample.eS))


###################################################
### code chunk number 4: LMGene.Rnw:79-83
###################################################
data(sample.mat)
dim(sample.mat)
data(vlist)  
vlist


###################################################
### code chunk number 5: LMGene.Rnw:87-89
###################################################
test.eS<-neweS(sample.mat, vlist)
class(test.eS)


###################################################
### code chunk number 6: LMGene.Rnw:103-105
###################################################
tranpar <- tranest(sample.eS)
tranpar


###################################################
### code chunk number 7: LMGene.Rnw:112-114
###################################################
tranpar <- tranest(sample.eS, 100)
tranpar


###################################################
### code chunk number 8: LMGene.Rnw:124-128
###################################################

trsample.eS <- transeS(sample.eS, tranpar$lambda, tranpar$alpha)
exprs(sample.eS)[1:3,1:8]
exprs(trsample.eS)[1:3,1:8]


###################################################
### code chunk number 9: LMGene.Rnw:136-138
###################################################
tranparmult <- tranest(sample.eS, mult=TRUE) 
tranparmult


###################################################
### code chunk number 10: LMGene.Rnw:143-145
###################################################
trsample.eS <- transeS (sample.eS, tranparmult$lambda, tranparmult$alpha)
exprs(trsample.eS)[1:3,1:8]


###################################################
### code chunk number 11: LMGene.Rnw:150-152
###################################################
tranparmult <- tranest(sample.eS, ngenes=100, mult=TRUE, lowessnorm=TRUE) 
tranparmult


###################################################
### code chunk number 12: LMGene.Rnw:158-160
###################################################
tranpar <- tranest(sample.eS, model='patient + dose + patient:dose')
tranpar


###################################################
### code chunk number 13: LMGene.Rnw:178-180
###################################################
trsample.eS <- transeS (sample.eS, tranparmult$lambda, tranparmult$alpha)
ntrsample.eS <- lnormeS (trsample.eS) 


###################################################
### code chunk number 14: LMGene.Rnw:186-187
###################################################
sigprobes <- LMGene(ntrsample.eS)


###################################################
### code chunk number 15: LMGene.Rnw:192-193
###################################################
sigprobes <- LMGene(ntrsample.eS,level=.01)


###################################################
### code chunk number 16: LMGene.Rnw:202-204
###################################################
sigprobes <- LMGene(ntrsample.eS, model='patient+dose+patient:dose')
sigprobes


