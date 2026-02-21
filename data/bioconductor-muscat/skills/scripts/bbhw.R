# Code example from 'bbhw' vignette. See references/ for full tutorial.

## ----echo = FALSE, message = FALSE, warning = FALSE---------------------------
library(BiocStyle)

## ----load-libs, message = FALSE,  warning = FALSE-----------------------------
library(dplyr)
library(muscat)
library(SingleCellExperiment)

## ----echo = FALSE, fig.cap = "Bulk-based weighing of single-cell hypotheses. A-C: Example p-values of differential expression upon stress, from both a single-cell dataset with modest sample size (A and C) and a much larger bulk dataset (B) (data from Waag et al., biorxiv 2025). C: Splitting the single-cell p-values by significance of the respective gene in the bulk data leads to higher local excess of p-values. D: Example precision-recall curves in a different dataset with ground truth (based on downsampled data) using standard (local) FDR and the default bbhw method (see our paper for more detail)."----
knitr::include_graphics(system.file('extdata', 'bbhw.png', package = 'muscat'))

## -----------------------------------------------------------------------------
data("example_sce")
# since the dataset is a bit too small for the procedure, we'll double it:
sce <- rbind(example_sce, example_sce)
row.names(sce) <- make.unique(row.names(sce))
# pseudo-bulk aggregation
pb <- aggregateData(sce)
res <- pbDS(pb, verbose = FALSE)
# the signal is too strong in this data, so we'll reduce it
# (don't do this with real data!):
res$table$stim <- lapply(res$table$stim, \(x) {
    x$p_val <- sqrt(x$p_val)
    x$p_adj.loc <- p.adjust(x$p_val, method="fdr")
    x
})
# we assemble the cell types in a single table for the comparison of interest:
res2 <- bind_rows(res$table$stim, .id="cluster_id")
head(res2 <- res2[order(res2$p_adj.loc),])

## -----------------------------------------------------------------------------
set.seed(123)
bulkDEA <- data.frame(
    row.names=row.names(pb), 
    logFC=rnorm(nrow(pb)),
    PValue=runif(nrow(pb)))
# we'll spike some signal in:
gs_by_k <- split(res2$gene, res2$cluster_id)
sel <- unique(unlist(lapply(gs_by_k, \(x) x[3:150])))
bulkDEA[sel,"PValue"] <- abs(rnorm(length(sel), sd=0.01))
head(bulkDEA)

## -----------------------------------------------------------------------------
# here, we manually set 'nbins'
# because the dataset is too small, 
# you shouldn't normally need to do this:
res2 <- bbhw(pbDEA=res2, bulkDEA=bulkDEA, pb=pb, nbins=4, verbose=FALSE)

## -----------------------------------------------------------------------------
head(res2[order(res2$padj),c("gene","cluster_id","p_adj.loc","padj")])
table(standard=res2$p_adj.loc < 0.05, bbhw=res2$padj < 0.05)

## -----------------------------------------------------------------------------
c(standard=sum(res2$p_adj.loc < 0.05), bbhw=sum(res2$padj < 0.05))

## ----session-info-------------------------------------------------------------
sessionInfo()

