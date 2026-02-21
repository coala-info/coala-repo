# Code example from 'UCell_sce' vignette. See references/ for full tutorial.

## ----message=F, warning=F, results=F------------------------------------------
library(scRNAseq)
lung <- ZilionisLungData()
immune <- lung$Used & lung$used_in_NSCLC_immune
lung <- lung[,immune]
lung <- lung[,1:5000]

exp.mat <- Matrix::Matrix(counts(lung),sparse = TRUE)
colnames(exp.mat) <- paste0(colnames(exp.mat), seq(1,ncol(exp.mat)))

## -----------------------------------------------------------------------------
signatures <- list(
    Tcell = c("CD3D","CD3E","CD3G","CD2","TRAC"),
    Myeloid = c("CD14","LYZ","CSF1R","FCER1G","SPI1","LCK-"),
    NK = c("KLRD1","NCR1","NKG7","CD3D-","CD3E-"),
    Plasma_cell = c("MZB1","DERL3","CD19-")
)

## ----message=F, warning=F-----------------------------------------------------
library(UCell)
library(SingleCellExperiment)

sce <- SingleCellExperiment(list(counts=exp.mat))
sce <- ScoreSignatures_UCell(sce, features=signatures, 
                                 assay = 'counts', name=NULL)
altExp(sce, 'UCell')

## ----message=F, warning=F-----------------------------------------------------
library(scater)
library(patchwork)
#PCA
sce <- logNormCounts(sce)
sce <- runPCA(sce, scale=TRUE, ncomponents=10)

#UMAP
set.seed(1234)
sce <- runUMAP(sce, dimred="PCA")

## ----fig.wide=TRUE, dpi=60, message=F, warning=F, results=F-------------------
pll <- lapply(names(signatures), function(x) {
    plotUMAP(sce, colour_by = x, by_exprs_values = "UCell",
             point_size=0.5) + theme(aspect.ratio = 1)
})
wrap_plots(pll[1:2])

## -----------------------------------------------------------------------------
sce <- SmoothKNN(sce, signature.names = names(signatures), reduction="PCA")

## ----fig.wide=TRUE, dpi=60, message=F, warning=F, results=F-------------------
a <- plotUMAP(sce, colour_by="Myeloid", by_exprs_values="UCell",
         point_size=0.5) + ggtitle("UCell") + theme(aspect.ratio = 1)

b <- plotUMAP(sce, colour_by="Myeloid_kNN", by_exprs_values="UCell_kNN",
         point_size=0.5) + ggtitle("Smoothed UCell") + theme(aspect.ratio = 1)

a | b

## -----------------------------------------------------------------------------
sessionInfo()

