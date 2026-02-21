# Code example from 'BiocSklearn' vignette. See references/ for full tutorial.

## ----dsetup,echo=FALSE,results="hide",include=FALSE---------------------------
suppressPackageStartupMessages({
library(BiocSklearn)
library(BiocStyle)
example(skPCA) # to ensure you can build from scratch, otherwise import("numpy") fails
})

## ----loadup-------------------------------------------------------------------
library(BiocSklearn)

## ----doimp, eval=TRUE---------------------------------------------------------
library(BiocSklearn)
np = reticulate::import("numpy", convert=FALSE, delay_load=TRUE)
irloc = system.file("csv/iris.csv", package="BiocSklearn")
irismat = np$genfromtxt(irloc, delimiter=',')

## ----dota, eval=TRUE----------------------------------------------------------
np$take(irismat, 0:2, 0L )

## ----dor----------------------------------------------------------------------
fullpc = prcomp(data.matrix(iris[,1:4]))$x

## ----dopc1--------------------------------------------------------------------
ppca = skPCA(data.matrix(iris[,1:4]))
ppca

## ----lk1----------------------------------------------------------------------
tx = getTransformed(ppca)
dim(tx)
head(tx)

## ----lkconc-------------------------------------------------------------------
round(cor(tx, fullpc),3)

## ----doincr, eval=FALSE-------------------------------------------------------
# ippca = skIncrPCA(irismat) # problematic, needs basilisk cover
# ippcab = skIncrPCA(irismat, batch_size=25L)
# round(cor(getTransformed(ippcab), fullpc),3)

## ----dopartial, eval=FALSE----------------------------------------------------
# ta = np$take # provide slicer utility
# ipc = skPartialPCA_step(ta(irismat,0:49,0L))
# ipc = skPartialPCA_step(ta(irismat,50:99,0L), obj=ipc)
# ipc = skPartialPCA_step(ta(irismat,100:149,0L), obj=ipc)
# ipc$transform(ta(irismat,0:5,0L))
# fullpc[1:5,]

