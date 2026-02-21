# Code example from 'svaNUMT' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(#echo = TRUE,
  collapse = TRUE,
  comment = "#>")

## ----input, include=TRUE,results="hide",message=FALSE,warning=FALSE-----------
library(StructuralVariantAnnotation)
library(VariantAnnotation)
library(svaNUMT)

vcf <- readVcf(system.file("extdata", "chr1_numt_pe_HS25.sv.vcf", package = "svaNUMT"))
gr <- breakpointRanges(vcf)

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
library(readr)
numtS <- read_table(system.file("extdata", "numtS.txt", package = "svaNUMT"), 
    col_names = FALSE)
colnames(numtS) <- c("bin", "seqnames", "start", "end", "name", "score", "strand")
numtS <- GRanges(numtS)
GenomeInfoDb::seqlevelsStyle(numtS) <- "NCBI"

library(BSgenome.Hsapiens.UCSC.hg19)
genome <- BSgenome.Hsapiens.UCSC.hg19
genomeMT <- genome$chrMT

## -----------------------------------------------------------------------------
NUMT <- numtDetect(gr, numtS, genomeMT, max_ins_dist = 20)

## -----------------------------------------------------------------------------
GRangesList(NU=NUMT$MT$NU$`1`[[1]], MT=NUMT$MT$MT$`1`[[1]])

## -----------------------------------------------------------------------------
seqnames = 1
start = 1000000
end = 3000000
i <- sapply(NUMT$MT$NU[[seqnames]], function(x) 
  sum(countOverlaps(x, GRanges(seqnames = seqnames, IRanges(start, end))))>0)
list(NU=NUMT$MT$NU[[seqnames]][i], MT=NUMT$MT$MT[[seqnames]][i])

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
library(circlize)
numt_chr_prefix <- c(NUMT$MT$NU$`1`[[2]], NUMT$MT$MT$`1`[[2]])
GenomeInfoDb::seqlevelsStyle(numt_chr_prefix) <- "UCSC"
pairs <- breakpointgr2pairs(numt_chr_prefix)
pairs

## -----------------------------------------------------------------------------
circos.initializeWithIdeogram(
    data.frame(V1=c("chr1", "chrM"),
               V2=c(1791073,1),
               V3=c(1791093,16571),
               V4=c("p15.4",NA),
               V5=c("gpos50",NA)),  sector.width = c(0.2, 0.8))
#circos.initializeWithIdeogram()
circos.genomicLink(as.data.frame(S4Vectors::first(pairs)), 
                   as.data.frame(S4Vectors::second(pairs)))
circos.clear()

## -----------------------------------------------------------------------------
sessionInfo()

