# Code example from 'scoreInvHap' vignette. See references/ for full tutorial.

## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(warning=FALSE, message=FALSE)

## ----load_package-------------------------------------------------------------
library(scoreInvHap)

## ----eval=FALSE---------------------------------------------------------------
# library(snpStats)
# 
# ## From a bed
# snps <- read.plink("example.bed")
# 
# ## From a pedfile
# snps <- read.pedfile("example.ped", snps = "example.map")

## ----Load SNPs, message=FALSE-------------------------------------------------
library(VariantAnnotation)
vcf_file <- system.file("extdata", "example.vcf", package = "scoreInvHap")
vcf <- readVcf(vcf_file, "hg19")
vcf

## -----------------------------------------------------------------------------
check <- checkSNPs(vcf)
check
vcf <- check$genos

## ----classify-----------------------------------------------------------------
res <- scoreInvHap(SNPlist = vcf, inv = "inv7_005")
res

## ----classify_par, eval=FALSE-------------------------------------------------
# res <- scoreInvHap(SNPlist = vcf, inv = "inv7_005",
#                    BPPARAM = BiocParallel::MulticoreParam(8))

## ----scoreInvHap results------------------------------------------------------
# Get classification
head(classification(res))
# Get scores
head(scores(res))

## ----scoreInvHap scores-------------------------------------------------------
# Get max score
head(maxscores(res))
# Get difference score
head(diffscores(res))

## -----------------------------------------------------------------------------
plotScores(res, pch = 16, main = "QC based on scores")

## -----------------------------------------------------------------------------
# Get Number of scores used
head(numSNPs(res))
# Get call rate
head(propSNPs(res))

## -----------------------------------------------------------------------------
plotCallRate(res, main = "Call Rate QC")

## -----------------------------------------------------------------------------
## No filtering
length(classification(res))
## QC filtering
length(classification(res, minDiff = 0.1, callRate = 0.9))

## -----------------------------------------------------------------------------
## Inversion classification
table(classification(res))
## Haplotype classification
table(classification(res, inversion = FALSE))

## ----classify imputed---------------------------------------------------------
res_imp <- scoreInvHap(SNPlist = vcf, inv = "inv7_005", probs = TRUE)
res_imp

## ----compare classifications--------------------------------------------------
table(PostProbs = classification(res_imp), 
      BestGuess = classification(res))

## -----------------------------------------------------------------------------
data(inversionGR)
inversionGR

## -----------------------------------------------------------------------------
sessionInfo()

