# Code example from 'Seqgate-html-vignette' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
library(knitr)
opts_chunk$set(cache=FALSE, error=FALSE)

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----install------------------------------------------------------------------
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("SeqGate")

## ----load_SeqGate-------------------------------------------------------------
library(SeqGate)

## ----load_dataTest------------------------------------------------------------
data(data_MiTF_1000genes)
head(data_MiTF_1000genes)

## ----define_cond--------------------------------------------------------------
cond<-c("A","A","B","B","A","B")

## ----create_se----------------------------------------------------------------
rowData <- DataFrame(row.names=rownames(data_MiTF_1000genes))
colData <- DataFrame(Conditions=cond)
counts_strub <- SummarizedExperiment(
                  assays=list(counts=data_MiTF_1000genes),
                  rowData=rowData,
                  colData=colData)

## ----apply_basic--------------------------------------------------------------
counts_strub <- applySeqGate(counts_strub,"counts","Conditions")

## ----get_kept_features--------------------------------------------------------
keptGenes <- assay(counts_strub[rowData(counts_strub)$onFilter == TRUE,])
head(keptGenes)
dim(keptGenes)

## ----threshold----------------------------------------------------------------
metadata(counts_strub)$threshold

## ----get_filtered-------------------------------------------------------------
filteredOut <- assay(counts_strub[rowData(counts_strub)$onFilter == FALSE,])
head(filteredOut)

## ----apply_custom-------------------------------------------------------------
counts_strub <- applySeqGate(counts_strub,"counts","Conditions",
             prop0=1/3,
             percentile=0.8,
             propUpThresh=0.5)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

