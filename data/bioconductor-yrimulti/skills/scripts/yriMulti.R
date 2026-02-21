# Code example from 'yriMulti' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'---------------------------------
suppressMessages({
suppressWarnings({
suppressPackageStartupMessages({
BiocStyle::markdown()
})
})
})

## ----bib, echo = FALSE, results = 'hide'-----------------------------------
suppressMessages({
suppressWarnings({
suppressPackageStartupMessages({
library(knitcitations)
library(bibtex)
library(yriMulti)
library(dsQTL)
library(geuvPack)
library(erma)
library(VariantAnnotation)
library(gQTLstats)
library(Homo.sapiens)
})
})
})
allbib = read.bibtex("allbib.bib")

## ----fakeload1,echo=FALSE,results="hide"-----------------------------------
if (!exists("geuFPKM")) data(geuFPKM)

## ----lkexpr,eval=TRUE------------------------------------------------------
library(geuvPack)
data(geuFPKM)

## ----do1-------------------------------------------------------------------
geuFPKM

## ----fakeload2,echo=FALSE,results="hide"-----------------------------------
if (!exists("banovichSE")) data(banovichSE)

## ----lkmul,eval=TRUE-------------------------------------------------------
library(yriMulti)
data(banovichSE)

## ----do2-------------------------------------------------------------------
banovichSE

## ----lkdhsf,echo=FALSE,results="hide"--------------------------------------
if (!exists("DHStop5_hg19")) data(DHStop5_hg19)

## ----lkdhs,eval=TRUE-------------------------------------------------------
library(dsQTL)
if (!exists("DHStop5_hg19")) data(DHStop5_hg19)

## ----lkddd-----------------------------------------------------------------
DHStop5_hg19

## ----lkgeno,cache=TRUE-----------------------------------------------------
litvcf = readVcf(gtpath(20), 
      param=ScanVcfParam(which=GRanges("20", 
           IRanges(3.7e7,3.701e7))), genome="hg19")

## ----outca-----------------------------------------------------------------
litvcf
length(colnames(litvcf))
length(intersect(colnames(litvcf), colnames(banovichSE)))
length(intersect(colnames(litvcf), colnames(geuFPKM)))
length(intersect(colnames(litvcf), colnames(DHStop5_hg19)))

## ----lkmex,cache=TRUE------------------------------------------------------
m1 = mexGR(banovichSE, geuFPKM, symbol="ORMDL3")
m1
mcols(m1)[1:4,1:4]
table(mcols(m1)$type)

## ----lkbi,cache=TRUE-------------------------------------------------------
b1 = bindelms(geuFPKM, banovichSE, symbol="BRCA2", ytx=log,
   gradius=20000)
b1
mcols(b1)[1:3,]
summary(mcols(b1)$t)
mintind = which.min(mcols(b1)$t)
mincpg = names(b1)[mintind]
mincpg

## ----lkevm,fig=TRUE--------------------------------------------------------
plotEvM(b1)

## ----lkbcma, eval=TRUE-----------------------------------------------------
library(MultiAssayExperiment)
myobs = list(geuvRNAseq=geuFPKM, yri450k=banovichSE, yriDHS=DHStop5_hg19)
cold = colData(geuFPKM)
suppressWarnings({
library(MultiAssayExperiment)
mm = MultiAssayExperiment(myobs, as.data.frame(cold))
})
mm

## ----lkbrc, eval=TRUE------------------------------------------------------
library(erma)
brr = range(genemodel("BRCA2"))
brr

## ----dorsub, eval=TRUE-----------------------------------------------------
.subsetByRanges = function(ma, r) {
  subsetByRow(ma,r)
}
newmm = .subsetByRanges(mm, brr+20000)
newmm

## ----makeco----------------------------------------------------------------
library(doParallel)
registerDoSEQ()
allLM_pw = function(fmla, mae, xtx=force, ytx=force) {
#
# formula specifies dependent and independent assays
# form all regressions of ytx(dep) on xtx(indep) for all
# pairs of dependent and independent variables defined by
# assays for samples held in common
#
lf = as.list(fmla)
nms = lapply(lf, as.character)
yel = experiments(mae)[[nms[[2]]]]
xel = experiments(mae)[[nms[[3]]]]
sy = colnames(yel)
sx = colnames(xel)
sb = intersect(sy,sx)
yel = yel[,sb]
xel = xel[,sb]
vdf = as.matrix(expand.grid( rownames(yel),
    rownames(xel), stringsAsFactors=FALSE ))
allf = apply(vdf, 1, function(x) as.formula(paste(x, collapse="~")))
alllm = foreach (i = 1:length(allf)) %dopar% {
  df = data.frame(ytx(assay(yel)[vdf[i,1],]), xtx(assay(xel)[vdf[i,2],]))
  names(df) = vdf[i,]
  lm(allf[[i]], data=df)
  }
names(alllm) = apply(vdf,1,function(x) paste(x, collapse="~"))
allts = lapply(alllm, function(x) summary(x)$coef[2, "t value"])
list(mods=alllm, tslopes=allts)
}
pwplot = function(fmla1, fmla2, mae, ytx=force, xtx=force, ...) {
#
# use fmla1 with assays as components to identify
#    two assays to regard as sources of y and x
# fmla2 indicates which features to plot
#
lf = as.list(fmla1)
nms = lapply(lf, as.character)
yel = experiments(mae)[[nms[[2]]]]
xel = experiments(mae)[[nms[[3]]]]
sy = colnames(yel)
sx = colnames(xel)
sb = intersect(sy,sx)
yel = yel[,sb]
xel = xel[,sb]
lf2 = lapply(as.list(fmla2), as.character)
ndf = data.frame( ytx(assay(yel)[ lf2[[2]], ]), xtx(assay(xel)[ lf2[[3]], ]) )
names(ndf) = c(lf2[[2]], lf2[[3]])
plot(fmla2, ndf, ...)
}


## ----lkpwl, eval=TRUE------------------------------------------------------
pp = allLM_pw(geuvRNAseq~yri450k, newmm, ytx=log) 
names(pp)
summary(pp[[1]][[1]])
which.min(unlist(pp[[2]])) # not BRCA2 but FRY

## ----lkf,fig=TRUE, eval=TRUE-----------------------------------------------
pwplot(geuvRNAseq~yri450k, ENSG00000139618.9~cg20073910, newmm, ytx=log)

## ----redoVcfStackFunc,echo=FALSE,results="hide"----------------------------
VcfStack2 <- function(files=NULL, seqinfo=NULL, colData=NULL)
{
    if (is.null(files)) {
        files <- VcfFileList()
        header <- NULL
    } else {
        if (class(files) != "VcfFileList")
            files = VcfFileList(files)
#        files = indexVcf(files)
        header <- scanVcfHeader(files[[1]])
    
    }   

    if (is.null(seqinfo)) {
        seqinfo <- if (length(files)) {
            seqinfo(files)
        } else Seqinfo()
    }   

    if (is.null(colData) && length(files)) {
        colData <- DataFrame(row.names=samples(header))
    } else {
        colData <- as(colData, "DataFrame")
    }   

    if (is.null(rownames(colData)) && length(files))
         stop("specify rownames in 'colData'")

    new("VcfStack", files=files, colData=colData, seqinfo=seqinfo)
}

## ----mkvs, eval=TRUE-------------------------------------------------------
library(gQTLstats)
library(VariantAnnotation)
library(GenomicFiles)
pa = paths1kg(paste0("chr", c(21:22))) #,"Y")))
sn = vcfSamples(scanVcfHeader(TabixFile(pa[1])))
library(Homo.sapiens)  # necessary?
stopifnot(requireNamespace("GenomeInfoDb")) # indexVcf with S3 bucket? ->
ob = RangedVcfStack(VcfStack2(pa, seqinfo(Homo.sapiens)))
cd = DataFrame(id1kg=sn)
rownames(cd) = sn
colData(ob) = cd

## ----mkrvs, eval=TRUE------------------------------------------------------
myr = GRanges("chr22", IRanges(20e6,20.01e6))
rowRanges(ob) = myr
colData(ob) = DataFrame(colData(ob), zz=runif(nrow(colData(ob))))
hasInternetConnectivity = function()
 !is.null(nsl("www.r-project.org"))
#if (hasInternetConnectivity()) lka = assay(ob)
myobs = list(geuvRNAseq=geuFPKM, yri450k=banovichSE, yriDHS=DHStop5_hg19,
    yriGeno=ob)
suppressWarnings({
mm = MultiAssayExperiment(myobs)
})
mm

## ----results='asis',echo=FALSE---------------------------------------------
bibliography() #style="markdown")

