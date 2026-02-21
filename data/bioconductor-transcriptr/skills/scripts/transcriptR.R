# Code example from 'transcriptR' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----global_options, include = FALSE------------------------------------------
knitr::opts_chunk$set(prompt = TRUE, collapse = TRUE, fig.align = "center")

## ----fig.cap="transcriptR workflow", fig.align='center', echo=FALSE-----------
knitr::include_graphics(path = "./images/Main_scheme.png")

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("transcriptR")

## ----eval = TRUE, echo = FALSE, message = FALSE-------------------------------
library(transcriptR)

## ----cache = FALSE, echo = TRUE, results = 'hide', message = FALSE------------
library(GenomicFeatures)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
# Use UCSC genes as the reference annotations
knownGene <- TxDb.Hsapiens.UCSC.hg19.knownGene
# Extract genes information
knownGene.genes <- genes(knownGene)

## ----cache = FALSE------------------------------------------------------------
# load TranscriptionDataSet object
data(tds)
# view TranscriptionDataSet object
tds

## ----eval = FALSE-------------------------------------------------------------
# # or initialize a new one (do not run the following code)
# # specify a region of interest (optional)
# region <- GRanges(seqnames = "chr15", ranges = IRanges(start = 63260000, end = 63300000))
# # object construction
# tds <- constructTDS(file = path.to.Bam,
#                     region = region,
#                     fragment.size = 250,
#                     unique = FALSE,
#                     paired.end = FALSE,
#                     swap.strand = TRUE)

## -----------------------------------------------------------------------------
estimateBackground(tds, fdr.cutoff = 0.01)
# view estimated cutoff value
tds

## ----eval = FALSE-------------------------------------------------------------
# # look at the coverage profile of the regions expressed above the background level
# exportCoverage(object = tds, file = "plus.bw", type = "bigWig", strand = "+",
#                filter.by.coverage.cutoff = TRUE, rpm = FALSE)
# 
# # or check the raw coverage (all expressed regions)
# exportCoverage(object = tds, file = "plus_raw.bw", type = "bigWig", strand = "+",
#                filter.by.coverage.cutoff = FALSE, rpm = FALSE)

## -----------------------------------------------------------------------------
# create a range of gap distances to test
# from 0 bp to 10000 bp with the step of 100 bp
gd <- seq(from = 0, to = 10000, by = 100)
estimateGapDistance(object = tds, annot = knownGene.genes, filter.annot = TRUE, 
                    fpkm.quantile = 0.25, gap.dist.range = gd)
# view the optimal gap distance minimazing the sum of two errors
tds

## ----fig.cap="Gap distance error rate", fig.height=7, fig.width=7, fig.align='center'----
# get intermediate calculation 
gdTest <- getTestedGapDistances(tds)
head(gdTest)
# plot error rates
plotErrorRate(tds, lwd = 2)

## -----------------------------------------------------------------------------
detectTranscripts(tds, estimate.params = TRUE)

## -----------------------------------------------------------------------------
annotateTranscripts(object = tds, annot = knownGene.genes, min.overlap = 0.5)

## -----------------------------------------------------------------------------
trx <- getTranscripts(tds, min.length = 250, min.fpkm = 0.5) 
head(trx, 5)

## ----eval = FALSE-------------------------------------------------------------
# transcriptsToBed(object = trx, file = "transcripts.bed", strand.color = c("blue", "red"))

## ----fig.cap="Classification of the peaks on gene associated and background", fig.align='center', echo=FALSE----
knitr::include_graphics(path = "./images/Gene_associated_peak_prediction.png")

## ----fig.cap="Average RNA-seq signal across ChIP peak region", fig.align ='center', echo=FALSE----
knitr::include_graphics(path = "./images/Average_RNAseq_signal_across_peak_region.png")

## ----fig.cap='ChIP peak "strandedness" prediction', fig.align='center', echo=FALSE----
knitr::include_graphics(path = "./images/Peak_strandedness_prediction.png")

## ----cache = FALSE------------------------------------------------------------
# load ChipDataSet object
data(cds)
cds

## ----eval = FALSE-------------------------------------------------------------
# # or initialize a new one (do not run the following code)
# # specify the region of interest (optional)
# region <- GRanges(seqnames = "chr15", ranges = IRanges(start = 63260000, end = 63300000))
# # object construction
# cds <- constructCDS(peaks = path.to.peaks,       # path to a peak file
#                     reads = path.to.reads,       # path to a Bam file with reads
#                     region = region,
#                     TxDb = knownGene,            # annotation database to evaluate
#                                                  # genomic distribution of the peaks
#                     tssOf = "transcript",        # genomic feature to extract TSS region
#                     tss.region = c(-2000, 2000), # size of the TSS region,
#                                                  # from -2kb to +2 kb
#                     reduce.peaks = TRUE,         # merge neighboring peaks
#                     gapwidth = 500,              # min. gap distance between peaks
#                     unique = TRUE,
#                     swap.strand = FALSE)

## ----eval = TRUE--------------------------------------------------------------
peaks <- getPeaks(cds)
head(peaks, 3)

## ----cache = FALSE------------------------------------------------------------
getGenomicAnnot(cds)

## ----fig.cap="Genomic distribution of the peaks", fig.height=7, fig.width=7, fig.align='center'----
plotGenomicAnnot(object = cds, plot.type = "distr")

## ----fig.cap="Enrichment of peaks at distinct genomic features", fig.height=7, fig.width=7, fig.align='center'----
plotGenomicAnnot(object = cds, plot.type = "enrich")

## ----eval=TRUE, fig.cap="Estimated features", fig.height=5, fig.width=10, fig.align='center'----
plotFeatures(cds, plot.type = "box")

## ----eval = TRUE--------------------------------------------------------------
predictTssOverlap(object = cds, feature = "pileup", p = 0.75)
cds

## -----------------------------------------------------------------------------
peaks <- getPeaks(cds)
head(peaks, 3)

## ----eval = TRUE--------------------------------------------------------------
getConfusionMatrix(cds)
getPredictorSignificance(cds)

## ----fig.cap="Performance of the classification model (gene associated peaks prediction)", eval=TRUE, fig.width=6, fig.height=6, fig.align='center'----
plotROC(object = cds, col = "red3", grid = TRUE, auc.polygon = TRUE)

## ----eval = TRUE--------------------------------------------------------------
predictStrand(cdsObj = cds, tdsObj = tds, quant.cutoff = 0.1, win.size = 2000)
cds
peaks <- getPeaks(cds)
head(peaks[ peaks$predicted.tssOverlap == "yes" ], 3)

## ----eval = TRUE--------------------------------------------------------------
df <- getQuadProb(cds, strand = "+")
head(df, 3)

## ----eval = TRUE--------------------------------------------------------------
 getProbTreshold(cds)

## ----eval = FALSE-------------------------------------------------------------
# peaksToBed(object = cds, file = "peaks.bed", gene.associated.peaks = TRUE)

## -----------------------------------------------------------------------------
# set `estimate.params = TRUE` to re-calculate FPKM and coverage density
breakTranscriptsByPeaks(tdsObj = tds, cdsObj = cds, estimate.params = TRUE)
# re-annotate identified transcripts
annotateTranscripts(object = tds, annot = knownGene.genes, min.overlap = 0.5)
# retrieve the final set of transcripts
trx.final <- getTranscripts(tds)

## ----eval = FALSE-------------------------------------------------------------
# # visualize the final set of transcripts in a UCSC genome browser
# transcriptsToBed(object = trx.final, file = "transcripts_final.bed")

## -----------------------------------------------------------------------------
hits <- findOverlaps(query = trx, subject = trx.final)
trx.broken <- trx[unique(queryHits(hits)[duplicated(queryHits(hits))])]
head(trx.broken, 5)

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

