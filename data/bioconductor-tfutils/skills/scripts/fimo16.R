# Code example from 'fimo16' vignette. See references/ for full tutorial.

## ----lkfimo16-----------------------------------------------------------------
suppressPackageStartupMessages({
library(TFutils)
library(GenomicRanges)
})
fimo16

## ----lkimp--------------------------------------------------------------------
if (.Platform$OS.type != "windows") {
 si = TFutils::seqinfo_hg19_chr17
 myg = GRanges("chr17", IRanges(38.07e6,38.09e6), seqinfo=si)
 colnames(fimo16) = fimo16$HGNC 
 lk2 = GenomicFiles::reduceByRange(fimo16[, c("POU2F1", "VDR")],
   MAP=function(r,f) scanTabix(f, param=r))
 str(lk2)
}

## ----domult-------------------------------------------------------------------
#fimo_ranges = function(gf, query) { # prototypical code
# rowRanges(gf) = query
# ans = GenomicFiles::reduceByRange(gf, MAP=function(r,f) scanTabix(f, param=r))
# ans = unlist(ans, recursive=FALSE)  # drop top list structure
# tabs = lapply(ans, lapply, function(x) {
#     con = textConnection(x)
#     on.exit(close(con))
#     dtf = read.delim(con, h=FALSE, stringsAsFactors=FALSE, sep="\t")
#     colnames(dtf) = c("chr", "start", "end", "rname", "score", "dir", "pval")
#     ans = with(dtf, GRanges(seqnames=chr, IRanges(start, end),
#            rname=rname, score=score, dir=dir, pval=pval))
#     ans
#     })
# GRangesList(unlist(tabs, recursive=FALSE))
#}
if (.Platform$OS.type != "windows") {
 rr = fimo_granges(fimo16[, c("POU2F1", "VDR")], myg)
 rr
}

## ----sesss--------------------------------------------------------------------
sessionInfo()

