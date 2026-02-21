# Code example from 'htxcomp' vignette. See references/ for full tutorial.

## ----setup,echo=FALSE,results="hide"---------------------------------------
suppressPackageStartupMessages({
suppressMessages({
library(BiocStyle)
library(HumanTranscriptomeCompendium)
library(beeswarm)
library(SummarizedExperiment)
library(DT)
})
})

## ----lklo------------------------------------------------------------------
v = BiocManager::version()
if (v >= "3.10") {
 library(HumanTranscriptomeCompendium)
 genelev = htx_load()
 genelev
 assay(genelev)
}

## ----lksi------------------------------------------------------------------
if (v >= "3.10") {
sing = grep("single.cell", genelev$study_title, 
   ignore.case=TRUE)
length(sing)
}

## ----chkspec---------------------------------------------------------------
if (v >= "3.10") {
sa = genelev$study_accession[sing]
sing2 = sing[-which(duplicated(sa))]
length(sing2)
datatable(as.data.frame(colData(genelev[,sing2])),
   options=list(lengthMenu=c(3,5,10,50,100)))
}

## ----lkchar----------------------------------------------------------------
if (v >= "3.10") {
bulk = genelev[,-sing]
kpglio = grep("glioblastoma", bulk$study_title, 
  ignore.case=TRUE)
glioGene = bulk[,kpglio]
glioGene
}

## ----lkmat-----------------------------------------------------------------
if (v >= "3.10") {
beeswarm(as.matrix(assay(
   glioGene["ENSG00000138413.13",1:100])), pwcol=as.numeric(factor(glioGene$study_title[1:100])), ylab="IDH1 expression")
legend(.6, 15000, legend=unique(glioGene$study_accession[1:100]),
   col=1:2, pch=c(1,1))
}

## ----dotx, eval=FALSE------------------------------------------------------
#  if (v >= "3.10") {
#  txlev = htx_load(genesOnly=FALSE)
#  txlev
#  }

