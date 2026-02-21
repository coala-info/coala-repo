# Code example from 'AIMS' vignette. See references/ for full tutorial.

### R code from vignette source 'AIMS.Rnw'

###################################################
### code chunk number 1: loadPackages
###################################################
library(AIMS)
data(mcgillExample)


###################################################
### code chunk number 2: showMcGill
###################################################
dim(mcgillExample$D)
## convert the expression matrix to an ExpressionSet (Biobase)
mcgillExample$D <- ExpressionSet(assayData=mcgillExample$D)
head(mcgillExample$D[,1:5])
head(mcgillExample$EntrezID)


###################################################
### code chunk number 3: assignSubtypeToMcGill
###################################################
mcgill.subtypes <- applyAIMS(mcgillExample$D,
                             mcgillExample$EntrezID)
names(mcgill.subtypes)
head(mcgill.subtypes$cl)
head(mcgill.subtypes$prob)
table(mcgill.subtypes$cl)


###################################################
### code chunk number 4: assigneSampleOneSubtypeMcGill
###################################################
mcgill.first.sample.subtype <- applyAIMS(mcgillExample$D[,1,drop=FALSE],
                                         mcgillExample$EntrezID)
names(mcgill.first.sample.subtype)
head(mcgill.first.sample.subtype$cl)
head(mcgill.first.sample.subtype$prob)
table(mcgill.first.sample.subtype$cl)


###################################################
### code chunk number 5: assignSubtypeToVDX
###################################################
library(breastCancerVDX)
library(hgu133a.db)
data(vdx)

hgu133a.entrez <- as.character(as.list(hgu133aENTREZID)[featureNames(vdx)])
vdx.subtypes <- applyAIMS(vdx,
                          hgu133a.entrez)
names(vdx.subtypes)
head(vdx.subtypes$cl)
head(vdx.subtypes$prob)
table(vdx.subtypes$cl)


###################################################
### code chunk number 6: sessionInfo
###################################################
toLatex(sessionInfo())


