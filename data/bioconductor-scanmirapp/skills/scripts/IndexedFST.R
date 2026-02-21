# Code example from 'IndexedFST' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(BiocStyle)

## -----------------------------------------------------------------------------
library(scanMiRApp)
# we create a temporary directory in which the files will be saved
tmp <- tempdir()
f <- file.path(tmp, "test")
# we create a dummy data.frame
d <- data.frame( category=sample(LETTERS[1:4], 10000, replace=TRUE),
                 var2=sample(LETTERS, 10000, replace=TRUE),
                 var3=runif(10000) )

saveIndexedFst(d, index.by="category", file.prefix=f)

## -----------------------------------------------------------------------------
d2 <- loadIndexedFst(f)
class(d2)
summary(d2)

## -----------------------------------------------------------------------------
format(object.size(d),units="Kb")
format(object.size(d2),units="Kb")

## -----------------------------------------------------------------------------
nrow(d2)
ncol(d2)
colnames(d2)
head(d2)

## -----------------------------------------------------------------------------
names(d2)
lengths(d2)

## -----------------------------------------------------------------------------
catB <- d2$B
head(catB)

## -----------------------------------------------------------------------------
library(GenomicRanges)
gr <- GRanges(sample(LETTERS[1:3],200,replace=TRUE), IRanges(seq_len(200), width=2))
gr$propertyA <- factor(sample(letters[1:5],200,replace=TRUE))
gr

## -----------------------------------------------------------------------------
f2 <- file.path(tmp, "test2")
saveIndexedFst(gr, index.by="seqnames", file.prefix=f2)
d1 <- loadIndexedFst(f2)
names(d1)
head(d1$A)

## -----------------------------------------------------------------------------
saveIndexedFst(gr, index.by="propertyA", file.prefix=f2)
d2 <- loadIndexedFst(f2)
names(d2)

## -----------------------------------------------------------------------------
list.files(tmp, "test2")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

