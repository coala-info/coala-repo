# Code example from 'CatsCradleSingleCellExperimentQuickStart' vignette. See references/ for full tutorial.

## ----[SCE1] setup, include = FALSE, warning = FALSE---------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    fig.dim = c(6,6),
    comment = "#>"
)

## ----[SCE2], message=FALSE----------------------------------------------------
library(SingleCellExperiment,quietly=TRUE)
library(CatsCradle,quietly=TRUE)
library(ggplot2,quietly=TRUE)
getExample = make.getExample()
S_sce = getExample('S_sce')
df = as.data.frame(reducedDim(S_sce,'UMAP'))
df$seurat_clusters = S_sce$seurat_clusters
g = ggplot(df,aes(x=UMAP_1,y=UMAP_2,color=seurat_clusters)) +
    geom_point() +
    ggtitle('SingleCellExperiment of cells colored by seurat_cluster')
print(g)    

## ----[SCE3]-------------------------------------------------------------------
STranspose_sce = getExample('STranspose_sce')
print(STranspose_sce)
df = as.data.frame(reducedDim(STranspose_sce,'UMAP'))
df$seurat_clusters = STranspose_sce$seurat_clusters
h = ggplot(df,aes(x=umap_1,y=umap_2,color=seurat_clusters)) +
    geom_point() +
    ggtitle('SingleCellExperiment of genes colored by cluster')
print(h)  



## ----[SCE4]-------------------------------------------------------------------
hallmark = getExample('hallmark')
h = 'HALLMARK_OXIDATIVE_PHOSPHORYLATION'

idx = colnames(STranspose_sce) %in% hallmark[[h]]

k = ggplot(data=df,aes(x=umap_1,y=umap_2,color=seurat_clusters)) +
    geom_point() + 
    geom_point(data=df[idx,],aes(x=umap_1,y=umap_2),color='black',size=2.7) +
    geom_point(data=df[idx,],aes(x=umap_1,y=umap_2),color='green') +
    ggtitle(paste(h,'\non gene clusters'))

print(k)
pValue = getObjectSubsetClusteringPValue(STranspose_sce,idx)
pValue

## ----[SCE5], message=FALSE----------------------------------------------------
library(SpatialExperiment)
X_sce = getExample('X_sce')
cellCoords = as.data.frame(spatialCoords(X_sce))
cellCoords$cluster = X_sce$cluster
ell = ggplot(cellCoords,aes(x=x,y=y,color=cluster)) +
      geom_point() +
      ggtitle('Spatial coordinates colored by cell type')
print(ell)      

## ----[SCE6]-------------------------------------------------------------------
delaunayNeighbours = getExample('delaunayNeighbours')
head(delaunayNeighbours,10)

## ----[SCE7]-------------------------------------------------------------------
NBHDByCTMatrixExtended = getExample('NBHDByCTMatrixExtended')
clusters = getExample('clusters')
colours = getExample('colours')
cellTypesPerCellTypeMatrixExtended =
      computeCellTypesPerCellTypeMatrix(NBHDByCTMatrixExtended,clusters)

cellTypesPerCellTypeGraphFromCellMatrix(cellTypesPerCellTypeMatrixExtended,
                                        minWeight = 0.05, colours = colours)

## ----[SCE8]-------------------------------------------------------------------
NBHDByCTSingleCellExtended_sce = getExample('NBHDByCTSingleCellExtended_sce')
cellCoords$neighbourhood_clusters =
  NBHDByCTSingleCellExtended_sce$neighbourhood_clusters
nbhdPlot = ggplot(cellCoords,aes(x=x,y=y,color=neighbourhood_clusters)) +
           geom_point() +
	   ggtitle('Cell coordinates colored by neighbourhood_clusters')
print(nbhdPlot)	   

## ----[SCE9]-------------------------------------------------------------------
extendedNeighbours = getExample('extendedNeighbours')
smallXenium = getExample('smallXenium')
agg_sce = aggregateGeneExpression(smallXenium,extendedNeighbours,
                                    verbose=FALSE,
				    returnType='sce')
cellCoords$aggregation_clusters = agg_sce$aggregation_clusters
aggPlot = ggplot(cellCoords,aes(x=x,y=y,color=aggregation_clusters)) +
           geom_point() +
	   ggtitle('Cell coordinates colored by aggregation_clusters')
print(aggPlot)	  

## ----[SCE10], message=FALSE---------------------------------------------------
library(pheatmap)
tab = table(cellCoords[,c('aggregation_clusters','neighbourhood_clusters')])
                             
M = matrix(as.numeric(tab),nrow=nrow(tab))
rownames(M) = paste('aggregation_cluster',rownames(tab))
colnames(M) = paste('nbhd_cluster',colnames(tab))
for(i in 1:nrow(M)) M[i,] = M[i,] / sum(M[i,])
pheatmap(M)

## ----[SCE11], message=FALSE---------------------------------------------------
library(fossil,quietly=TRUE)
adjustedRandIndex = adj.rand.index(agg_sce$aggregation_clusters,
                       NBHDByCTSingleCellExtended_sce$neighbourhood_clusters)
adjustedRandIndex

## ----[SCE12]------------------------------------------------------------------
ligandReceptorResults = getExample('ligandReceptorResults')
ligandReceptorResults$interactionsOnEdges[1:10,1:10]

## ----[SCE13]------------------------------------------------------------------
sessionInfo()

