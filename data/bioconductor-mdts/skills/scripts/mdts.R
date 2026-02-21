# Code example from 'mdts' vignette. See references/ for full tutorial.

## ----echo=F, message=F, warning=F---------------------------------------------
library(MDTS); library(BSgenome.Hsapiens.UCSC.hg19)
setwd(system.file("extdata", package="MDTS"))
load('pD.RData')
pD

## ----echo=FALSE, message=FALSE------------------------------------------------
library(MDTS)

## ----eval=F, warning=F--------------------------------------------------------
# library(MDTS); library(BSgenome.Hsapiens.UCSC.hg19)
# # Using the raw data from MDTSData
# devtools::install_github("jmf47/MDTSData")
# setwd(system.file("data", package="MDTSData"))
# 
# # Importing the pedigree file that includes information on where to locate the
# # raw bam files
# pD <- getMetaData("pD.ped")
# 
# # Information on the GC content and mappability to estimate GC and mappability
# # for the MDTS bins
# genome <- BSgenome.Hsapiens.UCSC.hg19; map_file = "chr1.map.bw"
# 
# # This command now subsets 5 samples to determine MDTS bins
# # pD is the metaData matrix from getMetaData()
# # n is the number of samples to examine to calculate the bins
# # readLength is the sequencing read length
# # minimumCoverage is the minimum read depth for a location to be included
# #     in a proto region
# # medianCoverage is the median number of reads across the n samples in a bin
# bins <- calcBins(metaData=pD, n=5, readLength=100, minimumCoverage=5,
#                 medianCoverage=150, genome=genome, mappabilityFile=map_file)

## ----eval=F-------------------------------------------------------------------
# # pD is the phenotype matrix
# # bins is the previously calculated MDTS bins
# # rl is the sequencing read length
# counts = calcCounts(pD, bins, rl=100)

## ----message=FALSE, warning=F-------------------------------------------------
load(system.file("extdata", 'bins.RData', package = "MDTS"))
load(system.file("extdata", 'counts.RData', package = "MDTS"))
load(system.file("extdata", 'pD.RData', package = "MDTS"))

## -----------------------------------------------------------------------------
bins

## -----------------------------------------------------------------------------
head(counts)

## ----warning=F----------------------------------------------------------------
# counts is the raw read depth of [MDTS bins x samples]
# bins is the previously calculated MDTS bins
mCounts <- normalizeCounts(counts, bins)

## ----warning=F----------------------------------------------------------------
# mCounts is the normalized read depth of [MDTS bins x samples]
# bins is the previously calculated MDTS bins
# pD is the phenotype matrix
md <- calcMD(mCounts, pD)

## ----warning=FALSE, message=FALSE, warning=F----------------------------------
# md is the Minimum Distance of [MDTS bins x trio]
# bins is the previously calculated MDTS bins
# mCounts is the normalized read depth of [MDTS bins x samples]
cbs <- segmentMD(md=md, bins=bins)
denovo <- denovoDeletions(cbs, mCounts, bins)

## -----------------------------------------------------------------------------
denovo

## -----------------------------------------------------------------------------
sessionInfo()

