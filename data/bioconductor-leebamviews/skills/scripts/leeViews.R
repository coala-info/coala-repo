# Code example from 'leeViews' vignette. See references/ for full tutorial.

### R code from vignette source 'leeViews.Rnw'

###################################################
### code chunk number 1: lkd
###################################################
suppressPackageStartupMessages({
library(leeBamViews)  # bam files stored in package
library(S4Vectors)
})
bpaths = dir(system.file("bam", package="leeBamViews"), full=TRUE, patt="bam$")
#
# extract genotype and lane information from filenames
#
gt = gsub(".*/", "", bpaths)
gt = gsub("_.*", "", gt)
lane = gsub(".*(.)$", "\\1", gt)
geno = gsub(".$", "", gt)
#
# format the sample-level information appropriately
#
pd = DataFrame(geno=geno, lane=lane, row.names=paste(geno,lane,sep="."))
prd = new("DFrame")  # protocol data could go here
#
# create the views object, adding some arbitrary experiment-level information
#
bs1 = BamViews(bamPaths=bpaths, bamSamples=pd, 
        bamExperiment=list(annotation="org.Sc.sgd.db"))
bs1
#
# get some sample-level data
#
bamSamples(bs1)$geno


###################################################
### code chunk number 2: lkc
###################################################
START=c(861250, 863000)
END=c(862750, 864000)
exc = GRanges(seqnames="Scchr13", IRanges(start=START, end=END), strand="+")
bamRanges(bs1) = exc
bs1


###################################################
### code chunk number 3: lkcov
###################################################
library(GenomicAlignments)
covex =
  RleList(lapply(bamPaths(bs1), function(x)
                 coverage(readGAlignments(x))[["Scchr13"]]))
names(covex) = gsub(".bam$", "", basename(bamPaths(bs1)))
head(covex, 3)


###################################################
### code chunk number 4: addso (eval = FALSE)
###################################################
## library(GenomeGraphs)
## cov2baseTrack = function(rle, start, end,
##    dp = DisplayPars(type="l", lwd=0.5, color="black"),
##    countTx=function(x)log10(x+1)) {
##  require(GenomeGraphs)
##  if (!is(rle, "Rle")) stop("requires instance of Rle")
##  dat = runValue(rle)
##  loc = cumsum(runLength(rle))
##  ok = which(loc >= start & loc <= end)
##  makeBaseTrack(base = loc[ok], value=countTx(dat[ok]),
##     dp=dp)
## }
## trs = lapply(covex, function(x) cov2baseTrack(x, START[1], END[1],
##    countTx = function(x)pmin(x, 80)))
## ac = as.character
## names(trs) = paste(ac(bamSamples(bs1)$geno), ac(bamSamples(bs1)$lane), sep="")
## library(biomaRt)
## mart = useMart("ensembl", "scerevisiae_gene_ensembl")
## gr = makeGeneRegion(START, END, chromosome="XIII",
##   strand="+", biomart=mart, dp=DisplayPars(plotId=TRUE,
##   idRotation=0, idColor="black"))
## trs[[length(trs)+1]] = gr
## trs[[length(trs)+1]] = makeGenomeAxis()


###################################################
### code chunk number 5: lkf (eval = FALSE)
###################################################
## print( gdPlot( trs, minBase=START[1], maxBase=END[1]) )


###################################################
### code chunk number 6: mkps (eval = FALSE)
###################################################
## plotStrains = function(bs, query, start, end, snames, mart, chr, strand="+") {
##  filtbs = bs[query, ]
##  cov = lapply(filtbs, coverage)
##  covtrs = lapply(cov, function(x) cov2baseTrack(x[[1]], start, end,
##    countTx = function(x) pmin(x,80)))
##  names(covtrs) = snames
##  gr = makeGeneRegion(start, end, chromosome=chr,
##        strand=strand, biomart=mart, dp=DisplayPars(plotId=TRUE,
##        idRotation=0, idColor="black"))
##  grm = makeGeneRegion(start, end, chromosome=chr,
##        strand="-", biomart=mart, dp=DisplayPars(plotId=TRUE,
##        idRotation=0, idColor="black"))
##  covtrs[[length(covtrs)+1]] = gr
##  covtrs[[length(covtrs)+1]] = makeGenomeAxis()
##  covtrs[[length(covtrs)+1]] = grm
##  gdPlot( covtrs, minBase=start, maxBase=end )
## }


###################################################
### code chunk number 7: lkda (eval = FALSE)
###################################################
## data(leeUnn)
## names(leeUnn)
## leeUnn[1:4,1:8]
## table(leeUnn$study)
## l13 = leeUnn[ leeUnn$chr == 13, ]
## l13d = na.omit(l13[ l13$study == "David", ])
## d13r = GRanges(seqnames="Scchr13", IRanges( l13d$start, l13d$end ),
##   strand=ifelse(l13d$strand==1, "+", ifelse(l13d$strand=="0", "*", "-")))
## elementMetadata(d13r)$name = paste("dav13x", 1:length(d13r), sep=".")
## bamRanges(bs1) = d13r
## d13tab = tabulateReads( bs1 )


###################################################
### code chunk number 8: makn
###################################################
myrn = GRanges(seqnames="Scchr13",
  IRanges(start=seq(861250, 862750, 100), width=100), strand="+")
elementMetadata(myrn)$name = paste("til", 1:length(myrn), sep=".")
bamRanges(bs1) = myrn
tabulateReads(bs1, "+")


###################################################
### code chunk number 9: ddee
###################################################
library(org.Sc.sgd.db)
library(IRanges)
c13g = get("13", revmap(org.Sc.sgdCHR))  # all genes on chr13
c13loc = unlist(mget(c13g, org.Sc.sgdCHRLOC))  # their 'start' addresses
c13locend = unlist(mget(c13g, org.Sc.sgdCHRLOCEND))
c13locp = c13loc[c13loc>0]     # confine attention to + strand
c13locendp = c13locend[c13locend>0]
ok = !is.na(c13locp) & !is.na(c13locendp)
c13pr = GRanges(seqnames="Scchr13", IRanges(c13locp[ok], c13locendp[ok]),
    strand="+")   # store and clean up names
elementMetadata(c13pr)$name = gsub(".13$", "", names(c13locp[ok]))
c13pr
c13pro = c13pr[ order(ranges(c13pr)), ]


###################################################
### code chunk number 10: dolim
###################################################
lim = GRanges(seqnames="Scchr13", IRanges(800000,900000), strand="+")
c13prol = c13pro[ which(overlapsAny(c13pro , lim) ), ]


###################################################
### code chunk number 11: getm
###################################################
bamRanges(bs1) = c13prol
annotab = tabulateReads(bs1, strandmarker="+")


###################################################
### code chunk number 12: gettot
###################################################
totcnts = totalReadCounts(bs1)


###################################################
### code chunk number 13: lkedd
###################################################
library(edgeR)
#
# construct an edgeR container for read counts, including 
#   genotype and region (gene) metadata
#
dgel1 = DGEList( counts=t(annotab)[,-c(1,2)], 
   group=factor(bamSamples(bs1)$geno),
   lib.size=totcnts, genes=colnames(annotab))
#
# compute a dispersion factor for the negative binomial model
#
cd = estimateCommonDisp(dgel1)
#
# test for differential expression between two groups
# for each region
#
et12 = exactTest(cd)
#
# display statistics for the comparison
#
tt12 = topTags(et12)
tt12


###################################################
### code chunk number 14: lkma
###################################################
plotSmear(cd, cex=.8, ylim=c(-5,5))
text(tt12$table$logCPM, tt12$table$logFC+.15, as.character(
  tt12$table$genes), cex=.65)


###################################################
### code chunk number 15: lks
###################################################
sessionInfo()


