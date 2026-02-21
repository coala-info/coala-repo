# Code example from 'single_cell_edger' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## pre-load to avoid load messages in report
library(scRNAseq)
library(scater)
library(scran)
library(Glimma)
library(edgeR)

library(AnnotationHub)
setAnnotationHubOption("ASK", FALSE)

## -----------------------------------------------------------------------------
library(scRNAseq)
library(scater)
library(scran)
library(Glimma)
library(edgeR)

sce <- ZeiselBrainData(ensembl=TRUE)

## -----------------------------------------------------------------------------
sce <- logNormCounts(sce)

var_mod <- modelGeneVar(sce)
hvg_genes <- getTopHVGs(var_mod, n=500)
hvg_sce <- sce[hvg_genes, ]

hvg_sce <- logNormCounts(hvg_sce)

## -----------------------------------------------------------------------------
glimmaMDS(
    exprs(hvg_sce),
    groups = colData(hvg_sce)
)

## -----------------------------------------------------------------------------
colData(sce)$pb_group <-
    paste0(colData(sce)$level1class,
           "_",
           colData(sce)$level2class)

sce_counts <- counts(sce)
pb_counts <- t(rowsum(t(sce_counts), colData(sce)$pb_group))

pb_samples <- colnames(pb_counts)
pb_samples <- gsub("astrocytes_ependymal", "astrocytes-ependymal", pb_samples)
pb_split <- do.call(rbind, strsplit(pb_samples, "_"))
pb_sample_anno <- data.frame(
    sample = pb_samples,
    cell_type = pb_split[, 1],
    sample_group = pb_split[, 2]
)

## -----------------------------------------------------------------------------
pb_dge <- DGEList(
    counts = pb_counts,
    samples = pb_sample_anno,
    group = pb_sample_anno$cell_type
)

pb_dge <- calcNormFactors(pb_dge)

## -----------------------------------------------------------------------------
design <- model.matrix(~0 + cell_type, data = pb_dge$samples)
colnames(design) <- make.names(gsub("cell_type", "", colnames(design)))

pb_dge <- estimateDisp(pb_dge, design)

contr <- makeContrasts("pyramidal.SS - pyramidal.CA1", levels = design)

pb_fit <- glmFit(pb_dge, design)
pb_lrt <- glmLRT(pb_fit, contrast = contr)

## -----------------------------------------------------------------------------
glimmaMA(pb_lrt, dge = pb_dge)

## ----eval = FALSE-------------------------------------------------------------
# sc_dge <- DGEList(
#     counts = sce_counts,
#     group = colData(sce)$level1class
# )
# 
# sc_dge <- sc_dge[, colData(sce)$level1class %in% c("pyramidal CA1", "pyramidal SS")]
# 
# glimmaMA(
#     pb_lrt,
#     dge = sc_dge[, sample(1:ncol(sc_dge), 100)]
# )

## -----------------------------------------------------------------------------
sessionInfo()

