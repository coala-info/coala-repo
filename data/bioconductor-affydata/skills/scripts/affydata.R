# Code example from 'affydata' vignette. See references/ for full tutorial.

### R code from vignette source 'affydata.Rnw'

###################################################
### code chunk number 1: affydata.Rnw:42-44
###################################################
library(affydata)
data(Dilution)


###################################################
### code chunk number 2: affydata.Rnw:56-57
###################################################
Dilution


###################################################
### code chunk number 3: affydata.Rnw:64-66
###################################################
phenoData(Dilution)
pData(Dilution)


###################################################
### code chunk number 4: affydata.Rnw:78-79
###################################################
pData(Dilution) ##notice the scanner covariate


###################################################
### code chunk number 5: affydata.Rnw:89-91
###################################################
par(mfrow=c(1,1))
boxplot(Dilution,col=c(2,2,3,3))


###################################################
### code chunk number 6: affydata.Rnw:112-113
###################################################
options(warn=-1)


###################################################
### code chunk number 7: affydata.Rnw:117-120
###################################################
gn <- sample(geneNames(Dilution),100) ##pick only a few genes
pms <- pm(Dilution[,3:4], gn)
mva.pairs(pms)


###################################################
### code chunk number 8: affydata.Rnw:129-131
###################################################
normalized.Dilution <- Biobase::combine(normalize(Dilution[, 1:2]),
                             normalize(Dilution[, 3:4]))


###################################################
### code chunk number 9: affydata.Rnw:140-141
###################################################
normalize.methods(Dilution)


###################################################
### code chunk number 10: affydata.Rnw:153-154
###################################################
boxplot(normalized.Dilution, col=c(2,2,3,3), main="Normalized Arrays")


###################################################
### code chunk number 11: affydata.Rnw:164-166
###################################################
pms <- pm(normalized.Dilution[, 3:4],gn)
mva.pairs(pms)


