# Code example from 'SLGI' vignette. See references/ for full tutorial.

### R code from vignette source 'SLGI.Rnw'

###################################################
### code chunk number 1: set up
###################################################
library("SLGI")
library("org.Sc.sgd.db")

##loading Tong et al data
data(SGA)
data(Atong)


###################################################
### code chunk number 2: rejected
###################################################
rejected <- length(intersect(SGA, org.Sc.sgdREJECTORF))


###################################################
### code chunk number 3: aliasMatch
###################################################
updateSGA=mget(SGA, org.Sc.sgdCOMMON2ORF, ifnotfound = NA )


###################################################
### code chunk number 4: essential genes in query gene list
###################################################
data(essglist)
esg = names(essglist)
n1 <- sum( esg %in% dimnames(Atong)[[1]])
n2 <- sum( esg %in% dimnames(Atong)[[2]])


###################################################
### code chunk number 5: SLGI.Rnw:154-156
###################################################
data(Boeke2006raw)
data(Boeke2006)


###################################################
### code chunk number 6: SLGI.Rnw:179-182
###################################################
## Schuldiner et al. (2005)
data(gi2005)
data(gi2005.metadata)


###################################################
### code chunk number 7: SLGI.Rnw:200-201
###################################################
data(TFmat)


###################################################
### code chunk number 8: ScISI
###################################################
library(ScISI)
data(ScISIC)
ScISIC[1:5, 1:5]


###################################################
### code chunk number 9: SLGI.Rnw:230-236
###################################################
data(Boeke2006)
data(dSLAM)

dim(Boeke2006)
Boeke2006red <- gi2Interactome(Boeke2006, ScISIC)
dim(Boeke2006red)


###################################################
### code chunk number 10: SLGI.Rnw:246-247
###################################################
interact <- getInteraction(Boeke2006red, dSLAM, ScISIC)


###################################################
### code chunk number 11: SLGI.Rnw:252-253
###################################################
intSummary <- iSummary(interact$bwMat, n=5)


###################################################
### code chunk number 12: SLGI.Rnw:261-263 (eval = FALSE)
###################################################
## modelBoeke <- modelSLGI(Boeke2006red, 
##           universe= dSLAM, interactome=ScISIC,type="intM", perm=5)


###################################################
### code chunk number 13: SLGI.Rnw:270-271 (eval = FALSE)
###################################################
## plot(modelBoeke,pch=20)


###################################################
### code chunk number 14: SLGI.Rnw:291-296 (eval = FALSE)
###################################################
## array <- dSLAM[dSLAM %in% rownames(ScISIC)]
## query <- rownames(Boeke2006)[rownames(Boeke2006) %in% rownames(ScISIC)]
## allInteract <- matrix(1, nrow=length(query), ncol=length(array),
##                dimnames=list(query, array))
## tested <- getInteraction(allInteract, dSLAM, ScISIC)


###################################################
### code chunk number 15: SLGI.Rnw:299-302 (eval = FALSE)
###################################################
## testedInteract <- test2Interact(iMat=interact$bwMat, tMat=tested$bwMat, interactome=ScISIC)
## significant <- hyperG(cbind("Tested"=testedInteract$tested,"Interact"=testedInteract$interact), 
##               sum(Boeke),  nrow(Boeke2006red)*length(dSLAM)) 


