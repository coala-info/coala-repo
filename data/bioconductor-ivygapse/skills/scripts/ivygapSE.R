# Code example from 'ivygapSE' vignette. See references/ for full tutorial.

## ----loadup, echo=FALSE-------------------------------------------------------
suppressPackageStartupMessages({
library(SummarizedExperiment)
library(ivygapSE)
library(DT)
library(grid)
library(png)
library(ggplot2)
library(limma)
library(randomForest)
})

## ----chk----------------------------------------------------------------------
library(ivygapSE)
data(ivySE)
ivySE

## ----lkd----------------------------------------------------------------------
dim(ivySE)

## ----lkse---------------------------------------------------------------------
length(unique(metadata(ivySE)$tumorDetails$donor_id))

## ----lkcon--------------------------------------------------------------------
sum(metadata(ivySE)$tumorDetails$tumor_name %in% ivySE$tumor_name)

## ----getsbd,echo=FALSE--------------------------------------------------------
subd = metadata(ivySE)$subBlockDetails
dsub = dim(subd)

## ----lkonto,image=TRUE,echo=FALSE---------------------------------------------
nomenclat()

## ----lkk,echo=FALSE,fig=TRUE--------------------------------------------------
designOverview()

## ----lkdttum,echo=FALSE-------------------------------------------------------
datatable(tumorDetails(ivySE), options=list(lengthMenu=c(3,5,10,50,100)))

## ----lkdts,echo=FALSE---------------------------------------------------------
datatable(subBlockDetails(ivySE), options=list(lengthMenu=c(3,5,10,50,    100)))

## ----lkcdd,echo=FALSE---------------------------------------------------------
datatable(as.data.frame(colData(ivySE)), options=list(lengthMenu=c(3,5,10,50,100)))

## ----lksbbbb------------------------------------------------------------------
sb = subBlockDetails(ivySE)
table(sb$study_name)

## ----lksa,fig=TRUE------------------------------------------------------------
struc = as.character(colData(ivySE)$structure_acronym)
spls = strsplit(struc, "-")
basis = vapply(spls, function(x) x[1], character(1))
spec = vapply(spls, function(x) x[2], character(1))
table(basis, exclude=NULL)
barplot(table(basis))

## ----lktab--------------------------------------------------------------------
lapply(split(spec,basis), function(x)sort(table(x),decreasing=TRUE))

## ----lklim, cache=TRUE--------------------------------------------------------
library(limma)
ebout = getRefLimma()

## ----lknnn--------------------------------------------------------------------
odig = options()$digits
options(digits=3)
limma::topTable(ebout, 2)
options(digits=odig) # revert

## ----bindmol------------------------------------------------------------------
moltype = tumorDetails(ivySE)$molecular_subtype
names(moltype) = tumorDetails(ivySE)$tumor_name
moltype[nchar(moltype)==0] = "missing"
ivySE$moltype = factor(moltype[ivySE$tumor_name])

## ----setdup, cache=TRUE-------------------------------------------------------
library(limma)
refex = ivySE[, grep("reference", ivySE$structure_acronym)]
refmat = assay(refex)
tydes = model.matrix(~moltype, data=as.data.frame(colData(refex)))
ok = which(apply(tydes,2,sum)>0)  # some subtypes don't have ref histo samples
tydes = tydes[,ok]
block = factor(refex$tumor_id)
dd = duplicateCorrelation(refmat, tydes, block=block)
f2 = lmFit(refmat, tydes, correlation=dd$consensus)
ef2 = eBayes(f2)
colnames(tydes)
topTable(ef2,2)

## ----lkrf,fig=TRUE------------------------------------------------------------
refex = ivySE[, grep("reference", ivySE$structure_acronym)]
refex$struc = factor(refex$structure_acronym)
iqrs = rowIQRs(assay(refex))
inds = which(iqrs>quantile(iqrs,.5))
set.seed(1234)
rf1 = randomForest(x=t(assay(refex[inds,])), 
        y=refex$struc, mtry=30, importance=TRUE) 
rf1
varImpPlot(rf1)

