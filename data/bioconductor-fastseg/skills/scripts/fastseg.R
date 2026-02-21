# Code example from 'fastseg' vignette. See references/ for full tutorial.

## ----message=FALSE------------------------------------------------------------
library(fastseg)

## -----------------------------------------------------------------------------
data(coriell)
head(coriell)

samplenames <- colnames(coriell)[4:5]
data <- as.matrix(coriell[4:5])
#data[is.na(data)] <- median(data, na.rm=TRUE)
chrom <- coriell$Chromosome
maploc <- coriell$Position

## -----------------------------------------------------------------------------
library("GenomicRanges")

## with both individuals
gr <- GRanges(seqnames=chrom,
        ranges=IRanges(maploc, end=maploc))
mcols(gr) <- data
colnames(mcols(gr)) <- samplenames
res <- fastseg(gr)
head(res)

## with one individual
gr2 <- gr
data2 <- as.matrix(data[, 1])
colnames(data2) <- "sample1"
mcols(gr2) <- data2
res <- fastseg(gr2)
head(res)

## ----message=FALSE, eval=require(oligo)---------------------------------------
library("Biobase")
eSet <- Biobase::ExpressionSet()
assayData(eSet) <- list(intensity=data)

featureData(eSet) <- AnnotatedDataFrame(
        data=data.frame(
                chrom = paste("chr",chrom,sep=""),
                start = maploc, 
                end   = maploc,stringsAsFactors=FALSE))
phenoData(eSet) <- AnnotatedDataFrame(
        data=data.frame(samples=samplenames))
sampleNames(eSet) <- samplenames
res <- fastseg(eSet)
head(res)

## -----------------------------------------------------------------------------
data2 <- data[, 1]
res <- fastseg(data2)
head(res)

## -----------------------------------------------------------------------------
data2 <- data[1:400, ]
res <- fastseg(data2)
head(res)

## -----------------------------------------------------------------------------
## with both individuals
gr <- GRanges(seqnames=chrom,
        ranges=IRanges(maploc, end=maploc))
mcols(gr) <- data
colnames(mcols(gr)) <- samplenames
res <- fastseg(gr,segMedianT=0.2)

## -----------------------------------------------------------------------------
segPlot(gr,res, plot.type="w")

## ----fig.height=10, fig.width=10, message=FALSE-------------------------------
segPlot(gr, res, plot.type="s")

## -----------------------------------------------------------------------------
data(fastsegData)
system.time(res <- fastseg(fastsegData))

## -----------------------------------------------------------------------------
segPlot(fastsegData,res, plot.type="w")

## ----message=FALSE------------------------------------------------------------
library(DNAcopy)
cna <- DNAcopy::CNA(fastsegData,chrom="chr1",maploc=1:length(fastsegData))
system.time(res2 <- DNAcopy::segment(cna))

## -----------------------------------------------------------------------------
plot(res2, plot.type="w", xmaploc=TRUE)

## ----eval=FALSE---------------------------------------------------------------
# toBibtex(citation("fastseg"))

