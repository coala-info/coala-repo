# Code example from 'Workflow' vignette. See references/ for full tutorial.

## ----setup, message=FALSE, warning=FALSE--------------------------------------
library(chipseq) 
library(GenomicFeatures) 
library(lattice)

## ----preprocess, eval=FALSE---------------------------------------------------
# qa_list <- lapply(sampleFiles, qa)
# report(do.call(rbind, qa_list))
# ## spend some time evaluating the QA report, then procede
# filter <- compose(chipseqFilter(), alignQualityFilter(15))
# cstest <- GenomicRangesList(lapply(sampleFiles, function(file) {
#   as(readAligned(file, filter), "GRanges")
# }))
# cstest <- cstest[seqnames(cstest) %in% c("chr10", "chr11", "chr12")]

## -----------------------------------------------------------------------------
data(cstest)
cstest 

## ----convert-cstest, echo=FALSE, eval=FALSE-----------------------------------
# ## code used to convert the GenomeDataList to a GRangesList
# cstest <- GenomicRangesList(lapply(cstest, function(gd)
#   do.call(c, lapply(names(gd), function(chr)
#     pos <- gd[[chr]]
#     starts <- c( pos[["-"]] - 23L, pos[["+"]])
#     GRanges(chr, IRanges(starts, width = 24),
#            rep(c("-", "+"), elementNROWS(pos))) ))
# ))

## -----------------------------------------------------------------------------
cstest$ctcf

## ----estimate.mean.fraglen----------------------------------------------------
fraglen <- estimate.mean.fraglen(cstest$ctcf, method="correlation")
fraglen[!is.na(fraglen)] 

## -----------------------------------------------------------------------------
ctcf.ext <- resize (cstest$ctcf, width = 200)
ctcf.ext

## -----------------------------------------------------------------------------
cov.ctcf <- coverage(ctcf.ext)
cov.ctcf

## -----------------------------------------------------------------------------
islands <- slice(cov.ctcf, lower = 1)
islands

## -----------------------------------------------------------------------------
viewSums(islands)
viewMaxs(islands)

nread.tab <- table(viewSums(islands) / 200)
depth.tab <- table(viewMaxs(islands))

nread.tab[,1:10]
depth.tab[,1:10]

## -----------------------------------------------------------------------------
islandReadSummary <- function(x)
{
    g <- resize(x, 200)
    s <- slice(coverage(g), lower = 1)
    tab <- table(viewSums(s) / 200)
    df <- DataFrame(tab)
    colnames(df) <- c("chromosome", "nread", "count")
    df$nread <- as.integer(df$nread)
    df
}

## -----------------------------------------------------------------------------
head(islandReadSummary(cstest$ctcf)) 

## -----------------------------------------------------------------------------
nread.islands <- DataFrameList(lapply(cstest, islandReadSummary)) 
nread.islands <- stack(nread.islands, "sample") 
nread.islands 

## ----fig.height=10------------------------------------------------------------
xyplot(log(count) ~  nread | sample, as.data.frame(nread.islands),
       subset = (chromosome == "chr10" & nread <= 40), 
       layout = c(1, 2), pch = 16, type = c("p", "g"))

## ----fig.height=8-------------------------------------------------------------
xyplot(log(count) ~ nread | sample, data = as.data.frame(nread.islands), 
       subset = (chromosome == "chr10" & nread <= 40), 
       layout = c(1, 2), pch = 16, type = c("p", "g"), 
       panel = function(x, y, ...) {
           panel.lmline(x[1:2], y[1:2], col = "black")
           panel.xyplot(x, y, ...)
       })

## -----------------------------------------------------------------------------
islandDepthSummary <- function(x) 
{
  g <- resize(x, 200) 
  s <- slice(coverage(g), lower = 1) 
  tab <- table(viewMaxs(s) / 200) 
  df <- DataFrame(tab) 
  colnames(df) <- c("chromosome", "depth", "count")
  df$depth <- as.integer(df$depth) 
  df
} 

depth.islands <- DataFrameList(lapply(cstest, islandDepthSummary))
depth.islands <- stack(depth.islands, "sample")

plt <- xyplot(log(count) ~ depth | sample, as.data.frame(depth.islands),
       subset = (chromosome == "chr10" & depth <= 20), 
       layout = c(1, 2), pch = 16, type = c("p", "g"), 
       panel = function(x, y, ...){
           lambda <- 2 * exp(y[2]) / exp(y[1]) 
           null.est <- function(xx) {
               xx * log(lambda) - lambda - lgamma(xx + 1)
           } 
           log.N.hat <- null.est(1) - y[1]
           panel.lines(1:10, -log.N.hat + null.est(1:10), col = "black")
           panel.xyplot(x, y, ...)
       })

## depth.islands <- summarizeReads(cstest, summary.fun = islandDepthSummary)

## ----fig.height=10, echo=FALSE------------------------------------------------
plt

## ----islandDepthPlot, eval=FALSE----------------------------------------------
# islandDepthPlot(cov.ctcf)

## ----peakCutoff---------------------------------------------------------------
peakCutoff(cov.ctcf, fdr = 0.0001) 

## -----------------------------------------------------------------------------
peaks.ctcf <- slice(cov.ctcf, lower = 8) 
peaks.ctcf 

## ----peakSummary--------------------------------------------------------------
peaks <- peakSummary(peaks.ctcf) 

## -----------------------------------------------------------------------------
peak.depths <- viewMaxs(peaks.ctcf)

cov.pos <- coverage(ctcf.ext[strand(ctcf.ext) == "+"]) 
cov.neg <- coverage(ctcf.ext[strand(ctcf.ext) == "-"])

peaks.pos <- Views(cov.pos, ranges(peaks.ctcf)) 
peaks.neg <- Views(cov.neg, ranges(peaks.ctcf))

wpeaks <- tail(order(peak.depths$chr10), 4)
wpeaks

## ----fig.height=5-------------------------------------------------------------
coverageplot(peaks.pos$chr10[wpeaks[1]], peaks.neg$chr10[wpeaks[1]])

## ----fig.height=5-------------------------------------------------------------
coverageplot(peaks.pos$chr10[wpeaks[2]], peaks.neg$chr10[wpeaks[2]])

## ----fig.height=5-------------------------------------------------------------
coverageplot(peaks.pos$chr10[wpeaks[3]], peaks.neg$chr10[wpeaks[3]])

## ----fig.height=5-------------------------------------------------------------
coverageplot(peaks.pos$chr10[wpeaks[4]], peaks.neg$chr10[wpeaks[4]])

## -----------------------------------------------------------------------------
## find peaks for GFP control
cov.gfp <- coverage(resize(cstest$gfp, 200))
peaks.gfp <- slice(cov.gfp, lower = 8)

peakSummary <- diffPeakSummary(peaks.gfp, peaks.ctcf)

plt <- xyplot(asinh(sums2) ~ asinh(sums1) | seqnames,
       data = as.data.frame(peakSummary), 
       panel = function(x, y, ...) {
           panel.xyplot(x, y, ...)
           panel.abline(median(y - x), 1)
       },
       type = c("p", "g"), alpha = 0.5, aspect = "iso")

## ----fig.height=5, echo=FALSE-------------------------------------------------
plt

## -----------------------------------------------------------------------------
mcols(peakSummary) <- 
    within(mcols(peakSummary), 
       {
           diffs <- asinh(sums2) - asinh(sums1) 
           resids <- (diffs - median(diffs)) / mad(diffs) 
           up <- resids > 2 
           down <- resids < -2 
           change <- ifelse(up, "up", ifelse(down, "down", "flat")) 
       })

## -----------------------------------------------------------------------------
library(TxDb.Mmusculus.UCSC.mm9.knownGene) 
gregions <- transcripts(TxDb.Mmusculus.UCSC.mm9.knownGene) 
gregions 

## -----------------------------------------------------------------------------
promoters <- flank(gregions, 1000, both = TRUE) 

## -----------------------------------------------------------------------------
peakSummary$inPromoter <- peakSummary %over% promoters
xtabs(~ inPromoter + change, peakSummary) 

## -----------------------------------------------------------------------------
peakSummary$inUpstream <- peakSummary %over% flank(gregions, 20000)
peakSummary$inGene <- peakSummary %over% gregions

## -----------------------------------------------------------------------------
sumtab <- 
    as.data.frame(rbind(total = xtabs(~ change, peakSummary),
                        promoter = xtabs(~ change, 
                          subset(peakSummary, inPromoter)),
                        upstream = xtabs(~ change, 
                          subset(peakSummary, inUpstream)),
                        gene = xtabs(~ change, subset(peakSummary, inGene))))
## cbind(sumtab, ratio = round(sumtab[, "down"] /  sumtab[, "up"], 3))

## ----rtracklayer-upload, eval=FALSE-------------------------------------------
# library(rtracklayer)
# session <- browserSession()
# genome(session) <- "mm9"
# session$gfpCov <- cov.gfp
# session$gfpPeaks <- peaks.gfp
# session$ctcfCov <- cov.ctcf
# session$ctcfPeaks <- peaks.ctcf

## ----rtracklayer-view, eval=FALSE---------------------------------------------
# peak.ord <- order(unlist(peak.depths), decreasing=TRUE)
# peak.sort <- as(peaks.ctcf, "GRanges")[peak.ord]
# view <- browserView(session, peak.sort[1], full = c("gfpCov", "ctcfCov"))

## ----tracklayer-view-5, eval=FALSE--------------------------------------------
# views <- browserView(session, head(peak.sort, 5), full = c("gfpCov", "ctcfCov"))

## -----------------------------------------------------------------------------
sessionInfo() 

