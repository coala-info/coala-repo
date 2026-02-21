# Code example from 'sevenC' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# # install.packages("BiocManager")
# BiocManager::install("sevenC")

## ----results = "hide", message = FALSE----------------------------------------
library(sevenC)

# load provided CTCF motifs in human genome
motifs <- motif.hg19.CTCF.chr22

# get motifs pairs
gi <- prepareCisPairs(motifs)

## ----eval = FALSE, echo = TRUE------------------------------------------------
# 
# # use example ChIP-seq bigWig file
# bigWigFile <- system.file("extdata", "GM12878_Stat1.chr22_1-30000000.bigWig",
#   package = "sevenC")
# 
# # add ChIP-seq coverage and compute correaltion at motif pairs
# gi <- addCor(gi, bigWigFile)

## ----eval = TRUE, echo = FALSE------------------------------------------------
# check if on windows to prevent bigWig reading errors from rtracklayer
if (.Platform$OS.type == 'windows') {
  # use motif data with ChIP-seq coverage
  motifs <- motif.hg19.CTCF.chr22.cov
  gi <- prepareCisPairs(motifs)
  gi <- addCovCor(gi)
  
} else {
  # use example ChIP-seq bigWig file
  bigWigFile <- system.file("extdata", "GM12878_Stat1.chr22_1-30000000.bigWig", 
    package = "sevenC")
  
  # add ChIP-seq coverage and compute correaltion at motif pairs
  gi <- addCor(gi, bigWigFile)
}

## -----------------------------------------------------------------------------
# predict looping interactions among all motif pairs
loops <- predLoops(gi)

## ----results = "hide", message = FALSE----------------------------------------
library(sevenC)

# load provided CTCF motifs
motifs <- motif.hg19.CTCF.chr22

## -----------------------------------------------------------------------------
# use example ChIP-seq bigWig file
bigWigFile <- system.file("extdata", "GM12878_Stat1.chr22_1-30000000.bigWig", 
  package = "sevenC")

## ----eval = FALSE-------------------------------------------------------------
# # read ChIP-seq coverage
# motifs <- addCovToGR(motifs, bigWigFile)

## ----eval = TRUE, echo = FALSE------------------------------------------------
# check if OS is windows
if (.Platform$OS.type == 'windows') {
  motifs <- motif.hg19.CTCF.chr22.cov
} else {
  # read ChIP-seq coverage 
  motifs <- addCovToGR(motifs, bigWigFile)
}

## -----------------------------------------------------------------------------
motifs$chip

## -----------------------------------------------------------------------------
gi <- prepareCisPairs(motifs, maxDist = 10^6)

gi

## -----------------------------------------------------------------------------
# add ChIP-seq coverage and compute correaltion at motif pairs
gi <- addCovCor(gi)

## -----------------------------------------------------------------------------
loops <- predLoops(gi)

loops

## ----results = "hide", message = FALSE----------------------------------------
library(GenomicInteractions)

# export to output file
export.bedpe(loops, "loop_interactions.bedpe", score = "pred")


## ----eval = FALSE, echo = TRUE------------------------------------------------
# # load provided CTCF motifs
# motifs <- motif.hg19.CTCF.chr22
# 
# # use example ChIP-seq coverage file
# bigWigFile <- system.file("extdata", "GM12878_Stat1.chr22_1-30000000.bigWig",
#   package = "sevenC")
# 
# # add ChIP-seq coverage
# motifs <- addCovToGR(motifs, bigWigFile)
# 
# # build motif pairs
# gi <- prepareCisPairs(motifs, maxDist = 10^6)
# 
# # add correaltion of ChIP-signal
# gi <- addCovCor(gi)

## ----eval = TRUE, echo = FALSE------------------------------------------------
# check if OS is windows
if (.Platform$OS.type == 'windows') {
  motifs <- motif.hg19.CTCF.chr22.cov
} else {
  # load provided CTCF motifs
  motifs <- motif.hg19.CTCF.chr22
  
  # use example ChIP-seq coverage file
  bigWigFile <- system.file("extdata", "GM12878_Stat1.chr22_1-30000000.bigWig", 
    package = "sevenC")
  
  # add ChIP-seq coverage
  motifs <- addCovToGR(motifs, bigWigFile)
}
  
gi <- prepareCisPairs(motifs, maxDist = 10^6)

# add correaltion of ChIP-signal
gi <- addCovCor(gi)

## ----message = FALSE----------------------------------------------------------
# parse known loops
knownLoopFile <- system.file("extdata", 
  "GM12878_HiCCUPS.chr22_1-30000000.loop.txt", package = "sevenC")

knownLoops <- parseLoopsRao(knownLoopFile)

## -----------------------------------------------------------------------------
# add known loops
gi <- addInteractionSupport(gi, knownLoops)

## -----------------------------------------------------------------------------
fit <- glm(
  formula = loop ~ cor_chip + dist + strandOrientation, 
  data = mcols(gi), 
  family = binomial()
  )

## -----------------------------------------------------------------------------
# add predict loops
gi <- predLoops(
  gi,
  formula = loop ~ cor_chip + dist + strandOrientation,
  betas = coef(fit),
  cutoff = NULL
)

## -----------------------------------------------------------------------------
gi 

## ----fig.width = 3, fig.height = 4--------------------------------------------
boxplot(gi$pred ~ gi$loop, 
        ylab = "Predicted interaction probability")


## -----------------------------------------------------------------------------
sessionInfo()

