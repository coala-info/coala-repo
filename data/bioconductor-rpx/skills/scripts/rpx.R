# Code example from 'rpx' vignette. See references/ for full tutorial.

## ----env, echo = FALSE--------------------------------------------------------
suppressPackageStartupMessages(library("BiocStyle"))
suppressPackageStartupMessages(library("Biostrings"))

## ----pxdata-------------------------------------------------------------------
library("rpx")
id <- "PXD000001"
px <- PXDataset(id)
px

## ----pxid---------------------------------------------------------------------
pxid(px)

## ----purl---------------------------------------------------------------------
pxurl(px)

## ----pxtax--------------------------------------------------------------------
pxtax(px)

## ----pxref--------------------------------------------------------------------
strwrap(pxref(px))

## ----pxfiles------------------------------------------------------------------
pxfiles(px)

## ----pxget--------------------------------------------------------------------
f <- pxget(px, "F063721.dat-mztab.txt")
f

## ----more, warning=FALSE------------------------------------------------------
fas <- grep("fasta", pxfiles(px), value = TRUE)
fas
f <- pxget(px, fas) ## file available in the rpx cache
f

## ----example1, message = FALSE------------------------------------------------
library("Biostrings")
readAAStringSet(f)

## ----si-----------------------------------------------------------------------
sessionInfo()

