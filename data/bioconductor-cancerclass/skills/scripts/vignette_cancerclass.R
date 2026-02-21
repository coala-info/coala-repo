# Code example from 'vignette_cancerclass' vignette. See references/ for full tutorial.

### R code from vignette source 'vignette_cancerclass.Rnw'

###################################################
### code chunk number 1: vignette_cancerclass.Rnw:34-37
###################################################
library(cancerclass)
data(GOLUB1)
GOLUB1


###################################################
### code chunk number 2: vignette_cancerclass.Rnw:42-43
###################################################
  nval <- nvalidate(GOLUB1[1:200, ], ngenes=c(5, 10, 20, 50, 100, 200))


###################################################
### code chunk number 3: vignette_cancerclass.Rnw:50-51
###################################################
  plot(nval)


###################################################
### code chunk number 4: vignette_cancerclass.Rnw:65-66
###################################################
  val <- validate(GOLUB1[1:200, ], ngenes=10, ntrain="balanced")


###################################################
### code chunk number 5: vignette_cancerclass.Rnw:73-74
###################################################
  plot(val)


###################################################
### code chunk number 6: vignette_cancerclass.Rnw:86-92
###################################################
library(cancerdata)
data(VEER)
data(VIJVER)
VIJVER2 <- VIJVER[, setdiff(sampleNames(VIJVER), sampleNames(VEER))]
predictor <- fit(VEER, method="welch.test")
prediction <- predict(predictor, VIJVER2, positive="DM", dist="cor")


###################################################
### code chunk number 7: vignette_cancerclass.Rnw:99-100
###################################################
  plot(prediction, type="histogram", positive="DM", score="zeta")


###################################################
### code chunk number 8: vignette_cancerclass.Rnw:114-115
###################################################
  plot(prediction, type="roc", positive="DM", score="zeta")


###################################################
### code chunk number 9: vignette_cancerclass.Rnw:129-130
###################################################
  plot(prediction, type="logistic", positive="DM", score="zeta")


