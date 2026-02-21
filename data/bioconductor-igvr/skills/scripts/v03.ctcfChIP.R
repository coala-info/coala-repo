# Code example from 'v03.ctcfChIP' vignette. See references/ for full tutorial.

## ----setup, include = FALSE-------------------------------------------------------------------------------------------
options(width=120)
knitr::opts_chunk$set(
   collapse = TRUE,
   eval=interactive(),
   echo=TRUE,
   comment = "#>"
)

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# library(igvR)
# igv <- igvR()
# setBrowserWindowTitle(igv, "CTCF ChIP-seq")
# setGenome(igv, "hg19")
# showGenomicRegion(igv, "chr3:128,079,020-128,331,275")
#    # or
# showGenomicRegion(igv, "GATA2")
# for(i in 1:4) zoomOut(igv)

## ----eval=TRUE, echo=FALSE--------------------------------------------------------------------------------------------
knitr::include_graphics("images/ctcfBam-01.png")

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# roi <- getGenomicRegion(igv)
# gr.roi <- with(roi, GRanges(seqnames=chrom, ranges = IRanges(start, end)))
# param <- ScanBamParam(which=gr.roi, what = scanBamWhat())
# bamFile <- system.file(package="igvR", "extdata", "ctcf-gata2", "gata2-region-hg19.bam")
# alignments <- readGAlignments(bamFile, use.names=TRUE, param=param)

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# track <- GenomicAlignmentTrack(trackName="ctcf bam", alignments, visibilityWindow=10000000, trackHeight=200)
# displayTrack(igv, track)

## ----eval=TRUE, echo=FALSE--------------------------------------------------------------------------------------------
knitr::include_graphics("images/ctcfBam-02.png")

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# lapply(tbl.pk, class)
# head(tbl.pk)
# 
# constructed from a data.frame.
# 
# 

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# narrowPeaksFile <- system.file(package="igvR", "extdata", "ctcf-gata2",
#                                "gata2-region-macs2-narrowPeaks.RData")
# tbl.pk <- get(load(narrowPeaksFile))
# dim(tbl.pk) # 109 4
# head(tbl.pk)
#   #      chrom     start       end score
#   # 6381 chr10 127910682 127910864    27
#   # 6382 chr10 128075644 128075811    89
#   # 6383 chr10 128259852 128259984    27
#   # 6384 chr10 128286655 128286920    78
#   # 6385 chr10 128437706 128437938    89
#   # 8827 chr11 127965327 127965489    70
# 
# unlist(lapply(tbl.pk, class))
# #        chrom       start         end       score
# #  "character"   "integer"   "integer"   "integer"
# 
# track <- DataFrameQuantitativeTrack("macs2 peaks", tbl.pk, color="red", autoscale=TRUE)
# displayTrack(igv, track)
# 

## ----eval=TRUE, echo=FALSE--------------------------------------------------------------------------------------------
knitr::include_graphics("images/ctcfBam-03.png")

## ----out.width="500px", eval=TRUE, echo=FALSE-------------------------------------------------------------------------
knitr::include_graphics("images/ctcfMotif.png")

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
#    # get the DNA sequence in the current region
# dna <- with(roi, getSeq(BSgenome.Hsapiens.UCSC.hg19, chrom, start, end))
#    # get the first of three motifs for CTCF.  (a more thorough study would use all three)
# pfm.ctcf <- MotifDb::query(MotifDb, c("CTCF", "sapiens", "jaspar2022"), notStrings="ctcfl")
# motif.name <- names(pfm.ctcf)[1]
# pfm <- pfm.ctcf[[1]]
# 
#    # Find matches >= 80% of this motif in the sequence.  create a suitable
#    # data.frame for another DataFrameQuantitativeTrack
# 
# hits.forward <- matchPWM(pfm, as.character(dna), with.score=TRUE, min.score="80%")
# hits.reverse <- matchPWM(reverseComplement(pfm), as.character(dna), with.score=TRUE, min.score="80%")
# 
# tbl.forward <- as.data.frame(ranges(hits.forward))
# tbl.reverse <- as.data.frame(ranges(hits.reverse))
# tbl.forward$score <- mcols(hits.forward)$score
# tbl.reverse$score <- mcols(hits.reverse)$score
# 
# tbl.matches <- rbind(tbl.forward, tbl.reverse)
# tbl.matches$chrom <- roi$chrom
# tbl.matches$start <- tbl.matches$start + roi$start
# 
# tbl.matches$end <- tbl.matches$end + roi$start
# 
# tbl.matches$name <- paste0("MotifDb::", motif.name)
# tbl.matches <- tbl.matches[, c("chrom", "start", "end", "name", "score")]
# dim(tbl.matches) # 25 5
# head(tbl.matches)
#     #   chrom     start       end                                       name    score
#     # 1  chr3 128110910 128110928 MotifDb::Hsapiens-jaspar2018-CTCF-MA0139.1 10.70369
#     # 2  chr3 128114573 128114591 MotifDb::Hsapiens-jaspar2018-CTCF-MA0139.1 10.36891
#     # 3  chr3 128127658 128127676 MotifDb::Hsapiens-jaspar2018-CTCF-MA0139.1 10.44666
#     # 4  chr3 128138376 128138394 MotifDb::Hsapiens-jaspar2018-CTCF-MA0139.1 10.54861
#     # 5  chr3 128139280 128139298 MotifDb::Hsapiens-jaspar2018-CTCF-MA0139.1 10.51689
#     # 6  chr3 128173128 128173146 MotifDb::Hsapiens-jaspar2018-CTCF-MA0139.1 10.37987
# 

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# track <- DataFrameQuantitativeTrack("MA0139.1 scores", tbl.matches[, c(1,2,3,5)],
#                                     color="random", autoscale=FALSE, min=8, max=12)
# displayTrack(igv, track)

## ----eval=TRUE, echo=FALSE--------------------------------------------------------------------------------------------
knitr::include_graphics("images/ctcfBam-04.png")

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# 
# roi <- getGenomicRegion(igv)
# bigwig.file <- system.file(package="igvR", "extdata", "ctcf-gata2", "gata2-region-h3k4me3.bw")
# 
# bw.slice <- import(bigwig.file, which=gr.roi)
# track <- GRangesQuantitativeTrack("h3k4me3", bw.slice, autoscale=TRUE)
# displayTrack(igv, track)
# 

## ----eval=TRUE, echo=FALSE--------------------------------------------------------------------------------------------
knitr::include_graphics("images/ctcfBam-05.png")

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# showGenomicRegion(igv, "chr3:128,202,505-128,222,868")

## ----eval=TRUE, echo=FALSE--------------------------------------------------------------------------------------------
knitr::include_graphics("images/ctcfBam-07.png")

## ----eval=TRUE--------------------------------------------------------------------------------------------------------
sessionInfo()

