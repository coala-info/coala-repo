# Code example from 'GDSArray' vignette. See references/ for full tutorial.

## ----options, eval=TRUE, echo=FALSE-------------------------------------------
options(showHeadLines=3)
options(showTailLines=3)

## ----getPackage, eval=FALSE---------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("GDSArray")

## ----Load, message=FALSE------------------------------------------------------
library(GDSArray)

## ----GDSArray-----------------------------------------------------------------
file <- gdsExampleFileName("seqgds")
GDSArray(file, "genotype/data")

## ----GDSMatrix----------------------------------------------------------------
GDSArray(file, "annotation/format/DP/data")

## ----GDSFile------------------------------------------------------------------
gf <- GDSFile(file)
gf$annotation$info
gf$annotation$info$AC

## ----seedAccessor-------------------------------------------------------------
gt <- GDSArray(file, "genotype/data")
seed(gt)

## ----gdsfileAccessor----------------------------------------------------------
gdsfile(gt)

## ----gdsnodes-----------------------------------------------------------------
gdsnodes(file)
identical(gdsnodes(file), gdsnodes(gf))
varname <- gdsnodes(file)[2]
GDSArray(file, varname)

## ----dims---------------------------------------------------------------------
dp <- GDSArray(file, "annotation/format/DP/data")
dim(dp)
class(dimnames(dp))
lengths(dimnames(dp))

## ----methods------------------------------------------------------------------
dp[1:3, 10:15]
dp[c(TRUE, FALSE), ]

## ----numeric------------------------------------------------------------------
log(dp)
dp[rowMeans(dp) < 60, ]

## ----GDSArraySeed-------------------------------------------------------------
seed <- GDSArray:::GDSArraySeed(file, "genotype/data")
seed

## ----GDSArray-from-GDSArraySeed-----------------------------------------------
GDSArray(seed)

## ----da-----------------------------------------------------------------------
class(DelayedArray(seed))

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

