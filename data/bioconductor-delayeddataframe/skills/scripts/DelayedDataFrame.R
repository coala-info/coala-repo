# Code example from 'DelayedDataFrame' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "##"
)

## ----options, eval=TRUE, echo=FALSE-------------------------------------------
options(showHeadLines=3)
options(showTailLines=3)

## ----getPackage, eval=FALSE---------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("DelayedDataFrame")

## ----getDevel, eval=FALSE-----------------------------------------------------
# BiocManager::install("Bioconductor/DelayedDataFrame")

## ----Load, message=FALSE, warning=FALSE---------------------------------------
library(DelayedDataFrame)

## ----GDSArray-----------------------------------------------------------------
library(GDSArray)
file <- SeqArray::seqExampleFileName("gds")
gdsnodes(file)
varid <- GDSArray(file, "annotation/id")  
DP <- GDSArray(file, "annotation/info/DP")

## ----construction-------------------------------------------------------------
ddf <- DelayedDataFrame(varid, DP)  ## only accommodate 1D GDSArrays with same length

## ----accessors----------------------------------------------------------------
lazyIndex(ddf)
nrow(ddf)
rownames(ddf)

## -----------------------------------------------------------------------------
lazyIndex(ddf)@listData
lazyIndex(ddf)@index

## ----lazyIndex----------------------------------------------------------------
ddf1 <- ddf[1:20,]
identical(ddf@listData, ddf1@listData)
lazyIndex(ddf1)
nrow(ddf1)

## -----------------------------------------------------------------------------
as(letters, "DelayedDataFrame")

## -----------------------------------------------------------------------------
as(DataFrame(letters), "DelayedDataFrame")

## -----------------------------------------------------------------------------
(a <- as(list(a=1:5, b=6:10), "DelayedDataFrame"))
lazyIndex(a)

## -----------------------------------------------------------------------------
df1 <- as(ddf1, "DataFrame")
df1@listData
dim(df1)

## ----singleSB1----------------------------------------------------------------
ddf[, 1, drop=FALSE]

## ----singleSB2----------------------------------------------------------------
ddf[, "DP", drop=FALSE]

## ----singleSB3----------------------------------------------------------------
ddf[, c(TRUE,FALSE), drop=FALSE]

## ----singleSB4----------------------------------------------------------------
(a <- ddf1[1:10, 2, drop=FALSE])
lazyIndex(a)
nrow(a)

## ----doubleSB-----------------------------------------------------------------
ddf[[1]]
ddf[["varid"]]
identical(ddf[[1]], ddf[["varid"]])

## ----rbind--------------------------------------------------------------------
ddf2 <- ddf[21:40, ]
(ddfrb <- rbind(ddf1, ddf2))
lazyIndex(ddfrb)

## ----cbind, error=FALSE-------------------------------------------------------
(ddfcb <- cbind(varid = ddf1[,1, drop=FALSE], DP=ddf1[, 2, drop=FALSE]))
lazyIndex(ddfcb)

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

