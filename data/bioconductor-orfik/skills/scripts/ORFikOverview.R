# Code example from 'ORFikOverview' vignette. See references/ for full tutorial.

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
library(ORFik)                        # This package
library(GenomicFeatures)              # For basic transcript operations
library(data.table)                   # For fast table operations
library(BSgenome.Hsapiens.UCSC.hg19)  # Human genome

## ----eval = TRUE, echo = TRUE-------------------------------------------------
txdbFile <- system.file("extdata", "hg19_knownGene_sample.sqlite", 
                        package = "GenomicFeatures")

## ----eval = TRUE, echo = TRUE-------------------------------------------------
txdb <- loadTxdb(txdbFile)
fiveUTRs <- loadRegion(txdb, "leaders")
fiveUTRs[1]

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
# Extract sequences of fiveUTRs.
tx_seqs <- extractTranscriptSeqs(BSgenome.Hsapiens.UCSC.hg19::Hsapiens, 
                                 fiveUTRs) 
tx_seqs[1]

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
fiveUTR_ORFs <- findMapORFs(fiveUTRs, tx_seqs, groupByTx = FALSE)
fiveUTR_ORFs[1:2]

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
txNames(fiveUTR_ORFs[1:2]) # <- Which transcript

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
names(fiveUTR_ORFs[1:2]) # <- Which ORF

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
# saveRDS(fiveUTR_ORFs[1:2], "save/path/uorfs.rds")

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
# export.bed12(fiveUTR_ORFs[1:2], "save/path/uorfs.bed12")

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
orf_seqs <- extractTranscriptSeqs(BSgenome.Hsapiens.UCSC.hg19::Hsapiens,
                                  fiveUTR_ORFs[1:3])
orf_seqs

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
# writeXStringSet(orf_seqs, filepath = "uorfs.fasta")

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
orf_aa_seq <- Biostrings::translate(orf_seqs)
orf_aa_seq

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
# writeXStringSet(orf_aa_seq, filepath = "uorfs_AA.fasta")

## ----eval = TRUE, echo = TRUE-------------------------------------------------
unlisted_ranges <- unlistGrl(fiveUTR_ORFs)
test_ranges <- groupGRangesBy(unlisted_ranges) # <- defualt is tx grouping by names()
test_ranges[1]

## ----eval = TRUE, echo = TRUE-------------------------------------------------
unlisted_ranges <- unlistGrl(fiveUTR_ORFs)
test_ranges <- groupGRangesBy(unlisted_ranges, unlisted_ranges$names)
test_ranges[1:2]

## ----eval = TRUE, echo = TRUE-------------------------------------------------
  unlisted_ranges <- unlistGrl(fiveUTR_ORFs)
  ORFs <- groupGRangesBy(unlisted_ranges, unlisted_ranges$names)
  length(ORFs) # length means how many ORFs left in set

## ----eval = TRUE, echo = TRUE-------------------------------------------------
  ORFs <- ORFs[widthPerGroup(ORFs) >= 60]
  length(ORFs)

## ----eval = TRUE, echo = TRUE-------------------------------------------------
  ORFs <- ORFs[numExonsPerGroup(ORFs) > 1]
  length(ORFs)

## ----eval = TRUE, echo = TRUE-------------------------------------------------
  
  ORFs <- ORFs[strandPerGroup(ORFs) == "+"]
  # all remaining ORFs where on positive strand, so no change
  length(ORFs)

## ----eval = TRUE, echo = TRUE-------------------------------------------------
startSites(fiveUTR_ORFs, asGR = TRUE, keep.names = TRUE, is.sorted = TRUE)
stopSites(fiveUTR_ORFs, asGR = TRUE, keep.names = TRUE, is.sorted = TRUE)

## ----eval = TRUE, echo = TRUE-------------------------------------------------
starts <- startCodons(fiveUTR_ORFs, is.sorted = TRUE)
stops <- stopCodons(fiveUTR_ORFs, is.sorted = TRUE)
starts[1:2]

## ----eval = TRUE, echo = TRUE-------------------------------------------------
txSeqsFromFa(starts, BSgenome.Hsapiens.UCSC.hg19::Hsapiens, is.sorted = TRUE)
"Stop codons"
txSeqsFromFa(stops, BSgenome.Hsapiens.UCSC.hg19::Hsapiens, is.sorted = TRUE)

## ----eval = TRUE, echo = TRUE-------------------------------------------------
  library(Biostrings)
  # strand with ORFs in both directions
  seqs <- DNAStringSet("ATGAAATGAAGTAAATCAAAACAT")
  ######################>######################< (< > is direction of ORF)
  
  # positive strands
  pos <- findORFs(seqs, startCodon = "ATG", minimumLength = 0)
  # negative strands
  neg <- findORFs(reverseComplement(seqs),
                  startCodon = "ATG", minimumLength = 0)

## ----eval = TRUE, echo = TRUE-------------------------------------------------
  pos <- GRanges(pos, strand = "+")
  neg <- GRanges(neg, strand = "-")
  # as GRanges
  res <- c(pos, neg)
  # or merge together and make GRangesList
  res <- split(res, seq.int(1, length(pos) + length(neg)))
  res[1:2]

## ----eval = TRUE, echo = TRUE-------------------------------------------------
  res[strandBool(res)] # Keep only + stranded ORFs

## ----eval = TRUE, echo = TRUE, warning = FALSE, message = FALSE---------------
# path to example CageSeq data from hg19 heart sample
cageData <- system.file("extdata", "cage-seq-heart.bed.bgz", 
                        package = "ORFik")
# get new Transcription Start Sites using CageSeq dataset
newFiveUTRs <- reassignTSSbyCage(fiveUTRs, cageData)
newFiveUTRs

## ----eval = TRUE, echo = TRUE-------------------------------------------------
# Find path to a bam file
bam_file <- system.file("extdata/Danio_rerio_sample", "ribo-seq.bam", package = "ORFik")
footprints <- readBam(bam_file)

## ----eval = TRUE, echo = TRUE-------------------------------------------------
table(readWidths(footprints))

## ----eval = TRUE, echo = TRUE, warning = FALSE, message = FALSE---------------
gtf_file <- system.file("extdata/references/danio_rerio", "annotations.gtf", package = "ORFik")
txdb <- loadTxdb(gtf_file)
tx <- loadRegion(txdb, part = "tx")
cds <- loadRegion(txdb, part = "cds")
trailers <- loadRegion(txdb, part = "trailers")
cds[1]

## ----eval = FALSE, echo = TRUE, warning = FALSE, message = FALSE--------------
# loadRegions(gtf_file, parts = c("tx", "cds", "trailers"))

## ----eval = TRUE, echo = TRUE-------------------------------------------------
footprintsGR <- convertToOneBasedRanges(footprints, addSizeColumn = TRUE)
footprintsGR

## ----eval = TRUE, echo = TRUE-------------------------------------------------
  hitMap <- windowPerReadLength(cds, tx,  footprintsGR, pShifted = FALSE)
  coverageHeatMap(hitMap, scoring = "transcriptNormalized")

## ----eval = TRUE, echo = TRUE-------------------------------------------------
footprints <- footprints[readWidths(footprints) == 29]
footprintsGR <- footprintsGR[readWidths(footprintsGR) == 29]
footprints

## ----eval = TRUE, echo = TRUE, warning = FALSE--------------------------------
txNames <- filterTranscripts(txdb) # <- get only transcripts that pass filter
tx <- tx[txNames]; cds <- cds[txNames]; trailers <- trailers[txNames];
windowsStart <- startRegion(cds, tx, TRUE, upstream = 30, 29)
windowsStop <- startRegion(trailers, tx, TRUE, upstream = 30, 29)
windowsStart

## ----eval = TRUE, echo = TRUE, warning = FALSE--------------------------------
hitMapStart <- metaWindow(footprintsGR, windowsStart, withFrames = TRUE, fraction = 29)
hitMapStop <- metaWindow(footprintsGR, windowsStop, withFrames = TRUE, fraction = 29)

## ----eval = TRUE, echo = TRUE, warning = FALSE--------------------------------
  pSitePlot(hitMapStart)

## ----eval = TRUE, echo = TRUE, warning = FALSE--------------------------------
  pSitePlot(hitMapStop, region = "stop")

## ----eval = TRUE, echo = TRUE, warning = FALSE--------------------------------
shifts <- detectRibosomeShifts(footprints, txdb, stop = TRUE)
shifts

## ----eval = TRUE, echo = TRUE, warning = FALSE--------------------------------
shiftedFootprints <- shiftFootprints(footprints, shifts)
shiftedFootprints

## ----eval = TRUE, echo = TRUE, warning = FALSE--------------------------------
shiftedFootprints <- collapseDuplicatedReads(shiftedFootprints, addSizeColumn = TRUE)
shiftedFootprints

## ----eval = TRUE, echo = TRUE, warning = FALSE, message = FALSE---------------
fiveUTRs <- fiveUTRs[1:10]
faFile <- BSgenome.Hsapiens.UCSC.hg19::Hsapiens
tx_seqs <- extractTranscriptSeqs(faFile, fiveUTRs)

fiveUTR_ORFs <- findMapORFs(fiveUTRs, tx_seqs, groupByTx = FALSE)

## ----eval = TRUE, echo = TRUE, warning = FALSE, message = FALSE---------------
starts <- unlist(ORFik:::firstExonPerGroup(fiveUTR_ORFs), use.names = FALSE)
RFP <- promoters(starts, upstream = 0, downstream = 1)
RFP$size <- rep(29, length(RFP)) # store read widths
# set RNA-seq seq to duplicate transcripts
RNA <- unlist(exonsBy(txdb, by = "tx", use.names = TRUE), use.names = TRUE)

## ----eval = TRUE, echo = TRUE, warning = FALSE, message = FALSE---------------
# transcript database
txdb <- loadTxdb(txdbFile)
dt <- computeFeatures(fiveUTR_ORFs[1:4], RFP, RNA, txdb, faFile, 
                      sequenceFeatures = TRUE)
dt

## ----eval = TRUE, echo = TRUE-------------------------------------------------
cds <- cdsBy(txdb, by = "tx", use.names = TRUE)[1:10]
tx <- exonsBy(txdb, by = "tx", use.names = TRUE)[names(cds)]
faFile <- BSgenome.Hsapiens.UCSC.hg19::Hsapiens

kozakSequenceScore(cds, tx, faFile, species = "human")



## ----eval = TRUE, echo = TRUE-------------------------------------------------
pfm <- t(matrix(as.integer(c(29,26,28,26,22,35,62,39,28,24,27,17,
                             21,26,24,16,28,32,5,23,35,12,42,21,
                             25,24,22,33,22,19,28,17,27,47,16,34,
                             25,24,26,25,28,14,5,21,10,17,15,28)),
                ncol = 4))

kozakSequenceScore(cds, tx, faFile, species = pfm)

## ----eval = TRUE, echo = TRUE-------------------------------------------------
seqs <- startRegionString(cds, tx, faFile, upstream = 5, downstream = 5)
rate <- fpkm(cds, RFP)
ORFik:::kozakHeatmap(seqs, rate)


## ----eval = TRUE, echo = TRUE-------------------------------------------------
  # First make some toy example
  cds <- GRanges("chr1", IRanges(c(1, 10, 20, 30, 40, 50, 60, 70, 80),
                                 c(5, 15, 25, 35, 45, 55, 65, 75, 85)),
                 "+")
  names(cds) <- c(rep("tx1", 3), rep("tx2", 3), rep("tx3", 3))
  cds <- groupGRangesBy(cds)
  ribo <- GRanges("chr1", c(1, rep.int(23, 4), 30, 34, 34, 43, 60, 64, 71, 74),
                  "+")
  # We could do a simplification and use the ORFik entropy function
  entropy(cds, ribo) # <- spread of reads

## ----eval = TRUE, echo = TRUE-------------------------------------------------
tile <- tile1(cds, FALSE, FALSE) # tile them to 1 based positions
tails <- tails(tile, 9) # get 9 last bases per cds
stopOverlap <- countOverlaps(tails, ribo)
allOverlap <- countOverlaps(cds, ribo)
fractions <- (stopOverlap + 1) / (allOverlap + 1) # pseudocount 1
cdsToRemove <- fractions > 1 / 2 # filter with pseudocounts (1+1)/(3+1) 
cdsToRemove

## ----eval = TRUE, echo = TRUE, warning = FALSE, message = FALSE---------------
# Get the annotation
txdb <- loadTxdb(gtf_file)
# Ribo-seq
bam_file <- system.file("extdata/Danio_rerio_sample", "ribo-seq.bam", package = "ORFik")
reads <- readGAlignments(bam_file)
shiftedReads <- shiftFootprints(reads, detectRibosomeShifts(reads, txdb))  

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
# Lets take all valid transcripts, with size restrictions:
# leader > 100 bases, cds > 100 bases, trailer > 100 bases
txNames <- filterTranscripts(txdb, 100, 100, 100) # valid transcripts
loadRegions(txdb, parts = c("leaders", "cds", "trailers", "tx"), 
            names.keep = txNames)

# Create meta coverage per part of transcript
leaderCov <- metaWindow(shiftedReads, leaders, scoring = NULL, 
                        feature = "leaders")

cdsCov <- metaWindow(shiftedReads, cds, scoring = NULL, 
                     feature = "cds")

trailerCov <- metaWindow(shiftedReads, trailers, scoring = NULL, 
                         feature = "trailers")

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
dt <- rbindlist(list(leaderCov, cdsCov, trailerCov))
dt[, `:=` (fraction = "Ribo-seq")] # Set info column
# zscore gives shape, a good starting plot
windowCoveragePlot(dt, scoring = "zscore", title = "Ribo-seq metaplot") 

## ----eval = TRUE, echo = TRUE-------------------------------------------------
windowCoveragePlot(dt, scoring = "median", title = "Ribo-seq metaplot") 

## ----eval = TRUE, echo = TRUE-------------------------------------------------
if (requireNamespace("BSgenome.Hsapiens.UCSC.hg19")) {
  # size 100 window: 50 upstream, 49 downstream of TIS
  windowsStart <- startRegion(cds, tx, TRUE, upstream = 50, 49)
  hitMapStart <- metaWindow(shiftedReads, windowsStart, withFrames = TRUE)
  pSitePlot(hitMapStart, length = "meta coverage")
}

## ----eval = TRUE, echo = TRUE, message = FALSE, fig.height=8------------------
hitMap <- windowPerReadLength(cds, tx,  shiftedReads)
coverageHeatMap(hitMap, addFracPlot = TRUE)

## ----eval = TRUE, echo = TRUE, message=FALSE----------------------------------
if (requireNamespace("BSgenome.Hsapiens.UCSC.hg19")) {
  # Load more files like above (Here I make sampled data from earlier Ribo-seq)
  dt2 <- copy(dt)
  dt2[, `:=` (fraction = "Ribo-seq2")]
  dt2$score <- dt2$score + sample(seq(-40, 40), nrow(dt2), replace = TRUE)
  
  dtl <- rbindlist(list(dt, dt2))
  windowCoveragePlot(dtl, scoring = "median", title = "Ribo-seq metaplots") 
}

