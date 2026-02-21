# Code example from 'CatsCradleQuickStart' vignette. See references/ for full tutorial.

## ----setup, include = FALSE, warning = FALSE----------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    fig.dim = c(6,6),
    comment = "#>"
)

## ----[QS1], message=FALSE-----------------------------------------------------
library(Seurat,quietly=TRUE)
library(CatsCradle,quietly=TRUE)
data(exSeuratObj)
DimPlot(exSeuratObj,cols='polychrome')

## ----[QS2]--------------------------------------------------------------------
getExample = make.getExample()
STranspose = getExample('STranspose')
print(STranspose)
DimPlot(STranspose,cols='polychrome')

## ----[QS3], message=FALSE-----------------------------------------------------
library(ggplot2,quietly=TRUE)
hallmark = getExample('hallmark')
h = 'HALLMARK_OXIDATIVE_PHOSPHORYLATION'
umap = FetchData(STranspose,c('umap_1','umap_2'))
idx = colnames(STranspose) %in% hallmark[[h]]
g = DimPlot(STranspose,cols='polychrome') +
    geom_point(data=umap[idx,],aes(x=umap_1,y=umap_2),color='black',size=2.7) +
    geom_point(data=umap[idx,],aes(x=umap_1,y=umap_2),color='green') +
    ggtitle(paste(h,'\non gene clusters'))
print(g)
pValue = getObjectSubsetClusteringPValue(STranspose,idx)
pValue

## ----[QS4]--------------------------------------------------------------------
smallXenium = getExample('smallXenium')
ImageDimPlot(smallXenium,cols='polychrome')

## ----[QS5]--------------------------------------------------------------------
delaunayNeighbours = getExample('delaunayNeighbours')
head(delaunayNeighbours,10)

## ----[QS6]--------------------------------------------------------------------
NBHDByCTMatrixExtended = getExample('NBHDByCTMatrixExtended')
clusters = getExample('clusters')
colours = getExample('colours')
cellTypesPerCellTypeMatrixExtended = computeCellTypesPerCellTypeMatrix(NBHDByCTMatrixExtended,clusters)

cellTypesPerCellTypeGraphFromCellMatrix(cellTypesPerCellTypeMatrixExtended, minWeight = 0.05, colours = colours)

## ----[QS7]--------------------------------------------------------------------
NBHDByCTSeuratExtended = getExample('NBHDByCTSeuratExtended')
smallXenium$NBHDClusterExtended= 
  NBHDByCTSeuratExtended@active.ident
ImageDimPlot(smallXenium, group.by = c("NBHDClusterExtended"), 
             size = 1, cols = "polychrome")

## ----[QS8]--------------------------------------------------------------------
extendedNeighbours = getExample('extendedNeighbours')
agg = aggregateGeneExpression(smallXenium,extendedNeighbours,
                                    verbose=FALSE)
smallXenium$aggregateNBHDClusters = agg@active.ident
ImageDimPlot(smallXenium,group.by='aggregateNBHDClusters',cols='polychrome',
             size=1)

## ----[QS9], message=FALSE-----------------------------------------------------
library(pheatmap)
tab = table(smallXenium@meta.data[,c("aggregateNBHDClusters",
                                     "NBHDClusterExtended" )])
M = matrix(as.numeric(tab),nrow=nrow(tab))
rownames(M) = paste('aggregation_cluster',rownames(tab))
colnames(M) = paste('nbhd_cluster',colnames(tab))
for(i in 1:nrow(M)) M[i,] = M[i,] / sum(M[i,])
pheatmap(M)

## ----[QS10], message=FALSE----------------------------------------------------
library(fossil,quietly=TRUE)
adjustedRandIndex = adj.rand.index(agg@active.ident,
                                   NBHDByCTSeuratExtended@active.ident)
adjustedRandIndex

## ----[QS11]-------------------------------------------------------------------
ligandReceptorResults = getExample('ligandReceptorResults')
ligandReceptorResults$interactionsOnEdges[1:10,1:10]

## ----[QS12]-------------------------------------------------------------------
sessionInfo()

