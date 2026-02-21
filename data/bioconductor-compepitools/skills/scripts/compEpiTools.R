# Code example from 'compEpiTools' vignette. See references/ for full tutorial.

## ----options,echo=FALSE-----------------------------------------------
options(width=72)

## ----libs, message=FALSE, cache=TRUE, warning= FALSE------------------
library(compEpiTools)
require(TxDb.Mmusculus.UCSC.mm9.knownGene)
require(org.Mm.eg.db)
txdb <- TxDb.Mmusculus.UCSC.mm9.knownGene

## ----GRcounting,fig.width=6,fig.height=5,out.width='.85\\textwidth',message=FALSE,cache=TRUE----
bampath <- system.file("extdata", "ex1.bam", package="Rsamtools")
ir <- IRanges(start=c(1000, 100), end=c(2000, 1000))
gr <- GRanges(seqnames=Rle(c('seq1','seq2')), ranges=ir)
res <- GRbaseCoverage(Object=gr, bam=bampath)
GRcoverage(Object=gr, bam=bampath, Nnorm=FALSE, Snorm=FALSE)[1]
GRcoverageInbins(Object=gr, bam=bampath, Nnorm=FALSE, Snorm=FALSE, Nbins=5)[1,]
summit <- GRcoverageSummit(Object=gr, bam=bampath)
plot(res[[1]], type='l', xlab='bp', ylab='reads count')
abline(v=start(summit[1])-start(gr[1])+1, lty=2, lwd=2)

## ----GRann, message=FALSE,cache=TRUE----------------------------------
TSSpos <- TSS(txdb)
gr <- TSSpos[1:5]
start(gr) <- start(gr) - 1000
end(gr) <- end(gr) - 600
mcols(gr) <- NULL
# retrieving CGI mm9 islands from UCSC annotation tables
cgipath <- system.file("extdata", "CGIgr_mm9.Rdata", package="compEpiTools")
load(cgipath)
res <- GRannotate(Object=GRmidpoint(gr), txdb=txdb, EG2GS=org.Mm.eg.db, 
	upstream=2000, downstream=1000, userAnn=GRangesList(CGI=CGIgr_mm9))
show(res)

## ----GRheat1,fig.width=6,fig.height=9,out.width='.85\\textwidth',message=FALSE,cache=TRUE----
gr <- TSSpos[1:50]
start(gr) <- start(gr) - 1000
end(gr) <- end(gr) - 600
extgr <- GRanges(seqnames(gr), ranges=IRanges(start(gr) - 1000, end(gr) + 1000))
data <- heatmapData(grl=list(ChIPseq=gr), refgr=extgr, type='gr', nbins=20, txdb=txdb)
pvalues <- c(runif(20,1e-20,1e-8), runif(15,1e-4,1e-2), runif(15,0.5,1))
pvalues <- cbind(pvalues, rep(0, 50), rep(0, 50))
rownames(data[[1]][[1]]) <- paste(1:50, signif(pvalues[,1],1), sep=' # ')
heatmapPlot(matList=data[[1]], clusterInds=1:3)

## ----GRheat2,fig.width=6,fig.height=9,out.width='.85\\textwidth',message=FALSE,cache=TRUE----
heatmapPlot(matList=data[[1]], sigMat=pvalues, clusterInds=1:3)

## ----info,echo=TRUE---------------------------------------------------
sessionInfo()

