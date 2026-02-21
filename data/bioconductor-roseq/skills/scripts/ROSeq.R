# Code example from 'ROSeq' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ROSeq)
library(edgeR)
library(limma)

## ----data, message=FALSE,warning = FALSE,include=TRUE, cache=FALSE------------
samples<-list()
samples$count<-ROSeq::L_Tung_single$NA19098_NA19101_count
samples$group<-ROSeq::L_Tung_single$NA19098_NA19101_group
samples$count[1:5,1:5]

## ----preprocesing, message=FALSE,warning = FALSE,include=TRUE, cache=FALSE----
gene_names<-rownames(samples$count)
samples$count<-apply(samples$count,2,function(x) as.numeric(x))
rownames(samples$count)<-gene_names
samples$count<-samples$count[,colSums(samples$count> 0) > 2000]
gkeep<-apply(samples$count,1,function(x) sum(x>2)>=3)
samples$count<-samples$count[gkeep,]
samples$count<-limma::voom(ROSeq::TMMnormalization(samples$count))

## ----main, message=FALSE,warning = FALSE, include=TRUE, cache=FALSE-----------
output<-ROSeq(countData=samples$count$E, condition = samples$group, numCores=1)

## ----output, message=FALSE,warning = FALSE,include=TRUE, cache=FALSE----------
output[1:5,]

