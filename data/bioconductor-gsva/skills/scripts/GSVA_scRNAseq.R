# Code example from 'GSVA_scRNAseq' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
options(width=80)
knitr::opts_chunk$set(collapse=TRUE,
                      message=FALSE,
                      warning=FALSE,
                      comment="",
                      fig.align="center",
                      fig.wide=TRUE)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(SingleCellExperiment)
library(TENxPBMCData)

sce <- TENxPBMCData(dataset="pbmc4k")
sce

## ----message=FALSE, warning=FALSE---------------------------------------------
library(scuttle)

is_mito <- grepl("^MT-", rowData(sce)$Symbol_TENx)
table(is_mito)

## -----------------------------------------------------------------------------
sce <- quickPerCellQC(sce, subsets=list(Mito=is_mito),
                           sub.fields="subsets_Mito_percent")
dim(sce)

## ----cntxgene, fig.width=5, fig.height=5, out.width="600px", fig.cap="Empirical cumulative distribution of UMI counts per gene. The red vertical bar indicates a cutoff value of 100 UMI counts per gene across all cells, below which genes will be filtered out."----
cntxgene <- rowSums(assays(sce)$counts)+1
plot.ecdf(cntxgene, xaxt="n", panel.first=grid(), xlab="UMI counts per gene",
          log="x", main="", xlim=c(1, 1e5), las=1)
axis(1, at=10^(0:5), labels=10^(0:5))
abline(v=100, lwd=2, col="red")

## -----------------------------------------------------------------------------
sce <- sce[cntxgene >= 100, ]
dim(sce)

## -----------------------------------------------------------------------------
sce <- computeLibraryFactors(sce)
sce <- logNormCounts(sce)
assayNames(sce)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(GSEABase)
library(GSVA)

fname <- file.path(system.file("extdata", package="GSVAdata"),
                   "pbmc_cell_type_gene_set_signatures.gmt.gz")
gsets <- readGMT(fname)
gsets

## -----------------------------------------------------------------------------
gsvaAnnotation(sce) <- ENSEMBLIdentifier("org.Hs.eg.db")
gsvaAnnotation(sce)

## -----------------------------------------------------------------------------
gsvapar <- gsvaParam(sce, gsets)
gsvapar

## -----------------------------------------------------------------------------
gsvaranks <- gsvaRanks(gsvapar)
gsvaranks

## -----------------------------------------------------------------------------
es <- gsvaScores(gsvaranks)
es

## ----eval=FALSE---------------------------------------------------------------
# geneSets(gsvaranks) <- geneSets(gsvapar)[1:2]
# es2 <- gsvaScores(gsvaranks)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(scran)

g <- buildSNNGraph(es, k=20, assay.type="es")

## ----message=FALSE, warning=FALSE---------------------------------------------
library(igraph)

colLabels(es) <- factor(cluster_walktrap(g)$membership)
table(colLabels(es))

## -----------------------------------------------------------------------------
## whmax <- apply(assay(es), 2, which.max)
whmax <- apply(assay(es), 2, function(x) which.max(as.vector(x)))
gsxlab <- split(rownames(es)[whmax], colLabels(es))
gsxlab <- names(sapply(sapply(gsxlab, table), which.max))
colLabels(es) <- factor(gsub("[0-9]\\.", "", gsxlab))[colLabels(es)]
table(colLabels(es))

## ----scpcaclusters, echo=TRUE, message=FALSE, warning=FALSE, fig.height=5, fig.width=6, out.width="600px", fig.cap="Cell type assignments of PBMC scRNA-seq data, based on GSVA scores."----
library(RColorBrewer)

res <- prcomp(assay(es))
varexp <- res$sdev^2 / sum(res$sdev^2)
nclusters <- nlevels(colLabels(es))
hmcol <- colorRampPalette(brewer.pal(nclusters, "Set1"))(nclusters)
par(mar=c(4, 5, 1, 1))
plot(res$rotation[, 1], res$rotation[, 2], col=hmcol[colLabels(es)], pch=19,
     xlab=sprintf("PCA 1 (%.0f%%)", varexp[1]*100),
     ylab=sprintf("PCA 2 (%.0f%%)", varexp[2]*100),
     las=1, cex.axis=1.2, cex.lab=1.5)
legend("topright", gsub("_", " ", levels(colLabels(es))), fill=hmcol, inset=0.01)

## ----gsvaenrichment, echo=TRUE, fig.height=5, fig.width=5, out.width="600px", fig.cap="GSVA enrichment plot of the EOSINOPHILS gene set in the expression profile of the first cell annotated to that cell type."----
firsteosinophilcell <- which(colLabels(es) == "EOSINOPHILS")[1]
par(mar=c(4, 5, 1, 1))
gsvaEnrichment(gsvaranks, column=firsteosinophilcell, geneSet="EOSINOPHILS",
               cex.axis=1.2, cex.lab=1.5, plot="ggplot")

## ----session_info, cache=FALSE------------------------------------------------
sessionInfo()

