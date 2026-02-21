# Code example from 'bambu' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,tidy = TRUE,
    warning=FALSE, message=FALSE,
    comment = "##>"
)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("bambu")
# BiocManager::install("NanoporeRNASeq")

## ----results = "hide"---------------------------------------------------------
library(bambu)
test.bam <- system.file("extdata",
    "SGNex_A549_directRNA_replicate5_run1_chr9_1_1000000.bam",
    package = "bambu")
fa.file <- system.file("extdata",
    "Homo_sapiens.GRCh38.dna_sm.primary_assembly_chr9_1_1000000.fa",
    package = "bambu")
gtf.file <- system.file("extdata", "Homo_sapiens.GRCh38.91_chr9_1_1000000.gtf",
    package = "bambu")
bambuAnnotations <- prepareAnnotations(gtf.file)
se <- bambu(reads = test.bam, annotations = bambuAnnotations,
    genome = fa.file)

## -----------------------------------------------------------------------------
library(bambu)
library(NanoporeRNASeq)
data("SGNexSamples")
SGNexSamples
library(ExperimentHub)
NanoporeData <- query(ExperimentHub(), c("NanoporeRNA", "GRCh38","BAM"))
bamFile <- Rsamtools::BamFileList(NanoporeData[["EH3808"]])

## -----------------------------------------------------------------------------
# get path to fasta file
genomeSequenceData <- query(ExperimentHub(), c("NanoporeRNA", "GRCh38","FASTA"))
genomeSequence <- genomeSequenceData[["EH7260"]]

## -----------------------------------------------------------------------------
library(BSgenome.Hsapiens.NCBI.GRCh38)
genomeSequenceBsgenome <- BSgenome.Hsapiens.NCBI.GRCh38

## -----------------------------------------------------------------------------
gtf.file <- system.file("extdata", "Homo_sapiens.GRCh38.91_chr9_1_1000000.gtf",
    package = "bambu")
annotation <- prepareAnnotations(gtf.file)

## -----------------------------------------------------------------------------
txdb_file <- system.file("extdata", "Homo_sapiens.GRCh38.91.annotations-txdb_chr9_1_1000000.sqlite",
    package = "bambu")
txdb <- AnnotationDbi::loadDb(txdb_file)
annotation <- prepareAnnotations(txdb)

## -----------------------------------------------------------------------------
data("HsChr22BambuAnnotation")
HsChr22BambuAnnotation

## ----results = "hide"---------------------------------------------------------
se <- bambu(reads = bamFile, annotations = HsChr22BambuAnnotation,
    genome = genomeSequence, ncore = 1)

## -----------------------------------------------------------------------------
se

## ----results = "hide"---------------------------------------------------------
seNoquant <- bambu(reads = bamFile,
    annotations = HsChr22BambuAnnotation,
    genome = genomeSequence, quant = FALSE)

## ----results = "hide"---------------------------------------------------------
seUnextended <- bambu(reads = bamFile,
    annotations = HsChr22BambuAnnotation,
    genome = genomeSequence, discovery = FALSE)

## -----------------------------------------------------------------------------
seUnextended

## ----results = "hide"---------------------------------------------------------
bamFiles <- Rsamtools::BamFileList(NanoporeData[["EH3808"]],
    NanoporeData[["EH3809"]],NanoporeData[["EH3810"]], NanoporeData[["EH3811"]],
    NanoporeData[["EH3812"]], NanoporeData[["EH3813"]])
se.multiSample <- bambu(reads = bamFiles,  annotations = HsChr22BambuAnnotation,
    genome = genomeSequence)

## ----results = "hide"---------------------------------------------------------
se.NDR_0.3 <- bambu(reads = bamFiles, annotations = HsChr22BambuAnnotation,
    genome = genomeSequence, NDR = 0.3)

## ----results = 'hide'---------------------------------------------------------
newAnnotations <- bambu(reads = bamFiles, annotations = HsChr22BambuAnnotation,
    genome = genomeSequence, NDR = 1, quant = FALSE)
annotations.filtered <- newAnnotations[(!is.na(mcols(newAnnotations)$NDR) & mcols(newAnnotations)$NDR<0.1) | is.na(mcols(newAnnotations)$NDR)]
se.NDR_1 <- bambu(reads = bamFiles, annotations = annotations.filtered, genome = genomeSequence, NDR = 1, discovery = FALSE)

## ----fig.width = 8, fig.height = 6--------------------------------------------
library(ggplot2)
plotBambu(se.multiSample, type = "heatmap")

## ----fig.width = 8, fig.height = 6--------------------------------------------
plotBambu(se.multiSample, type = "pca")

## ----fig.width = 8, fig.height = 10-------------------------------------------
plotBambu(se.multiSample, type = "annotation", gene_id = "ENSG00000099968")

## -----------------------------------------------------------------------------
colData(se.multiSample)$condition <- as.factor(SGNexSamples$cellLine)

## -----------------------------------------------------------------------------
seGene.multiSample <- transcriptToGeneExpression(se.multiSample)
seGene.multiSample

## ----fig.width = 8, fig.height = 6--------------------------------------------
colData(seGene.multiSample)$groupVar <- SGNexSamples$cellLine
plotBambu(seGene.multiSample, type = "heatmap")

## -----------------------------------------------------------------------------
save.dir <- tempdir()
writeBambuOutput(se.multiSample, path = save.dir, prefix = "NanoporeRNASeq_")

## -----------------------------------------------------------------------------
save.file <- tempfile(fileext = ".gtf")
writeToGTF(rowRanges(se.multiSample), file = save.file)

## ----results = 'hide'---------------------------------------------------------
se <- bambu(reads = bamFiles, annotations = HsChr22BambuAnnotation,
    genome = genomeSequence, opt.discovery = list(fitReadClassModel = FALSE))

## ----results = 'hide'---------------------------------------------------------
novelAnnotations <- bambu(reads = bamFiles, annotations = NULL, genome = genomeSequence, NDR = 1, quant = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# #se <- bambu(rcFile = rcFiles, annotations = annotations, genome = fa.file)

## ----results = 'hide'---------------------------------------------------------
se <- bambu(reads = bamFiles, rcOutDir = save.dir, annotations = HsChr22BambuAnnotation, genome = genomeSequence)

## -----------------------------------------------------------------------------
library(BiocFileCache)
bfc <- BiocFileCache(save.dir, ask = FALSE)
info <- bfcinfo(bfc)

## -----------------------------------------------------------------------------
info
# running bambu using the first file
se <- bambu(reads = info$rpath[1:3], annotations = HsChr22BambuAnnotation, genome = genomeSequence)

## -----------------------------------------------------------------------------
se <- bambu(reads = bamFiles, annotations = HsChr22BambuAnnotation, genome = genomeSequence, discovery = FALSE, quant = FALSE)

## -----------------------------------------------------------------------------
rowData(se[[1]])

## -----------------------------------------------------------------------------
se <- bambu(reads = bamFiles, annotations = HsChr22BambuAnnotation, genome = genomeSequence, trackReads = TRUE)
metadata(se)$readToTranscriptMaps[[1]]

## ----eval = FALSE-------------------------------------------------------------
#    # first train the model using a related annotated dataset from .bam
# 
# se = bambu(reads = sample1.bam, annotations = annotations, genome = fa.file, discovery = FALSE, quant = FALSE, opt.discovery = list(returnModel = TRUE)) # note that discovery and quant need to be set to FALSE, alternatively you can have them set to TRUE and retrieve the model from the rcFile as long as returnModel = TRUE.
# # newDefaultModel = metadata(se[[1]])$model # [[1]] will select the model trained on the first sample
# 
#   #alternatively train the model using an rcFile
# rcFile <- readRDS(pathToRcFile)
# newDefaultModel = trainBambu(rcFile)
# 
# # use the trained model on another sample
# # sample2.bam and fa.file2 represent the aligned reads and genome for the poorly annotated sample
# se <- bambu(reads = sample2.bam, annotations = NULL, genome = fa.file2, opt.discovery = list(defaultModels = newDefaultModel, fitReadClassModel = FALSE))
# 
# #trainBambu Arguments
# 
# rcFile <- NULL, min.readCount = 2, nrounds = 50, NDR.threshold = 0.1, verbose = TRUE

## -----------------------------------------------------------------------------
se <- bambu(reads = bamFiles, annotations = HsChr22BambuAnnotation, genome = genomeSequence, opt.discovery = list(min.txScore.singleExon = 0))

## -----------------------------------------------------------------------------
library(DESeq2)
dds <- DESeqDataSetFromMatrix(round(assays(seGene.multiSample)$counts),
                                    colData = colData(se.multiSample),
                                    design = ~ condition)
dds.deseq <- DESeq(dds)
deGeneRes <- DESeq2::results(dds.deseq, independentFiltering = FALSE)
head(deGeneRes[order(deGeneRes$padj),])

## -----------------------------------------------------------------------------
summary(deGeneRes)

## ----fig.width = 8, fig.height = 6--------------------------------------------
library(apeglm)
resLFC <- lfcShrink(dds.deseq, coef = "condition_MCF7_vs_K562", type = "apeglm")
plotMA(resLFC, ylim = c(-3,3))

## -----------------------------------------------------------------------------
library(DEXSeq)
dxd <- DEXSeqDataSet(countData = round(assays(se.multiSample)$counts), 
sampleData = as.data.frame(colData(se.multiSample)), 
design = ~sample + exon + condition:exon,
featureID = rowData(se.multiSample)$TXNAME, 
groupID = rowData(se.multiSample)$GENEID)
dxr <- DEXSeq(dxd)
head(dxr)

## ----fig.width = 8, fig.height = 6--------------------------------------------
plotMA(dxr, cex = 0.8 )

## -----------------------------------------------------------------------------
sessionInfo()

