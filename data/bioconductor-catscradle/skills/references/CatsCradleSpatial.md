# CatsCradle Spatial Vignette

#### Anna Laddach and Michael Shapiro

#### 2025-12-25

*[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)*

![](data:image/png;base64...)

## Introduction

Here we describe the tools that CatsCradle offers for exploiting the spatial relationships in spatial transcriptomics data.

We will be using a subset of a Xenium data set that profiles the mouse hippocampus available from 10x genomics (<https://www.10xgenomics.com/datasets/fresh-frozen-mouse-brain-for-xenium-explorer-demo-1-standard>)

Here we visualise this subset coloured by cell type. Here cell clusters (Louvain cluster) have been assigned cell type identities using RCTD along with a reference dataset (<https://www.dropbox.com/s/cuowvm4vrf65pvq/allen_cortex.rds?dl=1>) followed by minimal manual curation. Please note these assignments are not definitive and are for illustratory purporses only.

```
library(Seurat,quietly=TRUE)
library(CatsCradle,quietly=TRUE)
getExample = make.getExample()
smallXenium = getExample('smallXenium')
ImageDimPlot(smallXenium, cols = "polychrome", size = 1)
```

![](data:image/png;base64...)

We will want to answer questions like the following:

Is the expression of a particular gene localised? Who are the immediate neighbours of a given cell? Do certain types of cells tend to co-localise? Is the spatial association of two cell types, (say, glia and macrophages) statistically significant? For any pair of neighbouring cells, are they engaged in ligand-repceptor interactions? Can we classify different types of tissue neighbourhoods? Are different neighbourhood types characterised by the cell types found in them? The genes expressed in them? The ligand-receptor interactions taking place in them?

### Neighbourhoods

A key concept here is that of a *neighbourhood*. A neighbourhood is a spatially contiguous set of cells. In every case we will consider, a neighbourhood is a set of cells *centred on a particular cell*.

The simplest sort of neighbourhood consists of a cell together with its immediate neighbours. We compute these as a Delaunay triangulation using the centroids of the cells:

```
centroids = GetTissueCoordinates(smallXenium)
rownames(centroids) = centroids$cell
clusters = smallXenium@active.ident
delaunayNeighbours = computeNeighboursDelaunay(centroids)
head(delaunayNeighbours)
#>   nodeA nodeB
#> 1 16307 16316
#> 2 16314 16317
#> 3 16296 16299
#> 4 16299 16307
#> 5 16309 16316
#> 6 16309 16314
```

Two cells are neighbours if they appear on the same row. The neighbourhood of the cell 16307 consists of the following 7 cells:

```
idx = (delaunayNeighbours$nodeA == 16307 |
       delaunayNeighbours$nodeB == 16307)
nbhd = unique(c(delaunayNeighbours$nodeA[idx],
                delaunayNeighbours$nodeB[idx]))
nbhd
#> [1] "16307" "16299" "16303" "16298" "16296" "16316" "16317"
```

We can compute extended neighbourhoods by considering (say) each cell’s neighbours, their neighbours, their neighbours and their neighbours. Here we have such an extended neighbourhood as a list and again as a data frame with each row giving a pair of cells in a common extended neighbourhood. In this case we are building an extended neighbourhood of combinatorial radius 4.

```
extendedNeighboursList = getExtendedNBHDs(delaunayNeighbours, 4)
#> radius 2
#> radius 3
#> radius 4
extendedNeighbours = collapseExtendedNBHDs(extendedNeighboursList, 4)
```

Now the extended neighbourhood of cell 16307 consists of 92 cells:

```
idx = (extendedNeighbours$nodeA == 16307 |
       extendedNeighbours$nodeB == 16307)
nbhd = unique(c(extendedNeighbours$nodeA[idx],
                extendedNeighbours$nodeB[idx]))
length(nbhd)
#> [1] 92
```

We can also create neighbours based on Euclidean distance in the tissue.

```
euclideanNeighbours = computeNeighboursEuclidean(centroids,
threshold=20)
```

We see two reasons for looking at these extended neighbourhoods. One is that while the Delaunay triangulation might be more appropriate for looking at cell to cell interactions involving direct contact, extended neighbourhoods might be more appropriate for studying interactions based on diffusible ligands. The second is that when we go on to characterise *types* of neighbourhoods, these extended neighbourhoods exhibit less noise.

We offer two viewpoints as to what is “going on” in a neighbourhood. One is that a neighbourhood is characterised by the cell types that are found in it. In this view, just as a cell expresses genes, a neighbourhood “expresses” cell types. A second viewpoint is that a neighbourhood also expresses genes. That is, for each neighbourhood, we can compute the total gene expression across all the cells in that neighbourhood.

In this vignette we will focus on the first viewpoint. This is not because we think the first viewpoint is more important or because we necessarily expect it to be more fruitful. It’s because the second viewpoint so directly parallels standard Seurat single cell transcriptomics analyses that it requires less explanation. So before we move on to the neighbourhoods / cell types viewpoint, we give an overview of the neighbourhoods / aggregate gene expression viewpoint.

### Neighbourhoods as characterised by gene expression

Here we create a Seurat object based on the aggregate gene expression in each of our extended neighbourhoods and display the clustering of the neighbourhoods (called aggregation\_clusters) both on the tissue plot and on the resulting UMAP.

```
agg = aggregateGeneExpression(smallXenium,extendedNeighbours,
                                    verbose=FALSE)
#> Warning: Data is of class matrix. Coercing to dgCMatrix.
smallXenium$aggregateNBHDClusters = agg@active.ident
ImageDimPlot(smallXenium,group.by='aggregateNBHDClusters',cols='polychrome')
```

![](data:image/png;base64...)

Since neighbourhoods here are indexed by individual cells, the neighbourhood gene aggregation Seurat object is formally identical to a standard Seurat object. In particular, this allows the standard sorts of analyses including clustering of neighbourhoods into types; dimension reduction using PCA, UMAP, tSNE; discovery of marker genes for each neighbourhood type; plotting of aggregate gene expression on neighbourhood UMAP; use of CatsCradle to discover novel clustering of genes based on their expression across the different neighbourhoods.

## Neighbourhoods as characterised by cell types

### Calculation of neighbourhood celltype composition

Given any of the spatial graphs describing neighbourhoods calculated above, we can now calculate the cell type composition of neighbourhoods.

```
NBHDByCTMatrix = computeNBHDByCTMatrix(delaunayNeighbours, clusters)
```

In the resulting matrix neighbourhoods are rows and cell types are columns. The values in the matrix indicate the number of cells of a given type within a neighbourhood.

Let’s do the same for our extended neighbourhoods.

```
NBHDByCTMatrixExtended =
  computeNBHDByCTMatrix(extendedNeighbours, clusters)
```

### Analysis of contact based interactions between cell types

We can go on to calculate a matrix which gives the fraction of contacts cells of a given type make with cells of another cell type.

```
cellTypesPerCellTypeMatrix =
  computeCellTypesPerCellTypeMatrix(NBHDByCTMatrix,clusters)
```

Rows and columns both correspond to cell types, but they are playing different roles. For a given row (say, cell type A) the entry in column B represents the fraction of cells in neighbourhoods of cells of type A that are of type B.

We can then display this as a force directed graph. Here we choose only to display contact based interactions that constitute at least 5% of a cell type’s interactions. Of note, this graph is directed as, for example, 50% of cell type A’s interactions might be with cell type B, but only 5% of cell type B’s interactions might be with cell type A.

```
colours = DiscretePalette(length(levels(clusters)), palette = "polychrome")
names(colours) = levels(clusters)

cellTypesPerCellTypeGraphFromCellMatrix(cellTypesPerCellTypeMatrix,
                                    minWeight = 0.05, colours = colours)
```

![](data:image/png;base64...)

```
#> IGRAPH be1f8a5 DNW- 16 55 --
#> + attr: coords (g/n), name (v/c), color (v/c), weight (e/n), width
#> | (e/n)
#> + edges from be1f8a5 (vertex names):
#>  [1] 0_Oligo->3_Endo       0_Oligo->5_Astro      0_Oligo->10_Astro
#>  [4] 0_Oligo->11_Oligo     0_Oligo->13_Microglia 0_Oligo->14_Ependymal
#>  [7] 3_Endo ->0_Oligo      3_Endo ->5_Astro      3_Endo ->10_Astro
#> [10] 3_Endo ->11_Oligo     4_Astro->0_Oligo      4_Astro->3_Endo
#> [13] 4_Astro->5_Astro      4_Astro->6_VLMC       4_Astro->7_Granule
#> [16] 4_Astro->10_Astro     4_Astro->11_Oligo     4_Astro->14_Ependymal
#> [19] 4_Astro->17_Lamp5     4_Astro->20_VLMC      5_Astro->3_Endo
#> + ... omitted several edges
```

Here arrows are directed from rows to columns. Thus, we see an arrow from 12\_Pvalb to 18\_pyramidal because neighbourhoods of cells of type 12\_Pvalb are composed (across the dataset) of ~15% cells of type 18\_pyramidal. We do not see an arrow from 18\_pyramidal to 12\_Pvalb because neighbourhoods of cells of type 18\_pyramidal have only 3% cells of type 12\_Pvalb, which falls below the chosen cutoff.

It’s worth pointing out the following. The number of edges from cells of type A to cells of type B is the same as the number of edges from cells of type B to cells of type A. Thus the matrix of counts of these edges is symmetric. However, numbers of cells of types A and B are not necessarily equal, and this accounts for the assymmetry in the fractions.

```
library(pheatmap,quietly=TRUE)
pheatmap(cellTypesPerCellTypeMatrix)
```

![](data:image/png;base64...)

Let’s do the same for our extended nighbourhoods.

```
cellTypesPerCellTypeMatrixExtended = computeCellTypesPerCellTypeMatrix(NBHDByCTMatrixExtended,clusters)

cellTypesPerCellTypeGraphFromCellMatrix(cellTypesPerCellTypeMatrixExtended,
minWeight = 0.05, colours = colours)
```

![](data:image/png;base64...)

```
#> IGRAPH 0a6fa3a DNW- 16 62 --
#> + attr: coords (g/n), name (v/c), color (v/c), weight (e/n), width
#> | (e/n)
#> + edges from 0a6fa3a (vertex names):
#>  [1] 0_Oligo->3_Endo       0_Oligo->10_Astro     0_Oligo->11_Oligo
#>  [4] 0_Oligo->14_Ependymal 3_Endo ->0_Oligo      3_Endo ->5_Astro
#>  [7] 3_Endo ->6_VLMC       3_Endo ->10_Astro     3_Endo ->11_Oligo
#> [10] 3_Endo ->14_Ependymal 4_Astro->0_Oligo      4_Astro->5_Astro
#> [13] 4_Astro->6_VLMC       4_Astro->7_Granule    4_Astro->10_Astro
#> [16] 4_Astro->11_Oligo     4_Astro->14_Ependymal 4_Astro->20_VLMC
#> [19] 5_Astro->6_VLMC       5_Astro->11_Oligo     6_VLMC ->10_Astro
#> + ... omitted several edges
```

We can also calculate p values (upper tail, one-sided) for whether cell types are more commonly neighbours than expected by chance. To do this we compare the actual spatial neighbour graph to randomised spatial neighbour graphs where edges are randomised but the degree of each vertice is preserved. As this is carried out on the level of counts of undirected edges between celltypes the p value matrix is symmetric.

```
cellTypesPerCellTypePValues = computeNeighbourEnrichment(delaunayNeighbours,
                                          clusters)
```

By default it calculates p-values analytically using a hypergeometric test on the edges, where the arguments to the R phyper function are as follows: q = number of edges between cell type A and B m = number of edges between cell type B and any other cell type n = the number of edges between any cell type apart from cell type B k = number of edges between cell type B and any other cell type

The purist may object to the use of the hypergeometric test here. We may think of “edges out of a cell of type A” as being the random draw balls (here, edges) from the urn and “edges out of cells of type B” as being success. However, all edges out of a given cell of type A are in this “random draw”. Clearly the edges in this draw are not independent. However, empirically we find that p-values computed using this method correspond very closely to those computed using permutation while the computation time is orders of magnitude faster.

For legacy purposes, and user flexibility, we allow for the calculation of p-values by comparison to randomised graphs. The function offers two methods of randomisation, controlled by the parameter randomiseBy. With the value randomiseBy=‘cells’, the default, randomisaiton is carried out by fixing the underlying graph (e.g., Delaunay neigbhours graph) and permuting the cell types. For counting purposes, we keep the actual cell type at the center of each neighbourhood and count the permuted cell types surrounding it. With the value randomiseBy = ‘graph’ we use the function randomiseGraph() to permute the underlying graph. This uses a heuristic to produce a random graph which preserves the degrees of the vertices. When applied to a Delaunay neighbours graph this can produce a small number of self-edges and a small number of duplicated edges. In our experience, these are sufficiently few in number as to not interfere with the use of this randomisation method for permutation testing. randomiseBy=‘cells’ is quicker.

Let’s plot -log10(pvalue)

```
cellTypesPerCellTypePValuesNegLog = -log10(cellTypesPerCellTypePValues + 0.001)
pheatmap(cellTypesPerCellTypePValuesNegLog)
```

![](data:image/png;base64...)

## Analysis of neighbourhoods based on cell type composition

As mentioned above we can create Seurat objects of neighbourhoods where the underlying counts matrix gives the the number of cells of each type in a given neighbourhood. We can now perform dimensionality reduction and clustering based on neighbourhood composition. As the dimensionality of the feature space is relatively low (number of cell types) we calculate the UMAP using features rather than PCs.

```
NBHDByCTSeurat = computeNBHDVsCTObject(NBHDByCTMatrix,verbose=FALSE)
#> Warning: Feature names cannot have underscores ('_'), replacing with dashes
#> ('-')
#> Warning: Data is of class matrix. Coercing to dgCMatrix.
#> Warning in svd.function(A = t(x = object), nv = npcs, ...): You're computing
#> too large a percentage of total singular values, use a standard svd instead.
#> Modularity Optimizer version 1.3.0 by Ludo Waltman and Nees Jan van Eck
#>
#> Number of nodes: 4261
#> Number of edges: 165647
#>
#> Running Louvain algorithm...
#> Maximum modularity in 10 random starts: 0.9825
#> Number of communities: 17
#> Elapsed time: 0 seconds
```

Add cell type information to the neighbourhoodSeurat object.

```
NBHDByCTSeurat$cellType = clusters
```

Visualise neighbourhood clusters.

```
DimPlot(NBHDByCTSeurat, group.by = c("cellType"), cols = "polychrome", reduction = "umap")
```

![](data:image/png;base64...)

```
DimPlot(NBHDByCTSeurat, group.by = c("neighbourhood_clusters"), cols = "polychrome", reduction = "umap")
```

![](data:image/png;base64...)

We can now add information on neighbourhood clusters to our original Xenium object and visualise these on the tissue.

```
smallXenium$NBHDCluster = NBHDByCTSeurat@active.ident
ImageDimPlot(smallXenium, group.by = "NBHDCluster", size = 1, cols = "polychrome")
```

![](data:image/png;base64...)

Let’s try the same thing with our extended neighbourhoods up to degree 4.

```
NBHDByCTSeuratExtended = computeNBHDVsCTObject(NBHDByCTMatrixExtended,
                                               verbose=FALSE)
#> Warning: Feature names cannot have underscores ('_'), replacing with dashes
#> ('-')
#> Warning: Data is of class matrix. Coercing to dgCMatrix.
#> Warning in svd.function(A = t(x = object), nv = npcs, ...): You're computing
#> too large a percentage of total singular values, use a standard svd instead.
#> Modularity Optimizer version 1.3.0 by Ludo Waltman and Nees Jan van Eck
#>
#> Number of nodes: 4261
#> Number of edges: 105168
#>
#> Running Louvain algorithm...
#> Maximum modularity in 10 random starts: 0.9694
#> Number of communities: 8
#> Elapsed time: 0 seconds
```

Add cell type information to the NBHDByCTSeuratExtended object.

```
NBHDByCTSeuratExtended$cellType = clusters
```

Visualise extended neighbourhood clusters.

```
DimPlot(NBHDByCTSeuratExtended, group.by = c("cellType"), cols = "polychrome", reduction = "umap")
```

![](data:image/png;base64...)

```
DimPlot(NBHDByCTSeuratExtended, group.by = c("neighbourhood_clusters"), cols = "polychrome", reduction = "umap")
```

![](data:image/png;base64...)

We can now add information on extended neighbourhood clusters to our original Xenium object and visualise these on the tissue.

```
smallXenium$NBHDClusterExtended=
  NBHDByCTSeuratExtended@active.ident
ImageDimPlot(smallXenium, group.by = c("NBHDClusterExtended"),
             size = 1, cols = "polychrome")
```

![](data:image/png;base64...)

Here we retrieve fewer clusters, and these describe tissue architecture rather than small variations in cellular niche.

We leave it to the user to decide which approach is most applicable to the biological question at hand.

## Relating cell type clusters to neighbourhood clusters

We can now ask how clusters defined transcriptomically (cell type) relate to those defined based on neighbourhoods (cell niche). Put differently, each cell has its (transcriptomic) cell type and sits at the center of a neighbourhood with a given neighbourhood type. For each cell type A and each neighbourhood type B, we can ask what percentage of the time a cell of type A sits at the center of a neighbourhood of type B.

```
CTByNBHDCluster = table(NBHDByCTSeurat$cellType,NBHDByCTSeurat@active.ident)
CTByNBHDCluster = CTByNBHDCluster/rowSums(CTByNBHDCluster)

rownames(CTByNBHDCluster) = paste0("CellType",rownames(CTByNBHDCluster))
colnames(CTByNBHDCluster) = paste0("NBHDCluster",colnames(CTByNBHDCluster))

pheatmap(CTByNBHDCluster,
      fontsize_row=8,
      fontsize_col=8,
      cellheight=10,
      cellwidth=10)
```

![](data:image/png;base64...)

```
sankeyFromMatrix(CTByNBHDCluster)
```

This allows us to see which cell types share the same niche (neighbourhood clusters). Let’s also perform this analysis using the extended neighbourhoods.

```
CTByNBHDClusterExtended = table(NBHDByCTSeuratExtended$cellType,NBHDByCTSeuratExtended@active.ident)
CTByNBHDClusterExtended = CTByNBHDClusterExtended/rowSums(CTByNBHDClusterExtended)

rownames(CTByNBHDClusterExtended) = paste0("CellType",rownames(CTByNBHDClusterExtended))
colnames(CTByNBHDClusterExtended) = paste0("NBHDCluster",colnames(CTByNBHDClusterExtended))

pheatmap(CTByNBHDClusterExtended,
      fontsize_row=8,
      fontsize_col=8,
      cellheight=10,
      cellwidth=10)
```

![](data:image/png;base64...)

```
sankeyFromMatrix(CTByNBHDClusterExtended)
```

## Analysing cell types based on their neighbourhoods

Now we perform dimensionality reduction and clustering of cell types, based on the neighbourhoods they are found in. Note that this is based on the transpose of the matrix used in the previous section.

First we create a Seurat object for a cell type by neighbourhood matrix (the transposed NBHDByCTMatrix). Here we have a large feature space (number of cells) however a low number of observations (number of cell types). Therefore we compute the UMAP using PCs, however due to the low number of observations we need to set a lower value for n.neighbours.

```
CTByNBHDSeurat =
  computeNBHDVsCTObject(t(NBHDByCTMatrix), npcs = 10,
                        transpose = TRUE, resolution = 1, n.neighbors = 5,
            verbose=FALSE)
#> Warning: Data is of class matrix. Coercing to dgCMatrix.
#> Warning in svd.function(A = t(x = object), nv = npcs, ...): You're computing
#> too large a percentage of total singular values, use a standard svd instead.
#> Warning: k.param set larger than number of cells. Setting k.param to number of
#> cells - 1.
#> Modularity Optimizer version 1.3.0 by Ludo Waltman and Nees Jan van Eck
#>
#> Number of nodes: 16
#> Number of edges: 120
#>
#> Running Louvain algorithm...
#> Maximum modularity in 10 random starts: 0.0000
#> Number of communities: 1
#> Elapsed time: 0 seconds

CTByNBHDSeurat$cellType = colnames(CTByNBHDSeurat)

DimPlot(CTByNBHDSeurat, group.by = "cellType", cols = "polychrome",
        reduction = "umap", label = TRUE)
```

![](data:image/png;base64...)

Note how Pyramidal, Pvalb and Lamp5 neurons are located close together in UMAP space indicating they are often found in the same neighbourhoods.

We can also compute a force-directed graph embedding.

```
CTByNBHDSeurat= computeGraphEmbedding(CTByNBHDSeurat)
#> Warning: Keys should be one or more alphanumeric characters followed by an
#> underscore, setting key from graph to graph_

DimPlot(CTByNBHDSeurat,group.by = "cellType", cols = "alphabet", reduction = "graph", label = TRUE)
```

![](data:image/png;base64...)

From this 11\_oligo and 5\_Astro appear to be in neighbourhoods distinct from the other cell types. Looking at cell type localisation in the tissue shows that they colocalise.

```
ImageDimPlot(smallXenium, cols = "polychrome", size = 1)
```

![](data:image/png;base64...)

Clustering cell types using the Louvain algorithm acheives only one cluster. Let’s try hierachical clustering.

```
pca = Embeddings(CTByNBHDSeurat, reduction = "pca")
res = pheatmap(pca)
```

![](data:image/png;base64...)

Here we decide to cut the tree at the correct level to form 11 clusters.

```
CTClust = cutree(res$tree_row, k = 11)
CTByNBHDSeurat$neighbourhood_clusters = factor(CTClust)
```

Let’s look at the celltype composition of these clusters.

```
CTComposition = table(CTByNBHDSeurat$cellType, CTByNBHDSeurat$neighbourhood_clusters)
pheatmap(CTComposition)
```

![](data:image/png;base64...)

Although most clusters here are formed of a single cell type, cluster 2 contains several cell types. We anticipate this analysis may be more informative when performed on a larger tissue area, as some cell types are poorly represented in this subset. To this end we demonstrate how to explore the relationship between neighbourhood clusters and cell type clusters.

```
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
```

![](data:image/png;base64...)

```
sankeyFromMatrix(averageExpMatrix)
```

## Detection of genes with spatially variable expression.

Given a neighbour graph describing the spatial relationships between cells, we can compute spatial autocorrelation (here we use Moran’s I). This describes how clustered gene expression values are in space. We derive an upper tail p value based on permutation testing where expression values for genes are permuted. N.B in this implementation equal weights are given to all neighbours of a cell. Minimum values are limited by nSim, the number of permutations used.

```
moransI = runMoransI(smallXenium, delaunayNeighbours, assay = "SCT",
                     layer = "data", nSim = 20, verbose = FALSE)
```

Look at most spatially autocorrelated genes.

```
head(moransI)
#>                 moransI pValues
#> Nwd2          0.8551889    0.05
#> Neurod6       0.8356282    0.05
#> 2010300C02Rik 0.7932742    0.05
#> Cabp7         0.7759337    0.05
#> Epha4         0.7730172    0.05
#> Bhlhe22       0.7715628    0.05
```

Look at least spatially autocorrelated genes.

```
tail(moransI)
#>               moransI pValues
#> Arhgap25  0.016796297    0.05
#> Gm19410   0.006177101    0.50
#> Myl4      0.005703901    0.40
#> Opn3      0.005641610    0.30
#> Rxfp1    -0.001316899    0.50
#> Trbc2    -0.001713841    0.90
```

Here we visualise the most spatially autocorrelated gene.

```
ImageFeaturePlot(smallXenium, "Nwd2")
```

![](data:image/png;base64...)

Here we visualise the least spatially autocorrelated gene.

```
ImageFeaturePlot(smallXenium, "Trbc2")
```

![](data:image/png;base64...)

## Ligand receptor analysis

We can perform an analysis of ligand receptor interactions in order to infer communication between cells. Here we calculate whether interactions between ligand receptor pairs occur on edges of the spatial graph, i.e. between neighbouring cells, where cell A expresses a ligand and cell B expresses a receptor. Note that the distance between cell A and cell B will vary depending on how the graph has been constructed, larger distances may be desired for analyses involving diffusable ligands. We also analyse the number of ligand receptor interactions that occur between cells from the same cluster and between cells from different clusters. Note that clusters may represent cell type, or another property of the cells such as their neighbourhood type. We leave this for the user to decide.

We then calculate an analytical p-value for the enrichment of ligand-receptor interactions between clusters. Specifically an upper tail p-value for observing a given number of A-B edges positive for a given interaction is calculated using a binomial test (R pbinom function) where: q = number of A-B edges positive for an interaction size = total number of A-B edges
prob = pL\*pR Where pL is the probability of a cell expressing a specific ligand (number of cells positive for a ligand/total cells), and pR is the probability of a cell expressing a specific receptor (number of cells positive for a receptor/total cells). If conditional = True p-values will be calculated given the proportion of cells that express ligands and receptors in the specific clusters (pL = number of cells in cluster A positive for a ligand/number of cells in cluster A, pR = number of cells in cluster B positive for a receptor/number of cells in cluster B).

The analytical method to calculate p-values has a faster run time than the permutation-based method previously implemented in this package, however the user can optionally choose to calculate permutation-based p-values by using method = “permutation”. Of note, the speed of this method has also increased due to the use of sparse matrices.

```
ligandReceptorResults = performLigandReceptorAnalysis(smallXenium, delaunayNeighbours,
                                                "mouse", clusters,
                                                method = "analytical",
                                                conditional = FALSE,
                                                minEdgesPos = 10)
```

We look at interactions on edges. For concision, we display the first ten of our 28 ligand-receptor pairs. Since ligand-receptor interactions are directed, each undirected edge will show up both as cell A - cell B and as cell B - cell A.

```
head(as.matrix(ligandReceptorResults$interactionsOnEdges[,1:10]),10)
#>             Pecam1_Pecam1 Cdh4_Cdh4 Col1a1_Cd44 Fn1_Cd44 Nts_Ntsr2 Spp1_Cd44
#> 16307_16316          TRUE     FALSE       FALSE    FALSE     FALSE     FALSE
#> 16314_16317         FALSE     FALSE       FALSE    FALSE     FALSE     FALSE
#> 16296_16299         FALSE     FALSE       FALSE    FALSE     FALSE     FALSE
#> 16299_16307          TRUE     FALSE       FALSE    FALSE     FALSE     FALSE
#> 16309_16316         FALSE      TRUE       FALSE    FALSE     FALSE     FALSE
#> 16309_16314         FALSE     FALSE       FALSE    FALSE     FALSE     FALSE
#> 12028_12032         FALSE     FALSE       FALSE    FALSE     FALSE     FALSE
#> 12032_16914         FALSE     FALSE       FALSE    FALSE     FALSE     FALSE
#> 12032_16257         FALSE     FALSE       FALSE    FALSE     FALSE     FALSE
#> 2975_3339           FALSE     FALSE       FALSE    FALSE     FALSE     FALSE
#>             Cort_Htr1f Cort_Npy2r Penk_Htr1f Penk_Npy2r
#> 16307_16316      FALSE      FALSE      FALSE      FALSE
#> 16314_16317      FALSE      FALSE      FALSE      FALSE
#> 16296_16299      FALSE      FALSE      FALSE      FALSE
#> 16299_16307      FALSE      FALSE      FALSE      FALSE
#> 16309_16316      FALSE      FALSE      FALSE      FALSE
#> 16309_16314      FALSE      FALSE      FALSE      FALSE
#> 12028_12032      FALSE      FALSE       TRUE      FALSE
#> 12032_16914      FALSE      FALSE      FALSE      FALSE
#> 12032_16257      FALSE      FALSE      FALSE      FALSE
#> 2975_3339        FALSE      FALSE      FALSE      FALSE
```

Look at total interactions between/within clusters:

```
head(ligandReceptorResults$totalInteractionsByCluster[,1:10],10)
#>                      Cdh4_Cdh4 Cdh6_Cdh9 Col1a1_Cd44 Cort_Chrm2 Cort_Gpr17
#> 0_Oligo-0_Oligo              2         0           2          3          3
#> 0_Oligo-10_Astro             5         0           0          2          1
#> 0_Oligo-11_Oligo             0         1           0          1          0
#> 0_Oligo-12_Pvalb             3         0           0          0          0
#> 0_Oligo-13_Microglia         0         0           0          0          0
#> 0_Oligo-14_Ependymal         1         1           0          2          1
#> 0_Oligo-15_Oligo             0         1           0          1          2
#> 0_Oligo-3_Endo               0         0           0          2          1
#> 0_Oligo-4_Astro              0         0           0          0          0
#> 0_Oligo-5_Astro              0         0           0          2          0
#>                      Cort_Htr1f Cort_Npy2r Crh_Rxfp1 Fn1_Cd44 Nts_Gpr17
#> 0_Oligo-0_Oligo               0          0         0        3         4
#> 0_Oligo-10_Astro              0          0         0        1         0
#> 0_Oligo-11_Oligo              0          0         0        0         1
#> 0_Oligo-12_Pvalb              0          0         0        0         0
#> 0_Oligo-13_Microglia          0          0         0        0         0
#> 0_Oligo-14_Ependymal          0          0         0        6         1
#> 0_Oligo-15_Oligo              0          0         0        0         2
#> 0_Oligo-3_Endo                0          0         0        0         2
#> 0_Oligo-4_Astro               0          0         0        0         0
#> 0_Oligo-5_Astro               0          0         0        0         2
```

Look at mean interactions per edge between/within clusters (sum of ligand receptor interactions on A-B edges)/(total A-B edges):

```
head(ligandReceptorResults$meanInteractionsByCluster[,1:10],10)
#>                        Cdh4_Cdh4   Cdh6_Cdh9 Col1a1_Cd44  Cort_Chrm2
#> 0_Oligo-0_Oligo      0.006451613 0.000000000 0.006451613 0.009677419
#> 0_Oligo-10_Astro     0.113636364 0.000000000 0.000000000 0.045454545
#> 0_Oligo-11_Oligo     0.000000000 0.022727273 0.000000000 0.022727273
#> 0_Oligo-12_Pvalb     0.333333333 0.000000000 0.000000000 0.000000000
#> 0_Oligo-13_Microglia 0.000000000 0.000000000 0.000000000 0.000000000
#> 0_Oligo-14_Ependymal 0.009708738 0.009708738 0.000000000 0.019417476
#> 0_Oligo-15_Oligo     0.000000000 0.034482759 0.000000000 0.034482759
#> 0_Oligo-3_Endo       0.000000000 0.000000000 0.000000000 0.037735849
#> 0_Oligo-4_Astro      0.000000000 0.000000000 0.000000000 0.000000000
#> 0_Oligo-5_Astro      0.000000000 0.000000000 0.000000000 0.050000000
#>                       Cort_Gpr17 Cort_Htr1f Cort_Npy2r Crh_Rxfp1    Fn1_Cd44
#> 0_Oligo-0_Oligo      0.009677419          0          0         0 0.009677419
#> 0_Oligo-10_Astro     0.022727273          0          0         0 0.022727273
#> 0_Oligo-11_Oligo     0.000000000          0          0         0 0.000000000
#> 0_Oligo-12_Pvalb     0.000000000          0          0         0 0.000000000
#> 0_Oligo-13_Microglia 0.000000000          0          0         0 0.000000000
#> 0_Oligo-14_Ependymal 0.009708738          0          0         0 0.058252427
#> 0_Oligo-15_Oligo     0.068965517          0          0         0 0.000000000
#> 0_Oligo-3_Endo       0.018867925          0          0         0 0.000000000
#> 0_Oligo-4_Astro      0.000000000          0          0         0 0.000000000
#> 0_Oligo-5_Astro      0.000000000          0          0         0 0.000000000
#>                        Nts_Gpr17
#> 0_Oligo-0_Oligo      0.012903226
#> 0_Oligo-10_Astro     0.000000000
#> 0_Oligo-11_Oligo     0.022727273
#> 0_Oligo-12_Pvalb     0.000000000
#> 0_Oligo-13_Microglia 0.000000000
#> 0_Oligo-14_Ependymal 0.009708738
#> 0_Oligo-15_Oligo     0.068965517
#> 0_Oligo-3_Endo       0.037735849
#> 0_Oligo-4_Astro      0.000000000
#> 0_Oligo-5_Astro      0.050000000
```

Look at p-values (upper tail) for the enrichment of interactions. Of note these are set to NA if less than 10 edges are positive for a ligand-receptor interaction. This threshold can be changed using the “minEdgesPos” argument of performLigandReceptorAnalysis().

```
head(ligandReceptorResults$pValues,10)
#>                      Cdh4_Cdh4 Cdh6_Cdh9 Col1a1_Cd44 Cort_Chrm2 Cort_Gpr17
#> 0_Oligo-0_Oligo             NA        NA          NA         NA         NA
#> 0_Oligo-10_Astro            NA        NA          NA         NA         NA
#> 0_Oligo-11_Oligo            NA        NA          NA         NA         NA
#> 0_Oligo-12_Pvalb            NA        NA          NA         NA         NA
#> 0_Oligo-13_Microglia        NA        NA          NA         NA         NA
#> 0_Oligo-14_Ependymal        NA        NA          NA         NA         NA
#> 0_Oligo-15_Oligo            NA        NA          NA         NA         NA
#> 0_Oligo-3_Endo              NA        NA          NA         NA         NA
#> 0_Oligo-4_Astro             NA        NA          NA         NA         NA
#> 0_Oligo-5_Astro             NA        NA          NA         NA         NA
#>                      Cort_Htr1f Cort_Npy2r Crh_Rxfp1 Fn1_Cd44 Nts_Gpr17
#> 0_Oligo-0_Oligo              NA         NA        NA       NA        NA
#> 0_Oligo-10_Astro             NA         NA        NA       NA        NA
#> 0_Oligo-11_Oligo             NA         NA        NA       NA        NA
#> 0_Oligo-12_Pvalb             NA         NA        NA       NA        NA
#> 0_Oligo-13_Microglia         NA         NA        NA       NA        NA
#> 0_Oligo-14_Ependymal         NA         NA        NA       NA        NA
#> 0_Oligo-15_Oligo             NA         NA        NA       NA        NA
#> 0_Oligo-3_Endo               NA         NA        NA       NA        NA
#> 0_Oligo-4_Astro              NA         NA        NA       NA        NA
#> 0_Oligo-5_Astro              NA         NA        NA       NA        NA
#>                      Nts_Ntsr2 Nts_Tacr1 Pdyn_Chrm2 Pdyn_Gpr17 Pdyn_Htr1f
#> 0_Oligo-0_Oligo             NA        NA         NA         NA         NA
#> 0_Oligo-10_Astro            NA        NA         NA         NA         NA
#> 0_Oligo-11_Oligo            NA        NA         NA         NA         NA
#> 0_Oligo-12_Pvalb            NA        NA         NA         NA         NA
#> 0_Oligo-13_Microglia        NA        NA         NA         NA         NA
#> 0_Oligo-14_Ependymal        NA        NA         NA         NA         NA
#> 0_Oligo-15_Oligo            NA        NA         NA         NA         NA
#> 0_Oligo-3_Endo              NA        NA         NA         NA         NA
#> 0_Oligo-4_Astro             NA        NA         NA         NA         NA
#> 0_Oligo-5_Astro             NA        NA         NA         NA         NA
#>                      Pdyn_Npy2r Pecam1_Pecam1   Penk_Chrm2   Penk_Gpr17
#> 0_Oligo-0_Oligo              NA            NA 1.831169e-16 1.369393e-07
#> 0_Oligo-10_Astro             NA            NA           NA           NA
#> 0_Oligo-11_Oligo             NA            NA           NA           NA
#> 0_Oligo-12_Pvalb             NA            NA           NA           NA
#> 0_Oligo-13_Microglia         NA            NA           NA           NA
#> 0_Oligo-14_Ependymal         NA            NA           NA           NA
#> 0_Oligo-15_Oligo             NA            NA           NA           NA
#> 0_Oligo-3_Endo               NA            NA           NA           NA
#> 0_Oligo-4_Astro              NA            NA           NA           NA
#> 0_Oligo-5_Astro              NA            NA           NA           NA
#>                      Penk_Htr1f Penk_Npy2r Pthlh_Rxfp1 Spp1_Cd44 Sst_Chrm2
#> 0_Oligo-0_Oligo              NA         NA          NA        NA        NA
#> 0_Oligo-10_Astro             NA         NA          NA        NA        NA
#> 0_Oligo-11_Oligo             NA         NA          NA        NA        NA
#> 0_Oligo-12_Pvalb             NA         NA          NA        NA        NA
#> 0_Oligo-13_Microglia         NA         NA          NA        NA        NA
#> 0_Oligo-14_Ependymal         NA         NA          NA        NA        NA
#> 0_Oligo-15_Oligo             NA         NA          NA        NA        NA
#> 0_Oligo-3_Endo               NA         NA          NA        NA        NA
#> 0_Oligo-4_Astro              NA         NA          NA        NA        NA
#> 0_Oligo-5_Astro              NA         NA          NA        NA        NA
#>                      Sst_Gpr17 Sst_Htr1f Sst_Npy2r Vip_Rxfp1
#> 0_Oligo-0_Oligo             NA        NA        NA        NA
#> 0_Oligo-10_Astro            NA        NA        NA        NA
#> 0_Oligo-11_Oligo            NA        NA        NA        NA
#> 0_Oligo-12_Pvalb            NA        NA        NA        NA
#> 0_Oligo-13_Microglia        NA        NA        NA        NA
#> 0_Oligo-14_Ependymal        NA        NA        NA        NA
#> 0_Oligo-15_Oligo            NA        NA        NA        NA
#> 0_Oligo-3_Endo              NA        NA        NA        NA
#> 0_Oligo-4_Astro             NA        NA        NA        NA
#> 0_Oligo-5_Astro             NA        NA        NA        NA
```

Plot a heatmap showing -log10(pvalues) for the enrichment of ligand-receptor interactions between pairs of clusters.

```
ligRecMatrix = makeLRInteractionHeatmap(ligandReceptorResults, clusters, colours = colours, labelClusterPairs = FALSE)
```

![](data:image/png;base64...)![](data:image/png;base64...)

Make a heatmap of total ligand-receptor interactions between clusters.

```
cellTypePerCellTypeLigRecMatrix = makeSummedLRInteractionHeatmap(ligandReceptorResults, clusters, "total")
```

![](data:image/png;base64...)

Make a heatmap of summed mean ligand/receptor interactions between clusters i.e., (sum of all ligand receptor interactions on A-B edges)/(total A-B edges)

```
cellTypePerCellTypeLigRecMatrix = makeSummedLRInteractionHeatmap(ligandReceptorResults, clusters, "mean", logScale = TRUE)
```

![](data:image/png;base64...) Make a dotplot of ligand-receptor interactions.

```
p = plotLRDotplot(ligandReceptorResults, padjCutoff = 0.05, pvalCutoff = F, splitBy = "sender")
```

![](data:image/png;base64...) Here we choose to plot interactions with a p-adj value < 0.05 and split the data by sender populations. It is also possible to create dotplots of ligand-receptor interactions for specific populations:

```
plotLRDotplot(ligandReceptorResults, senderClusters = c("6_VLMC","7_Granule"),
              padjCutoff = 0.05, pvalCutoff = F, splitBy = "sender")
```

![](data:image/png;base64...)![](data:image/png;base64...)

Look at a histogram of values for summed mean ligand/receptor interactions between clusters.

```
hist(cellTypePerCellTypeLigRecMatrix)
```

![](data:image/png;base64...)

Visualise in graph format.

```
cellTypesPerCellTypeGraphFromCellMatrix(cellTypePerCellTypeLigRecMatrix,
                                    minWeight = 0.4, colours = colours)
```

![](data:image/png;base64...)

```
#> IGRAPH 2dda946 DNW- 16 54 --
#> + attr: coords (g/n), name (v/c), color (v/c), weight (e/n), width
#> | (e/n)
#> + edges from 2dda946 (vertex names):
#>  [1] 0_Oligo  ->3_Endo       0_Oligo  ->7_Granule    0_Oligo  ->12_Pvalb
#>  [4] 0_Oligo  ->15_Oligo     3_Endo   ->6_VLMC       3_Endo   ->10_Astro
#>  [7] 3_Endo   ->15_Oligo     3_Endo   ->17_Lamp5     4_Astro  ->0_Oligo
#> [10] 4_Astro  ->3_Endo       4_Astro  ->7_Granule    4_Astro  ->14_Ependymal
#> [13] 5_Astro  ->10_Astro     6_VLMC   ->3_Endo       6_VLMC   ->5_Astro
#> [16] 6_VLMC   ->10_Astro     6_VLMC   ->11_Oligo     6_VLMC   ->13_Microglia
#> [19] 7_Granule->5_Astro      7_Granule->10_Astro     7_Granule->14_Ependymal
#> + ... omitted several edges
```

Here the arrows are very thick - we can scale by a constant factor to improve the presentation.

```
scaleFactor = 3
cellTypesPerCellTypeGraphFromCellMatrix(cellTypePerCellTypeLigRecMatrix/scaleFactor,
                                    minWeight = 0.4/scaleFactor, colours = colours)
```

![](data:image/png;base64...)

```
#> IGRAPH 081027d DNW- 16 54 --
#> + attr: coords (g/n), name (v/c), color (v/c), weight (e/n), width
#> | (e/n)
#> + edges from 081027d (vertex names):
#>  [1] 0_Oligo  ->3_Endo       0_Oligo  ->7_Granule    0_Oligo  ->12_Pvalb
#>  [4] 0_Oligo  ->15_Oligo     3_Endo   ->6_VLMC       3_Endo   ->10_Astro
#>  [7] 3_Endo   ->15_Oligo     3_Endo   ->17_Lamp5     4_Astro  ->0_Oligo
#> [10] 4_Astro  ->3_Endo       4_Astro  ->7_Granule    4_Astro  ->14_Ependymal
#> [13] 5_Astro  ->10_Astro     6_VLMC   ->3_Endo       6_VLMC   ->5_Astro
#> [16] 6_VLMC   ->10_Astro     6_VLMC   ->11_Oligo     6_VLMC   ->13_Microglia
#> [19] 7_Granule->5_Astro      7_Granule->10_Astro     7_Granule->14_Ependymal
#> + ... omitted several edges
```

### Visualising ligand-receptor interactions: Seurat objects of edges

We wish to create a Seurat object where the points are edges between cells as a way of visualising ligand-receptor interactions. Since these interactions are asymmetric we need to consider directed edges. We will place the spatial coordinates of the edges A-B and B-A slightly separate but both between the centroids of cells A and B. The “expression matrix” is the binarised presence/absence of an interaction (ligand receptor pair) on an edge. This is useful for visualising where ligand receptor interactions occur spatially.

```
edgeSeurat = computeEdgeObject(ligandReceptorResults, centroids)
#> Warning: Feature names cannot have underscores ('_'), replacing with dashes
#> ('-')
```

For example we can visualise the Pdyn-Npy2r interaction.

```
ImageFeaturePlot(edgeSeurat, features = "Pdyn-Npy2r")
#> Warning: No layers found matching search pattern provided
#> Warning in FetchData.Assay5(object = object[[DefaultAssay(object = object)]], :
#> data layer is not found and counts layer is used
```

![](data:image/png;base64...)

In principle, the edge Seurat object allows for the computation of an edge UMAP and Louvain clustering of the edges based on ligand-receptor interaction. However some of these analyses are computationally expensive due to large number of edges.

### Spatial autocorrelation of ligand-receptor interactions

We can compute a spatial graph where edges in the original delaunayNeighbours become nodes and A-B edges (in the original graph) become connected to all A- edges and all B- edges. This allows us to perfom graph-based analyses associated with the spatial localisation of ligand receptor pairs on edges.

```
edgeNeighbours = computeEdgeGraph(delaunayNeighbours)
```

Compute Moran’s I for the spatial autocorrelation of ligand-receptor interactions.

```
moransILigandReceptor = runMoransI(edgeSeurat, edgeNeighbours, assay = "RNA",
                     layer = "counts", nSim = 100)
```

View most spatially autocorrelated ligand-receptor interactions.

```
moransILigandReceptor = getExample('moransILigandReceptor')
head(moransILigandReceptor)
#>                 moransI pValues
#> Penk-Htr1f    0.8392801    0.01
#> Vip-Rxfp1     0.7866141    0.02
#> Pthlh-Rxfp1   0.7812148    0.21
#> Pdyn-Npy2r    0.7593318    0.01
#> Nts-Ntsr2     0.7582268    0.01
#> Pecam1-Pecam1 0.7397425    0.01
```

View least spatially autocorrelated ligand-receptor interactions.

```
tail(moransILigandReceptor)
#>             moransI pValues
#> Spp1-Cd44 0.6559306    0.01
#> Nts-Tacr1 0.6388787    0.13
#> Nts-Gpr17 0.5903279    0.51
#> Sst-Npy2r 0.5636993    0.58
#> Sst-Htr1f 0.5442672    0.71
#> Sst-Gpr17 0.5305249    0.75
```

View ligand-receptor interaction with the highest spatial autocorrelation (Moran’s I).

```
ImageFeaturePlot(edgeSeurat, "Penk-Htr1f")
#> Warning: No layers found matching search pattern provided
#> Warning in FetchData.Assay5(object = object[[DefaultAssay(object = object)]], :
#> data layer is not found and counts layer is used
```

![](data:image/png;base64...)

View ligand-receptor interaction with the lowest spatial autocorrelation (Moran’s I).

```
ImageFeaturePlot(edgeSeurat, "Sst-Gpr17")
#> Warning: No layers found matching search pattern provided
#> Warning in FetchData.Assay5(object = object[[DefaultAssay(object = object)]], :
#> data layer is not found and counts layer is used
```

![](data:image/png;base64...)

## Quality control of Delaunay neighbours

We use Delaunay triangulation to estimate neighbour to neighbour contact between cells. However, a cell which happens to sit next to a tissue void is likely to have one or more Delaunay neighbours which are cells that sit on the other side of this void. We hope to detect these spurious edges based on their lengths. However, the distances between neighbouring cells’ centroids tend to depend on the types of the neighbouring cells. Accordingly, we have supplied functions to annotate edges with their distances and cell types; compute estimates for edge-length cutoffs based on cell type pair; plot the distributions of lengths together with proposed cutoffs; and subset the edges based on cutoffs.

### edgeLengthsAndCellTypePairs

This functions annotates edges with their lengths and the cell types of the two cells in question.

```
annEdges =
edgeLengthsAndCellTypePairs(delaunayNeighbours,clusters,centroids)
head(annEdges)
#>   nodeA nodeB    length cellTypePair
#> 1 16307 16316 19.883354          5_8
#> 2 16314 16317 35.634141          4_4
#> 3 16296 16299  8.127726          5_5
#> 4 16299 16307  8.957429          5_5
#> 5 16309 16316 25.730502          4_8
#> 6 16309 16314 18.029393          4_4
```

### Visualising the edge lengths

Here we visualise the distribution of edge lengths together with proposed cutoffs. We will say more in a moment about how these proposed cutoffs are calculated.

```
cutoffDF = edgeCutoffsByPercentile(annEdges,percentileCutof=95)
g = edgeLengthPlot(annEdges,cutoffDF,whichPairs=60)
print(g)
#> Warning: Removed 23 rows containing non-finite outside the scale range
#> (`stat_density()`).
```

![](data:image/png;base64...)

In this case, there are 111 types of edges based on the cell types of the cells they connect. By setting whichPairs=60, we are restricting to those types for which there are at least 60 such edges. Here we are also using a default xlim of 100. Passing the value NULL for cutoffDF will produce a plot without these cutoffs.

### Estimating edge length cutoffs

We offer several methods for estimating edge length cutoffs. We recommend visual inspection before settling on any specific set of results. Each of these returns a data frame with two columns, cellTypePair and cutoff. As we have just seen this can be used for the plotting function and it can also be used for culling the edges. Since these results are returned as a data frame, they can be tuned “by hand” by modifying the cutoff value for any individual cell type pair.

#### edgeCutoffsByClustering

```
cutoffDF = edgeCutoffsByClustering(annEdges)
```

This method works well in a small percentage of cases. For each cell type pair it performs k-means clustering of the lengths with k=2 and produces a cutoff halfway between the two clusters. This works well when there really are two clusters of edges, those between truly neighbouring cells and those across tissue voids. However, in the case where all the edges are between neighbouring cells, this will produce a spurious cutoff.

#### edgeCutoffsByPercentile

```
cutoffDF = edgeCutoffsByPercentile(annEdges,percentileCutoff=95)
```

This method produces cutoffs based on a chosen percentile applied across all cell type pairs. It has the advantages that its results are easily comprehensible in terms of the chosen parameter. The user my want to “mix and match” using different percentiles for different cell type pairs.

#### edgeCutoffsByZScore

```
cutoffDF = edgeCutoffsByZScore(annEdges,zCutoff=1.5)
```

Very similar to the previous method, using z-score instead of percentile.

#### edgeCutoffsByWatershed

```
cutoffDF = edgeCutoffsByWatershed(annEdges,nbins=15,tolerance=10)
```

For each cell type pair, this function first computes a histogram of the distances. It then uses watershed segmentation to discover the “humps” of this histogram. The most important of these will be the one containing the median of the distances. This reports as a cutoff the midpoint of the first histogram bin which is past this main hump. The parameter nbins specifies the number of bins for the histogram. The parameter tolerance controls the sensitivity of the watershed algorithm.

#### cullEdges

```
cutoffDF = edgeCutoffsByWatershed(annEdges,nbins=15,tolerance=10)
culledEdges = cullEdges(annEdges,cutoffDF)
nrow(annEdges)
#> [1] 12759
nrow(culledEdges)
#> [1] 12512
```

This subsets the edges according to the parameter cutoffSpec. This can be a cutoff data frame as produced by any of the edgeCutoff functions or can be a single number in which case all the cell type pairs will be trimmed to the same cutoff.

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] SpatialExperiment_1.20.0    SingleCellExperiment_1.32.0
#>  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [5] GenomicRanges_1.62.1        Seqinfo_1.0.0
#>  [7] IRanges_2.44.0              S4Vectors_0.48.0
#>  [9] BiocGenerics_0.56.0         generics_0.1.4
#> [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [13] fossil_0.4.0                shapefiles_0.7.2
#> [15] foreign_0.8-90              maps_3.4.3
#> [17] tictoc_1.2.1                pheatmap_1.0.13
#> [19] ggplot2_4.0.1               Seurat_5.4.0
#> [21] SeuratObject_5.3.0          sp_2.2-0
#> [23] future_1.68.0               CatsCradle_1.4.2
#>
#> loaded via a namespace (and not attached):
#>   [1] RcppAnnoy_0.0.22       splines_4.5.2          later_1.4.4
#>   [4] bitops_1.0-9           tibble_3.3.0           polyclip_1.10-7
#>   [7] fastDummies_1.7.5      lifecycle_1.0.4        globals_0.18.0
#>  [10] lattice_0.22-7         MASS_7.3-65            magrittr_2.0.4
#>  [13] plotly_4.11.0          sass_0.4.10            rmarkdown_2.30
#>  [16] jquerylib_0.1.4        yaml_2.3.12            httpuv_1.6.16
#>  [19] otel_0.2.0             sctransform_0.4.2      spam_2.11-1
#>  [22] spatstat.sparse_3.1-0  reticulate_1.44.1      cowplot_1.2.0
#>  [25] pbapply_1.7-4          RColorBrewer_1.1-3     abind_1.4-8
#>  [28] Rtsne_0.17             purrr_1.2.0            msigdbr_25.1.1
#>  [31] RCurl_1.98-1.17        pracma_2.4.6           data.tree_1.2.0
#>  [34] ggrepel_0.9.6          irlba_2.3.5.1          listenv_0.10.0
#>  [37] spatstat.utils_3.2-0   BiocStyle_2.38.0       goftest_1.2-3
#>  [40] RSpectra_0.16-2        spatstat.random_3.4-3  fitdistrplus_1.2-4
#>  [43] parallelly_1.46.0      codetools_0.2-20       DelayedArray_0.36.0
#>  [46] tidyselect_1.2.1       farver_2.1.2           spatstat.explore_3.6-0
#>  [49] jsonlite_2.0.0         progressr_0.18.0       ggridges_0.5.7
#>  [52] survival_3.8-3         tools_4.5.2            ica_1.0-3
#>  [55] Rcpp_1.1.0             glue_1.8.0             gridExtra_2.3
#>  [58] SparseArray_1.10.8     xfun_0.55              EBImage_4.52.0
#>  [61] dplyr_1.1.4            withr_3.0.2            BiocManager_1.30.27
#>  [64] fastmap_1.2.0          digest_0.6.39          R6_2.6.1
#>  [67] mime_0.13              networkD3_0.4.1        scattermore_1.2
#>  [70] tensor_1.5.1           jpeg_0.1-11            dichromat_2.0-0.1
#>  [73] spatstat.data_3.1-9    tidyr_1.3.2            data.table_1.18.0
#>  [76] httr_1.4.7             htmlwidgets_1.6.4      S4Arrays_1.10.1
#>  [79] uwot_0.2.4             pkgconfig_2.0.3        gtable_0.3.6
#>  [82] rdist_0.0.5            lmtest_0.9-40          S7_0.2.1
#>  [85] XVector_0.50.0         htmltools_0.5.9        dotCall64_1.2
#>  [88] fftwtools_0.9-11       zigg_0.0.2             scales_1.4.0
#>  [91] png_0.1-8              spatstat.univar_3.1-5  geometry_0.5.2
#>  [94] knitr_1.51             reshape2_1.4.5         rjson_0.2.23
#>  [97] nlme_3.1-168           magic_1.6-1            curl_7.0.0
#> [100] cachem_1.1.0           zoo_1.8-15             stringr_1.6.0
#> [103] KernSmooth_2.23-26     parallel_4.5.2         miniUI_0.1.2
#> [106] pillar_1.11.1          grid_4.5.2             vctrs_0.6.5
#> [109] RANN_2.6.2             promises_1.5.0         xtable_1.8-4
#> [112] cluster_2.1.8.1        evaluate_1.0.5         magick_2.9.0
#> [115] cli_3.6.5              locfit_1.5-9.12        compiler_4.5.2
#> [118] crayon_1.5.3           rlang_1.1.6            future.apply_1.20.1
#> [121] labeling_0.4.3         plyr_1.8.9             stringi_1.8.7
#> [124] viridisLite_0.4.2      deldir_2.0-4           assertthat_0.2.1
#> [127] babelgene_22.9         lazyeval_0.2.2         tiff_0.1-12
#> [130] spatstat.geom_3.6-1    Matrix_1.7-4           RcppHNSW_0.6.0
#> [133] patchwork_1.3.2        shiny_1.12.1           ROCR_1.0-11
#> [136] Rfast_2.1.5.2          igraph_2.2.1           RcppParallel_5.1.11-1
#> [139] bslib_0.9.0
```