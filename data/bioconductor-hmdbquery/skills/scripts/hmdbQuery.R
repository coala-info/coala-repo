# Code example from 'hmdbQuery' vignette. See references/ for full tutorial.

## ----setu,echo=FALSE,results="hide"-------------------------------------------
suppressMessages({
suppressPackageStartupMessages({
library(hmdbQuery)
library(gwascat)
})
})

## ----lk1----------------------------------------------------------------------
library(hmdbQuery)
lk1 = HmdbEntry(prefix = "http://www.hmdb.ca/metabolites/", 
       id = "HMDB0000001")

## ----lk2----------------------------------------------------------------------
lk1

## ----lkta---------------------------------------------------------------------
data(hmdb_disease)
hmdb_disease

## ----lkdis3-------------------------------------------------------------------
d1 = diseases(lk1) # data.frame
pmids = unlist(d1["references", 5][[1]][2,])
library(annotate)
pm = pubmed(pmids[1])
ab = buildPubMedAbst(xmlRoot(pm)[[1]])
ab

## ----lkdee--------------------------------------------------------------------
biospecimens(lk1)
tissues(lk1)
st = store(lk1)
head(names(st))
length(names(st))
st$protein_assoc["name",]
st$protein_assoc["gene_name",]

