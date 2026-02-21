# Code example from 'NanoporeRNASeq' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE, tidy = TRUE,
    warning=FALSE, message=FALSE,
    comment = "##>"
)

## ----setup--------------------------------------------------------------------
library("NanoporeRNASeq")

## ----samples------------------------------------------------------------------
data("SGNexSamples")
SGNexSamples

## ----bamfiles-----------------------------------------------------------------
library(ExperimentHub)
NanoporeData <- query(ExperimentHub(), c("NanoporeRNA", "GRCh38","Bam"))
bamFiles <- Rsamtools::BamFileList(NanoporeData[["EH3808"]],
    NanoporeData[["EH3809"]],NanoporeData[["EH3810"]], NanoporeData[["EH3811"]],
    NanoporeData[["EH3812"]], NanoporeData[["EH3813"]])

## ----annotation---------------------------------------------------------------
data("HsChr22BambuAnnotation")
HsChr22BambuAnnotation

## ----fig.width = 8, fig.height = 6--------------------------------------------
library(ggbio)
range <- HsChr22BambuAnnotation$ENST00000215832
# plot mismatch track
library(BSgenome.Hsapiens.NCBI.GRCh38)
# plot annotation track
tx <- autoplot(range, aes(col = strand), group.selfish = TRUE)
# plot coverage track
coverage <- autoplot(bamFiles[[1]], aes(col = coverage),which = range)

#merge the tracks into one plot
tracks(annotation = tx, coverage = coverage,
        heights = c(1, 3)) + theme_minimal()

## ----load bambu---------------------------------------------------------------
library(bambu)
genomeSequenceData <- query(ExperimentHub(), c("NanoporeRNA", "GRCh38","FASTA"))
genomeSequence <- genomeSequenceData[["EH7260"]]

## ----results = "hide"---------------------------------------------------------
se <- bambu(reads = bamFiles,
            annotations = HsChr22BambuAnnotation,
            genome = genomeSequence)

## -----------------------------------------------------------------------------
se

## ----fig.width = 8, fig.height = 10-------------------------------------------
plotBambu(se, type = "annotation", gene_id = "ENSG00000099968")

## -----------------------------------------------------------------------------
sessionInfo()

