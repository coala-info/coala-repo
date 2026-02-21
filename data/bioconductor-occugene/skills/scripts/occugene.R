# Code example from 'occugene' vignette. See references/ for full tutorial.

### R code from vignette source 'occugene.Rnw'

###################################################
### code chunk number 1: momments
###################################################
library("occugene")
n <- 60
p <- c(seq(10,1,-1),seq(10,1,-1),18)/124
p <- p/sum(p)
eMult(n,p)
varMult(n,p)


###################################################
### code chunk number 2: approx momments
###################################################
eMult(n,p,iter=100,seed=4)
varMult(n,p,iter=100,seed=4)


###################################################
### code chunk number 3: load
###################################################
data(sampleAnnotation)
data(sampleInsertions)
print(sampleAnnotation)
print(sampleInsertions)
a.data <- sampleAnnotation
experiment <- sampleInsertions


###################################################
### code chunk number 4: et
###################################################
orf <- cbind(a.data$first,a.data$last)
clone <- experiment$position
etDelta(10,orf,clone)


###################################################
### code chunk number 5: wj next
###################################################
orf <- cbind(a.data$first,a.data$last)
clone <- experiment$position
fFit(orf,clone,FALSE)
unbiasDelta0(10,orf,clone,iter=10,seed=4,alpha=0.05,TR=F)


###################################################
### code chunk number 6: number essential will
###################################################
unbiasB0(orf,clone,iter=10,seed=4,alpha=0.05,TR=F)


###################################################
### code chunk number 7: conversion
###################################################
newOrf <- occup2Negenes(orf,clone)
print(newOrf)


