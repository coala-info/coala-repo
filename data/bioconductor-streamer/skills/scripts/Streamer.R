# Code example from 'Streamer' vignette. See references/ for full tutorial.

### R code from vignette source 'Streamer.Rnw'

###################################################
### code chunk number 1: Load packages
###################################################
library(GenomicAlignments)
library(Streamer)


###################################################
### code chunk number 2: BamInput class
###################################################

.BamInput <-
    setRefClass("BamInput",
    contains="Producer",
    fields=list(
        file="character",
        ranges="GRanges",
        .seqNames="character"))

.BamInput$methods(
    yield=function()
    {
       "yield data from .bam file"
       if (verbose) msg("BamInput$.yield()")
       if(length(.self$.seqNames))
       {
            seq <- .self$.seqNames[1]
            .self$.seqNames <- .self$.seqNames[-1]
            idx <- as.character(seqnames(.self$ranges)) == seq
            param <- ScanBamParam(which=.self$ranges[idx],
                                  what=character())
            aln <- readGAlignments(.self$file, param=param)
            seqlevels(aln) <- seq
       } else {
           aln <- GAlignments()
       }
       list(aln)
    })



###################################################
### code chunk number 3: BamInput constructor
###################################################

BamInput <- function(file, ranges,...)
{
    .seqNames <- names(scanBamHeader(file)[[1]]$target)
    .BamInput$new(file=file, ranges=ranges, .seqNames=.seqNames, ...)
}



###################################################
### code chunk number 4: CountGOverlap class
###################################################

.CountGOverlap <-
    setRefClass("CountGOverlap",
    contains="Consumer",
    fields=list(ranges="GRanges",
                mode="character",
                ignore.strand="logical"))

.CountGOverlap$methods(
    yield=function()
    {
        "return number of hits"
        if (verbose) msg(".CountGOt$yield()")
        aln <- callSuper()[[1]]
        df <- DataFrame(hits=numeric(0))
        if(length(aln))
        {
            idx <- as.character(seqnames(.self$ranges)) == levels(rname(aln))
            which <- .self$ranges[idx]
            olap <- summarizeOverlaps(which, aln, mode=.self$mode,
                                      ignore.strand=.self$ignore.strand)
            df <- as(assays(olap)[[1]], "DataFrame")
            dimnames(df) <- list(rownames(olap), seqlevels(aln))
        }
        df
    })

CountGOverlap <-
    function(ranges,
             mode = c("Union", "IntersectionStrict",
               "IntersectionNotEmpty"),
             ignore.strand = FALSE, ...)
{
    values(ranges)$pos <- seq_len(length(ranges))
    .CountGOverlap$new(ranges=ranges, mode=mode,
                       ignore.strand=ignore.strand, ...)
}



###################################################
### code chunk number 5: BAM file and ranges
###################################################

galn_file <- system.file("extdata", "ex1.bam", package="Rsamtools")
gr <-
    GRanges(seqnames =
            Rle(c("seq2", "seq2", "seq2", "seq1"), c(1, 3, 2, 4)),
            ranges = IRanges(rep(10,1), width = 1:10,
              names = head(letters,10)),
            strand = Rle(strand(rep("+", 5)), c(1, 2, 2, 3, 2)),
            score = 1:10,
            GC = seq(1, 0, length=10))

bam <- BamInput(file = galn_file, ranges = gr)
olap  <- CountGOverlap(ranges=gr, mode="IntersectionNotEmpty")
s <- Stream(bam, olap)
yield(s)



###################################################
### code chunk number 6: overlap counter
###################################################

overlapCounter <- function(pr, cs) {
    s <- Stream(pr, cs)
    len <- length(levels(seqnames(pr$ranges)))
    lst <- vector("list", len)
    for(i in 1:len) {
        lst[[i]] <- yield(s)
        names(lst[[i]]) <- "Count"
    }
    do.call(rbind, lst)[names(cs$ranges), ,drop=FALSE ]
}

bam <- BamInput(file = galn_file, ranges = gr)
olap  <- CountGOverlap(ranges=gr, mode="IntersectionNotEmpty")
overlapCounter(bam, olap)


