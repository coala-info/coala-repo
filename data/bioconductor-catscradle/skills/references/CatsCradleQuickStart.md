# CatsCradle Quick Start

#### Anna Laddach and Michael Shapiro

#### 2025-12-25

*[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)*

![](data:image/png;base64...)

## Introduction

CatsCradle provides two types of functionality for analysing single cell data. It provides tools for the clustering and annotation of genes and it provides extensive tools for analysing spatial transcriptomics data.

## Clustering and annotation of genes

A typical analysis of scRNA-seq data using Seurat involves dimensionality reduction (PCA, UMAP, tSNE) and the clustering of cells using the Louvain algorithm. All of this is done based on the similarities and differences in the genes cells express. Here we see a UMAP where the points are cells, coloured by their seurat\_clusters.

```
library(Seurat,quietly=TRUE)
library(CatsCradle,quietly=TRUE)
data(exSeuratObj)
DimPlot(exSeuratObj,cols='polychrome')
```

![](data:image/png;base64...)

By transposing the expression matrix, we can use the same technology to produce a Seurat object where the samples are the genes and the features are cells. Genes now have their own UMAP and their own clusters. This is all done on the basis of the similarities and differences in the cells they are expressed in.

```
getExample = make.getExample()
STranspose = getExample('STranspose')
print(STranspose)
#> An object of class Seurat
#> 540 features across 2000 samples within 1 assay
#> Active assay: RNA (540 features, 540 variable features)
#>  3 layers present: counts, data, scale.data
#>  2 dimensional reductions calculated: pca, umap
DimPlot(STranspose,cols='polychrome')
```

![](data:image/png;base64...)

### Gene clusters vs. cell clusters

There are a number of ways of investigating the relationship between gene clusters and cell clusters. One is by computing the average expression of each gene cluster in each cell cluster; this can be displayed as a heat map or a Sankey graph - the cat’s cradle of our CatsCradle. (See getAverageExpressionMatrix() and sankeyFromMatrix() in the CatsCradle vignette CatsCradle.

### Spatial co-location of genes on gene UMAP

Gene sets such as Hallmark tend to localise on gene UMAP, though they are not necessarily confined to specific gene clusters. Here we show HALLMARK\_OXIDATIVE\_PHOSPHORYLATION (subset to the genes in our Seurat object) superimposed in green and black on the gene cluster UMAP.

```
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
```

![](data:image/png;base64...)

```
pValue = getObjectSubsetClusteringPValue(STranspose,idx)
pValue
#> [1] 0.001
```

The p-value here is limited by the default number of randomisation trials in getSubsetClusteringPValue(). Of the 50 Hallmark gene sets, 31 have clustering p-values less than 0.05.

The computation of these p-values is ultimately carried out by medianComplementPValue(). We wish to determine whether a subset *X* of a set of points *S* is randomly scattered across *S* or is somehow localised. To do this we consider the complement *C* of *X* in *S*. If *X* is “spread out” randomly across *S*, every point of *C* will be close to some point in *X*. Accordingly, the median distance from points in *C* to their nearest point in *X* will be small. If on the contrary, *X* is localised, many points in *C* will be distant from *X*, thereby producing a larger median complement distance. We produce a p-value by comparing the median complement distance for *X* to those for randomised sets of the same size as *X*.

### Gene annotation

This allows one to predict functions of a given gene by looking at annotations of its neighbouring genes. If a gene has its own annotation and also has neighbours which have annotations, we can compare the actual annotation to the predicted annotation. These predictions perform well above chance as described in the section Predicting gene function of the CatsCradle vignette CatsCradle.

## Analysis of spatial transcriptomic data

CatsCradle provides extensive tools for the analysis of spatial transcriptomics data. Here we see cell type plotted on the cell centroids of our example data.

```
smallXenium = getExample('smallXenium')
ImageDimPlot(smallXenium,cols='polychrome')
```

![](data:image/png;base64...)

With Moran’s I, we can see spatial autocorrelation of gene expression and compute p-values for this. See CatsCradle spatial vignette CatsCradleSpatial.

### Neighbourhoods

The key concept in our analysis of this kind of data is the *neighbourhood*. In general, a neighbourhood is a contiguous set of cells. In all of our use cases, each neighbourhood is set of cells *around a given cell*. Accordingly, a neighbourhood can be referred to by the name of the cell at its centre.

The simplest type of neighbourhood arises from Delaunay triangulation where each neighbourhood consists of a cell and its immediate neighbours. This is an undirected graph in which each cell has an edge connecting it to each of these neighbours.

```
delaunayNeighbours = getExample('delaunayNeighbours')
head(delaunayNeighbours,10)
#>    nodeA nodeB
#> 1  16307 16316
#> 2  16314 16317
#> 3  16296 16299
#> 4  16299 16307
#> 5  16309 16316
#> 6  16309 16314
#> 7  12028 12032
#> 8  12032 16914
#> 9  12032 16257
#> 10  2975  3339
```

We can also make extended neighbourhoods, e.g., by finding the neighbours of each cell, their neighbours, and their neighbours. getExtendedNBHDs() produces a list characterising these neighbours by their combinatorial radius and collapseExtendedNBHDs() collapses these so that all the extended neighbours of each cell are now treated as neighbours.

In addition, neighbourhoods can be found on the basis of Euclidean distance.

For each cell type A, we can ask “What types of cells are found around cells of type A?” We can display the answer in a directed graph. Here we are using an extended neighbourhood. A fat arrow from type A to type B indicates that neighbourhoods around cells of type A have lots of cells of type B. Here we only display an arrow from A to B when cells of type B compose at least 5 percent of the cells in neighbourhoods around type A.

```
NBHDByCTMatrixExtended = getExample('NBHDByCTMatrixExtended')
#> radius 2
#> radius 3
#> radius 4
clusters = getExample('clusters')
colours = getExample('colours')
cellTypesPerCellTypeMatrixExtended = computeCellTypesPerCellTypeMatrix(NBHDByCTMatrixExtended,clusters)

cellTypesPerCellTypeGraphFromCellMatrix(cellTypesPerCellTypeMatrixExtended, minWeight = 0.05, colours = colours)
```

![](data:image/png;base64...)

```
#> IGRAPH 408e995 DNW- 16 62 --
#> + attr: coords (g/n), name (v/c), color (v/c), weight (e/n), width
#> | (e/n)
#> + edges from 408e995 (vertex names):
#>  [1] 0_Oligo->3_Endo       0_Oligo->10_Astro     0_Oligo->11_Oligo
#>  [4] 0_Oligo->14_Ependymal 3_Endo ->0_Oligo      3_Endo ->5_Astro
#>  [7] 3_Endo ->6_VLMC       3_Endo ->10_Astro     3_Endo ->11_Oligo
#> [10] 3_Endo ->14_Ependymal 4_Astro->0_Oligo      4_Astro->5_Astro
#> [13] 4_Astro->6_VLMC       4_Astro->7_Granule    4_Astro->10_Astro
#> [16] 4_Astro->11_Oligo     4_Astro->14_Ependymal 4_Astro->20_VLMC
#> [19] 5_Astro->6_VLMC       5_Astro->11_Oligo     6_VLMC ->10_Astro
#> + ... omitted several edges
```

We can also test for statistical significance for the enrichment of a given cell type in the neighbourhoods around another cell type (see CatsCradleSpatial).

### Neighourhood Seurat objects.

Neighbourhoods naturally want to be encoded into Seurat objects. There are two ways to do this.

#### Neighbourhoods and cell types

Just as cells express genes, with poetic license we can say that neighbourhoods “express” cell types. A cell types by neighbourhoods matrix gives the counts of cells of each type in each neighbourhood. This can be taken as the counts matrix for a Seurat object. We can then use the Louvain algorithm to cluster neighbourhoods into neighbourhood types. If we like, we can display these on a neighbourhood UMAP.

Here we attach these neighbourhood\_clusters from a neighbourhood Seurat object (created by computeNBHDVsCTObject()) to our original spatial object and visualize the neighbourhood clusters on the tissue coordinates. (Again, we are using extended neighbourhoods.)

```
NBHDByCTSeuratExtended = getExample('NBHDByCTSeuratExtended')
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
smallXenium$NBHDClusterExtended=
  NBHDByCTSeuratExtended@active.ident
ImageDimPlot(smallXenium, group.by = c("NBHDClusterExtended"),
             size = 1, cols = "polychrome")
```

![](data:image/png;base64...)

### Aggregate gene expression

As well as expressing cell types, neighbourhoods also express genes. We can take the gene expression profile of a neighbourhood to be the total aggregate expression of each gene across all cells in the neighbourhood. This produces a genes by neighbourhoods count matrix. The function aggregateGeneExpression() takes as arguments an underlying Seurat object and a set of neighbourhoods and produces a Seurat object where the rows are the genes of the underlying Seurat object and the columns are the neighbourhoods. Since each neighbourhood corresponds to a cell in our usage, this is formally indistinguishable from a normal Seurat object. However, to avoid confusion, we have labelled the clusters as aggregation\_clusters rather than the standard seurat\_clusters.

This enables all the usual analyses: dimension reduction and Louvain clustering (here giving another clustering of the neighbourhoods). In addition, we can find the marker genes which characterise the transcriptomic differences between the neighbourhood types.

```
extendedNeighbours = getExample('extendedNeighbours')
agg = aggregateGeneExpression(smallXenium,extendedNeighbours,
                                    verbose=FALSE)
#> Warning: Data is of class matrix. Coercing to dgCMatrix.
smallXenium$aggregateNBHDClusters = agg@active.ident
ImageDimPlot(smallXenium,group.by='aggregateNBHDClusters',cols='polychrome',
             size=1)
```

![](data:image/png;base64...)

Notice that since our neighbourhoods are all indexed by cells, we can compare the different methods of clustering neighbourhoods. Here we give a heatmap comparing the clustering based on cell types in our extended neighbourhoods to that based on aggregate gene expression. We see, for example, that aggregation clusters 7, 13, 14, 16 and 17 are subsumed into cell type neighbourhood cluster 0. More generally, we see that clustering based on aggregate gene expression tends to subdivide that based on the cell types in each neighbourhood.

```
library(pheatmap)
tab = table(smallXenium@meta.data[,c("aggregateNBHDClusters",
                                     "NBHDClusterExtended" )])
M = matrix(as.numeric(tab),nrow=nrow(tab))
rownames(M) = paste('aggregation_cluster',rownames(tab))
colnames(M) = paste('nbhd_cluster',colnames(tab))
for(i in 1:nrow(M)) M[i,] = M[i,] / sum(M[i,])
pheatmap(M)
```

![](data:image/png;base64...)

Another way of comparing clusterings is via the adjusted Rand index. This compares two classifications of the same set of objects. It can vary between -1 and 1. It takes the value 1 when these classifications denote the same subsets and 0 when they agree at a level no better than chance.

```
library(fossil,quietly=TRUE)
adjustedRandIndex = adj.rand.index(agg@active.ident,
                                   NBHDByCTSeuratExtended@active.ident)
adjustedRandIndex
#> [1] 0.2198536
```

## Ligand-receptor analysis

The Delaunay triangulation gives us an opportunity to look at the ligand-receptor interactions between neighbouring cells. We use the Nichenetr ligand-receptor pairs to discover the pairs in our gene panel. Nichnetr lists over eleven thousand ligand-receptor pairs. Of these 28 appear in our example panel.

The main function for carrying out ligand-receptor analysis is performLigandReceptorAnalysis(). This produces a list with multiple entries. These include a data frame interactionsOnEdges. Here the first two columns are nodeA and nodeB which give the edge in question and next two columns give their corresponding clusters. The remaining columns are logicals, each corresponding to a particular ligand-receptor pair and indicating whether that pair is present on that edge. Notice that while the neighbour-neighbour relationship in the Delaunay triangulation is undirected, the ligand-receptor relationship is directed. Accordingly, in interactionsOnEdges, a given edge appears as both the pair cell A - cell B and as the pair cell B - cell A.

```
ligandReceptorResults = getExample('ligandReceptorResults')
ligandReceptorResults$interactionsOnEdges[1:10,1:10]
#> 10 x 10 sparse Matrix of class "lgCMatrix"
#>   [[ suppressing 10 column names 'Pecam1_Pecam1', 'Cdh4_Cdh4', 'Col1a1_Cd44' ... ]]
#>
#> 16307_16316 | . . . . . . . . .
#> 16314_16317 . . . . . . . . . .
#> 16296_16299 . . . . . . . . . .
#> 16299_16307 | . . . . . . . . .
#> 16309_16316 . | . . . . . . . .
#> 16309_16314 . . . . . . . . . .
#> 12028_12032 . . . . . . . . | .
#> 12032_16914 . . . . . . . . . .
#> 12032_16257 . . . . . . . . . .
#> 2975_3339   . . . . . . . . . .
```

Other fields are downstream of this data frame. For example, pValue tells whether a given ligand-receptor pair is statistically significantly enriched in the interactions between two specific cell types. For further details see the section Ligand receptor analysis in the Cats Cradle Spatial vignette CatsCradleSpatial.

## CatsCradle, Seurat objects, SingleCellExperiment objects and SpatialExperiment objects

CatsCradle provides rudimentary support for the Bioconductor classes SingleCellExperiment and its derived class SpatialExperiment.

Every function which accepts a Seurat object as input can also accept a SingleCellExperiment in its place. Any function which returns a Seurat object can also return a SingleCellExperiment, in one case, a SpatialExperiment, through the use of the parameter returnType. In each case, the internals of the functions are manipulating Seurat objects. Conversion to and from these is performed upon entry to and return from the function and these coversions are rather lightweight in nature. They have slightly more functionality than as.Seurat and as.SingleCellExperiment. In addition to invoking these functions, they carry over the nearest neighbour graphs, and in one case carry over the tissue coordinates from a spatial Seurat object to a SpatialExperiment object. Because of the shallow nature of these conversions, other information may be lost.

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#>  [1] fossil_0.4.0       shapefiles_0.7.2   foreign_0.8-90     maps_3.4.3
#>  [5] tictoc_1.2.1       pheatmap_1.0.13    ggplot2_4.0.1      Seurat_5.4.0
#>  [9] SeuratObject_5.3.0 sp_2.2-0           future_1.68.0      CatsCradle_1.4.2
#>
#> loaded via a namespace (and not attached):
#>   [1] RcppAnnoy_0.0.22            splines_4.5.2
#>   [3] later_1.4.4                 bitops_1.0-9
#>   [5] tibble_3.3.0                polyclip_1.10-7
#>   [7] fastDummies_1.7.5           lifecycle_1.0.4
#>   [9] globals_0.18.0              lattice_0.22-7
#>  [11] MASS_7.3-65                 magrittr_2.0.4
#>  [13] plotly_4.11.0               sass_0.4.10
#>  [15] rmarkdown_2.30              jquerylib_0.1.4
#>  [17] yaml_2.3.12                 httpuv_1.6.16
#>  [19] otel_0.2.0                  sctransform_0.4.2
#>  [21] spam_2.11-1                 spatstat.sparse_3.1-0
#>  [23] reticulate_1.44.1           cowplot_1.2.0
#>  [25] pbapply_1.7-4               RColorBrewer_1.1-3
#>  [27] abind_1.4-8                 Rtsne_0.17
#>  [29] GenomicRanges_1.62.1        purrr_1.2.0
#>  [31] BiocGenerics_0.56.0         msigdbr_25.1.1
#>  [33] RCurl_1.98-1.17             pracma_2.4.6
#>  [35] IRanges_2.44.0              S4Vectors_0.48.0
#>  [37] data.tree_1.2.0             ggrepel_0.9.6
#>  [39] irlba_2.3.5.1               listenv_0.10.0
#>  [41] spatstat.utils_3.2-0        BiocStyle_2.38.0
#>  [43] goftest_1.2-3               RSpectra_0.16-2
#>  [45] spatstat.random_3.4-3       fitdistrplus_1.2-4
#>  [47] parallelly_1.46.0           codetools_0.2-20
#>  [49] DelayedArray_0.36.0         tidyselect_1.2.1
#>  [51] farver_2.1.2                matrixStats_1.5.0
#>  [53] stats4_4.5.2                spatstat.explore_3.6-0
#>  [55] Seqinfo_1.0.0               jsonlite_2.0.0
#>  [57] progressr_0.18.0            ggridges_0.5.7
#>  [59] survival_3.8-3              tools_4.5.2
#>  [61] ica_1.0-3                   Rcpp_1.1.0
#>  [63] glue_1.8.0                  gridExtra_2.3
#>  [65] SparseArray_1.10.8          xfun_0.55
#>  [67] MatrixGenerics_1.22.0       EBImage_4.52.0
#>  [69] dplyr_1.1.4                 withr_3.0.2
#>  [71] BiocManager_1.30.27         fastmap_1.2.0
#>  [73] digest_0.6.39               R6_2.6.1
#>  [75] mime_0.13                   networkD3_0.4.1
#>  [77] scattermore_1.2             tensor_1.5.1
#>  [79] jpeg_0.1-11                 dichromat_2.0-0.1
#>  [81] spatstat.data_3.1-9         tidyr_1.3.2
#>  [83] generics_0.1.4              data.table_1.18.0
#>  [85] httr_1.4.7                  htmlwidgets_1.6.4
#>  [87] S4Arrays_1.10.1             uwot_0.2.4
#>  [89] pkgconfig_2.0.3             gtable_0.3.6
#>  [91] rdist_0.0.5                 lmtest_0.9-40
#>  [93] S7_0.2.1                    SingleCellExperiment_1.32.0
#>  [95] XVector_0.50.0              htmltools_0.5.9
#>  [97] dotCall64_1.2               fftwtools_0.9-11
#>  [99] zigg_0.0.2                  scales_1.4.0
#> [101] Biobase_2.70.0              png_0.1-8
#> [103] SpatialExperiment_1.20.0    spatstat.univar_3.1-5
#> [105] geometry_0.5.2              knitr_1.51
#> [107] reshape2_1.4.5              rjson_0.2.23
#> [109] nlme_3.1-168                magic_1.6-1
#> [111] curl_7.0.0                  cachem_1.1.0
#> [113] zoo_1.8-15                  stringr_1.6.0
#> [115] KernSmooth_2.23-26          parallel_4.5.2
#> [117] miniUI_0.1.2                pillar_1.11.1
#> [119] grid_4.5.2                  vctrs_0.6.5
#> [121] RANN_2.6.2                  promises_1.5.0
#> [123] xtable_1.8-4                cluster_2.1.8.1
#> [125] evaluate_1.0.5              magick_2.9.0
#> [127] cli_3.6.5                   locfit_1.5-9.12
#> [129] compiler_4.5.2              crayon_1.5.3
#> [131] rlang_1.1.6                 future.apply_1.20.1
#> [133] labeling_0.4.3              plyr_1.8.9
#> [135] stringi_1.8.7               viridisLite_0.4.2
#> [137] deldir_2.0-4                assertthat_0.2.1
#> [139] babelgene_22.9              lazyeval_0.2.2
#> [141] tiff_0.1-12                 spatstat.geom_3.6-1
#> [143] Matrix_1.7-4                RcppHNSW_0.6.0
#> [145] patchwork_1.3.2             shiny_1.12.1
#> [147] SummarizedExperiment_1.40.0 ROCR_1.0-11
#> [149] Rfast_2.1.5.2               igraph_2.2.1
#> [151] RcppParallel_5.1.11-1       bslib_0.9.0
```