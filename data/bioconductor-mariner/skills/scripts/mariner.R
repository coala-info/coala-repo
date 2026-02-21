# Code example from 'mariner' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----installPackageBioconductor, eval=FALSE-----------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("mariner")

## ----installPackage, eval=FALSE-----------------------------------------------
# if (!requireNamespace("remotes", quietly = TRUE))
#     install.packages("remotes")
# remotes::install_github("EricSDavis/mariner")

## ----as_ginteractions, message=FALSE------------------------------------------
library(mariner)
library(marinerData)

## BEDPE-formatted file
bedpeFile <- marinerData::WT_5kbLoops.txt()

## Read BEDPE
bedpe <- read.table(bedpeFile, header = TRUE)
head(bedpe)

## Coerce to GInteractions
gi <- as_ginteractions(bedpe, keep.extra.columns = FALSE)
gi

## ----GInteractionAccessors, results='hold'------------------------------------
seqnames1(gi) |> head()
start1(gi) |> head()
end1(gi) |> head()
seqnames2(gi) |> head()
start2(gi) |> head()
end2(gi) |> head()

## ----binning1, message=FALSE--------------------------------------------------
## Assign to 1Kb bins
binned <- assignToBins(x=gi, binSize = 1e3, pos1='center', pos2='center')

## Show that each anchor is 1Kb
library(InteractionSet)
width(binned) |> lapply(unique)


## ----binning2-----------------------------------------------------------------
## Assign anchor1 to 1Kb bins and anchor2 to 25Kb bins
binned <- assignToBins(x=gi, binSize=c(1e3, 25e3), pos1="start", pos2="center")

## Show that the first anchor is 1Kb and
## second anchor is 25Kb
width(binned) |> lapply(unique)

## ----snapping, results='hold'-------------------------------------------------
## Create an example GInteractions object
gi <- GInteractions(
    anchor1 = c(
        GRanges("chr1:1-15"),
        GRanges("chr1:1-11")
    ),
    anchor2 = c(
        GRanges("chr1:25-31"),
        GRanges("chr1:19-31")
    )
)

## Original interactions
gi

## Snap to bins with different binSizes
snapToBins(x=gi, binSize=5)
snapToBins(x=gi, binSize=10)

## ----binningFigure, fig.align='center', out.width='75%', echo=FALSE-----------
knitr::include_graphics("figures/binningFigure.png")

## ----merging1, message=FALSE--------------------------------------------------
library(mariner)
library(marinerData)

## BEDPE-formatted files
bedpeFiles <- c(
    marinerData::FS_5kbLoops.txt(),
    marinerData::WT_5kbLoops.txt()
)
names(bedpeFiles) <- c("FS", "WT")

## Read as list of GInteractions
giList <-
    lapply(bedpeFiles, read.table, header=TRUE) |>
    lapply(as_ginteractions)

lapply(giList, summary)

## ----merging2-----------------------------------------------------------------
mgi <- mergePairs(
    x=giList,
    radius=10e3
)
mgi

## ----clusters, results='hold'-------------------------------------------------
mgi[12772]
clusters(mgi[12772])

## ----merging3-----------------------------------------------------------------
mgi <- mergePairs(
    x=giList,
    radius=10e3,
    column="APScoreAvg",
    selectMax=TRUE
)
mgi

## ----clusters2, results='hold'------------------------------------------------
mgi[12772]
clusters(mgi[12772])

## ----sets---------------------------------------------------------------------
## List the input sources
sources(mgi)

## Interactions unique to each source
sets(mgi) |> lapply(summary)

## Interactions shared by both sources
sets(x=mgi, include=sources(mgi))

## ----examplePullPixels, message=FALSE-----------------------------------------
library(mariner)
library(marinerData)

## BEDPE-formatted files
bedpeFiles <- c(
    marinerData::FS_5kbLoops.txt(),
    marinerData::WT_5kbLoops.txt()
)
names(bedpeFiles) <- c("FS", "WT")

## Read as list of GInteractions
giList <-
    lapply(bedpeFiles, read.table, header=TRUE) |>
    lapply(as_ginteractions)

## Merge
mgi <- mergePairs(x=giList, radius=10e3, column="APScoreAvg")

summary(mgi)

## ----loadHicFiles, message=FALSE----------------------------------------------
library(marinerData)
hicFiles <- c(
    LEUK_HEK_PJA27_inter_30.hic(),
    LEUK_HEK_PJA30_inter_30.hic()
)
names(hicFiles) <- c("FS", "WT")
hicFiles

## ----strawr-------------------------------------------------------------------
library(strawr)

## Normalizations
lapply(hicFiles, readHicNormTypes)

## Resolutions
lapply(hicFiles, readHicBpResolutions)

## Chromosomes
lapply(hicFiles, readHicChroms) |>
    lapply(head)

## ----seqLevelStyles-----------------------------------------------------------
GenomeInfoDb::seqlevelsStyle(mgi) <- 'ENSEMBL'

## ----binPixels----------------------------------------------------------------
## Assign interactions to 100Kb bins
binned <- assignToBins(x=mgi, binSize=100e3)

## ----pullPixels---------------------------------------------------------------
imat <- pullHicPixels(
    x=binned[1:1000],
    files=hicFiles,
    binSize=100e3
)
imat

## -----------------------------------------------------------------------------
counts(imat)

## ----pullMatrices1------------------------------------------------------------
iarr <- pullHicMatrices(
    x=binned[1:1000],
    file=hicFiles,
    binSize = 25e3
)
iarr

## -----------------------------------------------------------------------------
counts(iarr)

## -----------------------------------------------------------------------------
counts(iarr, showDimnames=TRUE)

## ----pullMatrices2------------------------------------------------------------
## Define region with 1-pixel buffer
regions <- pixelsToMatrices(x=binned[1:1000], buffer=1)

## Pull 3x3 matrices from 1000 interactions and 2 hic files
iarr <- pullHicMatrices(
    x=regions,
    files=hicFiles,
    binSize=100e3
)

## See count matrices
counts(iarr)

## ----pullMatrices3------------------------------------------------------------

## Bin at two different resolutions
binned <- assignToBins(x=mgi, binSize=c(100e3, 250e3))

## Pull 10x25 matrices from 1000 interactions and 2 hic files
iarr2 <- pullHicMatrices(
    x=binned[1:1000],
    files=hicFiles,
    binSize=10e3
)

## See count matrices
counts(iarr2)

## ----aggHic-------------------------------------------------------------------
## One matrix per interaction
aggHicMatrices(x=iarr, by="interactions")

## One matrix per file
aggHicMatrices(x=iarr, by="files")

## One matrix total
aggHicMatrices(x=iarr)

## ----plotMatrix---------------------------------------------------------------
mat <- aggHicMatrices(x=iarr)
plotMatrix(data=mat)

## ----selectionFunctions-------------------------------------------------------
## Define the buffer
buffer <- 3

## Select center pixel
selectCenterPixel(mhDist=0, buffer=buffer)

## With a radial distance
selectCenterPixel(mhDist=0:1, buffer=buffer)

## Select all corners
selectCorners(n=2, buffer=buffer)

## Combine functions
selectTopLeft(n=2, buffer=buffer) +
    selectBottomRight(n=2, buffer=buffer)

## ----loopEnrichment, message=FALSE--------------------------------------------
library(mariner)
library(marinerData)

## Define hicFiles
hicFiles <- c(
    LEUK_HEK_PJA27_inter_30.hic(),
    LEUK_HEK_PJA30_inter_30.hic()
) |> setNames(c("FS", "WT"))

## Read in loops
loops <- 
    WT_5kbLoops.txt() |>
    setNames("WT") |>
    read.table(header=TRUE, nrows=1000) |>
    as_ginteractions() |>
    assignToBins(binSize=100e3) |>
    GenomeInfoDb::`seqlevelsStyle<-`('ENSEMBL')

## Define foreground & background
buffer <- 10
fg <- selectCenterPixel(mhDist=0:1, buffer=buffer)
bg <- selectTopLeft(n=2, buffer=buffer) +
    selectBottomRight(n=2, buffer=buffer)

## Calculate loop enrichment
enrich <- calcLoopEnrichment(
    x=loops,
    files=hicFiles,
    fg=fg,
    bg=bg
)
enrich

## -----------------------------------------------------------------------------
sessionInfo()

