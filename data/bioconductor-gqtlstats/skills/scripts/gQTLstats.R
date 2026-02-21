# Code example from 'gQTLstats' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'-------------------------------
BiocStyle::markdown()

## ----setup,echo=FALSE----------------------------------------------------
suppressPackageStartupMessages({
library(SummarizedExperiment)
library(Homo.sapiens)
library(org.Hs.eg.db)
library(geuvStore2)
library(gQTLBase)
library(gQTLstats)
})

## ----contset-------------------------------------------------------------
library(geuvStore2)
library(gQTLBase)
library(gQTLstats)
library(parallel)
nco = detectCores()
library(doParallel)
registerDoSEQ()
if (.Platform$OS.type != "windows") {
  registerDoParallel(cores=max(c(1, floor(nco/2))))
}
prst = makeGeuvStore2() 

## ----getqs, cache=TRUE---------------------------------------------------
qassoc = storeToQuantiles(prst, field="chisq",
    probs=c(seq(0,.999,.001), 1-(c(1e-4,1e-5,1e-6))))
tail(qassoc)

## ----gethist, cache=TRUE-------------------------------------------------
hh = storeToHist( prst, breaks= c(0,qassoc,1e9) )
tail(hh$counts)

## ----twoFDRs, cache=TRUE-------------------------------------------------
rawFDR = storeToFDR(prst, 
   xprobs=c(seq(.05,.95,.05),.975,.990,.995,.9975,.999, 
   .9995, .9999, .99999) )

## ----makefilt------------------------------------------------------------
dmfilt = function(x)  # define the filtering function
     x[ which(x$MAF >= 0.05 & x$mindist <= 500000) ] 

## ----runfilt, cache=TRUE-------------------------------------------------
filtFDR = storeToFDR(prst, 
   xprobs=c(seq(.05,.95,.05),.975,.990,.995,.9975,.999, 
   .9995, .9999, .99999), filter = dmfilt )

## ----lktails-------------------------------------------------------------
rawFDR
filtFDR

## ----showfd2, plot=TRUE--------------------------------------------------
rawtab = getTab(rawFDR)
filttab = getTab(filtFDR)
 plot(rawtab[-(1:10),"assoc"], 
      -log10(rawtab[-(1:10),"fdr"]+1e-6), log="x", axes=FALSE,
  xlab="Observed association", ylab="-log10 plugin FDR")
 axis(1, at=c(seq(0,10,1),100,200))
 axis(2)
 points(filttab[-(1:10),1], -log10(filttab[-(1:10),2]+1e-6), pch=2)
 legend(1, 5, pch=c(1,2), legend=c("all loci", "MAF >= 0.05 & dist <= 500k"))

## ----shobfu,cache=FALSE,eval=FALSE---------------------------------------
#  fdbp = storeToFDRByProbe( prst, xprobs=c(seq(.025,.975,.025),.99))
#  tail(getTab(fdbp),5)

## ----shobpf,cache=FALSE,eval=FALSE---------------------------------------
#  fdAtM05bp = storeToFDRByProbe( prst, filter=function(x) x[which(x$MAF > .05)],
#     xprobs=c(seq(.025,.975,.025),.99))
#  tail(getTab(fdAtM05bp),5)

## ----lkgam,fig=TRUE------------------------------------------------------
library(mgcv)
rawFDR = setFDRfunc(rawFDR)
filtFDR = setFDRfunc(filtFDR)
par(mfrow=c(2,2))
txsPlot(rawFDR)
txsPlot(filtFDR)
directPlot(rawFDR)
directPlot(filtFDR)

## ----doenums,cache=TRUE--------------------------------------------------
rawEnum = enumerateByFDR(prst, rawFDR, threshold=.05) 
rawEnum[order(rawEnum$chisq,decreasing=TRUE)[1:3]]
length(rawEnum)

## ----lkmd----------------------------------------------------------------
names(metadata(rawEnum))

## ----dofenum,cache=TRUE--------------------------------------------------
filtEnum = enumerateByFDR(prst, filtFDR, threshold=.05,
   filter=dmfilt) 
filtEnum[order(filtEnum$chisq,decreasing=TRUE)[1:3]]
length(filtEnum)

## ----dosens,fig=TRUE-----------------------------------------------------
data(sensByProbe) # see example(senstab) for construction approach
tab = senstab( sensByProbe )
plot(tab)

## ----counts,cache=TRUE---------------------------------------------------
flens = storeApply( prst, function(x) {
    length(x[ which(x$MAF >= .08 & x$mindist <= 25000), ] )
})

## ----lklen---------------------------------------------------------------
sum(unlist(flens))

## ----bindback------------------------------------------------------------
library(geuvPack)
data(geuFPKM)
basic = mcols(rowRanges(geuFPKM))[, c("gene_id", "gene_status", "gene_type",
    "gene_name")]
rownames(basic) = basic$gene_id
extr = basic[ filtEnum$probeid, ]
mcols(filtEnum) = cbind(mcols(filtEnum), extr)
stopifnot(all.equal(filtEnum$probeid, filtEnum$gene_id))
filtEnum[1:3]

## ----lkscores,fig=TRUE---------------------------------------------------
data(hmm878)
library(geuvStore2)
prst = makeGeuvStore2() 
myg = "ENSG00000183814.10" # LIN9
data(filtFDR)
library(ggplot2)
manhWngr( store = prst, probeid = myg, sym="LIN9",
  fdrsupp=filtFDR, namedGR=hmm878 )

## ----dovaranno,cache=TRUE------------------------------------------------
suppressPackageStartupMessages({
library(VariantAnnotation)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
})
txdb = TxDb.Hsapiens.UCSC.hg19.knownGene
seqlevelsStyle(filtEnum) = "UCSC"
#seqinfo(filtEnum) = seqinfo(txdb)
seqlengths(filtEnum)[paste0("chr", c(1:22,"M"))] = 
 seqlengths(txdb)[paste0("chr", c(1:22,"M"))]
filtEnum = keepStandardChromosomes(filtEnum) 
suppressWarnings({
allv = locateVariants(filtEnum, txdb, AllVariants()) # multiple recs per eQTL 
})
table(allv$LOCATION)
hits = findOverlaps( filtEnum, allv )
filtEex = filtEnum[ queryHits(hits) ]
mcols(filtEex) = cbind(mcols(filtEex), mcols(allv[subjectHits(hits)])[,1:7])
filtEex[1:3]

## ----lkall---------------------------------------------------------------
args(AllAssoc)

## ----demoit--------------------------------------------------------------
require(GenomeInfoDb)
require(geuvPack)
require(Rsamtools)
data(geuFPKM)  # get a ranged summarized expt
lgeu = geuFPKM[ which(seqnames(geuFPKM)=="chr20"), ] # limit to chr20
seqlevelsStyle(lgeu) = "NCBI"
tf20 = TabixFile(system.file("vcf/c20exch.vcf.gz", package="gQTLstats"))
if (require(VariantAnnotation)) scanVcfHeader(tf20)
set.seed(1234)
mysr = GRanges("20", IRanges(33.099e6, 33.52e6))
lita = AllAssoc(geuFPKM[1:10,], tf20, mysr)
names(mcols(lita))

## ----dem2----------------------------------------------------------------
litb = AllAssoc(geuFPKM[11:20,], tf20, mysr)
litc = AllAssoc(geuFPKM[21:30,], tf20, mysr)

## ----docoll--------------------------------------------------------------
buf = gQTLstats:::collapseToBuf(lita, litb, frag="_obs")
buf
buf = gQTLstats:::collapseToBuf(buf, litc, frag="_obs")
buf

## ----doperm--------------------------------------------------------------
pbuf = gQTLstats:::collapseToBuf(lita, litb, frag="_permScore_1")
pbuf = gQTLstats:::collapseToBuf(pbuf, litc, frag="_permScore_1")
pbuf

## ----dof,fig=TRUE--------------------------------------------------------
plot(density(buf$scorebuf[,1]))
lines(density(pbuf$scorebuf[,1]), lty=2)

