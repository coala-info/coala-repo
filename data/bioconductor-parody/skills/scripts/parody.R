# Code example from 'parody' vignette. See references/ for full tutorial.

## ----setuppp,echo=FALSE-------------------------------------------------------
suppressPackageStartupMessages({
library(parody)
library(BiocStyle)
})

## ----do1----------------------------------------------------------------------
library(parody)

## ----dun21--------------------------------------------------------------------
lead <- c(83, 70, 62, 55, 56, 57, 57, 58, 59, 50, 51, 
        52, 52, 52, 54, 54, 45, 46, 48,
        48, 49, 40, 40, 41, 42, 42, 44, 
        44, 35, 37, 38, 38, 34, 13, 14)

## ----dobox1-------------------------------------------------------------------
boxplot(lead)

## ----dobox2-------------------------------------------------------------------
calout.detect(lead,alpha=.05,method="boxplot", scaling=
function(n,alpha)1.5)

## ----dobox3-------------------------------------------------------------------
calout.detect(lead,alpha=.05,method="boxplot",ftype="ideal")

## ----dor----------------------------------------------------------------------
calout.detect(lead,alpha=.05,method="GESD",k=5)

## ----domemd-------------------------------------------------------------------
calout.detect(lead,alpha=.05,method="medmad",scaling=hamp.scale.3)

## ----dosh---------------------------------------------------------------------
calout.detect(lead,alpha=.05,method="shorth")

## ----dot----------------------------------------------------------------------
data(tcost)
ostr = mv.calout.detect(tcost)
ostr

## ----doparis------------------------------------------------------------------
thecol = rep("black", nrow(tcost))
thecol[ostr$ind] = "red"
pairs(tcost, col=thecol, pch=19)

## ----dobipi-------------------------------------------------------------------
pc = prcomp(tcost)
biplot(pc)

## ----mvmv---------------------------------------------------------------------
ftcost = tcost[-c(9,21),]
fpc = prcomp(ftcost)
biplot(fpc)

