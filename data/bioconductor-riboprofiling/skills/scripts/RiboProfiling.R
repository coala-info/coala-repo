# Code example from 'RiboProfiling' vignette. See references/ for full tutorial.

## ----knitr, echo=FALSE, results="hide"----------------------------------------
library("knitr")
opts_chunk$set(tidy=FALSE,dev="png",fig.show="hide",
               fig.width=4,fig.height=4.5,
               message=FALSE)

## ----<style-knitr, eval=TRUE, echo=FALSE, results="asis"-------------------
BiocStyle::latex()

## ----options,echo=FALSE-------------------------------------------------------
options(digits=3, width=80, prompt=" ", continue=" ")

## ----Import_library_noEcho,echo=TRUE,eval=FALSE-------------------------------
# library(RiboProfiling)
# listInputBam <- c(
#     BamFile("http://genomique.info/data/public/RiboProfiling/ctrl.bam"),
#     BamFile("http://genomique.info/data/public/RiboProfiling/nutlin2h.bam")
#     )
# covData <- riboSeqFromBAM(listInputBam, genomeName="hg19")

## ----Import_library,echo=FALSE------------------------------------------------
suppressWarnings(suppressMessages(library(RiboProfiling)))

## ----riboSeqfromBam,echo=FALSE,eval=TRUE,dev=c("png"),fig.width=7-------------

myFileCtrl <- system.file("extdata", "ctrl_sample.bam", package="RiboProfiling")
myFileNutlin2h <- system.file("extdata", "nutlin2h_sample.bam", package="RiboProfiling")
listeInputBam <- c(myFileCtrl, myFileNutlin2h)

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene
covData <-
    suppressMessages(
        suppressWarnings(
            riboSeqFromBAM(
                listeInputBam,
                txdb=txdb,
                listShiftValue=c(-14, -14)
            )
        )
    )

## ----GAlignments_from_BAM,echo=TRUE,eval=FALSE--------------------------------
# aln <- readGAlignments(
#         BamFile("http://genomique.info/data/public/RiboProfiling/ctrl.bam")
#     )

## ----Hist_quick,echo=TRUE,eval=TRUE,dev=c('png')------------------------------
data(ctrlGAlignments)
aln <- ctrlGAlignments
matchLenDistr <- histMatchLength(aln, 0)
matchLenDistr[[2]]

## ----CovAroundTSS_quick,eval=FALSE,echo=TRUE,split=TRUE-----------------------
# #transform the GAlignments object into a GRanges object
# #(faster processing of the object)
# alnGRanges <- readsToStartOrEnd(aln, what="start")
# #txdb object with annotations
# txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
# oneBinRanges <- aroundPromoter(txdb, alnGRanges, percBestExpressed=0.001)
# #the coverage in the TSS flanking region for the reads with match sizes 29:31
# listPromoterCov <-
#     readStartCov(
#         alnGRanges,
#         oneBinRanges,
#         matchSize=c(29:31),
#         fixedInterval=c(-20, 20),
#         renameChr="aroundTSS",
#         charPerc="perc"
#     )
# plotSummarizedCov(listPromoterCov)

## ----TSS_Cov,echo=FALSE,eval=TRUE,fig.height=10,dev=c('png')------------------
#transform the GAlignments object into a GRanges object
#(faster processing of the object)
alnGRanges <- readsToStartOrEnd(aln, what="start")
#make a txdb object containing the annotations for the specified species.
#In this case hg19.
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene
#Please make sure that seqnames of txdb correspond to the seqnames
#of the alignment files ("chr" particle)
#if not rename the txdb seqlevels
#seqlevels(txdb) <- sub("chr", "", seqlevels(txdb))
#get the flanking region around the promoter of the 0.1% best expressed CDSs
oneBinRanges <- aroundPromoter(txdb, alnGRanges, percBestExpressed=0.001)
#the coverage in the TSS flanking region for the summarized read match sizes
#the coverage in the TSS flanking region for the reads with match sizes 29:31
listPromoterCov <-
    suppressWarnings(
        readStartCov(
            alnGRanges,
            oneBinRanges,
            matchSize=c(29:32),
            fixedInterval=c(-20, 20),
            renameChr="aroundTSS",
            charPerc="perc"
        )
    )
suppressMessages(plotSummarizedCov(listPromoterCov))


## ----CountReads_echo,echo=TRUE,eval=FALSE-------------------------------------
# #keep only the match read sizes 30-33
# alnGRanges <- alnGRanges[which(!is.na(match(alnGRanges$score,30:33)))]
# #get all CDSs by transcript
# cds <- cdsBy(txdb, by="tx", use.names=TRUE)
# #get all exons by transcript
# exonGRanges <- exonsBy(txdb, by="tx", use.names=TRUE)
# #get the per transcript relative position of start and end codons
# cdsPosTransc <- orfRelativePos(cds, exonGRanges)
# #compute the counts on the different features
# #after applying the specified shift value on the read start along the transcript
# countsDataCtrl1 <-
#     countShiftReads(
#         exonGRanges=exonGRanges[names(cdsPosTransc)],
#         cdsPosTransc=cdsPosTransc,
#         alnGRanges=alnGRanges,
#         shiftValue=-14
#     )
# head(countsDataCtrl1[[1]])
# listCountsPlots <- countsPlot(
#     list(countsDataCtrl1[[1]]),
#     grep("_counts$", colnames(countsDataCtrl1[[1]])),
#     1
# )
# listCountsPlots

## ----CountReads,echo=FALSE,eval=TRUE,fig.width=7,dev=c('png')-----------------
#get all CDSs by transcript
cds <- GenomicFeatures::cdsBy(txdb, by="tx", use.names=TRUE)
#get all exons by transcript
exonGRanges <- GenomicFeatures::exonsBy(txdb, by="tx", use.names=TRUE)
#get the per transcript relative position of start and end codons
#cdsPosTransc <- orfRelativePos(cds, exonGRanges)
data("cdsPosTransc")
#compute the counts on the different features after applying
#the specified shift value on the read start along the transcript
countsDataCtrl1 <-
    countShiftReads(
        exonGRanges[names(cdsPosTransc)],
        cdsPosTransc,
        alnGRanges,
        -14
    )
listCountsPlots <- countsPlot(
    list(countsDataCtrl1[[1]]),
    grep("_counts$", colnames(countsDataCtrl1[[1]])),
    1
)
invisible(capture.output(
    suppressWarnings(
        suppressMessages(
            print(listCountsPlots))
        )
    )
)
head(countsDataCtrl1[[1]], n=3)

## ----codon_cov_position,echo=TRUE,eval=TRUE-----------------------------------
data(codonIndexCovCtrl)
head(codonIndexCovCtrl[[1]], n=3)

## ----CodonAnalysis_echo,echo=TRUE,eval=FALSE----------------------------------
# listReadsCodon <- countsDataCtrl1[[2]]
# #get the names of the expressed ORFs grouped by transcript
# cds <- cdsBy(txdb, use.names=TRUE)
# orfCoord <- cds[names(cds) %in% names(listReadsCodon)]
# #chromosome names should correspond between the BAM,
# #the annotations, and the genome
# genomeSeq <- BSgenome.Hsapiens.UCSC.hg19
# #codon frequency, coverage, and annotation
# codonData <- codonInfo(listReadsCodon, genomeSeq, orfCoord)

## ----CodonAnalysis,echo=FALSE,eval=TRUE---------------------------------------
listReadsCodon <- countsDataCtrl1[[2]]
#get the names of the ORFs for which we have coverage
#grouped by transcript
cds <- GenomicFeatures::cdsBy(txdb, use.names=TRUE)
orfCoord <- cds[names(cds) %in% names(listReadsCodon)]
genomeSeq <- BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19
#codon frequency, coverage, and annotation
codonData <- codonInfo(listReadsCodon, genomeSeq, orfCoord)

## ----CountReads_res,results=TRUE,echo=TRUE,split=FALSE------------------------
data("codonDataCtrl")
head(codonDataCtrl[[1]], n=3)

## ----CodonPCA,echo=TRUE,eval=TRUE,dev=c("png")--------------------------------
codonUsage <- codonData[[1]]
codonCovMatrix <- codonData[[2]]
#keep only genes with a minimum number of reads
nbrReadsGene <- apply(codonCovMatrix, 1, sum)
ixExpGenes <- which(nbrReadsGene >= 50)
codonCovMatrix <- codonCovMatrix[ixExpGenes, ]
#get the PCA on the codon coverage
codonCovMatrixTransp <- t(codonCovMatrix)
rownames(codonCovMatrixTransp) <- colnames(codonCovMatrix)
colnames(codonCovMatrixTransp) <- rownames(codonCovMatrix)
listPCACodonCoverage <- codonPCA(codonCovMatrixTransp, "codonCoverage")
listPCACodonCoverage[[2]]

## ----sessInfo,echo=TRUE,eval=TRUE---------------------------------------------
sessionInfo()

