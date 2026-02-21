# Code example from 'Overview' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE)

## ----preliminaries, message=FALSE, echo=FALSE---------------------------------
library("ShortRead")

## ----sample, eval=FALSE-------------------------------------------------------
# sampler <- FastqSampler('E-MTAB-1147/fastq/ERR127302_1.fastq.gz', 20000)
# set.seed(123); ERR127302_1 <- yield(sampler)
# sampler <- FastqSampler('E-MTAB-1147/fastq/ERR127302_2.fastq.gz', 20000)
# set.seed(123); ERR127302_2 <- yield(sampler)

## ----stream, eval=FALSE-------------------------------------------------------
# strm <- FastqStreamer("a.fastq.gz")
# repeat {
#     fq <- yield(strm)
#     if (length(fq) == 0)
#         break
#     ## process chunk
# }

## ----sampler, eval=FALSE------------------------------------------------------
# sampler <- FastqSampler("a.fastq.gz")
# fq <- yield(sampler)

## ----countFastq---------------------------------------------------------------
fl <- system.file(package="ShortRead", "extdata", "E-MTAB-1147",
                  "ERR127302_1_subset.fastq.gz")
countFastq(fl)

## ----readFastq----------------------------------------------------------------
fq <- readFastq(fl)

## ----ShortReadQ---------------------------------------------------------------
fq
fq[1:5]
head(sread(fq), 3)
head(quality(fq), 3)

## ----encoding-----------------------------------------------------------------
encoding(quality(fq))

## ----qa-files1, eval=FALSE----------------------------------------------------
# fls <- dir("/path/to", "*fastq$", full=TRUE)

## ----qa-qa, eval=FALSE--------------------------------------------------------
# qaSummary <- qa(fls, type="fastq")

## ----qa-view, eval=FALSE------------------------------------------------------
# browseURL(report(qaSummary))

## ----qa-files2, echo=FALSE----------------------------------------------------
load("qa_E-MTAB-1147.Rda")

## ----qa-elements--------------------------------------------------------------
qaSummary

## ----qa-readCounts------------------------------------------------------------
head(qaSummary[["readCounts"]])
head(qaSummary[["baseCalls"]])

## ----filter-scheme------------------------------------------------------------
myFilterAndTrim <-
    function(fl, destination=sprintf("%s_subset", fl))
{
    ## open input stream
    stream <- open(FastqStreamer(fl))
    on.exit(close(stream))
    repeat {
        ## input chunk
        fq <- yield(stream)
        if (length(fq) == 0)
            break
        ## trim and filter, e.g., reads cannot contain 'N'...
        fq <- fq[nFilter()(fq)]  # see ?srFilter for pre-defined filters
        ## trim as soon as 2 of 5 nucleotides has quality encoding less
        ## than "4" (phred score 20)
        fq <- trimTailw(fq, 2, "4", 2)
        ## drop reads that are less than 36nt
        fq <- fq[width(fq) >= 36]
        ## append to destination
        writeFastq(fq, destination, "a")
    }
}

## ----export-------------------------------------------------------------------
## location of file
exptPath <- system.file("extdata", package="ShortRead")
sp <- SolexaPath(exptPath)
pattern <- "s_2_export.txt"
fl <- file.path(analysisPath(sp), pattern)
strsplit(readLines(fl, n=1), "\t")
length(readLines(fl))

## ----colClasses---------------------------------------------------------------
colClasses <- rep(list(NULL), 21)
colClasses[9:10] <- c("DNAString", "BString")
names(colClasses)[9:10] <- c("read", "quality")

## ----readXStringColumns-------------------------------------------------------
cols <- readXStringColumns(analysisPath(sp), pattern, colClasses)
cols

## ----size---------------------------------------------------------------------
object.size(cols$read)
object.size(as.character(cols$read))

## ----tables-------------------------------------------------------------------
tbls <- tables(fq)
names(tbls)
tbls$top[1:5]
head(tbls$distribution)

## ----srdistance---------------------------------------------------------------
dist <- srdistance(sread(fq), names(tbls$top)[1])[[1]]
table(dist)[1:10]

## ----aln-not-near-------------------------------------------------------------
fqSubset <- fq[dist>4]

## ----polya--------------------------------------------------------------------
countA <- alphabetFrequency(sread(fq))[,"A"]
fqNoPolyA <- fq[countA < 30]

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

