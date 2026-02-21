# Code example from 'scfind' vignette. See references/ for full tutorial.

## ----knitr-options, echo=FALSE, message=FALSE, warning=FALSE, cache=TRUE----
library(knitr)
opts_chunk$set(fig.align = 'center', fig.width = 6, fig.height = 5, dev = 'png')
op <- options(gvis.plot.tag='chart')

## ---- warning=FALSE, message=FALSE-----------------------------------------
library(SingleCellExperiment)
library(scfind)

head(ann)
yan[1:3, 1:3]

## --------------------------------------------------------------------------
sce <- SingleCellExperiment(assays = list(normcounts = as.matrix(yan)), colData = ann)
# this is needed to calculate dropout rate for feature selection
# important: normcounts have the same zeros as raw counts (fpkm)
counts(sce) <- normcounts(sce)
logcounts(sce) <- log2(normcounts(sce) + 1)
# use gene names as feature symbols
rowData(sce)$feature_symbol <- rownames(sce)
isSpike(sce, "ERCC") <- grepl("^ERCC-", rownames(sce))
# remove features with duplicated names
sce <- sce[!duplicated(rownames(sce)), ]
sce

## --------------------------------------------------------------------------
geneIndex <- buildCellTypeIndex(sce)
p_values <- -log10(findCellType(geneIndex, c("SOX6", "SNAI3")))
barplot(p_values, ylab = "-log10(pval)", las = 2)

## --------------------------------------------------------------------------
geneIndex <- buildCellIndex(sce)
res <- findCell(geneIndex, c("SOX6", "SNAI3"))
res$common_exprs_cells

## --------------------------------------------------------------------------
barplot(-log10(res$p_values), ylab = "-log10(pval)", las = 2)

## ----echo=FALSE------------------------------------------------------------
sessionInfo()

