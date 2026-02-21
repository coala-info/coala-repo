# Code example from 'tapseq_target_genes' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message=FALSE, results="hide"--------------------------------------------
library(TAPseq)
library(Seurat)

# example of mouse bone marrow 10x gene expression data
data("bone_marrow_genex")

# transcript counts
GetAssayData(bone_marrow_genex, layer = "counts", assay = "RNA")[1:10, 1:10]

# number of cells per cell type
table(Idents(bone_marrow_genex))

## ----message=FALSE, results="hide"--------------------------------------------
# automatically select a number of target genes using 10-fold cross-validation
target_genes_cv <- selectTargetGenes(bone_marrow_genex)
head(target_genes_cv)
length(target_genes_cv)

## ----message=FALSE, results="hide"--------------------------------------------
# identify approximately 100 target genes that can be used to identify cell populations
target_genes_100 <- selectTargetGenes(bone_marrow_genex, targets = 100)
length(target_genes_100)

## ----message=FALSE, warning=FALSE, fig.height=3, fig.width=7.15---------------
plotTargetGenes(bone_marrow_genex, target_genes = target_genes_100)

## -----------------------------------------------------------------------------
sessionInfo()

