# Code example from 'Informeasure' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "##>"
)

## -----------------------------------------------------------------------------
# data.frame data type 
library(Informeasure)

load(system.file("extdata/tcga.brca.testdata.Rdata", package = "Informeasure"))

mRNAexpression   <- log2(mRNAexpression + 1)

x <- as.numeric(mRNAexpression[which(rownames(mRNAexpression) == "BRCA1"), ])
y <- as.numeric(mRNAexpression[which(rownames(mRNAexpression) == "BARD1"), ])

XY <- discretize2D(x,y)

MI.measure(XY)

## ----echo = FALSE, results = 'hide', warning = FALSE--------------------------
suppressPackageStartupMessages(library(SummarizedExperiment))

## -----------------------------------------------------------------------------
# SummarizedExperiment data type 
library(Informeasure)
library(SummarizedExperiment)

load(system.file("extdata/tcga.brca.testdata.Rdata", package = "Informeasure"))

mRNAexpression <- as.matrix(mRNAexpression)
se.mRNAexpression = SummarizedExperiment(assays = list(mRNAexpression = mRNAexpression))

assays(se.mRNAexpression)[["log2"]] <- log2(assays(se.mRNAexpression)[["mRNAexpression"]]+1)

x <- assays(se.mRNAexpression["BRCA1", ])$log2
y <- assays(se.mRNAexpression["BARD1", ])$log2

XY <- discretize2D(x,y)

MI.measure(XY)

## -----------------------------------------------------------------------------
# data.frame data type
library(Informeasure)

load(system.file("extdata/tcga.brca.testdata.Rdata", package = "Informeasure"))

lncRNAexpression <- log2(lncRNAexpression + 1)
miRNAexpression  <- log2(miRNAexpression + 1)
mRNAexpression   <- log2(mRNAexpression + 1)

x <- as.numeric(miRNAexpression[which(rownames(miRNAexpression) == "hsa-miR-26a-5p"), ])
y <- as.numeric(mRNAexpression[which(rownames(mRNAexpression) == "PTEN"), ])
z <- as.numeric(lncRNAexpression[which(rownames(lncRNAexpression) == "PTENP1"), ])

XYZ <- discretize3D(x,y,z)

CMI.measure(XYZ)

## -----------------------------------------------------------------------------
# SummarizedExperiment data type
library(Informeasure)
library(SummarizedExperiment)

load(system.file("extdata/tcga.brca.testdata.Rdata", package="Informeasure"))

lncRNAexpression <- as.matrix(lncRNAexpression)
se.lncRNAexpression = SummarizedExperiment(assays = list(lncRNAexpression = lncRNAexpression))

miRNAexpression <- as.matrix(miRNAexpression)
se.miRNAexpression = SummarizedExperiment(assays = list(miRNAexpression = miRNAexpression))

mRNAexpression <- as.matrix(mRNAexpression)
se.mRNAexpression = SummarizedExperiment(assays = list(mRNAexpression = mRNAexpression))

assays(se.lncRNAexpression)[["log2"]] <- log2(assays(se.lncRNAexpression)[["lncRNAexpression"]] + 1)

assays(se.miRNAexpression)[["log2"]] <- log2(assays(se.miRNAexpression)[["miRNAexpression"]] + 1)

assays(se.mRNAexpression)[["log2"]] <- log2(assays(se.mRNAexpression)[["mRNAexpression"]] + 1)


x <- assays(se.miRNAexpression["hsa-miR-26a-5p", ])$log2
y <- assays(se.mRNAexpression["PTEN", ])$log2
z <- assays(se.lncRNAexpression["PTENP1", ])$log2

XYZ <- discretize3D(x,y,z)

CMI.measure(XYZ)

## -----------------------------------------------------------------------------
# data.frame data type
library(Informeasure)

load(system.file("extdata/tcga.brca.testdata.Rdata", package = "Informeasure"))

miRNAexpression  <- log2(miRNAexpression + 1)
mRNAexpression   <- log2(mRNAexpression + 1)

x <- as.numeric(miRNAexpression[which(rownames(miRNAexpression) == "hsa-miR-34a-5p"), ])
y <- as.numeric(mRNAexpression[which(rownames(mRNAexpression) == "MYC"), ])
z <- as.numeric(miRNAexpression[which(rownames(miRNAexpression) == "hsa-miR-34b-5p"), ])

XYZ <- discretize3D(x,y,z)

II.measure(XYZ)

## -----------------------------------------------------------------------------
# SummarizedExperiment data type
library(Informeasure)
library(SummarizedExperiment)

load(system.file("extdata/tcga.brca.testdata.Rdata", package="Informeasure"))

miRNAexpression <- as.matrix(miRNAexpression)
se.miRNAexpression = SummarizedExperiment(assays = list(miRNAexpression = miRNAexpression))

mRNAexpression <- as.matrix(mRNAexpression)
se.mRNAexpression = SummarizedExperiment(assays = list(mRNAexpression = mRNAexpression))

assays(se.miRNAexpression)[["log2"]] <- log2(assays(se.miRNAexpression)[["miRNAexpression"]] + 1)

assays(se.mRNAexpression)[["log2"]] <- log2(assays(se.mRNAexpression)[["mRNAexpression"]] + 1)

x <- assays(se.miRNAexpression["hsa-miR-34a-5p", ])$log2
y <- assays(se.mRNAexpression["MYC", ])$log2
z <- assays(se.miRNAexpression["hsa-miR-34b-5p", ])$log2

XYZ <- discretize3D(x,y,z)

II.measure(XYZ)

## -----------------------------------------------------------------------------
# data.frame data type
library(Informeasure)

load(system.file("extdata/tcga.brca.testdata.Rdata", package = "Informeasure"))

miRNAexpression  <- log2(miRNAexpression + 1)
mRNAexpression   <- log2(mRNAexpression + 1)

x <- as.numeric(miRNAexpression[which(rownames(miRNAexpression) == "hsa-miR-34a-5p"), ])
y <- as.numeric(miRNAexpression[which(rownames(miRNAexpression) == "hsa-miR-34b-5p"), ])
z <- as.numeric(mRNAexpression[which(rownames(mRNAexpression) == "MYC"), ])

XYZ <- discretize3D(x,y,z)

PID.measure(XYZ)

## -----------------------------------------------------------------------------
# SummarizedExperiment data type
library(Informeasure)
library(SummarizedExperiment)

load(system.file("extdata/tcga.brca.testdata.Rdata", package="Informeasure"))

miRNAexpression <- as.matrix(miRNAexpression)
se.miRNAexpression = SummarizedExperiment(assays = list(miRNAexpression = miRNAexpression))

mRNAexpression <- as.matrix(mRNAexpression)
se.mRNAexpression = SummarizedExperiment(assays = list(mRNAexpression = mRNAexpression))

assays(se.miRNAexpression)[["log2"]] <- log2(assays(se.miRNAexpression)[["miRNAexpression"]] + 1)

assays(se.mRNAexpression)[["log2"]] <- log2(assays(se.mRNAexpression)[["mRNAexpression"]] + 1)

x <- assays(se.miRNAexpression["hsa-miR-34a-5p", ])$log2
y <- assays(se.miRNAexpression["hsa-miR-34b-5p", ])$log2
z <- assays(se.mRNAexpression["MYC", ])$log2

XYZ <- discretize3D(x,y,z)

PID.measure(XYZ)

## -----------------------------------------------------------------------------
# data.frame data type
library(Informeasure)

load(system.file("extdata/tcga.brca.testdata.Rdata", package = "Informeasure"))

lncRNAexpression <- log2(lncRNAexpression + 1)
miRNAexpression  <- log2(miRNAexpression + 1)
mRNAexpression   <- log2(mRNAexpression + 1)

x <- as.numeric(miRNAexpression[which(rownames(miRNAexpression)   == "hsa-miR-26a-5p"), ])
y <- as.numeric(mRNAexpression[which(rownames(mRNAexpression)     == "PTEN"), ])
z <- as.numeric(lncRNAexpression[which(rownames(lncRNAexpression) == "PTENP1"), ])

XYZ <- discretize3D(x,y,z)

PMI.measure(XYZ)

## -----------------------------------------------------------------------------
# SummarizedExperiment data type 
library(Informeasure)
library(SummarizedExperiment)

load(system.file("extdata/tcga.brca.testdata.Rdata", package="Informeasure"))

lncRNAexpression <- as.matrix(lncRNAexpression)
se.lncRNAexpression = SummarizedExperiment(assays = list(lncRNAexpression = lncRNAexpression))

miRNAexpression <- as.matrix(miRNAexpression)
se.miRNAexpression = SummarizedExperiment(assays = list(miRNAexpression = miRNAexpression))

mRNAexpression <- as.matrix(mRNAexpression)
se.mRNAexpression = SummarizedExperiment(assays = list(mRNAexpression = mRNAexpression))

assays(se.lncRNAexpression)[["log2"]] <- log2(assays(se.lncRNAexpression)[["lncRNAexpression"]] + 1)

assays(se.miRNAexpression)[["log2"]] <- log2(assays(se.miRNAexpression)[["miRNAexpression"]] + 1)

assays(se.mRNAexpression)[["log2"]] <- log2(assays(se.mRNAexpression)[["mRNAexpression"]] + 1)

x <- assays(se.miRNAexpression["hsa-miR-26a-5p", ])$log2
y <- assays(se.mRNAexpression["PTEN", ])$log2
z <- assays(se.lncRNAexpression["PTENP1", ])$log2

XYZ <- discretize3D(x,y,z)

PMI.measure(XYZ)

## -----------------------------------------------------------------------------
sessionInfo()

