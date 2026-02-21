# Code example from 'cfTools-vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----"install", eval = FALSE--------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# BiocManager::install("cfTools")

## ----'install_dev', eval = FALSE----------------------------------------------
# BiocManager::install("jasminezhoulab/cfTools")

## ----demo---------------------------------------------------------------------
library(cfTools)
library(utils)
demo.dir <- system.file("data", package="cfTools")

## -----------------------------------------------------------------------------
PEReads <- file.path(demo.dir, "demo.sorted.bed.txt.gz")
head(read.table(PEReads, header=FALSE), 2)

## -----------------------------------------------------------------------------
fragInfo <- MergePEReads(PEReads)
head(fragInfo, 2)

## -----------------------------------------------------------------------------
CpG_OT <- file.path(demo.dir, "CpG_OT_demo.txt.gz")
CpG_OB <- file.path(demo.dir, "CpG_OB_demo.txt.gz")
head(read.table(CpG_OT, header=FALSE), 2)
head(read.table(CpG_OB, header=FALSE), 2)

## -----------------------------------------------------------------------------
methInfo <- MergeCpGs(CpG_OT, CpG_OB)
head(methInfo, 2)

## -----------------------------------------------------------------------------
fragMeth <- GenerateFragMeth(fragInfo, methInfo)
head(fragMeth, 2)

## -----------------------------------------------------------------------------
methLevel <- read.table(file.path(demo.dir, "beta_matrix.txt.gz"), 
                      row.names=1, header = TRUE)
sampleTypes <- read.table(file.path(demo.dir, "sample_type.txt.gz"), 
                        row.names=1, header = TRUE)$sampleType
markerNames <- read.table(file.path(demo.dir, "marker_index.txt.gz"), 
                        row.names=1, header = TRUE)$markerIndex
print(methLevel)
print(sampleTypes)
print(markerNames)

## -----------------------------------------------------------------------------
markerParam <- GenerateMarkerParam(methLevel, sampleTypes, markerNames)
print(markerParam)

## ----message=FALSE------------------------------------------------------------
library(GenomicRanges)

# a BED file of fragment-level methylation information
frag_bed <- read.csv(file.path(demo.dir, "demo.fragment_level.meth.bed.txt.gz"), 
                     header=TRUE, sep="\t")
frag_meth.gr <- GRanges(seqnames=frag_bed$chr, 
                     ranges=IRanges(frag_bed$start, frag_bed$end),
                     strand=frag_bed$strand,
                     methState=as.character(frag_bed$methState))

# a BED file of genomic regions of markers
markers_bed <- read.csv(file.path(demo.dir, "markers.bed.txt.gz"), 
                        header=TRUE, sep="\t")
markers.gr <- GRanges(seqnames=markers_bed$chr, 
                      ranges=IRanges(markers_bed$start, markers_bed$end),
                      markerName=markers_bed$markerName)

head(frag_meth.gr, 2)
head(markers.gr, 2)

## -----------------------------------------------------------------------------
ranges <- subsetByOverlaps(frag_meth.gr, markers.gr, ignore.strand=TRUE)
hits <- findOverlaps(frag_meth.gr, markers.gr,ignore.strand=TRUE)
idx <- subjectHits(hits)

values <- DataFrame(markerName=markers.gr$markerName[idx])
mcols(ranges) <- c(mcols(ranges), values)

marker.methState <- as.data.frame(cbind(ranges$markerName, 
                                        ranges$methState))
colnames(marker.methState) <- c("markerName", "methState")
head(marker.methState, 4)

## -----------------------------------------------------------------------------
fragMethFile <- file.path(demo.dir, "CancerDetector.reads.txt.gz")
markerParamFile <- file.path(demo.dir, "CancerDetector.markers.txt.gz")
head(read.csv(fragMethFile, sep = "\t", colClasses = "character"), 4)
head(read.csv(markerParamFile, sep = "\t"), 4)

## -----------------------------------------------------------------------------
CancerDetector(fragMethFile, markerParamFile, lambda=0.5, id="test")

## -----------------------------------------------------------------------------
fragMethFile2 <- file.path(demo.dir, "cfDeconvolve.reads.txt.gz")
markerParamFile2 <- file.path(demo.dir, "cfDeconvolve.markers.txt.gz")
head(read.csv(fragMethFile2, header=TRUE, sep="\t", 
              colClasses = "character"), 4)
head(read.csv(markerParamFile2, header=TRUE, sep="\t", 
              colClasses = "character"), 4)

## -----------------------------------------------------------------------------
numTissues <- 7
emAlgorithmType <- "em.global.unknown"
likelihoodRatioThreshold <- 2
emMaxIterations <- 100
randomSeed <- 0
id <- "test"

## ----message=TRUE-------------------------------------------------------------
tissueFraction <- cfDeconvolve(fragMethFile2, markerParamFile2, numTissues, 
                               emAlgorithmType, likelihoodRatioThreshold, 
                               emMaxIterations, randomSeed, id)
tissueFraction

## -----------------------------------------------------------------------------
fragMethInfo <- file.path(demo.dir, "cfsort_reads.txt.gz")
head(read.csv(fragMethInfo, header=TRUE, sep="\t", 
              colClasses = "character"), 4)

## ----message=FALSE------------------------------------------------------------
tissueFraction2 <- cfSort(fragMethInfo, id="demo")
tissueFraction2

## -----------------------------------------------------------------------------
cancer_normal_df <- CancerDetector(fragMethFile, markerParamFile, lambda=0.5, id="test")
PlotFractionPie(cancer_normal_df, title = "cfDNA Composition", class_colors = c("normal_cfDNA_fraction" = "blue"), font_size = 1.2)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

