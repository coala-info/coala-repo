# Code example from 'plgem' vignette. See references/ for full tutorial.

### R code from vignette source 'plgem.Rnw'

###################################################
### code chunk number 1: PLGEMwrapper
###################################################
library(plgem)
data(LPSeset)
set.seed(123)
LPSdegList <- run.plgem(esdata=LPSeset)


###################################################
### code chunk number 2: modelFitting
###################################################
LPSfit <- plgem.fit(data=LPSeset, covariate=1, fitCondition='C', p=10, q=0.5,
  plot.file=FALSE, fittingEval=TRUE, verbose=TRUE)


###################################################
### code chunk number 3: observedSTN
###################################################
LPSobsStn <- plgem.obsStn(data=LPSeset, covariate=1, baselineCondition=1,
  plgemFit=LPSfit, verbose=TRUE)


###################################################
### code chunk number 4: resampledSTN
###################################################
set.seed(123)
LPSresampledStn <- plgem.resampledStn(data=LPSeset, plgemFit=LPSfit,
  iterations="automatic", verbose=TRUE)


###################################################
### code chunk number 5: Pvalues
###################################################
LPSpValues <- plgem.pValue(observedStn=LPSobsStn,
  plgemResampledStn=LPSresampledStn, verbose=TRUE)
head(LPSpValues)


###################################################
### code chunk number 6: DEGselection
###################################################
LPSdegList <- plgem.deg(observedStn=LPSobsStn, plgemPval=LPSpValues,
  delta=0.001, verbose=TRUE)
head(LPSdegList$significant[["0.001"]][["LPS_vs_C"]])


###################################################
### code chunk number 7: sessionInfo
###################################################
sessionInfo()


