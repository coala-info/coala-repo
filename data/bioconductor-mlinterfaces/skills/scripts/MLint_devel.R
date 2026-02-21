# Code example from 'MLint_devel' vignette. See references/ for full tutorial.

## ----setup, message=FALSE-----------------------------------------------------
library(MLInterfaces) 
library(gbm)
getClass("learnerSchema") 

## ----lkrf---------------------------------------------------------------------
randomForestI@converter

## ----lknn---------------------------------------------------------------------
nnetI@converter 

## ----lkknn--------------------------------------------------------------------
knnI(k=3, l=2)@converter

## ----show, message=FALSE------------------------------------------------------
library(MASS)
data(crabs)
kp = sample(1:200, size=120)
rf1 = MLearn(sp~CL+RW, data=crabs, randomForestI, kp, ntree=100)
rf1
RObject(rf1)
knn1 = MLearn(sp~CL+RW, data=crabs, knnI(k=3,l=2), kp)
knn1

## ----mkadaI, message=FALSE----------------------------------------------------
adaI = makeLearnerSchema("ada", "ada", standardMLIConverter )
arun = MLearn(sp~CL+RW, data=crabs, adaI, kp )
confuMat(arun)
RObject(arun)

## ----lks----------------------------------------------------------------------
standardMLIConverter

## ----lkggg--------------------------------------------------------------------
gbm2

## ----tryg---------------------------------------------------------------------
BgbmI
set.seed(1234)
gbrun = MLearn(sp~CL+RW+FL+CW+BD, data=crabs, BgbmI(n.trees.pred=25000,thresh=.5), kp, n.trees=25000, distribution="bernoulli", verbose=FALSE )
gbrun
confuMat(gbrun)
summary(testScores(gbrun))

