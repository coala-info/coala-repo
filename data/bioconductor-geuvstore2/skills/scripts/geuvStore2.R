# Code example from 'geuvStore2' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'---------------------------------
BiocStyle::markdown()

## ----lkone-----------------------------------------------------------------
suppressPackageStartupMessages(library(geuvStore2))
prst = makeGeuvStore2()
prst

## ----lktwo,cache=TRUE------------------------------------------------------
library(gQTLBase)
# prstore = ciseStore(prst, addProbeMap=TRUE, addRangeMap=TRUE)
prstore = makeGeuvStore2()
prstore

## ----lookup1---------------------------------------------------------------
head(
extractByProbes(prstore, 
   probeids=c("ENSG00000183814.10", "ENSG00000174827.9"))
)

## ----lookup2---------------------------------------------------------------
head(
extractByRanges(prstore, GRanges("1", IRanges(146000000, width=1e6)))
)

## ----doapp-----------------------------------------------------------------
lens = storeApply(prstore, length)
summary(unlist(lens))

## ----basecode,eval=FALSE---------------------------------------------------
#  library(geuvPack)
#  data(geuFPKM)
#  seqlevelsStyle(geuFPKM) = "NCBI"
#  library(GenomeInfoDb)
#  ok = which(seqnames(geuFPKM) %in% c(1:22, "X"))
#  geuFPKM = geuFPKM[ok,]
#  
#  library(gQTLBase)
#  #load("../INTERACTIVE/geuvExtractStore.rda")
#  #kpp = geuvExtractStore@probemap[,1]
#  data("kpp", package="geuvStore2")
#  geuFPKM  = geuFPKM[kpp,]
#  
#  library(gQTLBase)
#  featlist = balancedFeatList( geuFPKM[order(rowRanges(geuFPKM)),], max=6 )
#  lens = sapply(featlist,length)
#  featlist = featlist[ which(lens>0) ]
#  
#  library(BatchJobs)
#  regExtrP6 = makeRegistry("extractP6pop",  # tile/cis
#    packages=c("GenomicRanges", "gQTLstats", "geuvPack",
#               "Rsamtools", "VariantAnnotation"), seed=1234)
#  myf = function(i) {
#     if (!exists("geuFPKM")) data(geuFPKM)
#     seqlevelsStyle(geuFPKM) = "NCBI"
#     curse = geuFPKM[i,]
#     load("gsvs.rda")
#     svmat = gsvs$sv
#     colnames(svmat) = paste0("SV", 1:ncol(svmat))
#     colData(curse) = cbind(colData(curse), DataFrame(svmat))
#     fmla = as.formula(paste("~popcode+", paste0(colnames(svmat), collapse="+")))
#     curse = regressOut(curse, fmla)
#     pn = gtpath( paste0("chr", as.character(seqnames(curse)[1])) )
#     tf = TabixFile(pn)
#     cisAssoc( curse, tf, cisradius=1000000, nperm=6 )
#     }
#  batchMap(regExtrP6, myf, featlist )
#  submitJobs(regExtrP6, job.delay = function(n,i) runif(1,1,3))

