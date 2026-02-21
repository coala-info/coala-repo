# Code example from 'CatsCradleSpatial' vignette. See references/ for full tutorial.

## ----[Sp1] setup, include = FALSE, warning = FALSE----------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    fig.dim = c(6,6),
    comment = "#>"
)

## ----[Sp2], message=FALSE-----------------------------------------------------
library(Seurat,quietly=TRUE)
library(CatsCradle,quietly=TRUE)
getExample = make.getExample()
smallXenium = getExample('smallXenium')
ImageDimPlot(smallXenium, cols = "polychrome", size = 1)

## ----[Sp3]--------------------------------------------------------------------
centroids = GetTissueCoordinates(smallXenium)
rownames(centroids) = centroids$cell
clusters = smallXenium@active.ident
delaunayNeighbours = computeNeighboursDelaunay(centroids)
head(delaunayNeighbours)

## ----[Sp4]--------------------------------------------------------------------
idx = (delaunayNeighbours$nodeA == 16307 |
       delaunayNeighbours$nodeB == 16307)
nbhd = unique(c(delaunayNeighbours$nodeA[idx],
                delaunayNeighbours$nodeB[idx]))
nbhd		

## ----[Sp5]--------------------------------------------------------------------
extendedNeighboursList = getExtendedNBHDs(delaunayNeighbours, 4)
extendedNeighbours = collapseExtendedNBHDs(extendedNeighboursList, 4)

## ----[Sp6]--------------------------------------------------------------------
idx = (extendedNeighbours$nodeA == 16307 |
       extendedNeighbours$nodeB == 16307)
nbhd = unique(c(extendedNeighbours$nodeA[idx],
                extendedNeighbours$nodeB[idx]))
length(nbhd)		

## ----[Sp7]--------------------------------------------------------------------
euclideanNeighbours = computeNeighboursEuclidean(centroids,
threshold=20)

## ----[Sp8]--------------------------------------------------------------------
agg = aggregateGeneExpression(smallXenium,extendedNeighbours,
                                    verbose=FALSE)
smallXenium$aggregateNBHDClusters = agg@active.ident
ImageDimPlot(smallXenium,group.by='aggregateNBHDClusters',cols='polychrome')

## ----[Sp9]--------------------------------------------------------------------
NBHDByCTMatrix = computeNBHDByCTMatrix(delaunayNeighbours, clusters)

## ----[Sp10]-------------------------------------------------------------------
NBHDByCTMatrixExtended = 
  computeNBHDByCTMatrix(extendedNeighbours, clusters)

## ----[Sp11]-------------------------------------------------------------------
cellTypesPerCellTypeMatrix = 
  computeCellTypesPerCellTypeMatrix(NBHDByCTMatrix,clusters)

## ----[Sp12]-------------------------------------------------------------------
colours = DiscretePalette(length(levels(clusters)), palette = "polychrome")
names(colours) = levels(clusters)

cellTypesPerCellTypeGraphFromCellMatrix(cellTypesPerCellTypeMatrix, 
                                    minWeight = 0.05, colours = colours)

## ----[Sp13], message=FALSE----------------------------------------------------
library(pheatmap,quietly=TRUE)
pheatmap(cellTypesPerCellTypeMatrix)

## ----[Sp14]-------------------------------------------------------------------
cellTypesPerCellTypeMatrixExtended = computeCellTypesPerCellTypeMatrix(NBHDByCTMatrixExtended,clusters)

cellTypesPerCellTypeGraphFromCellMatrix(cellTypesPerCellTypeMatrixExtended,
minWeight = 0.05, colours = colours)

## ----[Sp15]-------------------------------------------------------------------
cellTypesPerCellTypePValues = computeNeighbourEnrichment(delaunayNeighbours, 
                                          clusters)

## ----[Sp16]-------------------------------------------------------------------
cellTypesPerCellTypePValuesNegLog = -log10(cellTypesPerCellTypePValues + 0.001)
pheatmap(cellTypesPerCellTypePValuesNegLog)

## ----[Sp17]-------------------------------------------------------------------
NBHDByCTSeurat = computeNBHDVsCTObject(NBHDByCTMatrix,verbose=FALSE)

## ----[Sp18]-------------------------------------------------------------------
NBHDByCTSeurat$cellType = clusters

## ----[Sp19]-------------------------------------------------------------------
DimPlot(NBHDByCTSeurat, group.by = c("cellType"), cols = "polychrome", reduction = "umap")
DimPlot(NBHDByCTSeurat, group.by = c("neighbourhood_clusters"), cols = "polychrome", reduction = "umap")

## ----[Sp20]-------------------------------------------------------------------
smallXenium$NBHDCluster = NBHDByCTSeurat@active.ident
ImageDimPlot(smallXenium, group.by = "NBHDCluster", size = 1, cols = "polychrome")

## ----[Sp21]-------------------------------------------------------------------
NBHDByCTSeuratExtended = computeNBHDVsCTObject(NBHDByCTMatrixExtended,
                                               verbose=FALSE)

## ----[Sp22]-------------------------------------------------------------------
NBHDByCTSeuratExtended$cellType = clusters

## ----[Sp23]-------------------------------------------------------------------
DimPlot(NBHDByCTSeuratExtended, group.by = c("cellType"), cols = "polychrome", reduction = "umap")
DimPlot(NBHDByCTSeuratExtended, group.by = c("neighbourhood_clusters"), cols = "polychrome", reduction = "umap")

## ----[Sp24]-------------------------------------------------------------------
smallXenium$NBHDClusterExtended= 
  NBHDByCTSeuratExtended@active.ident
ImageDimPlot(smallXenium, group.by = c("NBHDClusterExtended"), 
             size = 1, cols = "polychrome")

## ----[Sp25]-------------------------------------------------------------------
CTByNBHDCluster = table(NBHDByCTSeurat$cellType,NBHDByCTSeurat@active.ident)
CTByNBHDCluster = CTByNBHDCluster/rowSums(CTByNBHDCluster)

rownames(CTByNBHDCluster) = paste0("CellType",rownames(CTByNBHDCluster))
colnames(CTByNBHDCluster) = paste0("NBHDCluster",colnames(CTByNBHDCluster))

pheatmap(CTByNBHDCluster,
      fontsize_row=8,
      fontsize_col=8,
      cellheight=10,
      cellwidth=10)

sankeyFromMatrix(CTByNBHDCluster)

## ----[Sp26]-------------------------------------------------------------------
CTByNBHDClusterExtended = table(NBHDByCTSeuratExtended$cellType,NBHDByCTSeuratExtended@active.ident)
CTByNBHDClusterExtended = CTByNBHDClusterExtended/rowSums(CTByNBHDClusterExtended)

rownames(CTByNBHDClusterExtended) = paste0("CellType",rownames(CTByNBHDClusterExtended))
colnames(CTByNBHDClusterExtended) = paste0("NBHDCluster",colnames(CTByNBHDClusterExtended))

pheatmap(CTByNBHDClusterExtended,
      fontsize_row=8,
      fontsize_col=8,
      cellheight=10,
      cellwidth=10)

sankeyFromMatrix(CTByNBHDClusterExtended)

## ----[Sp27]-------------------------------------------------------------------
CTByNBHDSeurat = 
  computeNBHDVsCTObject(t(NBHDByCTMatrix), npcs = 10, 
                        transpose = TRUE, resolution = 1, n.neighbors = 5,
			verbose=FALSE)

CTByNBHDSeurat$cellType = colnames(CTByNBHDSeurat)

DimPlot(CTByNBHDSeurat, group.by = "cellType", cols = "polychrome", 
        reduction = "umap", label = TRUE)

## ----[Sp28]-------------------------------------------------------------------
CTByNBHDSeurat= computeGraphEmbedding(CTByNBHDSeurat)

DimPlot(CTByNBHDSeurat,group.by = "cellType", cols = "alphabet", reduction = "graph", label = TRUE)

## ----[Sp29]-------------------------------------------------------------------
ImageDimPlot(smallXenium, cols = "polychrome", size = 1)

## ----[Sp30]-------------------------------------------------------------------
pca = Embeddings(CTByNBHDSeurat, reduction = "pca")
res = pheatmap(pca)

## ----[Sp31]-------------------------------------------------------------------
CTClust = cutree(res$tree_row, k = 11)
CTByNBHDSeurat$neighbourhood_clusters = factor(CTClust)

## ----[Sp32]-------------------------------------------------------------------
CTComposition = table(CTByNBHDSeurat$cellType, CTByNBHDSeurat$neighbourhood_clusters)
pheatmap(CTComposition)

## ----[Sp33]-------------------------------------------------------------------
averageExpMatrix = getAverageExpressionMatrix(NBHDByCTSeurat,
                           CTByNBHDSeurat,
			    clusteringName='neighbourhood_clusters')
averageExpMatrix = tagRowAndColNames(averageExpMatrix,
                                     ccTag='neighbourhoodClusters_',
                                     gcTag='cellTypeClusters_')
pheatmap(averageExpMatrix,
      fontsize_row=8,
      fontsize_col=8,
      cellheight=10,
      cellwidth=10)


sankeyFromMatrix(averageExpMatrix)

## ----[Sp34]-------------------------------------------------------------------
moransI = runMoransI(smallXenium, delaunayNeighbours, assay = "SCT", 
                     layer = "data", nSim = 20, verbose = FALSE)

## ----[Sp35]-------------------------------------------------------------------
head(moransI)

## ----[Sp36]-------------------------------------------------------------------
tail(moransI)

## ----[Sp37]-------------------------------------------------------------------
ImageFeaturePlot(smallXenium, "Nwd2")

## ----[Sp38]-------------------------------------------------------------------
ImageFeaturePlot(smallXenium, "Trbc2")

## ----[Sp39]-------------------------------------------------------------------
ligandReceptorResults = performLigandReceptorAnalysis(smallXenium, delaunayNeighbours, 
                                                "mouse", clusters, 
                                                method = "analytical", 
                                                conditional = FALSE,
                                                minEdgesPos = 10)

## ----[Sp40]-------------------------------------------------------------------
head(as.matrix(ligandReceptorResults$interactionsOnEdges[,1:10]),10)

## ----[Sp41]-------------------------------------------------------------------
head(ligandReceptorResults$totalInteractionsByCluster[,1:10],10)

## ----[Sp42]-------------------------------------------------------------------
head(ligandReceptorResults$meanInteractionsByCluster[,1:10],10)

## ----[Sp43]-------------------------------------------------------------------
head(ligandReceptorResults$pValues,10) 

## ----[Sp44]-------------------------------------------------------------------
ligRecMatrix = makeLRInteractionHeatmap(ligandReceptorResults, clusters, colours = colours, labelClusterPairs = FALSE)

## ----[Sp45]-------------------------------------------------------------------
cellTypePerCellTypeLigRecMatrix = makeSummedLRInteractionHeatmap(ligandReceptorResults, clusters, "total")

## ----[Sp46]-------------------------------------------------------------------
cellTypePerCellTypeLigRecMatrix = makeSummedLRInteractionHeatmap(ligandReceptorResults, clusters, "mean", logScale = TRUE)

## ----[Sp47]-------------------------------------------------------------------
p = plotLRDotplot(ligandReceptorResults, padjCutoff = 0.05, pvalCutoff = F, splitBy = "sender")

## ----[Sp48]-------------------------------------------------------------------
plotLRDotplot(ligandReceptorResults, senderClusters = c("6_VLMC","7_Granule"), 
              padjCutoff = 0.05, pvalCutoff = F, splitBy = "sender")

## ----[Sp49]-------------------------------------------------------------------
hist(cellTypePerCellTypeLigRecMatrix)

## ----[Sp50]-------------------------------------------------------------------
cellTypesPerCellTypeGraphFromCellMatrix(cellTypePerCellTypeLigRecMatrix, 
                                    minWeight = 0.4, colours = colours)

## ----[Sp51]-------------------------------------------------------------------
scaleFactor = 3
cellTypesPerCellTypeGraphFromCellMatrix(cellTypePerCellTypeLigRecMatrix/scaleFactor, 
                                    minWeight = 0.4/scaleFactor, colours = colours)

## ----[Sp52]-------------------------------------------------------------------
edgeSeurat = computeEdgeObject(ligandReceptorResults, centroids)

## ----[Sp53]-------------------------------------------------------------------
ImageFeaturePlot(edgeSeurat, features = "Pdyn-Npy2r")

## ----[Sp54]-------------------------------------------------------------------
edgeNeighbours = computeEdgeGraph(delaunayNeighbours)

## ----[Sp55] , eval=FALSE------------------------------------------------------
# moransILigandReceptor = runMoransI(edgeSeurat, edgeNeighbours, assay = "RNA",
#                      layer = "counts", nSim = 100)

## ----[Sp56]-------------------------------------------------------------------
moransILigandReceptor = getExample('moransILigandReceptor')
head(moransILigandReceptor)

## ----[Sp57]-------------------------------------------------------------------
tail(moransILigandReceptor)

## ----[Sp58]-------------------------------------------------------------------
ImageFeaturePlot(edgeSeurat, "Penk-Htr1f")

## ----[Sp59]-------------------------------------------------------------------
ImageFeaturePlot(edgeSeurat, "Sst-Gpr17")

## ----[Sp60]-------------------------------------------------------------------
annEdges =
edgeLengthsAndCellTypePairs(delaunayNeighbours,clusters,centroids)
head(annEdges)

## ----[Sp61]-------------------------------------------------------------------
cutoffDF = edgeCutoffsByPercentile(annEdges,percentileCutof=95)
g = edgeLengthPlot(annEdges,cutoffDF,whichPairs=60)
print(g)

## ----[Sp62]-------------------------------------------------------------------
cutoffDF = edgeCutoffsByClustering(annEdges)

## ----[Sp63]-------------------------------------------------------------------
cutoffDF = edgeCutoffsByPercentile(annEdges,percentileCutoff=95)

## ----[Sp65]-------------------------------------------------------------------
cutoffDF = edgeCutoffsByZScore(annEdges,zCutoff=1.5)

## ----[Sp66]-------------------------------------------------------------------
cutoffDF = edgeCutoffsByWatershed(annEdges,nbins=15,tolerance=10)

## ----[Sp67]-------------------------------------------------------------------
cutoffDF = edgeCutoffsByWatershed(annEdges,nbins=15,tolerance=10)
culledEdges = cullEdges(annEdges,cutoffDF)
nrow(annEdges)
nrow(culledEdges)

## ----[Sp68]-------------------------------------------------------------------
sessionInfo()

