# Code example from 'pcaGoPromoter' vignette. See references/ for full tutorial.

### R code from vignette source 'pcaGoPromoter.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: setup
###################################################
options(width=80,digits=6)


###################################################
### code chunk number 2: bioC (eval = FALSE)
###################################################
## source("http://bioconductor.org/biocLite.R")
## biocLite("pcaGoPromoter",dependencies=TRUE)


###################################################
### code chunk number 3: libPcaGoPromoter (eval = FALSE)
###################################################
## library("pcaGoPromoter")


###################################################
### code chunk number 4: libSerumStimulation (eval = FALSE)
###################################################
## library("serumStimulation")
## data(serumStimulation)


###################################################
### code chunk number 5: groups (eval = FALSE)
###################################################
## groups <- as.factor( c( rep("control",5) , rep("serumInhib",5) ,
##                         rep("serumOnly",3) ) )
## groups


###################################################
### code chunk number 6: fig1 (eval = FALSE)
###################################################
## pcaInfoPlot(eData=serumStimulation,groups=groups)


###################################################
### code chunk number 7: pca (eval = FALSE)
###################################################
## pcaOutput <- pca(serumStimulation)


###################################################
### code chunk number 8: fig2 (eval = FALSE)
###################################################
## plot(pcaOutput, groups=groups)


###################################################
### code chunk number 9: probeIds (eval = FALSE)
###################################################
## loadsNegPC2 <- getRankedProbeIds( pcaOutput, pc=2, decreasing=FALSE )[1:1365]


###################################################
### code chunk number 10: GOtree (eval = FALSE)
###################################################
## GOtreeOutput <- GOtree( input = loadsNegPC2)


###################################################
### code chunk number 11: fig3 (eval = FALSE)
###################################################
## plot(GOtreeOutput,legendPosition = "bottomright")


###################################################
### code chunk number 12: copyToPdf (eval = FALSE)
###################################################
## dev.copy2pdf(file="GOtree.pdf")


###################################################
### code chunk number 13: printGOtree (eval = FALSE)
###################################################
## head(GOtreeOutput$sigGOs,n=10)


###################################################
### code chunk number 14: printPrimo (eval = FALSE)
###################################################
## TFtable <- primo( loadsNegPC2 )
## head(TFtable$overRepresented)


###################################################
### code chunk number 15: printPrimeHits (eval = FALSE)
###################################################
## probeIds <- primoHits( loadsNegPC2 , id = 9343 )	
## head(probeIds)


