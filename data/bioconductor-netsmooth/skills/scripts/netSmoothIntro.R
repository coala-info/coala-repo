# Code example from 'netSmoothIntro' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
library(netSmooth)
library(pheatmap)
library(SingleCellExperiment)

## ----netsum,echo=FALSE,fig.cap="Network-smoothing concept"--------------------
# All defaults
knitr::include_graphics("bckgrnd.png")

## ----echo=TRUE----------------------------------------------------------------
data(smallPPI)
data(smallscRNAseq)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
smallscRNAseq.sm.se <- netSmooth(smallscRNAseq, smallPPI, alpha=0.5)
smallscRNAseq.sm.sce <- SingleCellExperiment(
    assays=list(counts=assay(smallscRNAseq.sm.se)),
    colData=colData(smallscRNAseq.sm.se)
)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
anno.df <- data.frame(cell.type=colData(smallscRNAseq)$source_name_ch1)
rownames(anno.df) <- colnames(smallscRNAseq)
pheatmap(log2(assay(smallscRNAseq)+1), annotation_col = anno.df,
         show_rownames = FALSE, show_colnames = FALSE,
         main="before netSmooth")

pheatmap(log2(assay(smallscRNAseq.sm.sce)+1), annotation_col = anno.df,
         show_rownames = FALSE, show_colnames = FALSE,
         main="after netSmooth")

## ----echo=TRUE, eval=FALSE----------------------------------------------------
# smallscRNAseq.sm.se <- netSmooth(smallscRNAseq, smallPPI, alpha='auto')
# smallscRNAseq.sm.sce <- SingleCellExperiment(
#     assays=list(counts=assay(smallscRNAseq.sm.se)),
#     colData=colData(smallscRNAseq.sm.se)
# )
# 
# pheatmap(log2(assay(smallscRNAseq.sm.sce)+1), annotation_col = anno.df,
#          show_rownames = FALSE, show_colnames = FALSE,
#          main="after netSmooth (optimal alpha)")

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
yhat <- robustClusters(smallscRNAseq, makeConsensusMinSize=2, makeConsensusProportion=.9)$clusters
yhat.sm <- robustClusters(smallscRNAseq.sm.se, makeConsensusMinSize=2, makeConsensusProportion=.9)$clusters
cell.types <- colData(smallscRNAseq)$source_name_ch1
knitr::kable(
  table(cell.types, yhat), caption = 'Cell types and `robustClusters` in the raw data.'
)
knitr::kable(
  table(cell.types, yhat.sm), caption = 'Cell types and `robustClusters` in the smoothed data.'
)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
smallscRNAseq <- runPCA(smallscRNAseq, ncomponents=2)
smallscRNAseq <- runTSNE(smallscRNAseq, ncomponents=2)
smallscRNAseq <- runUMAP(smallscRNAseq, ncomponents=2)

plotPCA(smallscRNAseq, colour_by='source_name_ch1') + ggtitle("PCA plot")
plotTSNE(smallscRNAseq, colour_by='source_name_ch1') + ggtitle("tSNE plot")
plotUMAP(smallscRNAseq, colour_by='source_name_ch1') + ggtitle("UMAP plot")

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
pickDimReduction(smallscRNAseq)

## -----------------------------------------------------------------------------
sessionInfo()

