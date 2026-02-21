# Code example from 'emtdataR' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----install------------------------------------------------------------------
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("emtdata")

## ----load-packages, message=FALSE---------------------------------------------
library(emtdata)
library(ExperimentHub)
library(SummarizedExperiment)

## ----get-emtdata--------------------------------------------------------------
eh = ExperimentHub()
query(eh , 'emtdata')

## ----download-emtdata-cursons2018-id------------------------------------------
eh[['EH5440']]

## ----download-emtdata-cursons2018-accessor------------------------------------
#metadata are displayed
cursons2018_se(metadata = TRUE)
#data are loaded
cursons2018_se()

## ----access-se----------------------------------------------------------------
cursons2018_se = eh[['EH5440']]

#read counts
assay(cursons2018_se)[1:5, 1:5]

#genes
rowData(cursons2018_se)

#sample information
colData(cursons2018_se)

## -----------------------------------------------------------------------------
library(edgeR)
library(RColorBrewer)
cursons2018_dge <- asDGEList(cursons2018_se)
cursons2018_dge <- calcNormFactors(cursons2018_dge)
plotMDS(cursons2018_dge)

## -----------------------------------------------------------------------------
cursons2015_se = eh[['EH5441']]
cursons2015_dge <- asDGEList(cursons2015_se)
cursons2015_dge <- calcNormFactors(cursons2015_dge)
colours <- brewer.pal(7, name = "Paired")
plotMDS(cursons2015_dge, dim.plot = c(2,3), col=rep(colours, each = 3)) 

## -----------------------------------------------------------------------------
foroutan2017_se = eh[['EH5439']]
foroutan2017_dge <- asDGEList(foroutan2017_se, assay_name = "logExpr")
foroutan2017_dge <- calcNormFactors(foroutan2017_dge)
tgfb_col <- as.numeric(foroutan2017_dge$samples$Treatment %in% 'TGFb') + 1
plotMDS(foroutan2017_dge, labels = foroutan2017_dge$samples$Treatment, col = tgfb_col)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

