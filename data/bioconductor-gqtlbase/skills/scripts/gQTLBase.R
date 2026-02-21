# Code example from 'gQTLBase' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'-------------------------------
BiocStyle::markdown()

## ----lktt,echo=FALSE-----------------------------------------------------
litt = structure(c(15280L, 4853L, 1450L, 1153L, 476L, 114L), .Dim = 6L, .Dimnames = structure(list(
    c("protein_coding", "pseudogene", "antisense", "lincRNA", 
    "processed_transcript", "IG_V_gene")), .Names = "")
)
litt

## ----eval=FALSE----------------------------------------------------------
#  gettests = function( chunk, useS3=FALSE ) {
#    library(VariantAnnotation)
#    snpsp = gtpath( chunk$chr, useS3=useS3)
#    tf = TabixFile( snpsp )
#    library(geuvPack)
#    if (!exists("geuFPKM")) data(geuFPKM)
#    clipped = clipPCs(regressOut(geuFPKM, ~popcode), 1:10)
#    set.seed(54321)
#    ans = cisAssoc( clipped[ chunk$genes, ], tf, cisradius=1000000, lbmaf=0.01 )
#    metadata(ans)$prepString = "clipPCs(regressOut(geuFPKM, ~popcode), 1:10)"
#    ans
#    }

## ----bjreg,eval=FALSE----------------------------------------------------
#  flatReg = makeRegistry("flatReg",  file.dir="flatStore",
#          seed=123, packages=c("GenomicRanges",
#              "GGtools", "VariantAnnotation", "Rsamtools",
#              "geuvPack", "GenomeInfoDb"))

## ----dosub,eval=FALSE----------------------------------------------------
#  batchMap(flatReg, gettests, flatlist)
#  submitJobs(flatReg)

## ----getstuff,results="hide", echo=FALSE---------------------------------
suppressPackageStartupMessages({
library(BiocGenerics)
library(Homo.sapiens)
library(stats4)
library(IRanges)
library(GGtools)
library(gQTLBase)
library(geuvStore2)
options(BBmisc.ProgressBar.style="off")
})

## ----doone---------------------------------------------------------------
library(gQTLBase)
library(geuvStore2)
mm = makeGeuvStore2()
mm

## ----getr----------------------------------------------------------------
loadResult(mm@reg, 1)[1:3]

## ----setuplen------------------------------------------------------------
library(BiocParallel)
library(parallel)
mp = MulticoreParam(workers=max(c(1, detectCores()-4)))
register(mp)

## ----getlen, cache=TRUE--------------------------------------------------
lens = storeApply(mm, length)
summary(unlist(lens))

## ----doex,cache=TRUE-----------------------------------------------------
pvec = mm@probemap[1:4,1]  # don't want API for map, just getting examples
litex = extractByProbes( mm, pvec )
length(litex)
litex[1:3]

## ----getfff--------------------------------------------------------------
allassoc = storeToFf(mm, "chisq")
length(allassoc)
object.size(allassoc)
allassoc[1:4]

