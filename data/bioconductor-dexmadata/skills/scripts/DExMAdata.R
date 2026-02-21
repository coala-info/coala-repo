# Code example from 'DExMAdata' vignette. See references/ for full tutorial.

### R code from vignette source 'DExMAdata.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: DExMAdata.Rnw:29-35
###################################################
library(DExMAdata)
data(IDsDExMA)
data(SynonymsDExMA)
data(avaliableIDs)
data(avaliableOrganism)
data(DExMAExampleData)


###################################################
### code chunk number 3: DExMAdata.Rnw:44-46
###################################################
class(listMatrixEX)
head(listMatrixEX$Study1)


###################################################
### code chunk number 4: DExMAdata.Rnw:50-52
###################################################
class(listPhenodatas)
head(listPhenodatas$Study1)


###################################################
### code chunk number 5: DExMAdata.Rnw:59-61
###################################################
class(listExpressionSets)
listExpressionSets$Study1


###################################################
### code chunk number 6: DExMAdata.Rnw:65-67
###################################################
class(ExpressionSetStudy5)
ExpressionSetStudy5


###################################################
### code chunk number 7: DExMAdata.Rnw:75-76
###################################################
str(maObjectDif)


###################################################
### code chunk number 8: DExMAdata.Rnw:82-83
###################################################
str(maObject)


###################################################
### code chunk number 9: DExMAdata.Rnw:93-100
###################################################
class(IDsDExMA)
length(IDsDExMA)
names(IDsDExMA)
head(IDsDExMA$Entrez)
head(IDsDExMA$Genesymbol)
class(SynonymsDExMA)
head(SynonymsDExMA)


###################################################
### code chunk number 10: DExMAdata.Rnw:106-108
###################################################
class(SynonymsDExMA)
head(SynonymsDExMA)


###################################################
### code chunk number 11: DExMAdata.Rnw:114-115
###################################################
avaliableIDs


###################################################
### code chunk number 12: DExMAdata.Rnw:120-121
###################################################
avaliableOrganism


###################################################
### code chunk number 13: DExMAdata.Rnw:142-143
###################################################
sessionInfo()


