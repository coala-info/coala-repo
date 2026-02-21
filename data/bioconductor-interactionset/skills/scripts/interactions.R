# Code example from 'interactions' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
require(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)

## -----------------------------------------------------------------------------
library(InteractionSet)
all.regions <- GRanges("chrA", IRanges(0:9*10+1, 1:10*10))

## -----------------------------------------------------------------------------
index.1 <- c(1,5,10)
index.2 <- c(3,2,6)
region.1 <- all.regions[index.1]
region.2 <- all.regions[index.2]

## -----------------------------------------------------------------------------
gi <- GInteractions(region.1, region.2)

## -----------------------------------------------------------------------------
gi <- GInteractions(index.1, index.2, all.regions)
gi

## -----------------------------------------------------------------------------
anchors(gi)

## -----------------------------------------------------------------------------
anchors(gi, id=TRUE)

## -----------------------------------------------------------------------------
regions(gi)

## -----------------------------------------------------------------------------
temp.gi <- gi
anchorIds(temp.gi) <- list(1:3, 5:7)

## -----------------------------------------------------------------------------
temp.gi <- gi
annotation <- rep(c("E", "P", "N"), length.out=length(all.regions))
regions(temp.gi)$anno <- annotation

## -----------------------------------------------------------------------------
anchors(temp.gi)

## -----------------------------------------------------------------------------
temp.gi <- gi
super.regions <- GRanges("chrA", IRanges(0:19*10+1, 1:20*10))
replaceRegions(temp.gi) <- super.regions

## -----------------------------------------------------------------------------
temp.gi <- gi
extra.regions <- GRanges("chrA", IRanges(10:19*10+1, 11:20*10))
appendRegions(temp.gi) <- extra.regions

## -----------------------------------------------------------------------------
metadata(gi)$description <- "I am a GInteractions object"
metadata(gi)

## -----------------------------------------------------------------------------
set.seed(1000)
norm.freq <- rnorm(length(gi)) # obviously, these are not real frequencies.
gi$norm.freq <- norm.freq
mcols(gi)

## -----------------------------------------------------------------------------
sub.gi <- gi[1:2]
sub.gi
anchors(sub.gi, id=TRUE)

## -----------------------------------------------------------------------------
identical(regions(gi), regions(sub.gi))

## -----------------------------------------------------------------------------
c(gi, sub.gi)
new.gi <- gi
regions(new.gi) <- resize(regions(new.gi), width=20)
c(gi, new.gi)

## -----------------------------------------------------------------------------
new.gi <- gi
anchorIds(new.gi) <- list(1:3, 5:7)
combined <- c(gi, new.gi)

## -----------------------------------------------------------------------------
combined <- swapAnchors(combined)

## -----------------------------------------------------------------------------
order(combined)
sorted <- sort(combined)
anchors(sorted, id=TRUE)

## -----------------------------------------------------------------------------
anchors(sorted, type="first")

## -----------------------------------------------------------------------------
doubled <- c(combined, combined)
duplicated(doubled)

## -----------------------------------------------------------------------------
anchorIds(new.gi) <- list(4:6, 1:3)
new.gi <- swapAnchors(new.gi)
swap.gi <- swapAnchors(gi)
match(new.gi, swap.gi)

## -----------------------------------------------------------------------------
new.gi==swap.gi

## -----------------------------------------------------------------------------
all.regions <- GRanges(rep(c("chrA", "chrB"), c(10, 5)), 
    IRanges(c(0:9*10+1, 0:4*5+1), c(1:10*10, 1:5*5)))
index.1 <- c(5, 15,  3, 12, 9, 10)
index.2 <- c(1,  5, 11, 13, 7,  4) 
gi <- GInteractions(index.1, index.2, all.regions)

## -----------------------------------------------------------------------------
pairdist(gi)

## -----------------------------------------------------------------------------
intrachr(gi)

## -----------------------------------------------------------------------------
of.interest <- GRanges("chrA", IRanges(30, 60))
olap <- findOverlaps(gi, of.interest)
olap

## -----------------------------------------------------------------------------
anchors(gi[queryHits(olap)])

## -----------------------------------------------------------------------------
paired.interest <- GInteractions(of.interest, GRanges("chrB", IRanges(10, 40)))
olap <- findOverlaps(gi, paired.interest)
olap

## -----------------------------------------------------------------------------
all.genes <- GRanges("chrA", IRanges(0:9*10, 1:10*10))
all.enhancers <- GRanges("chrB", IRanges(0:9*10, 1:10*10))
out <- linkOverlaps(gi, all.genes, all.enhancers)
head(out)

## -----------------------------------------------------------------------------
out <- linkOverlaps(gi, all.genes)
head(out)

## -----------------------------------------------------------------------------
all.chrs <- as.character(seqnames(regions(gi)))
group.by.chr <- paste0(all.chrs[anchors(gi, type="first", id=TRUE)], "+",
                       all.chrs[anchors(gi, type="second", id=TRUE)])

## -----------------------------------------------------------------------------
swap.gi <- swapAnchors(gi)                       
boundingBox(swap.gi, group.by.chr)

## -----------------------------------------------------------------------------
sgi <- GInteractions(index.1, index.2, all.regions, mode="strict")
class(sgi)

## -----------------------------------------------------------------------------
sgi <- as(gi, "StrictGInteractions") 

## -----------------------------------------------------------------------------
anchorIds(sgi) <- list(7:12, 1:6)
anchors(sgi, id=TRUE)

## -----------------------------------------------------------------------------
set.seed(1000)
Nlibs <- 4
counts <- matrix(rpois(Nlibs*length(gi), lambda=10), ncol=Nlibs)
lib.data <- DataFrame(lib.size=seq_len(Nlibs)*1e6)
iset <- InteractionSet(counts, gi, colData=lib.data)
iset

## -----------------------------------------------------------------------------
norm.freq <- matrix(rnorm(Nlibs*length(gi)), ncol=Nlibs)
iset2 <- InteractionSet(list(counts=counts, norm.freq=norm.freq), gi, colData=lib.data)
iset2

## -----------------------------------------------------------------------------
assay(iset)
assay(iset2, 2)

## -----------------------------------------------------------------------------
interactions(iset)

## -----------------------------------------------------------------------------
anchors(iset, id=TRUE) # easier than anchors(interactions(iset)), id=TRUE)
regions(iset)

## -----------------------------------------------------------------------------
lib.size <- seq_len(Nlibs) * 1e6
colData(iset)$lib.size <- lib.size
iset$lib.size <- lib.size # same result.

## -----------------------------------------------------------------------------
new.gi <- interactions(iset)
new.iset <- iset
interactions(new.iset) <- new.gi

## -----------------------------------------------------------------------------
regions(interactions(new.iset))$score <- 1
regions(new.iset)$score <- 1 # same as above.

## -----------------------------------------------------------------------------
iset[1:3,]
iset[,1:2]

## -----------------------------------------------------------------------------
rbind(iset, iset[1,])

## -----------------------------------------------------------------------------
cbind(iset, iset[,3])

## -----------------------------------------------------------------------------
row.indices <- 1:10
col.indices <- 9:15
row.regions <- all.regions[row.indices]
col.regions <- all.regions[col.indices]
Nr <- length(row.indices)
Nc <- length(col.indices)
counts <- matrix(rpois(Nr*Nc, lambda=10), Nr, Nc)
cm <- ContactMatrix(counts, row.regions, col.regions)

## -----------------------------------------------------------------------------
cm <- ContactMatrix(counts, row.indices, col.indices, all.regions)
cm

## -----------------------------------------------------------------------------
as.matrix(cm)

## -----------------------------------------------------------------------------
anchors(cm, type="row")

## -----------------------------------------------------------------------------
regions(cm)

## -----------------------------------------------------------------------------
temp.cm <- cm
as.matrix(temp.cm[1,1]) <- 0

## -----------------------------------------------------------------------------
anchorIds(temp.cm) <- list(1:10, 1:7)

## -----------------------------------------------------------------------------
regions(temp.cm)$GC <- runif(length(regions(temp.cm))) # not real values, obviously.
regions(temp.cm)

## -----------------------------------------------------------------------------
metadata(temp.cm)$description <- "I am a ContactMatrix"
metadata(temp.cm)

## -----------------------------------------------------------------------------
cm[1:5,]
cm[,1:5]

## -----------------------------------------------------------------------------
anchors(cm[,1:5], type="column", id=TRUE)

## -----------------------------------------------------------------------------
t(cm)

## -----------------------------------------------------------------------------
rbind(cm, cm[1:5,]) # extra rows
cbind(cm, cm[,1:5]) # extra columns

## -----------------------------------------------------------------------------
temp.cm <- cm
anchorIds(temp.cm) <- list(10:1, 15:9)
anchors(sort(temp.cm), id=TRUE)

## -----------------------------------------------------------------------------
order(temp.cm)

## -----------------------------------------------------------------------------
temp.cm <- rbind(cm, cm)
duplicated(temp.cm)
unique(temp.cm)

## -----------------------------------------------------------------------------
pairdist(cm)

## -----------------------------------------------------------------------------
intrachr(cm)

## -----------------------------------------------------------------------------
of.interest <- GRanges("chrA", IRanges(50, 100))
olap <- overlapsAny(cm, of.interest)
olap

## -----------------------------------------------------------------------------
and.mask <- outer(olap$row, olap$column, "&")
or.mask <- outer(olap$row, olap$column, "|")

## -----------------------------------------------------------------------------
my.matrix <- as.matrix(cm)
my.matrix[!and.mask] <- NA
my.matrix

## -----------------------------------------------------------------------------
olap <- overlapsAny(cm, GInteractions(of.interest, GRanges("chrB", IRanges(1, 20))))
olap

## -----------------------------------------------------------------------------
counts <- rpois(length(gi), lambda=10)
desired.rows <- 2:10
desired.cols <- 1:5
new.cm <- inflate(gi, desired.rows, desired.cols, fill=counts)
new.cm
anchors(new.cm, id=TRUE)
as.matrix(new.cm)

## -----------------------------------------------------------------------------
inflate(gi, GRanges("chrA", IRanges(50, 100)), GRanges("chrA", IRanges(10, 50)), fill=counts)

## -----------------------------------------------------------------------------
inflate(gi, "chrA", "chrB", fill=counts)

## -----------------------------------------------------------------------------
new.cm <- inflate(iset, desired.rows, desired.cols, sample=3)
as.matrix(new.cm)

## -----------------------------------------------------------------------------
new.iset <- deflate(cm)
new.iset

## -----------------------------------------------------------------------------
deflate(cm, collapse=FALSE)

## -----------------------------------------------------------------------------
x <- GRanges("chrA", IRanges(42, 48))
rse <- linearize(iset, x)
rse

## -----------------------------------------------------------------------------
rowRanges(rse)

## -----------------------------------------------------------------------------
sessionInfo()

