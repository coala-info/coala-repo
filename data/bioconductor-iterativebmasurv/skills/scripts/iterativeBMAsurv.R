# Code example from 'iterativeBMAsurv' vignette. See references/ for full tutorial.

### R code from vignette source 'iterativeBMAsurv.Rnw'

###################################################
### code chunk number 1: Setup
###################################################
library(BMA)
library(iterativeBMAsurv)


###################################################
### code chunk number 2: getTrainData
###################################################
## Use the sample training data. The data matrix is called trainData.
data(trainData)
## The survival time vector for the training set is called trainSurv, where survival times are reported in years.
data(trainSurv)
## The censor vector for the training set is called trainCens, where 0 = censored and 1 = uncensored.
data(trainCens)


###################################################
### code chunk number 3: trainingStep
###################################################
## Training phase: select relevant genes
## In this example training set, the top 100 genes have already been sorted in decreasing order of their log likelihood
ret.list <- iterateBMAsurv.train.wrapper (x=trainData, surv.time=trainSurv, cens.vec=trainCens, nbest=5)

## Extract the {\tt bic.surv} object
ret.bic.surv <- ret.list$obj

## Extract the names of the genes from the last iteration of {\tt bic.surv}
gene.names <- ret.list$curr.names

## Get the selected genes with probne0 > 0
top.gene.names <- gene.names[ret.bic.surv$probne0 > 0]
top.gene.names

## Get the posterior probabilities for the selected models
ret.bic.surv$postprob


###################################################
### code chunk number 4: testStep
###################################################
## The test data matrix is called testData.
data(testData)
## The survival time vector for the test set is called testSurv, where survival times are reported in years
data(testSurv)
## The censor vector for the test set is called testCens, where 0 = censored and 1 = uncensored
data(testCens)

## Get the subset of test data with the genes from the last iteration of bic.surv
curr.test.dat <- testData[, top.gene.names]

## Compute the predicted risk scores for the test samples
y.pred.test <- apply (curr.test.dat, 1, predictBicSurv, postprob.vec=ret.bic.surv$postprob, mle.mat=ret.bic.surv$mle)

## Compute the risk scores for the training samples
y.pred.train <- apply (trainData[, top.gene.names], 1, predictBicSurv, postprob.vec=ret.bic.surv$postprob, mle.mat=ret.bic.surv$mle)

## Assign risk categories for test samples
## Argument {\tt cutPoint} is the percentage cutoff for separating the high-risk group from the low-risk group
ret.table <- predictiveAssessCategory (y.pred.test, y.pred.train, testCens, cutPoint=50) 

## Extract risk group vector and risk group table
risk.vector <- ret.table$groups
risk.table <- ret.table$assign.risk
risk.table

## Create a survival object from the test set
mySurv.obj <- Surv(testSurv, testCens)

## Extract statistics including p-value, chi-square, and variance matrix
stats <- survdiff(mySurv.obj ~ unlist(risk.vector))
stats


###################################################
### code chunk number 5: trainPredictTestStep
###################################################
## Use p=10 genes and nbest=5 for fast computation
ret.bma <- iterateBMAsurv.train.predict.assess (train.dat=trainData, test.dat=testData, surv.time.train=trainSurv, surv.time.test=testSurv, cens.vec.train=trainCens, cens.vec.test=testCens, p=10, nbest=5)

## Extract the statistics from this survival analysis run
number.genes <- ret.bma$nvar
number.models <- ret.bma$nmodel
evaluate.success <- ret.bma$statistics
evaluate.success


###################################################
### code chunk number 6: crossValidationStep
###################################################
## Perform 1 run of 2-fold cross validation on the training set, using p=10 genes and nbest=5 for fast computation
## Argument {\tt diseaseType} specifies the type of disease present the training samples, used for writing to file
cv <- crossVal (exset=trainData, survTime=trainSurv, censor=trainCens, diseaseType="DLBCL", noRuns=1, noFolds=2, p=10, nbest=5)


###################################################
### code chunk number 7: imageplot
###################################################
 imageplot.iterate.bma.surv (ret.bic.surv)


