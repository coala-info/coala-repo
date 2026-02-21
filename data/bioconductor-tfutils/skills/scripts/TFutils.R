# Code example from 'TFutils' vignette. See references/ for full tutorial.

## ----setup,echo=FALSE---------------------------------------------------------
suppressWarnings({
suppressMessages({
suppressPackageStartupMessages({
library(BiocStyle)
library(TFutils)
library(org.Hs.eg.db)
library(GenomicFiles)
library(GO.db)
library(data.table)
library(knitr)
library(ggplot2)
library(data.table)
library(SummarizedExperiment)
library(BiocParallel)
library(png)
library(grid)
library(GSEABase) # for tftColl
library(gwascat)
data(fimoMap)
library(dplyr)
library(magrittr)
})
})
})

## ----setup2, echo=FALSE-------------------------------------------------------
library(TFutils)
library(AnnotationDbi)
suppressMessages({
tfdf = AnnotationDbi::select(org.Hs.eg.db::org.Hs.eg.db, 
    keys="GO:0003700", keytype="GO", 
    columns=c("ENTREZID", "SYMBOL"))
})
tfdf = tfdf[, c("ENTREZID", "SYMBOL")]
TFs_GO = TFCatalog(name="GO.0003700", nativeIds=tfdf$ENTREZID,
 HGNCmap=tfdf)

data(tftColl)
data(tftCollMap)
TFs_MSIG = TFCatalog(name="MsigDb.TFT", nativeIds=names(tftColl),
 HGNCmap=data.frame(tftCollMap,stringsAsFactors=FALSE))

data(cisbpTFcat)
TFs_CISBP = TFCatalog(name="CISBP.info", nativeIds=cisbpTFcat[,1],
 HGNCmap = cisbpTFcat)

data(hocomoco.mono.sep2018)
TFs_HOCO = TFCatalog(name="hocomoco11", nativeIds=hocomoco.mono.sep2018[,1],
 HGNCmap=hocomoco.mono.sep2018)

## ----lkupset,echo=FALSE,out.width='60%', fig.cap='Sizes of TF catalogs and of intersections based on HGNC symbols for TFs.', fig.pos='h'----
suppressPackageStartupMessages({library(UpSetR)})
allhg = keys(org.Hs.eg.db::org.Hs.eg.db, keytype="SYMBOL")
#activesym = unique(unlist(list(TFs_GO@HGNCmap[,2], TFs_HOCO@HGNCmap[,2], TFs_MSIG@HGNCmap[,2], TFs_CISBP@HGNCmap[,2])))
activesym = unique(unlist(list(HGNCmap(TFs_GO)[,2], HGNCmap(TFs_HOCO)[,2], HGNCmap(TFs_MSIG)[,2], HGNCmap(TFs_CISBP)[,2])))
use = intersect(allhg, activesym)
mymat = matrix(0, nr=length(use), nc=4)
rownames(mymat) = use
iu = function(x) intersect(x,use)
mymat[na.omit(iu(HGNCmap(TFs_GO)[,2])),1] = 1
mymat[na.omit(iu(HGNCmap(TFs_MSIG)[,2])),2] = 1
mymat[na.omit(iu(HGNCmap(TFs_HOCO)[,2])),3] = 1
mymat[na.omit(iu(HGNCmap(TFs_CISBP)[,2])),4] = 1
colnames(mymat) = c("GO", "MSigDb", "HOCO", "CISBP")
upset(data.frame(mymat),nsets=4,sets=c("MSigDb", "HOCO", "GO", "CISBP"), keep.order=TRUE, order.by="degree"
)

## ----TFclass, out.width='110%', fig.cap = 'Screenshots of AmiGO and TFClass hierarchy excerpts.',echo=FALSE----
knitr::include_graphics('AMIGOplus.png')

## ----dodo,echo=FALSE----------------------------------------------------------
library(knitr)
cismap = HGNCmap(TFs_CISBP)
scis = split(cismap, cismap$HGNC)
uf = vapply(scis, function(x) x$Family_Name[1],"character")
CISTOP = sort(table(uf),decreasing=TRUE)[1:10]
hoc = HGNCmap(TFs_HOCO)
shoc = split(hoc, hoc$HGNC)
sfam = vapply(shoc, function(x)x$`TF family`[1], "character")
HOTOP = sort(table(sfam),decreasing=TRUE)[1:10]
kable(data.frame(CISBP=names(CISTOP), Nc=as.numeric(CISTOP), 
   HOCOMOCO=names(HOTOP), Nh=as.numeric(HOTOP)), format="markdown")

## ----lkbro--------------------------------------------------------------------
TFutils::tftColl

## ----lktft2-------------------------------------------------------------------
grep("NFK", names(TFutils::tftColl), value=TRUE)

## ----demoredu-----------------------------------------------------------------
library(GenomicFiles)
data(fimo16)
fimo16
head(colData(fimo16))

## ----demoredu2, cache=TRUE----------------------------------------------------
if (.Platform$OS.type != "windows") {
 library(BiocParallel)
 register(SerialParam()) # important for macosx?
 rowRanges(fimo16) = GRanges("chr17", IRanges(38.077e6, 38.084e6))
 rr = GenomicFiles::reduceByFile(fimo16, MAP=function(r,f)
   scanTabix(f, param=r))
} else {
rr = readRDS(system.file("fimoser/fimo16rr.rds", package="TFutils"))
}

## ----paraa--------------------------------------------------------------------
asdf = function(x) data.table::fread(paste0(x, collapse="\n"), header=FALSE)
gg = lapply(rr, function(x) {
       tmp = asdf(x[[1]][[1]]) 
       data.frame(loc=tmp$V2, score=-log10(tmp$V7))
     })
for (i in 1:length(gg))  gg[[i]]$tf = colData(fimo16)[i,2]

## ----domat--------------------------------------------------------------------
matchcis = match(colData(fimo16)[,2], cisbpTFcat[,2])
famn = cisbpTFcat[matchcis,]$Family_Name
for (i in 1:length(gg))  gg[[i]]$tffam = famn[i]
nn = do.call(rbind, gg)

## ----finish, fig.height=3.5,echo=FALSE,fig.cap='TF binding in the vicinity of gene ORMDL3.  Points are -log10-transformed FIMO-based p-values colored according to TF class as annotated in CISBP.  Segments at bottom of plot are transcribed regions of ORMDL3 according to UCSC gene models in build hg19.'----
library(ggplot2)
myf = function(a=38077296, b=38078938) 
  geom_segment(aes(x=a, xend=b, y=2.85, yend=2.85, 
  colour="[ORMDL3]"))
ggplot(nn, aes(x=loc,y=score,group=tffam, colour=tffam)) + 
  geom_point() + myf() + myf(38079365, 38079516) + 
    myf(38080283, 38080478) + myf(38081008, 38081058) + 
    myf(38081422, 38081624) + myf(38081876, 38083094) + 
    myf(38083737, 38083884) + ylab("-log10 FIMO p-value") + 
 xlab("position on chr17, hg19")

## ----lkbi, fig.cap='Binding of CEBPB in the vicinity of ORMDL3 derived from ChIP-seq experiments in four cell lines reported by ENCODE.  Colored rectangles at top are regions identified as narrow binding peaks, arrows in bottom half are exons in ORMDL3.  Arrows sharing a common vertical position are members of the same transcript as cataloged in Ensembl version 75.', echo=FALSE----
pp = readPNG("ormdl3CEBPB.png")
grid.raster(pp)

## ----lktarapp, fig.cap='TFtargs() screenshot.  This example reports on recent EBI GWAS catalog hits on chromosome 17 only.',echo=FALSE----
pp = readPNG("tfTargsApp.png")
grid.raster(pp)

## ----ljlj---------------------------------------------------------------------
data(cisbpTFcat)
TFs_CISBP = TFCatalog(name="CISBP.info", 
   nativeIds=cisbpTFcat[,1],
   HGNCmap = cisbpTFcat)
TFs_CISBP

## ----defdir-------------------------------------------------------------------
library(dplyr)
library(magrittr)
library(gwascat)
#data(ebicat37)
load(system.file("legacy/ebicat37.rda", package="gwascat"))
directHitsInCISBP("Rheumatoid arthritis", ebicat37)

## ----lktr---------------------------------------------------------------------
tt = topTraitsOfTargets("MTF1", TFutils::tftColl, ebicat37)
head(tt)
table(tt[,1])

## ----dose---------------------------------------------------------------------
sessionInfo()

