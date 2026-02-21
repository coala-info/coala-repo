# Code example from 'cliProfilerIntroduction' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## ----BiocManager, eval=FALSE--------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("cliProfiler")

## ----initialize, results="hide", warning=FALSE, message=FALSE-----------------
library(cliProfiler)

## -----------------------------------------------------------------------------
testpath <- system.file("extdata", package = "cliProfiler")
## loading the test GRanges object
test <- readRDS(file.path(testpath, "test.rds"))
## Show an example of GRanges object
test

## -----------------------------------------------------------------------------
## the path for the test gff3 file
test_gff3 <- file.path(testpath, "annotation_test.gff3")
## the gff3 file can be loaded by import.gff3 function in rtracklayer package
shown_gff3 <- rtracklayer::import.gff3(test_gff3)
## show the test gff3 file
shown_gff3

## -----------------------------------------------------------------------------
meta <- metaGeneProfile(object = test, annotation = test_gff3)
meta[[1]]

## -----------------------------------------------------------------------------
library(ggplot2)
## For example if user want to have a new name for the plot
meta[[2]] + ggtitle("Meta Profile 2")

## -----------------------------------------------------------------------------
meta <- metaGeneProfile(object = test, annotation = test_gff3, 
                        include_intron = TRUE)
meta[[2]]

## -----------------------------------------------------------------------------
test$Treat <- c(rep("Treatment 1",50), rep("Treatment 2", 50))
meta <- metaGeneProfile(object = test, annotation = test_gff3, 
                        group = "Treat")
meta[[2]]

## ----eval=FALSE---------------------------------------------------------------
# metaGeneProfile(object = test, annotation = test_gff3, exlevel = 3,
#                 extranscript_support_level = c(4,5,6))

## -----------------------------------------------------------------------------
meta <- metaGeneProfile(object = test, annotation = test_gff3, split = TRUE)
meta[[2]]

## -----------------------------------------------------------------------------
intron <-  intronProfile(test, test_gff3)

## -----------------------------------------------------------------------------
intron[[1]]

## -----------------------------------------------------------------------------
intron[[2]]

## -----------------------------------------------------------------------------
intron <-  intronProfile(test, test_gff3, group = "Treat")
intron[[2]]

## -----------------------------------------------------------------------------
intronProfile(test, test_gff3, group = "Treat", exlevel = 3, 
    extranscript_support_level = c(4,5,6))

## -----------------------------------------------------------------------------
intronProfile(test, test_gff3, group = "Treat", maxLength = 10000,
    minLength = 50)

## -----------------------------------------------------------------------------
## Quick use
exon <- exonProfile(test, test_gff3)
exon[[1]]

## -----------------------------------------------------------------------------
exon[[2]]

## ----results='hide', warning=FALSE, message=FALSE-----------------------------
library(rtracklayer)
## Extract all the exon annotation
test_anno <- rtracklayer::import.gff3(test_gff3)
test_anno <- test_anno[test_anno$type == "exon"]
## Run the windowProfile
window_profile <- windowProfile(test, test_anno)

## -----------------------------------------------------------------------------
window_profile[[1]]

## -----------------------------------------------------------------------------
window_profile[[2]]

## -----------------------------------------------------------------------------
## Example for running the motifProfile
## The working species is mouse with mm10 annotation.
## Therefore the package 'BSgenome.Mmusculus.UCSC.mm10' need to be installed in 
## advance.
motif <- motifProfile(test, motif = "DRACH",
    genome = "BSgenome.Mmusculus.UCSC.mm10",
    fraction = TRUE, title = "Motif Profile",
    flanking = 10)

## -----------------------------------------------------------------------------
motif[[1]]

## -----------------------------------------------------------------------------
motif[[2]]

## -----------------------------------------------------------------------------
## Quick use of geneTypeProfile
geneTP <- geneTypeProfile(test, test_gff3)

## -----------------------------------------------------------------------------
geneTP[[1]]

## -----------------------------------------------------------------------------
geneTP[[2]]

## -----------------------------------------------------------------------------
SSprofile <- spliceSiteProfile(test, test_gff3, flanking=200, bin=40)

## -----------------------------------------------------------------------------
SSprofile[[1]]

## -----------------------------------------------------------------------------
SSprofile[[2]]

## ----eval=FALSE---------------------------------------------------------------
# spliceSiteProfile(test, test_gff3, flanking=200, bin=40, exlevel=3,
#                         extranscript_support_level = 6,
#                         title = "Splice Site Profile")

## -----------------------------------------------------------------------------
sessionInfo()

