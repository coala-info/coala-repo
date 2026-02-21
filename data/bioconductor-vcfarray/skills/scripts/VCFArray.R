# Code example from 'VCFArray' vignette. See references/ for full tutorial.

## ----options, eval=TRUE, echo=FALSE-------------------------------------------
options(showHeadLines=3)
options(showTailLines=3)

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----getPackage, eval=FALSE---------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("VCFArray")

## ----getDevel, eval=FALSE-----------------------------------------------------
# BiocManager::install("Bioconductor/VCFArray")

## ----Load, message=FALSE------------------------------------------------------
library(VCFArray)

## ----avail, message=FALSE-----------------------------------------------------
args(VCFArray)
fl <- system.file("extdata", "chr22.vcf.gz", package = "VariantAnnotation")
library(VariantAnnotation)
vcfFields(fl)

## ----constructor--------------------------------------------------------------
VCFArray(file = fl, name = "GT")

## ----constructor2-------------------------------------------------------------
vcf <- VariantAnnotation::VcfFile(fl)
VCFArray(file = vcf, name = "DS")

## ----rgstack------------------------------------------------------------------
extdata <- system.file(package = "GenomicFiles", "extdata")
files <- dir(extdata, pattern="^CEUtrio.*bgz$", full=TRUE)[1:2]
names(files) <- sub(".*_([0-9XY]+).*", "\\1", basename(files))
seqinfo <- as(readRDS(file.path(extdata, "seqinfo.rds")), "Seqinfo")
stack <- GenomicFiles::VcfStack(files, seqinfo)
gr <- as(GenomicFiles::seqinfo(stack)[rownames(stack)], "GRanges")
## RangedVcfStack
rgstack <- GenomicFiles::RangedVcfStack(stack, rowRanges = gr)  
rgstack

## ----constructor3-------------------------------------------------------------
vcfFields(rgstack)$geno
VCFArray(rgstack, name = "SB")

## ----remote, eval=FALSE-------------------------------------------------------
# chr22url <- "https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz"
# chr22url.tbi <- paste0(chr22url, ".tbi")
# va <- VCFArray(chr22url, vindex =chr22url.tbi, name = "GT")

## ----seedAccessor-------------------------------------------------------------
va <- VCFArray(fl, name = "GT")
seed(va)

## ----vcffileAccessor----------------------------------------------------------
vcffile(va)

## ----dims---------------------------------------------------------------------
va <- VCFArray(fl, name = "GT")
dim(va)
class(dimnames(va))
lengths(dimnames(va))

## ----subsetting---------------------------------------------------------------
va[1:3, 1:3]
va[c(TRUE, FALSE), ]

## ----numeric------------------------------------------------------------------
ds <- VCFArray(fl, name = "DS")
log(ds+5)

## ----VCFArraySeed-------------------------------------------------------------
seed <- VCFArray:::VCFArraySeed(fl, name = "GT", pfix = NULL)
seed
path(vcffile(seed))

## ----VCFArray-from-VCFArraySeed-----------------------------------------------
(va <- VCFArray(seed))

## ----da-----------------------------------------------------------------------
da <- DelayedArray(seed)
class(da)
all.equal(da, va)

## -----------------------------------------------------------------------------
sessionInfo()

