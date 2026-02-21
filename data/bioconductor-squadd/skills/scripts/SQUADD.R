# Code example from 'SQUADD' vignette. See references/ for full tutorial.

### R code from vignette source 'SQUADD.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: source package
###################################################
library(SQUADD)


###################################################
### code chunk number 2: instance
###################################################
# construct instance of SquadSimResServiceImpl
fpath <- system.file("extdata", package="SQUADD")
folder <- file.path(fpath,"data_IAA")
sim <- simResService (folder=folder,
			  time= 45,
			  ncolor=5,
      		  legend= c("ARF(a)", "ARF(i)", "AR_Genes", "Aux/IAA", 
      		  "BES1/BZR1","BIN2","BR","BRI1BAK1","BRR_Genes","BRX","BR_Biosynthesis","BZR1","DO","IAA","IAA_Biosynthesis","NGA1", "PIN", "SCFTir1","StimAux", "StimBR"), indexDeno=1,
			  method="lowess")


###################################################
### code chunk number 3: SimMatrix
###################################################
sim["selectNode"] <-c("DO","IAA_Biosynthesis","BR_Biosynthesis", "IAA", "BR")
plotSimMatrix(sim)


###################################################
### code chunk number 4: fittedValues
###################################################
tab <- getFittedTable(sim)


###################################################
### code chunk number 5: PredMap
###################################################
plotPredMap(sim)


###################################################
### code chunk number 6: FigPredMap
###################################################
plotPredMap(sim)


###################################################
### code chunk number 7: CorrelationCircle
###################################################
# Fill the field conditionList of the object sim 
sim["conditionList"] <- c("Normal", "brxlof", "BRrescue","brxarfilof","brxarfiBRrescue", "brxgof") 
plotCC(sim)


###################################################
### code chunk number 8: figCorrCircle
###################################################
# Fill the field conditionList of the object sim 
sim["conditionList"] <- c("Normal", "brxlof", "BRrescue","brxarfilof","brxarfiBRrescue", "brxgof") 
plotCC(sim)


###################################################
### code chunk number 9: SQUADD.Rnw:213-214
###################################################
sessionInfo()


