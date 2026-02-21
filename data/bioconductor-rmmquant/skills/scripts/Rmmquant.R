# Code example from 'Rmmquant' vignette. See references/ for full tutorial.

## ----setup_knitr, include = FALSE, cache = FALSE------------------------------
library("Rmmquant")
library("BiocStyle")
library("S4Vectors")
library("SummarizedExperiment")
library("knitr")
library("rmarkdown")
library("TBX20BamSubset")
library("TxDb.Mmusculus.UCSC.mm9.knownGene")
library("org.Mm.eg.db")
library("DESeq2")
opts_chunk$set(message = FALSE, error = FALSE, warning = FALSE,
               cache = FALSE, fig.width = 5, fig.height = 5)

## ----first--------------------------------------------------------------------
dir <- system.file("extdata", package="Rmmquant", mustWork = TRUE)
gtfFile <- file.path(dir, "test.gtf")
bamFile <- file.path(dir, "test.bam")
output <- RmmquantRun(gtfFile, bamFile)

## ----matrix-------------------------------------------------------------------
assays(output)$counts

## ----counts-------------------------------------------------------------------
assays(output)$counts

## ----stats--------------------------------------------------------------------
colData(output)

## ----bamfiles-----------------------------------------------------------------
bamFiles    <- getBamFileList()
sampleNames <- names(bamFiles)

## ----annotation---------------------------------------------------------------
gr <- genes(TxDb.Mmusculus.UCSC.mm9.knownGene, filter=list(tx_chrom="chr19"))

## ----ensembl------------------------------------------------------------------
ensemblIds <- sapply(as.list(org.Mm.egENSEMBL[mappedkeys(org.Mm.egENSEMBL)])
                     [mcols(gr)$gene_id], `[[`, 1)
gr         <- gr[! is.na(names(ensemblIds)), ]
names(gr)  <- unlist(ensemblIds)

## ----deseq2-------------------------------------------------------------------
output   <- RmmquantRun(genomicRanges=gr, readsFiles=bamFiles,
                        sampleNames=sampleNames, sorts=FALSE)
coldata <- data.frame(condition=factor(c(rep("control", 3), rep("KO", 3)),
                                       levels=c("control", "KO")),
                      row.names=sampleNames)
dds      <- DESeqDataSetFromMatrix(countData=assays(output)$counts,
                                   colData  =coldata,
                                   design   =~ condition)
dds      <- DESeq(dds)
res      <- lfcShrink(dds, coef=2)
res$padj <- ifelse(is.na(res$padj), 1, res$padj)
res[res$padj < 0.05, ]

## ----session_info-------------------------------------------------------------
devtools::session_info()

