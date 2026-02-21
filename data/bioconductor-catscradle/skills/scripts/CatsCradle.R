# Code example from 'CatsCradle' vignette. See references/ for full tutorial.

## ----setup, include = FALSE, warning = FALSE----------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    fig.dim=c(6,6),
    comment = "#>"
)

## ----[CC1], message=FALSE-----------------------------------------------------
library(CatsCradle,quietly=TRUE)
getExample = make.getExample()
exSeuratObj = getExample('exSeuratObj')
STranspose = transposeObject(exSeuratObj)

## ----[CC2], message=FALSE-----------------------------------------------------
library(Seurat,quietly=TRUE)
library(ggplot2,quietly=TRUE)
DimPlot(exSeuratObj,cols='polychrome') + ggtitle('Cell clusters on UMAP')

## ----[CC3]--------------------------------------------------------------------
DimPlot(STranspose,cols='polychrome') + ggtitle('Gene clusters on UMAP')

## ----[CC4], eval = FALSE------------------------------------------------------
# library(plotly,quietly=TRUE)
# umap = FetchData(STranspose,c('UMAP_1','UMAP_2','seurat_clusters'))
# umap$gene = colnames(STranspose)
# plot = ggplot(umap,aes(x=UMAP_1,y=UMAP_2,color=seurat_clusters,label=gene) +
#        geom_point()
# browseable = ggplotly(plot)
# print(browseable)
# htmlwidgets::saveWidget(as_widget(browseable),'genesOnUMAP.html')

## ----[CC5], message=FALSE-----------------------------------------------------
library(pheatmap,quietly=TRUE)
averageExpMatrix = getAverageExpressionMatrix(exSeuratObj,STranspose,layer='data')
averageExpMatrix = tagRowAndColNames(averageExpMatrix,
                                     ccTag='cellClusters_',
                                     gcTag='geneClusters_')
pheatmap(averageExpMatrix,
      treeheight_row=0,
      treeheight_col=0,
      fontsize_row=8,
      fontsize_col=8,
      cellheight=10,
      cellwidth=10,
      main='Cell clusters vs. Gene clusters')

## ----[CC6], eval = FALSE------------------------------------------------------
# catsCradle = sankeyFromMatrix(averageExpMatrix,
#                               disambiguation=c('cells_','genes_'),
#                               plus='cyan',minus='pink',
#                               height=800)
# print(catsCradle)

## ----[CC7]--------------------------------------------------------------------
hallmark = getExample('hallmark')
h = 'HALLMARK_G2M_CHECKPOINT'
umap = FetchData(STranspose,c('umap_1','umap_2'))
idx = colnames(STranspose) %in% hallmark[[h]]
g = DimPlot(STranspose,cols='polychrome') +
    geom_point(data=umap[idx,],aes(x=umap_1,y=umap_2),color='black',size=2.7) +
    geom_point(data=umap[idx,],aes(x=umap_1,y=umap_2),color='green') +
    ggtitle(paste(h,'\non gene clusters'))
print(g)

## ----[CC8]--------------------------------------------------------------------
g2mGenes = intersect(colnames(STranspose),
                     hallmark[['HALLMARK_G2M_CHECKPOINT']])
stats = getObjectSubsetClusteringStatistics(STranspose,
                                      g2mGenes,
                                      numTrials=1000)

## ----[CC9]--------------------------------------------------------------------
statsPlot = ggplot(data.frame(medianComplementDistance=stats$randomSubsetDistance),
                  aes(x=medianComplementDistance)) +
    geom_histogram(bins=50) +
    geom_vline(xintercept=stats$subsetDistance,color='red') +
    ggtitle('Hallmark G2M real and random median complement distance')
print(statsPlot)

## ----[CC10]-------------------------------------------------------------------
df = read.table('hallmarkPValues.txt',header=TRUE,sep='\t')
g = ggplot(df,aes(x=logPValue)) +
    geom_histogram() +
    geom_vline(xintercept=-log10(0.05)) +
    ggtitle('Hallmark gene set p-values')
print(g)

## ----[CC10.5]-----------------------------------------------------------------
h = "HALLMARK_ALLOGRAFT_REJECTION"
theSubset = hallmark[[h]]
theSubset = intersect(theSubset,colnames(STranspose))
alpha = .5
clusters = getSubsetComponents(STranspose,theSubset,alpha)
umap = FetchData(STranspose,c('umap_1','umap_2'))
umap$gene = rownames(umap)
numClusters = length(clusters)
umap$component = 0
for(i in 1:length(clusters))
    umap[clusters[[i]],'component'] = i
umap$component = factor(umap$component)
title = paste(h,'alpha =',alpha)
idx = umap$component != 0
g = ggplot() +
    geom_point(data=umap,aes(x=umap_1,y=umap_2),color='grey') +
    geom_point(data=umap[idx,],aes(x=umap_1,y=umap_2),color='black',size=3.5) +
    geom_point(data=umap[idx,],aes(x=umap_1,y=umap_2,color=component),size=3) +
    ggtitle(title)
print(g)

## ----[CC11]-------------------------------------------------------------------
meanZDF	 = meanZPerClusterOnUMAP(exSeuratObj,
                                 STranspose,
	                         'shortName')


h = ggplot(meanZDF,aes(x=umap_1,y=umap_2,color=EntericGliaCells)) +
    geom_point() +
    scale_color_gradient(low='green',high='red') +
    ggtitle('Mean z-score, Enteric glia on gene UMAP')
print(h)

## ----[CC12]-------------------------------------------------------------------
TDiff = meanZDF[,1:3]
TDiff$TDiff = meanZDF$TCells3 - meanZDF$TCells1
k = ggplot(TDiff,aes(x=umap_1,y=umap_2,color=TDiff)) +
    geom_point() +
    scale_color_gradient(low='green',high='red') +
    ggtitle('Mean z-score, TCells3 - TCells1')
print(k)

## ----[CC13]-------------------------------------------------------------------
geneSet = intersect(colnames(STranspose),
                    hallmark[['HALLMARK_INTERFERON_ALPHA_RESPONSE']])
geometricallyNearbyGenes = getNearbyGenes(STranspose,geneSet,radius=0.2,metric='umap')
theGeometricGenesThemselves = names(geometricallyNearbyGenes)
combinatoriallyNearbyGenes = getNearbyGenes(STranspose,geneSet,radius=1,metric='NN')
theCombinatoricGenesThemselves = names(combinatoriallyNearbyGenes)
df = FetchData(STranspose,c('umap_1','umap_2'))
df$gene = colnames(STranspose)
geneSetIdx = df$gene %in% geneSet
nearbyIdx = df$gene %in% theGeometricGenesThemselves
g = ggplot() +
    geom_point(data=df,aes(x=umap_1,y=umap_2),color='gray') +
    geom_point(data=df[geneSetIdx,],aes(x=umap_1,y=umap_2),color='blue') +
    geom_point(data=df[nearbyIdx,],aes(x=umap_1,y=umap_2),color='red') +
    ggtitle(paste0('Genes within geometric radius 0.2 (red) of \n',
                     'HALLMARK_INTERFERON_ALPHA_RESPONSE (blue)'))
print(g)

## ----[CC14]-------------------------------------------------------------------
annotatedGenes = annotateGenesByGeneSet(hallmark)
names(annotatedGenes[['Myc']])

## ----[CC15]-------------------------------------------------------------------
 Myc = annotateGeneAsVector('Myc',hallmark)
 MycNormalised = annotateGeneAsVector('Myc',hallmark,TRUE)

## ----[CC16]-------------------------------------------------------------------
predicted = predictAnnotation('Myc',hallmark,STranspose,radius=.5)
predicted$Myc[1:10]

## ----[CC17]-------------------------------------------------------------------
sessionInfo()

