# Code example from 'ssrch' vignette. See references/ for full tutorial.

## ----setup,echo=FALSE,results="hide"------------------------------------------
suppressPackageStartupMessages({
library(ssrch)
library(DT)
})

## ----lkds---------------------------------------------------------------------
data(docset_cancer68)
docset_cancer68

## ----lklkaa-------------------------------------------------------------------
retrieve_doc("ERP010142", docset_cancer68)[1:3,1:5]

## ----lkrec--------------------------------------------------------------------
docids = ls(envir=docs2kw(docset_cancer68))
allc = lapply(docids, 
   function(x) try(retrieve_doc(x, docset_cancer68)))
summary(sapply(allc,ncol))
lapply(allc[c(11,55)], names)

## ----lklk---------------------------------------------------------------------
library(ssrch)
searchDocs("Adjacent", docset_cancer68, ignore.case=TRUE)

## ----lkd1---------------------------------------------------------------------
getClass(class(docset_cancer68))

## ----try----------------------------------------------------------------------
NSChits = searchDocs("Non.Small Cell|NSCLC$", docset_cancer68, ignore.case=TRUE)
NSChits

## ----lkdocs-------------------------------------------------------------------
NSCdocs = lapply(unique(NSChits$docs), 
   function(x) retrieve_doc(x, docset_cancer68))
names(NSCdocs) = NSChits$docs
datatable(NSCdocs[[1]], options=list(lengthMenu=c(3,5,10)))
datatable(NSCdocs[[2]], options=list(lengthMenu=c(3,5,10)))
datatable(NSCdocs[[3]], options=list(lengthMenu=c(3,5,10)))

