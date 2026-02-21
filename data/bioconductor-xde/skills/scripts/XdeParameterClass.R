# Code example from 'XdeParameterClass' vignette. See references/ for full tutorial.

### R code from vignette source 'XdeParameterClass.Rnw'

###################################################
### code chunk number 1: XdeParameterClass.Rnw:43-44
###################################################
options(width=60)


###################################################
### code chunk number 2: params
###################################################
library(XDE)
data(expressionSetList)
xlist <- expressionSetList
params <- new("XdeParameter", esetList=xlist, phenotypeLabel="adenoVsquamous")
params


###################################################
### code chunk number 3: firstMcmc
###################################################
initialValues <- firstMcmc(params)
str(initialValues)


###################################################
### code chunk number 4: specifiedInitialValues
###################################################
params@specifiedInitialValues


###################################################
### code chunk number 5: hyperparameters
###################################################
hyperparameters(params)


###################################################
### code chunk number 6: hyperparamReplace (eval = FALSE)
###################################################
## hyperparameters(params)["alpha.a"] <- 1


###################################################
### code chunk number 7: tuning
###################################################
tuning(params)


###################################################
### code chunk number 8: changeEpsilon
###################################################
tuning(params)["a"] <- tuning(params)["a"]*0.5


###################################################
### code chunk number 9: updates
###################################################
updates(params)


###################################################
### code chunk number 10: conjugacy (eval = FALSE)
###################################################
## firstMcmc(params)$B <- rep(1,3)
## updates(params)["b"] <- 0


###################################################
### code chunk number 11: independence (eval = FALSE)
###################################################
## firstMcmc(params)$B <- rep(0, 3)
## updates(params)["b"] <- 0


###################################################
### code chunk number 12: blockUpdates (eval = FALSE)
###################################################
## updates(params)["rAndC2"] <- 3


###################################################
### code chunk number 13: output
###################################################
output(params)


###################################################
### code chunk number 14: differentPath (eval = FALSE)
###################################################
## directory(params) <- "logFiles"


###################################################
### code chunk number 15: burnin
###################################################
burnin(params) <- TRUE
iterations(params) <- 5


###################################################
### code chunk number 16: burnin2
###################################################
output(params)[2:22] <- rep(1, 21)
output(params)
burnin(params) <- TRUE
output(params)


###################################################
### code chunk number 17: burnin3
###################################################
##Specify a thin of 1 and save none of the parameters
output(params)[2:22] <- rep(0, 21)
output(params)
burnin(params) <- FALSE
output(params)


###################################################
### code chunk number 18: doNotSaveHugeChains
###################################################
burnin(params) <- FALSE
output(params)[c("nu", "DDelta", "delta", "probDelta", "sigma2", "phi")] <- 0
output(params)


###################################################
### code chunk number 19: XdeParameterClass.Rnw:538-539
###################################################
toLatex(sessionInfo())


