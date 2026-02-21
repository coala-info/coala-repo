# Code example from 'GenoGAM' vignette. See references/ for full tutorial.

## ----knitr, echo=FALSE, results="hide"-----------------------------------
library("knitr")
opts_chunk$set(
  tidy=FALSE,
  dev="png",
  #fig.show="hide",
  fig.width=4, fig.height=4.5,
  dpi = 300,
  cache=TRUE,
  message=FALSE,
  warning=FALSE)

## ----style, eval=TRUE, echo=FALSE, results="asis"--------------------------
BiocStyle::latex()

## ----loadGenoGAM, echo=FALSE-----------------------------------------------
library("GenoGAM")

## ----options, results="hide", echo=FALSE--------------------------------------
options(digits=3, width=80, prompt=" ", continue=" ")
opts_chunk$set(dev = 'pdf')

## ----parallel-----------------------------------------------------------------
library(GenoGAM)

## On multicore machines by default the number of available cores - 2 are registered
BiocParallel::registered()[1]

## ----parallel-register--------------------------------------------------------
BiocParallel::register(BiocParallel::SnowParam(workers = 4, progressbar = TRUE))

## ----check--------------------------------------------------------------------
BiocParallel::registered()[1]

## ----expdesign----------------------------------------------------------------

folder <- system.file("extdata/Set1", package='GenoGAM')

expDesign <- read.delim(
  file.path(folder, "experimentDesign.txt")
)

expDesign

## ----ggd----------------------------------------------------------------------
bpk <- 20
chunkSize <- 1000
overhangSize <- 15*bpk

## build the GenoGAMDataSet
ggd <- GenoGAMDataSet(
  expDesign, directory = folder,
  chunkSize = chunkSize, overhangSize = overhangSize,
  design = ~ s(x) + s(x, by = genotype)
)

ggd

## data filtered for regions with zero counts
filtered_ggd <- filterData(ggd)
filtered_ggd

## alternatively we can restricts the GenoGAM dataset to the positions of 
## interest as we know them by design of this example
ggd <- subset(ggd, seqnames == "chrXIV" & pos >= 305000 & pos <= 308000)

## They are almost the same as found by the filter
range(getIndex(filtered_ggd))

## ----settings, eval=FALSE-----------------------------------------------------
#  ## specify specific chromosomes
#  settings <- GenoGAM:::GenoGAMSettings(chromosomeList = c('chrI', 'chrII'))
#  
#  ## specify parameters through ScanBamParam
#  gr <- GRanges("chrI", IRanges(1,100000))
#  params <- ScanBamParam(which = gr)
#  settings <- GenoGAM:::GenoGAMSettings(bamParams = params)

## ----sizeFactor---------------------------------------------------------------
ggd <- computeSizeFactors(ggd)
sizeFactors(ggd)

## ----qualityCheck, eval=FALSE-------------------------------------------------
#  ## the function is not run as it creates new plots each time,
#  ## which are not very meaningful for such a small example
#  qualityCheck(ggd)

## ----fitwocv------------------------------------------------------------------
## fit model without parameters estimation
fit <- genogam(ggd, 
               lambda = 40954.1,
               family = mgcv::nb(theta = 6.927986),
               bpknots = bpk
)
fit

## ----fitwithcv, eval=FALSE----------------------------------------------------
#  fit_CV <- genogam(ggd,bpknots = bpk)

## ----view---------------------------------------------------------------------
# extract count data into a data frame 
df_data <- view(ggd)
head(df_data)

# extract fit into a data frame 
df_fit <- view(fit)
head(df_fit)

## ----viewranges---------------------------------------------------------------
gr <- GRanges("chrXIV", IRanges(306000, 308000))
head(view(ggd, ranges = gr))

## ----plotfit,  fig.width=6.5, fig.height=8------------------------------------
plot(fit, ggd, scale = FALSE)

## ----signif-------------------------------------------------------------------
fit <- computeSignificance(fit)
df_fit <- view(fit)
head(df_fit)

## ----regsignif----------------------------------------------------------------
gr
gr <- computeRegionSignificance(fit, regions = gr, what = 'genotype')
gr

## ----peaks--------------------------------------------------------------------
peaks <- callPeaks(fit, smooth = "genotype", threshold = 1)
peaks

peaks <- callPeaks(fit, smooth = "genotype", threshold = 1, 
                   peakType = "broad", cutoff = 0.75)
peaks

## ----bed, eval=FALSE----------------------------------------------------------
#  writeToBEDFile(peaks, file = 'myPeaks')

## ----sessInfo, results="asis", echo=FALSE-------------------------------------
toLatex(sessionInfo())

## ----resetOptions, results="hide", echo=FALSE---------------------------------
options(prompt="> ", continue="+ ")

