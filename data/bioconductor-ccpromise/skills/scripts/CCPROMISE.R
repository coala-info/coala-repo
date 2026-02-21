# Code example from 'CCPROMISE' vignette. See references/ for full tutorial.

### R code from vignette source 'CCPROMISE.Rnw'

###################################################
### code chunk number 1: options
###################################################
options(width=60)


###################################################
### code chunk number 2: Load CCPROMISE package and data
###################################################
library(CCPROMISE)
data(exmplESet)
data(exmplMSet)
data(exmplGeneSet)
data(exmplPat)


###################################################
### code chunk number 3: Display phPatt
###################################################
exmplPat


###################################################
### code chunk number 4: CCPROMISE at gene level
###################################################
test1 <- CCPROMISE(geneSet=exmplGeneSet, 
              ESet=exmplESet, 
              MSet=exmplMSet, 
              promise.pattern=exmplPat,                                            
              strat.var=NULL,
              prlbl=c('LC50', 'MRD22', 'EFS', 'PR3'), 
              EMlbl=c("Expr", "Methyl"), 
              nbperm=TRUE,
              max.ntail=10,
              nperms=100,
              seed=13)


###################################################
### code chunk number 5: Gene Level Result
###################################################
head(test1$PRres)


###################################################
### code chunk number 6: PROMISE at probe pair level
###################################################
test2 <- PrbPROMISE(geneSet=exmplGeneSet, 
              ESet=exmplESet, 
              MSet=exmplMSet, 
              promise.pattern=exmplPat,
              strat.var=NULL,
              prlbl=c('LC50', 'MRD22', 'EFS', 'PR3'), 
              EMlbl=c("Expr", "Methyl"),
              nbperm=TRUE,
              max.ntail=10,
              nperms=100,
              seed=13)


###################################################
### code chunk number 7: Gene Level Result
###################################################
head(test2$CORres)


###################################################
### code chunk number 8: Gene Level Result
###################################################
head(test2$PRres)


