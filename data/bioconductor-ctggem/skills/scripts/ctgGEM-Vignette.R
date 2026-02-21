# Code example from 'ctgGEM-Vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ---- eval=FALSE--------------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("ctgGEM")

## ----loadCTG, message=FALSE, warning=FALSE, results='hide'--------------------
library(ctgGEM)

## ----loadRaw, message=FALSE, warning=FALSE, results='hide'--------------------
# load HSMMSingleCell package 
library(HSMMSingleCell)
# load the data 
data(HSMM_expr_matrix)
data(HSMM_sample_sheet)
data(HSMM_gene_annotation)

## ----constructctgGEMset-------------------------------------------------------
toyGEMset <- ctgGEMset(exprsData = HSMM_expr_matrix,
                            phenoData = HSMM_sample_sheet,
                            featureData = HSMM_gene_annotation)

## ----monocleInfo--------------------------------------------------------------
monocleInfo(toyGEMset, "gene_id") <- "gene_short_name"
monocleInfo(toyGEMset, "ex_type") <- "FPKM"

## ----monocleInfo2-------------------------------------------------------------
# Set two marker genes to use semi-supervised mode
# Alternatively, omit the next two lines to run in unsupervised mode
monocleInfo(toyGEMset, "cell_id_1") <- "MYF5" # marks myoblasts
monocleInfo(toyGEMset, "cell_id_2") <- "ANPEP" # marks fibroblasts

## ----TSCANinfo----------------------------------------------------------------
TSCANinfo(toyGEMset) <- "ENSG00000000003.10"

## ----sincelldistonly, eval=FALSE----------------------------------------------
#  sincellInfo(toyGEMset, "method") <- "pearson"

## ----sincelldimred------------------------------------------------------------
sincellInfo(toyGEMset, "method") <- "classical-MDS"
sincellInfo(toyGEMset, "MDS.distance") <- "spearman"

## ----sincellclust-------------------------------------------------------------
sincellInfo(toyGEMset, "clust.method") <- "k-medoids"

## ----genMon, echo=TRUE, results='hide', message=FALSE-------------------------
toyGEMset <- generate_tree(dataSet = toyGEMset, treeType = "monocle")

## ----monPlots, echo=FALSE, out.width="400px", message=FALSE-------------------
plotOriginalTree(toyGEMset, "monocle")

## ----genSin, message=FALSE----------------------------------------------------
toyGEMset <- generate_tree(dataSet = toyGEMset, treeType = "sincell")

## ----sincellPlots, echo=FALSE, out.width="400px", message=FALSE---------------
plotOriginalTree(toyGEMset, "sincellIMC")
plotOriginalTree(toyGEMset, "sincellMST")
plotOriginalTree(toyGEMset, "sincellSST")

## ----genTSCAN, echo=TRUE, message=FALSE---------------------------------------
toyGEMset <- generate_tree(dataSet = toyGEMset, treeType = "TSCAN")

## ----TSCANplots, echo=FALSE, out.width="400px", message=FALSE-----------------
plotOriginalTree(toyGEMset, "TSCANclustering")
plotOriginalTree(toyGEMset, "TSCANsingleGene")

## ----genDes, message=FALSE----------------------------------------------------
toyGEMset <- generate_tree(dataSet = toyGEMset, treeType = "destiny")

## ----destinyPlots, echo=FALSE, out.width="400px", message=FALSE---------------
plotOriginalTree(toyGEMset, "destinyDM")
plotOriginalTree(toyGEMset, "destinyDPT")

## ----getNames, echo=TRUE------------------------------------------------------
names(originalTrees(toyGEMset))

## ----plotTree, echo=TRUE, message=FALSE---------------------------------------
plotOriginalTree(toyGEMset, "destinyDM")

## ----save, eval = TRUE--------------------------------------------------------
save(toyGEMset, file = "toyGEMset.Rda")

## -----------------------------------------------------------------------------
sessionInfo()

