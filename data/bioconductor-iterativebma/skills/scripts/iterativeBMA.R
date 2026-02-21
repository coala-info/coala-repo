# Code example from 'iterativeBMA' vignette. See references/ for full tutorial.

### R code from vignette source 'iterativeBMA.Rnw'

###################################################
### code chunk number 1: Setup
###################################################
library ("Biobase")
library("BMA")
library("iterativeBMA")


###################################################
### code chunk number 2: getTrainData
###################################################
## use the sample training data. The {\it ExpressionSet} is called trainData.
data(trainData)
## the class vector (0,1) is called trainClass
data(trainClass)


###################################################
### code chunk number 3: trainingStep
###################################################
## training phase: select relevant genes
ret.bic.glm <- iterateBMAglm.train (train.expr.set=trainData, trainClass, p=100)
ret.bic.glm$namesx
ret.bic.glm$probne0

## get the selected genes with probne0 > 0
ret.gene.names <- ret.bic.glm$namesx[ret.bic.glm$probne0 > 0]
ret.gene.names

## get the posterior probabilities for the selected models
ret.bic.glm$postprob


###################################################
### code chunk number 4: testStep
###################################################
## The test ExpressionSet is called testData.
data (testData)

## get the subset of test data with the genes from the last iteration of bic.glm
curr.test.dat <- t(exprs(testData)[ret.gene.names,])

## to compute the predicted probabilities for the test samples
y.pred.test <- apply (curr.test.dat, 1, bma.predict, postprobArr=ret.bic.glm$postprob, mleArr=ret.bic.glm$mle)

## compute the Brier Score if the class labels of the test samples are known
data (testClass)
brier.score (y.pred.test, testClass)


###################################################
### code chunk number 5: trainPredictStep
###################################################
## train and predict
ret.vec <- iterateBMAglm.train.predict (train.expr.set=trainData, test.expr.set=testData, trainClass, p=100)

## compute the Brier Score
data (testClass)
brier.score (ret.vec, testClass)


###################################################
### code chunk number 6: trainPredictTestStep
###################################################
iterateBMAglm.train.predict.test (train.expr.set=trainData, test.expr.set=testData, trainClass, testClass, p=100)


###################################################
### code chunk number 7: imageplot
###################################################
 imageplot.iterate.bma (ret.bic.glm)


