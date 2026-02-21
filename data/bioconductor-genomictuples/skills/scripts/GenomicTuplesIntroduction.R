# Code example from 'GenomicTuplesIntroduction' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----echo = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ----initialize, echo = TRUE, eval = TRUE-------------------------------------
library(GenomicTuples)

## ----example-GTuples, echo = TRUE, eval = TRUE--------------------------------
seqinfo <- Seqinfo(paste0("chr", 1:3), c(1000, 2000, 1500), NA, "mock1")
gt3 <- GTuples(seqnames = Rle(c("chr1", "chr2", "chr1", "chr3"),
                              c(1, 3, 2, 4)),
               tuples = matrix(c(1:10, 2:11, 3:12), ncol = 3),
               strand = Rle(strand(c("-", "+", "*", "+", "-")),
                            c(1, 2, 2, 3, 2)),
               score = 1:10, GC = seq(1, 0, length = 10), seqinfo = seqinfo)
names(gt3) <- letters[1:10]
gt3

## ----GTuples-help, eval = FALSE, echo = TRUE----------------------------------
# ?GTuples

## ----GTuples-coercion, eval = TRUE, echo = TRUE-------------------------------
as(gt3, "GRanges")

## ----GTuples-accessors1, eval = TRUE, echo = TRUE-----------------------------
seqnames(gt3)
tuples(gt3)
strand(gt3)

## ----GTuples-accessors2, eval = TRUE, echo = TRUE-----------------------------
mcols(gt3)

## ----GTuples-accessors3, eval = TRUE, echo = TRUE-----------------------------
seqinfo(gt3)

## ----GTuples-accessors4, eval = TRUE, echo = TRUE-----------------------------
length(gt3)
names(gt3)

## ----split, eval = TRUE, echo = TRUE------------------------------------------
sp <- split(gt3, rep(1:2, each=5))
sp

## ----c, eval = TRUE, echo = TRUE----------------------------------------------
c(sp[[1]], sp[[2]])

## ----subsetting-GTuples1, eval = TRUE, echo = TRUE----------------------------
gt3[2:3]

## ----subsetting-GTuples2, eval = TRUE, echo = TRUE----------------------------
gt3[2:3, "GC"]

## ----subsetting-GTuples3, eval = TRUE, echo = TRUE----------------------------
gt3_mod <- gt3
gt3_mod[2] <- gt3[1]
head(gt3_mod, n = 3)

## ----subsetting-GTuples4, eval = TRUE, echo = TRUE----------------------------
rep(gt3[2], times = 3)
rev(gt3)
head(gt3, n = 2)
tail(gt3, n = 2)
window(gt3, start = 2, end = 4)

## ----tuple-operations, eval = TRUE, echo = TRUE-------------------------------
start(gt3)
end(gt3)
tuples(gt3)

## ----shift, eval = TRUE, echo = TRUE------------------------------------------
shift(gt3, 500)

## ----tuples-method, eval = TRUE, echo = TRUE----------------------------------
tuples(gt3)

## ----size-method, eval = TRUE, echo = TRUE------------------------------------
size(gt3)

## ----IPD-method, eval = TRUE, echo = TRUE-------------------------------------
IPD(gt3)

## ----GTuplesList, eval = TRUE, echo = TRUE------------------------------------
seqinfo <- Seqinfo(paste0("chr", 1:3), c(1000, 2000, 1500), NA, "mock1")
gt3 <- GTuples(seqnames = Rle(c("chr1", "chr2", "chr1", "chr3"),
                              c(1, 3, 2, 4)),
               tuples = matrix(c(1:10, 2:11, 3:12), ncol = 3),
               strand = Rle(strand(c("-", "+", "*", "+", "-")),
                            c(1, 2, 2, 3, 2)),
               score = 1:10, GC = seq(1, 0, length = 10), seqinfo = seqinfo)
gtl3 <- GTuplesList(A = gt3[1:5], B = gt3[6:10])
gtl3

## ----GTuplesList-help, eval = FALSE, echo = TRUE------------------------------
# ?GTuplesList

## ----GTuplesList-to-GRangesList, eval = TRUE, echo = TRUE---------------------
as(gtl3, "GRangesList")

## ----basic-gtupleslist-accessors1, eval = TRUE, echo = TRUE-------------------
seqnames(gtl3)
# Returns a list of integer matrices
tuples(gtl3)
tuples(gtl3)[[1]]
strand(gtl3)

## ----basic-gtupleslist-accessors2, eval = TRUE, echo = TRUE-------------------
length(gtl3)
names(gtl3)

## ----basic-gtupleslist-accessors3, eval = TRUE, echo = TRUE-------------------
seqinfo(gtl3)

## ----basic-gtupleslist-accessors4, eval = TRUE, echo = TRUE-------------------
elementNROWS(gtl3)

## ----basic-gtupleslist-accessors5, eval = TRUE, echo = TRUE-------------------
isEmpty(gtl3)
isEmpty(GTuplesList())

## ----basic-gtupleslist-accessors6, eval = TRUE, echo = TRUE-------------------
mcols(gtl3) <- c("Feature A", "Feature B")
mcols(gtl3)

## ----combining-GTuplesLists, eval = TRUE, echo = TRUE-------------------------
ul <- unlist(gtl3)
ul

## ----GTuplesList-subsetting1, echo = TRUE, eval = TRUE------------------------
gtl3[1]
gtl3[[1]]
gtl3["A"]
gtl3$B

## ----GTuplesList-subsetting2, echo = TRUE, eval = TRUE------------------------
gtl3[1, "score"]
gtl3["B", "GC"]

## ----GTuplesList-subsetting3, echo = TRUE, eval = TRUE------------------------
rep(gtl3[[1]], times = 3)
rev(gtl3)
head(gtl3, n = 1)
tail(gtl3, n = 1)
window(gtl3, start = 1, end = 1)

## ----GTuplesList-accessors, eval = TRUE, echo = TRUE--------------------------
start(gtl3)
end(gtl3)
tuples(gtl3)

## ----shift-GTuplesList, eval = TRUE, echo = TRUE------------------------------
shift(gtl3, 500)
shift(gtl3, IntegerList(A = 300L, B = 500L))

## ----GTuplesList-looping1, echo = TRUE, eval = TRUE---------------------------
lapply(gtl3, length)
sapply(gtl3, length)

## ----GTuplesList-looping2, echo = TRUE, eval = TRUE---------------------------
gtl3_shift <- shift(gtl3, 10)
names(gtl3) <- c("shiftA", "shiftB")
mapply(c, gtl3, gtl3_shift)
Map(c, gtl3, gtl3_shift)

## ----GTuplesList-looping3, echo = TRUE, eval = TRUE---------------------------
endoapply(gtl3, rev)

## ----GTuplesList-looping4, echo = TRUE, eval = TRUE---------------------------
mendoapply(c, gtl3, gtl3_shift)

## ----GTuplesList-looping5, echo = TRUE, eval = TRUE---------------------------
Reduce(c, gtl3)

## ----unique-GTuplesList-methods, echo = TRUE, eval = TRUE---------------------
tuples(gtl3)
tuples(gtl3)[[1]]
size(gtl3)
IPD(gtl3)
IPD(gtl3)[[1]]

## ----1-tuples-findOverlaps-examples, eval = TRUE, echo = TRUE-----------------
# Construct example 1-tuples
gt1 <- GTuples(seqnames = c('chr1', 'chr1', 'chr1', 'chr2'), 
               tuples = matrix(c(10L, 10L, 10L, 10L), ncol = 1), 
               strand = c('+', '-', '*', '+'))
# GRanges version of gt1
gr1 <- as(gt1, "GRanges")
findOverlaps(gt1, gt1, type = 'any')
# GTuples and GRanges methods identical
identical(findOverlaps(gt1, gt1, type = 'any'), 
          findOverlaps(gr1, gr1, type = 'any'))
findOverlaps(gt1, gt1, type = 'start')
# GTuples and GRanges methods identical
identical(findOverlaps(gt1, gt1, type = 'start'), 
          findOverlaps(gr1, gr1, type = 'start'))
findOverlaps(gt1, gt1, type = 'end')
# GTuples and GRanges methods identical
identical(findOverlaps(gt1, gt1, type = 'end'), 
          findOverlaps(gr1, gr1, type = 'end'))
findOverlaps(gt1, gt1, type = 'within')
# GTuples and GRanges methods identical
identical(findOverlaps(gt1, gt1, type = 'within'), 
          findOverlaps(gr1, gr1, type = 'within'))
findOverlaps(gt1, gt1, type = 'equal')
# GTuples and GRanges methods identical
identical(findOverlaps(gt1, gt1, type = 'equal'), 
          findOverlaps(gr1, gr1, type = 'equal'))
# Can pass other arguments, such as select and ignore.strand
findOverlaps(gt1, gt1, type = 'equal', ignore.strand = TRUE, select = 'last')

## ----2-tuples-findOverlaps-examples, eval = TRUE, echo = TRUE-----------------
# Construct example 2-tuples
gt2 <- GTuples(seqnames = c('chr1', 'chr1', 'chr1', 'chr1', 'chr2'), 
               tuples = matrix(c(10L, 10L, 10L, 10L, 10L, 20L, 20L, 20L, 25L, 
                                 20L), ncol = 2), 
               strand = c('+', '-', '*', '+', '+'))
# GRanges version of gt2
gr2 <- as(gt2, "GRanges")
findOverlaps(gt2, gt2, type = 'any')
# GTuples and GRanges methods identical
identical(findOverlaps(gt2, gt2, type = 'any'), 
          findOverlaps(gr2, gr2, type = 'any'))
findOverlaps(gt2, gt2, type = 'start')
# GTuples and GRanges methods identical
identical(findOverlaps(gt2, gt2, type = 'start'), 
          findOverlaps(gr2, gr2, type = 'start'))
findOverlaps(gt2, gt2, type = 'end')
# GTuples and GRanges methods identical
identical(findOverlaps(gt2, gt2, type = 'end'), 
          findOverlaps(gr2, gr2, type = 'end'))
findOverlaps(gt2, gt2, type = 'within')
# GTuples and GRanges methods identical
identical(findOverlaps(gt2, gt2, type = 'within'), 
          findOverlaps(gr2, gr2, type = 'within'))
findOverlaps(gt2, gt2, type = 'equal')
# GTuples and GRanges methods identical
identical(findOverlaps(gt2, gt2, type = 'equal'), 
          findOverlaps(gr2, gr2, type = 'equal'))
# Can pass other arguments, such as select and ignore.strand
findOverlaps(gt2, gt2, type = 'equal', ignore.strand = TRUE, select = 'last')

## ----3-tuples-findOverlaps-examples, eval = TRUE, echo = TRUE-----------------
# Construct example 3-tuples
gt3 <- GTuples(seqnames = c('chr1', 'chr1', 'chr1', 'chr1', 'chr2'), 
               tuples = matrix(c(10L, 10L, 10L, 10L, 10L, 20L, 20L, 20L, 25L, 
                                 20L, 30L, 30L, 35L, 30L, 30L), ncol = 3), 
               strand = c('+', '-', '*', '+', '+'))
# GRanges version of gt3
gr3 <- as(gt3, "GRanges")
findOverlaps(gt3, gt3, type = 'any')
# GTuples and GRanges methods identical
identical(findOverlaps(gt3, gt3, type = 'any'), 
          findOverlaps(gr3, gr3, type = 'any')) # TRUE

findOverlaps(gt3, gt3, type = 'start')
# GTuples and GRanges methods identical
identical(findOverlaps(gt3, gt3, type = 'start'), 
          findOverlaps(gr3, gr3, type = 'start')) # TRUE

findOverlaps(gt3, gt3, type = 'end')
# GTuples and GRanges methods identical
identical(findOverlaps(gt3, gt3, type = 'end'), 
          findOverlaps(gr3, gr3, type = 'end')) # TRUE

findOverlaps(gt3, gt3, type = 'within')
# GTuples and GRanges methods identical
identical(findOverlaps(gt3, gt3, type = 'within'), 
          findOverlaps(gr3, gr3, type = 'within')) # TRUE

findOverlaps(gt3, gt3, type = 'equal')
# GTuples and GRanges methods **not** identical because  GRanges method ignores 
# "internal positions".
identical(findOverlaps(gt3, gt3, type = 'equal'), 
          findOverlaps(gr3, gr3, type = 'equal')) # FALSE
# Can pass other arguments, such as select and ignore.strand
findOverlaps(gt3, gt3, type = 'equal', ignore.strand = TRUE, select = 'last')

## ----3-tuples-pcompare-examples, eval = TRUE, echo = TRUE---------------------
# Construct example 3-tuples
gt3 <- GTuples(seqnames = c('chr1', 'chr1', 'chr1', 'chr1', 'chr2', 'chr1', 
                            'chr1'), 
               tuples = matrix(c(10L, 10L, 10L, 10L, 10L, 5L, 10L, 20L, 20L, 
                                 20L, 25L, 20L, 20L, 20L, 30L, 30L, 35L, 30L, 
                                 30L, 30L, 35L), 
                               ncol = 3), 
               strand = c('+', '-', '*', '+', '+', '+', '+'))
gt3

# pcompare each tuple to itself
pcompare(gt3, gt3)
gt3 < gt3
gt3 > gt3
gt3 == gt3

# pcompare the third tuple to all tuples
pcompare(gt3[3], gt3)
gt3[3] < gt3
gt3[3] > gt3
gt3[3] == gt3

## Some comparisons where tuples differ only in one coordinate

# Ordering of seqnames 
# 'chr1' < 'chr2' for tuples with otherwise identical coordinates
gt3[1] < gt3[5] # TRUE

# Ordering of strands
# '+' < '-' < '*' for tuples with otherwise identical coordiantes
gt3[1] < gt3[2] # TRUE
gt3[1] < gt3[2] # TRUE
gt3[1] < unstrand(gt3[2]) # TRUE
gt3[2] < unstrand(gt3[2]) # TRUE

# Ordering of tuples
# Tuples checked sequentially from pos1, ..., posm for tuples with otherwise
# identical coordinates
gt3[6] < gt3[1] # TRUE due to pos1
gt3[2] < gt3[4] # TRUE due to pos2
gt3[1] < gt3[7] # TRUE due to pos3

# Sorting of tuples
# Sorted first by seqnames, then by strand, then by tuples
sort(gt3)

# Duplicate tuples
# Duplicate tuples must have identical seqnames, strand and positions (tuples)
duplicated(c(gt3, gt3[1:3]))
unique(c(gt3, gt3[1:3]))

## ----sessionInfo, eval = TRUE, echo = TRUE------------------------------------
sessionInfo()

