# Code example from 'TxRegInfra' vignette. See references/ for full tutorial.

## ----setup,echo=FALSE,results="hide", eval=TRUE----------------------------
suppressPackageStartupMessages({
library(TxRegInfra)
library(GenomicFiles)
})

## ----lkmong, eval=TRUE-----------------------------------------------------
suppressPackageStartupMessages({
library(TxRegInfra)
library(mongolite)
library(Gviz)
library(EnsDb.Hsapiens.v75)
library(BiocParallel)
register(SerialParam())
})
con1 = mongo(url=URL_txregInAWS(), db="txregnet")
con1

## ----lkpar, eval=TRUE------------------------------------------------------
parent.env(con1)$orig

## ----getl, eval=TRUE-------------------------------------------------------
if (verifyHasMongoCmd()) {
  head(c1 <- listAllCollections(url=URL_txregInAWS(), db="txregnet"))
  }

## ----getl2, eval=TRUE------------------------------------------------------
mongo(url=URL_txregInAWS(), db="txregnet", 
   collection="Adipose_Subcutaneous_allpairs_v7_eQTL")$find(limit=1)

## ----doagg, eval=TRUE------------------------------------------------------
m1 = mongo(url = URL_txregInAWS(), db = "txregnet",  collection="CD14_DS17215_hg19_FP")
newagg = makeAggregator( by="chr", vbl="stat", op="$min", opname="min")

## ----lkagggg, eval=TRUE----------------------------------------------------
head(m1$aggregate(newagg))

## ----getcold, eval=TRUE----------------------------------------------------
# cd = makeColData() # works when mongo does
cd = TxRegInfra::basicColData
head(cd,2)

## ----domor1, eval=TRUE-----------------------------------------------------
rme0 = RaggedMongoExpt(con1, colData=cd)
rme1 = rme0[, which(cd$type=="FP")]

## ----lksb, cache=TRUE, eval=TRUE-------------------------------------------
s1 = sbov(rme1, GRanges("chr17", IRanges(38.07e6,38.09e6)))
s1
dim(sa <- sparseAssay(s1, 3))  # compact gives segfault
sa[953:956,c("fLung_DS14724_hg19_FP", "fMuscle_arm_DS17765_hg19_FP")]

## ----mym, eval=TRUE--------------------------------------------------------
ormm = txmodels("ORMDL3", plot=FALSE, name="ORMDL3")
sar = strsplit(rownames(sa), ":|-")
an = as.numeric
gr = GRanges(seqnames(ormm)[1], IRanges(an(sapply(sar,"[", 2)), an(sapply(sar,"[", 3))))
gr1 = gr
gr1$score = 1-sa[,1]
gr2 = gr
gr2$score = 1-sa[,2]
sc1 = DataTrack(gr1, name="Lung FP")
sc2 = DataTrack(gr2, name="Musc/Arm FP")
plotTracks(list(GenomeAxisTrack(), sc1, sc2, ormm), showId=TRUE)

