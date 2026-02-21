# Code example from 'miRmine' vignette. See references/ for full tutorial.

## --------------------------------------------------------------------------
#library(GenomicRanges)
#library(rtracklayer)
#library(SummarizedExperiment)
#library(Biostrings)
#library(Rsamtools)

ext.data <- system.file("extdata", package = "miRmine")
list.files(ext.data)

## --------------------------------------------------------------------------
library("miRmine")
data(miRmine)
miRmine

## --------------------------------------------------------------------------
adenocarcinoma = miRmine[ , miRmine$Disease %in% c("Adenocarcinoma")]
adenocarcinoma
as.character(adenocarcinoma$Sample.Accession)

## --------------------------------------------------------------------------
top.mirna = names(sort(rowSums(assays(adenocarcinoma)$counts))[1])
rowRanges(adenocarcinoma)$mirna_seq[[top.mirna]]

## --------------------------------------------------------------------------
library("DESeq2")

mirmine.subset = miRmine[, miRmine$Tissue %in% c("Lung", "Saliva")]
mirmine.subset = SummarizedExperiment(
    assays = SimpleList(counts=ceiling(assays(mirmine.subset)$counts)), 
    colData=colData(mirmine.subset), 
    rowRanges=rowRanges(mirmine.subset),
    rowData=NULL
)

ddsSE <- DESeqDataSet(mirmine.subset, design = ~ Tissue)
ddsSE <- ddsSE[ rowSums(counts(ddsSE)) > 1, ]

dds <- DESeq(ddsSE)
res <- results(dds)
res

## ----sessionInfo, echo=FALSE-----------------------------------------------
sessionInfo()

