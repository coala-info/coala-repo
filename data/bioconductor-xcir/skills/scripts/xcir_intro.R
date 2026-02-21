# Code example from 'xcir_intro' vignette. See references/ for full tutorial.

## ----setup, include=FALSE------------------------------------------------
library(knitr)
opts_chunk$set(echo = TRUE, fig.width = 7, fig.align = "center",
               message = FALSE, warning = FALSE)

## ------------------------------------------------------------------------
library(XCIR)
library(data.table)

## ------------------------------------------------------------------------
vcff <- system.file("extdata/AD_example.vcf", package = "XCIR")
vcf <- readVCF4(vcff)
head(vcf)

## ---- annoX--------------------------------------------------------------
annoX <- annotateX(vcf)
head(annoX)

## ----annoX-genotyped-----------------------------------------------------
annoXgeno <- annotateX(vcf, het_cutoff = 0)

## ----genic-phased--------------------------------------------------------
genic <- getGenicDP(annoX, highest_expr = TRUE)
head(genic)

## ----genic-unphased------------------------------------------------------
genic <- getGenicDP(annoX, highest_expr = FALSE)

## ------------------------------------------------------------------------
data <- fread(system.file("extdata/data34_vignette.tsv", package = "XCIR"))
xcig <- readLines(system.file("extdata/xcig_vignette.txt", package = "XCIR"))

## ------------------------------------------------------------------------
head(data)

## ---- betabin-bb---------------------------------------------------------
bb <- betaBinomXI(data, xciGenes = xcig, model = "BB")

## ------------------------------------------------------------------------
plotQC(bb[sample == "sample36"], xcig = xcig)
s36 <- data[sample == "sample36"]

## ----betabin-s36---------------------------------------------------------
s36fit <- betaBinomXI(s36, model = "AUTO", xciGenes = xcig, plot = TRUE)

## ----betabin-auto--------------------------------------------------------
auto <- betaBinomXI(data, xciGenes = xcig, model = "AUTO")

## ------------------------------------------------------------------------
auto[, status := ifelse(p_value < 0.05, "E", "S")]
auto[, .N, by = "status"]

## ----sampleclean---------------------------------------------------------
sc <- sample_clean(auto)
head(sc)

## ----getXCIstate---------------------------------------------------------
xcis <- getXCIstate(auto)
head(xcis)

## ----sessinfo------------------------------------------------------------
sessionInfo()

