# Code example from 'fithic' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# library("FitHiC")
# fragsfile <- system.file("extdata", "fragmentLists/Duan_yeast_EcoRI.gz",
#     package = "FitHiC")
# intersfile <- system.file("extdata", "contactCounts/Duan_yeast_EcoRI.gz",
#     package = "FitHiC")
# outdir <- file.path(getwd(), "Duan_yeast_EcoRI")
# FitHiC(fragsfile, intersfile, outdir, libname="Duan_yeast_EcoRI",
#     distUpThres=250000, distLowThres=10000)

## ----run, echo=FALSE, collapse=TRUE, warning=FALSE----------------------------
library("FitHiC")
fragsfile <- system.file("extdata", "fragmentLists/Duan_yeast_EcoRI.gz",
    package = "FitHiC")
intersfile <- system.file("extdata", "contactCounts/Duan_yeast_EcoRI.gz",
    package = "FitHiC")
outdir <- file.path(getwd(), "Duan_yeast_EcoRI")
FitHiC(fragsfile, intersfile, outdir, libname="Duan_yeast_EcoRI",
    distUpThres=250000, distLowThres=10000)

## ----run-visual, echo=FALSE, message=FALSE, warning=FALSE, results="hide"-----
library("FitHiC")
fragsfile <- system.file("extdata", "fragmentLists/Duan_yeast_EcoRI.gz",
    package = "FitHiC")
intersfile <- system.file("extdata", "contactCounts/Duan_yeast_EcoRI.gz",
    package = "FitHiC")
outdir <- file.path(getwd(), "Duan_yeast_EcoRI")
FitHiC(fragsfile, intersfile, outdir, libname="Duan_yeast_EcoRI",
    distUpThres=250000, distLowThres=10000, visual=TRUE)

## ----calculate-probabilities, echo=FALSE, results="asis"----------------------
output <- file.path(getwd(), "Duan_yeast_EcoRI",
    "Duan_yeast_EcoRI.fithic_pass1.txt")
data <- read.table(output, header=TRUE)
knitr::kable(head(data, n=6L), caption="Duan_yeast_EcoRI.fithic_pass1.txt")

output <- file.path(getwd(), "Duan_yeast_EcoRI",
    "Duan_yeast_EcoRI.fithic_pass2.txt")
data <- read.table(output, header=TRUE)
knitr::kable(head(data, n=6L), caption="Duan_yeast_EcoRI.fithic_pass2.txt")

## ----fit-spline, echo=FALSE, results="asis"-----------------------------------
output <- file.path(getwd(), "Duan_yeast_EcoRI",
    "Duan_yeast_EcoRI.spline_pass1.significances.txt.gz")
data <- read.table(gzfile(output), header=TRUE)
knitr::kable(head(data, n=6L), align="crcrrrr",
    caption="Duan_yeast_EcoRI.spline_pass1.significances.txt.gz")

output <- file.path(getwd(), "Duan_yeast_EcoRI",
    "Duan_yeast_EcoRI.spline_pass2.significances.txt.gz")
data <- read.table(gzfile(output), header=TRUE)
knitr::kable(head(data, n=6L), align="crcrrrr",
    caption="Duan_yeast_EcoRI.spline_pass2.significances.txt.gz")

## ----echo=FALSE, message=FALSE, warning=FALSE, results="hide"-----------------
fragsfile <- system.file("extdata", "fragmentLists/Duan_yeast_HindIII.gz",
    package = "FitHiC")
intersfile <- system.file("extdata", "contactCounts/Duan_yeast_HindIII.gz",
    package = "FitHiC")
outdir <- file.path(getwd(), "Duan_yeast_HindIII")
FitHiC(fragsfile, intersfile, outdir, libname="Duan_yeast_HindIII",
    distUpThres=250000, distLowThres=10000)

## ----message=FALSE, warning=FALSE, results="hide"-----------------------------
library("FitHiC")
fragsfile <- system.file("extdata",
    "fragmentLists/Dixon_hESC_HindIII_hg18_w40000_chr1.gz",
    package = "FitHiC")
intersfile <- system.file("extdata",
    "contactCounts/Dixon_hESC_HindIII_hg18_w40000_chr1.gz",
    package = "FitHiC")
outdir <- file.path(getwd(), "Dixon_hESC_HindIII_hg18_w40000_chr1")
FitHiC(fragsfile, intersfile, outdir,
    libname="Dixon_hESC_HindIII_hg18_w40000_chr1", noOfBins=50,
    distUpThres=5000000, distLowThres=50000, visual=TRUE)

## ----message=FALSE, warning=FALSE, results="hide"-----------------------------
library("FitHiC")
fragsfile <- system.file("extdata",
    "fragmentLists/Dixon_hESC_HindIII_hg18_combineFrags10_chr1.gz",
    package = "FitHiC")
intersfile <- system.file("extdata",
    "contactCounts/Dixon_hESC_HindIII_hg18_combineFrags10_chr1.gz",
    package = "FitHiC")
outdir <- file.path(getwd(), "Dixon_hESC_HindIII_hg18_combineFrags10_chr1")
FitHiC(fragsfile, intersfile, outdir,
    libname="Dixon_hESC_HindIII_hg18_combineFrags10_chr1", noOfBins=200,
    distUpThres=5000000, distLowThres=50000, visual=TRUE)

## ----message=FALSE, warning=FALSE, results="hide"-----------------------------
library("FitHiC")
fragsfile <- system.file("extdata",
    "fragmentLists/Dixon_mESC_HindIII_mm9_combineFrags10_chr1.gz",
    package = "FitHiC")
intersfile <- system.file("extdata",
    "contactCounts/Dixon_mESC_HindIII_mm9_combineFrags10_chr1.gz",
    package = "FitHiC")
outdir <- file.path(getwd(), "Dixon_mESC_HindIII_mm9_combineFrags10_chr1")
FitHiC(fragsfile, intersfile, outdir,
    libname="Dixon_mESC_HindIII_mm9_combineFrags10_chr1", noOfBins=200,
    distUpThres=5000000, distLowThres=50000, visual=TRUE)

## ----message=FALSE, warning=FALSE, results="hide"-----------------------------
library("FitHiC")
fragsfile <- system.file("extdata",
    "fragmentLists/Dixon_hESC_HindIII_hg18_w40000_chr1.gz",
    package = "FitHiC")
intersfile <- system.file("extdata",
    "contactCounts/Dixon_hESC_HindIII_hg18_w40000_chr1.gz",
    package = "FitHiC")
outdir <- file.path(getwd(), "Dixon_hESC_HindIII_hg18_w40000_chr1.afterICE")
biasfile <- system.file("extdata",
    "biasPerLocus/Dixon_hESC_HindIII_hg18_w40000_chr1.gz",
    package = "FitHiC")
FitHiC(fragsfile, intersfile, outdir, biasfile,
    libname="Dixon_hESC_HindIII_hg18_w40000_chr1", noOfBins=50,
    distUpThres=5000000, distLowThres=50000, visual=TRUE)

## ----message=FALSE, warning=FALSE, results="hide"-----------------------------
library("FitHiC")
fragsfile <- system.file("extdata", "fragmentLists/data_5000000_abs.bed.gz",
    package = "FitHiC")
intersfile <- system.file("extdata", "contactCounts/data_5000000.matrix.gz",
    package = "FitHiC")
biasfile <- system.file("extdata",
    "biasPerLocus/data_5000000_iced.matrix.biases.gz", package = "FitHiC")
outdir <- file.path(getwd(), "data_5000000")
FitHiC(fragsfile, intersfile, outdir, biasfile, libname="data_5000000",
    distUpThres=500000000, distLowThres=5000000, visual=TRUE, useHiCPro=TRUE)

## ----fragsfile, echo = FALSE, results = "asis"--------------------------------
fragsfile <- system.file("extdata",
    "fragmentLists/Dixon_hESC_HindIII_hg18_w40000_chr1.gz", package = "FitHiC")
data <- read.table(gzfile(fragsfile), header=FALSE,
    col.names=c("Chromosome Name", "Column 2", "Mid Point", "Hit Count",
    "Column 5"))
knitr::kable(head(data, n=6L), align = "crrrr", caption="FRAGSFILE")

## ----intersfile, echo=FALSE, results="asis"-----------------------------------
intersfile <- system.file("extdata",
    "contactCounts/Dixon_hESC_HindIII_hg18_w40000_chr1.gz", package = "FitHiC")
data <- read.table(gzfile(intersfile), header=FALSE,
    col.names=c("Chromosome1 Name", "Mid Point 1", "Chromosome2 Name",
    "Mid Point 2", "Hit Count"))
knitr::kable(head(data, n=6L), align = "crcrr", caption="INTERSFILE")

## ----biasfile, echo=FALSE, results="asis"-------------------------------------
biasfile <- system.file("extdata",
    "biasPerLocus/Dixon_hESC_HindIII_hg18_w40000_chr1.gz", package = "FitHiC")
data <- read.table(gzfile(biasfile), header=FALSE,
    col.names=c("Chromosome Name", "Mid Point", "Bias"))
knitr::kable(head(data, n=6L), align = "crr", caption="BIASFILE")

