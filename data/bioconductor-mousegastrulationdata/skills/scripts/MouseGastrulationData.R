# Code example from 'MouseGastrulationData' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide"-----------------------------------------------
knitr::opts_chunk$set(error=FALSE, warning=FALSE, message=FALSE)

## ----getPackage, eval=FALSE---------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("MouseGastrulationData")

## ----Load, message=FALSE------------------------------------------------------
library(MouseGastrulationData)

## -----------------------------------------------------------------------------
head(AtlasSampleMetadata, n = 3)

## ----message=FALSE------------------------------------------------------------
sce <- EmbryoAtlasData(samples = 21)
sce

## -----------------------------------------------------------------------------
counts(sce)[6:9, 1:3]

## -----------------------------------------------------------------------------
head(sizeFactors(sce))

## -----------------------------------------------------------------------------
head(rowData(sce))

## -----------------------------------------------------------------------------
head(colData(sce))

## ----fig.height = 6-----------------------------------------------------------
#exclude technical artefacts
singlets <- which(!(colData(sce)$doublet | colData(sce)$stripped))
plot(
    x = reducedDim(sce, "umap")[singlets, 1],
    y = reducedDim(sce, "umap")[singlets, 2],
    col = EmbryoCelltypeColours[colData(sce)$celltype[singlets]],
    pch = 19,
    xaxt = "n", yaxt = "n",
    xlab = "UMAP1", ylab = "UMAP2"
)

## ----message = FALSE----------------------------------------------------------
sce <- EmbryoAtlasData(samples=21, get.spliced=TRUE)
names(assays(sce))

## -----------------------------------------------------------------------------
unfilt <- EmbryoAtlasData(type="raw", samples=c(1:2))
sapply(unfilt, dim)

## -----------------------------------------------------------------------------
sessionInfo()

