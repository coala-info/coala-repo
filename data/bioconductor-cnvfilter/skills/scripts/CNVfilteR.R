# Code example from 'CNVfilteR' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(concordance=FALSE)
knitr::opts_chunk$set(fig.width = 8)
knitr::opts_chunk$set(fig.height = 5)
set.seed(21666641)

## ----getPackage, eval=FALSE---------------------------------------------------
#   if (!requireNamespace("BiocManager", quietly = TRUE))
#       install.packages("BiocManager")
#   BiocManager::install("CNVfilteR")

## ----eval = FALSE-------------------------------------------------------------
#   BiocManager::install("jpuntomarcos/CNVfilteR")

## ----message=FALSE------------------------------------------------------------
library(CNVfilteR)

cnvs.file <- system.file("extdata", "DECoN.CNVcalls.csv", package = "CNVfilteR", mustWork = TRUE)
cnvs.gr <- loadCNVcalls(cnvs.file = cnvs.file, chr.column = "Chromosome", start.column = "Start", end.column = "End", cnv.column = "CNV.type", sample.column = "Sample", genome = "hg19")


## -----------------------------------------------------------------------------
vcf.files <- c(system.file("extdata", "variants.sample1.vcf.gz", package = "CNVfilteR", mustWork = TRUE),
               system.file("extdata", "variants.sample2.vcf.gz", package = "CNVfilteR", mustWork = TRUE))
vcfs <- loadVCFs(vcf.files, cnvs.gr = cnvs.gr, genome = "hg19")

## ----message=FALSE------------------------------------------------------------
results <- filterCNVs(cnvs.gr, vcfs)
names(results)

## -----------------------------------------------------------------------------
results$cnvs[results$cnvs$filter == TRUE]

## -----------------------------------------------------------------------------
results$variantsForEachCNV[["3"]]

## ----fig.wide=TRUE------------------------------------------------------------
plotVariantsForCNV(results, "3")

## ----fig.wide=TRUE------------------------------------------------------------
plotVariantsForCNV(results, "19")

## -----------------------------------------------------------------------------
results$cnvs[results$cnvs$filter != TRUE]

## -----------------------------------------------------------------------------
results$variantsForEachCNV[["14"]]

## ----fig.wide=TRUE------------------------------------------------------------
plotVariantsForCNV(results, "3")

## ----message=FALSE------------------------------------------------------------

cnvs.file <- system.file("extdata", "DECoN.CNVcalls.csv", package = "CNVfilteR", mustWork = TRUE)
cnvs.gr <- loadCNVcalls(cnvs.file = cnvs.file, chr.column = "Chromosome", start.column = "Start", end.column = "End", cnv.column = "CNV.type", sample.column = "Sample", genome = "hg19")


## ----eval=FALSE---------------------------------------------------------------
# cnvs.gr.2 <- loadCNVcalls(cnvs.file = cnvs.file.2, deletion = "CN1", duplication = "CN3", chr.column = "Chromosome", start.column = "Start", end.column = "End", cnv.column = "CNV.type", sample.column = "Sample")

## -----------------------------------------------------------------------------
vcf.files <- c(system.file("extdata", "variants.sample1.vcf.gz", package = "CNVfilteR", mustWork = TRUE),
               system.file("extdata", "variants.sample2.vcf.gz", package = "CNVfilteR", mustWork = TRUE))
vcfs <- loadVCFs(vcf.files, cnvs.gr = cnvs.gr)

## -----------------------------------------------------------------------------
vcfs <- loadVCFs(vcf.files, cnvs.gr = cnvs.gr, vcf.source = "MyCaller", ref.support.field = "RD", alt.support.field = "AD")

## -----------------------------------------------------------------------------
vcf.file3 <- c(system.file("extdata", "variants.sample3.vcf", package = "CNVfilteR", mustWork = TRUE))
vcfs3 <- loadVCFs(vcf.file3, cnvs.gr = cnvs.gr, vcf.source = "MyCaller", list.support.field = "AD")

## -----------------------------------------------------------------------------
regions.to.exclude <- GRanges(seqnames = c("chr3","chr7", "chr7"), ranges = IRanges(c(10068098, 6012870, 142457319), c(10143614, 6048756, 142460923)))
vcfs4 <- loadVCFs(vcf.files, cnvs.gr = cnvs.gr, regions.to.exclude = regions.to.exclude)

## -----------------------------------------------------------------------------
results <- filterCNVs(cnvs.gr, vcfs)
tail(results$cnvs)

## ----fig.height=6, fig.wide=TRUE----------------------------------------------
p <- results$filterParameters
plotScoringModel(expected.ht.mean = p$expected.ht.mean, 
                 expected.dup.ht.mean1 = p$expected.dup.ht.mean1,
                 expected.dup.ht.mean2 = p$expected.dup.ht.mean2,
                 sigmoid.c1 = p$sigmoid.c1, 
                 sigmoid.c2.vector = p$sigmoid.c2.vector)


## ----fig.height=6, fig.wide=TRUE----------------------------------------------
plotScoringModel(expected.ht.mean = p$expected.ht.mean, 
                 expected.dup.ht.mean1 = p$expected.dup.ht.mean1,
                 expected.dup.ht.mean2 = p$expected.dup.ht.mean2,
                 sigmoid.c1 = 1, 
                 sigmoid.c2.vector = p$sigmoid.c2.vector)

## ----fig.height=6, fig.wide=TRUE----------------------------------------------
plotScoringModel(expected.ht.mean = p$expected.ht.mean, 
                 expected.dup.ht.mean1 = p$expected.dup.ht.mean1,
                 expected.dup.ht.mean2 = p$expected.dup.ht.mean2,
                 sigmoid.c1 = p$sigmoid.c1, 
                 sigmoid.c2.vector = c(28, 38.3, 46.7, 53.3, 61.3, 71.3))

## ----fig.wide=TRUE------------------------------------------------------------
plotVariantsForCNV(results, "16")

## ----fig.width=8, fig.height=8, fig.wide=TRUE---------------------------------
cnvs.file <- system.file("extdata", "DECoN.CNVcalls.2.csv",
                         package = "CNVfilteR", mustWork = TRUE)
cnvs.gr.2 <- loadCNVcalls(cnvs.file = cnvs.file, chr.column = "Chromosome",
                          start.column = "Start", end.column = "End", 
                          cnv.column = "CNV.type", sample.column = "Sample",
                          genome = "hg19")
plotAllCNVs(cnvs.gr.2)

## -----------------------------------------------------------------------------
  sessionInfo()

