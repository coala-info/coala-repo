# Code example from 'restfulSE' vignette. See references/ for full tutorial.

## ----setup,echo=FALSE,results="hide"---------------------------------------
suppressPackageStartupMessages({
library(restfulSE)
library(GO.db)
library(org.Hs.eg.db)
library(SummarizedExperiment)
library(ExperimentHub)
library(AnnotationHub)
})

## ----do10x,eval=TRUE-------------------------------------------------------
library(restfulSE)
my10x = se1.3M()
my10x

## ----doanno, eval=TRUE-----------------------------------------------------
library(org.Mm.eg.db)
hippdev = select(org.Mm.eg.db, 
    keys="GO:0021766", keytype="GO", column="ENSEMBL")$ENSEMBL
hippdev = intersect(hippdev, rownames(my10x))
unname(assay(my10x[ hippdev[1:10], 10001:10006]))

## ----lktiss, eval=TRUE-----------------------------------------------------
tiss = gtexTiss()
tiss

## ----findbr----------------------------------------------------------------
binds = grep("Brain", tiss$smtsd)
table(tiss$smtsd[binds][1:100]) # check diversity in 100 samples

## ----findn-----------------------------------------------------------------
ntgenes = goPatt(termPattern="neurotroph")
head(ntgenes)

## ----setup2,echo=FALSE-----------------------------------------------------
suppressPackageStartupMessages({
library(restfulSE)
library(SummarizedExperiment)
library(Rtsne)
library(rhdf5client)
})

## ----dobanoyy--------------------------------------------------------------
library(restfulSE)
hsds = H5S_source(URL_hsds())
hsds


## ----doba2-----------------------------------------------------------------
hsdsCon = setPath(hsds,"/home/reshg/bano_meQTLex.h5")
fetchDatasets(hsdsCon) #grab the dataset id of interest 
banoh5 = H5S_dataset2(hsdsCon,"d-435d7ad4-9f13-11e8-92c2-0242ac120021")

## ----doba3-----------------------------------------------------------------
ehub = ExperimentHub::ExperimentHub()
tag = names(AnnotationHub::query(ehub, "banoSEMeta"))
banoSE = ehub[[tag[1]]]
ds = H5S_Array(URL_hsds(), "/home/reshg/bano_meQTLex.h5", "assay001")
assays(banoSE) = SimpleList(betas=ds)
banoSE

## ----doba4-----------------------------------------------------------------
rbanoSub = banoSE[5:8, c(3:9, 40:50)] 
assay(rbanoSub) 

## ----gettx-----------------------------------------------------------------
tenx100k = se100k()
tenx100k

## ----anno------------------------------------------------------------------
library(org.Mm.eg.db)
atab = select(org.Mm.eg.db, keys="GO:0021766", keytype="GO", columns="ENSEMBL")
hg = atab[,"ENSEMBL"]
length(hgok <- intersect(hg, rownames(tenx100k)))

## ----getdat, cache=TRUE----------------------------------------------------
hipn = assay(tenx100k[hgok,1:4000])  # slow
d = dist(t(log(1+hipn)), method="manhattan")
proj = Rtsne(d)

## ----plt,fig=TRUE----------------------------------------------------------
plot(proj$Y)

## ----lktas-----------------------------------------------------------------
#data("tasicST6", package = "restfulSEData")
ehub = ExperimentHub::ExperimentHub()
tag = names(AnnotationHub::query(ehub, "tasicST6"))
tasicST6 = ehub[[tag[1]]]
tasicST6

## ----lkd-------------------------------------------------------------------
library(restfulSE)
#data("banoSEMeta", package = "restfulSEData")
ehub = ExperimentHub::ExperimentHub()
tag = names(AnnotationHub::query(ehub, "banoSEMeta"))
banoSEMeta = ehub[[tag[1]]]
banoSEMeta

## ----doso------------------------------------------------------------------
mys = H5S_source(serverURL=URL_hsds())
mys

