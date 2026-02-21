# CatsCradle

#### Anna Laddach and Michael Shapiro

#### 2025-12-25

*[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)*

![](data:image/png;base64...)

## Introduction

Here we describe the functionality in this package concerned with analysing the clustering of genes in single cell RNASeq data.

A typical Seurat single cell analysis starts with an expression matrix \(M\) where the rows represent genes and the columns represent individual cells. After normalisation one uses dimension reduction - PCA, UMAP, tSNE - to produce lower dimensional representations of the data for the cells and the Louvain algorithm to cluster cells with similar expression patterns.

CatsCradle operates based on a simple observation: by transposing the matrix \(M\), we can use the same methods to produce lower-dimensional representations of the genes and cluster the genes into groups that show similar patterns of expression.

```
library(CatsCradle,quietly=TRUE)
getExample = make.getExample()
exSeuratObj = getExample('exSeuratObj')
STranspose = transposeObject(exSeuratObj)
#> Warning: The default method for RunUMAP has changed from calling Python UMAP via reticulate to the R-native UWOT using the cosine metric
#> To use Python UMAP via reticulate, set umap.method to 'umap-learn' and metric to 'correlation'
#> This message will be shown once per session
```

This function transposes the expression matrix and carries out the basic functions, FindVariableFeatures(), ScaleData(), RunPCA(), RunUMAP(), FindNeighbors(), and FindClusters().

## Exploring CatsCradle

After transposing the usual Seurat object, the genes are now the columns (samples) and the individual cells are the rows (features). The Louvain clustering of the genes is now encoded in STranspose$seurat\_clusters. As with the cells, we can observe these clusters on UMAP, tSNE or PCA.

```
library(Seurat,quietly=TRUE)
library(ggplot2,quietly=TRUE)
DimPlot(exSeuratObj,cols='polychrome') + ggtitle('Cell clusters on UMAP')
```

![](data:image/png;base64...)

```
DimPlot(STranspose,cols='polychrome') + ggtitle('Gene clusters on UMAP')
```

![](data:image/png;base64...)

We have never seen a use case in which there was a reason to query the identities of the individual cells in a UMAP plot. However, this changes with a gene UMAP as each gene has a distinct (and interesting) identity. We recommend using plotly to produce a browseable version of the gene UMAP. This allows one to hover over the individual points and discover the genes in each cluster. Typical code might be

```
library(plotly,quietly=TRUE)
umap = FetchData(STranspose,c('UMAP_1','UMAP_2','seurat_clusters'))
umap$gene = colnames(STranspose)
plot = ggplot(umap,aes(x=UMAP_1,y=UMAP_2,color=seurat_clusters,label=gene) +
       geom_point()
browseable = ggplotly(plot)
print(browseable)
htmlwidgets::saveWidget(as_widget(browseable),'genesOnUMAP.html')
```

The question arises as to how to annotate the gene clusters. Assuming you have working annotations for the cell clusters it can be useful to examine which cells each of the gene clusters is expressed in. Here we give a heatmap of average expression of each gene cluster (columns) across each cell cluster (rows).

```
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
```

![](data:image/png;base64...)

Another way of seeing the relationship between cell clusters and gene clusters is in a Sankey graph. This is a bi-partite graph whose vertices are the cell clusters and the gene clusters. The edges of the graph display mean expression as the width of the edge. One can either display all edges with edge weight (width) displaying absolute value and colour distinguishing up- and down-regulation of expression or display separate Sankey graphs for the up- and down-regulated gene sets. It is these bi-partite graphs that contribute the name CatsCradle. Here the up-regulated gene sets are shown in cyan, the down-regulated sets in pink. The image was produced with the following code.

```
catsCradle = sankeyFromMatrix(averageExpMatrix,
                              disambiguation=c('cells_','genes_'),
                              plus='cyan',minus='pink',
                              height=800)
print(catsCradle)
```

The print command opens this in a browser. This allows one to query the individual vertices and edges. This can be saved with the saveWidget command as above.

## Biologically relevant gene sets on UMAP

Biologically relevant gene sets often cluster on CatsCradle gene UMAPs. Here we see a UMAP plot showing the gene clusters (by color), over-printed with the HALLMARK\_G2M\_CHECKPOINT that appear in STranspose in black. We see that these are strongly associated with gene cluster 8, but also show “satellite clusters” including an association with cluster 4 and with the border between clusters 0 and 3. In our experience, proliferation associated gene sets are among the most strongly clustered.

```
hallmark = getExample('hallmark')
#> Using human MSigDB with ortholog mapping to mouse. Use `db_species = "MM"` for mouse-native gene sets.
#> This message is displayed once per session.
#> Warning: The `category` argument of `msigdbr()` is deprecated as of msigdbr 10.0.0.
#> ℹ Please use the `collection` argument instead.
#> ℹ The deprecated feature was likely used in the CatsCradle package.
#>   Please report the issue at
#>   <https://github.com/AnnaLaddach/CatsCradle/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
h = 'HALLMARK_G2M_CHECKPOINT'
umap = FetchData(STranspose,c('umap_1','umap_2'))
idx = colnames(STranspose) %in% hallmark[[h]]
g = DimPlot(STranspose,cols='polychrome') +
    geom_point(data=umap[idx,],aes(x=umap_1,y=umap_2),color='black',size=2.7) +
    geom_point(data=umap[idx,],aes(x=umap_1,y=umap_2),color='green') +
    ggtitle(paste(h,'\non gene clusters'))
print(g)
```

![](data:image/png;base64...)

## Determining statistical significance of clustering

Given a set of points, \(S\) and a non-empty proper subset \(X \subset S\) we would like to determine the statistical significance of the degree to which \(X\) is clustered. To compute this we ask the opposite question: what would we see if \(X\) were randomly chosen? In this case we expect to see \(X\) broadly spread out across \(S\), i.e., most of \(S\) should be close to some point of \(X\). In particular we expect the median distance from the complement \(S \setminus X\) to \(X\) to be low. Of course, how low, depends on the size of \(X\). Conversely, if the points of \(X\) cluster together, we expect much of \(S \setminus X\) to be further from \(X\), at least compared to other sets of the same size. We use a distance function inspired by Hausdorf distance. Give a set \(X\), for each \(s\_k \in S \setminus X\), we take \(d\_k\) to be the distance from \(s\_k\) to the nearest point of \(X\). We then take the **median complement distance** to be the median of the values \(d\_k\). Comparing this median complement distance for \(X \subset S\) with those for randomly chosen sets \(X\_i \subset S\) allows us to assess the clustering of \(X\). (These \(X\_i\) are chosen to be the same size as \(X\).)

```
g2mGenes = intersect(colnames(STranspose),
                     hallmark[['HALLMARK_G2M_CHECKPOINT']])
stats = getObjectSubsetClusteringStatistics(STranspose,
                                      g2mGenes,
                                      numTrials=1000)
```

This uses UMAP as the default reduction and returns the median complement distance to the Hallmark G2M genes in STranspose, and the distances for 1000 randomly chosen sets of 56 genes. It computes a p-value based on the rank of the actual distance among the random distances and its z-score. Here we report a p-value of 0.001. However, as can be seen from the figure, the actual p-value is lower by many orders of magnitude.

```
statsPlot = ggplot(data.frame(medianComplementDistance=stats$randomSubsetDistance),
                  aes(x=medianComplementDistance)) +
    geom_histogram(bins=50) +
    geom_vline(xintercept=stats$subsetDistance,color='red') +
    ggtitle('Hallmark G2M real and random median complement distance')
print(statsPlot)
```

![](data:image/png;base64...)

Here we have shown the statistics for one of the gene sets that is most tightly clustered on UMAP. However, of the 50 Hallmark gene sets 31 cluster with a p-value better than 0.05.

```
df = read.table('hallmarkPValues.txt',header=TRUE,sep='\t')
g = ggplot(df,aes(x=logPValue)) +
    geom_histogram() +
    geom_vline(xintercept=-log10(0.05)) +
    ggtitle('Hallmark gene set p-values')
print(g)
#> `stat_bin()` using `bins = 30`. Pick better value `binwidth`.
```

![](data:image/png;base64...)

We have referred to median complement distance p-values as detecting clustering, but it might be more accurate to describe it as curdling. That is, it does not detect the tendency of the subset to co-locate in one region of the superset. Rather, it detects the tendency of points in the subset to stick close to each other. Accordingly, it makes sense to look at clustering within the subset. To do this, we analyse the Delaunay triangulation of the subset within the gene UMAP. We then classify the edges in this triangulation into shorter and longer edges which are assumed to be intra-subcluster and inter-subcluster edges. We discard the longer edges and look for the components of the resulting graph.

```
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
```

![](data:image/png;base64...)

## Gene z-scores on gene UMAP

Here we show that gene UMAP can reveal co-location of the genes that are up-regulated in each cell cluster. To do this, we start by finding the z-score for expression of each gene computed across all cells. For each gene in the gene Seurat object, and each cell cluster in the cell Seurat object, we then compute the mean z-score for that gene in the cells of that cluster. Plot this on the gene umap reveals localised patterns of gene expression. Creating a browseable figure allows for easy querying of the up-regulated genes.

```
meanZDF  = meanZPerClusterOnUMAP(exSeuratObj,
                                 STranspose,
                             'shortName')

h = ggplot(meanZDF,aes(x=umap_1,y=umap_2,color=EntericGliaCells)) +
    geom_point() +
    scale_color_gradient(low='green',high='red') +
    ggtitle('Mean z-score, Enteric glia on gene UMAP')
print(h)
```

![](data:image/png;base64...)

P-values for the spatial autocorrelation of these values can be found using runMoransI().

In the case where there are multiple clusters of similar cells, plotting the difference in mean z-score can illuminate the differences in the sub-clusters. Here we plot the difference in z-score between TCells3 and TCells1.

```
TDiff = meanZDF[,1:3]
TDiff$TDiff = meanZDF$TCells3 - meanZDF$TCells1
k = ggplot(TDiff,aes(x=umap_1,y=umap_2,color=TDiff)) +
    geom_point() +
    scale_color_gradient(low='green',high='red') +
    ggtitle('Mean z-score, TCells3 - TCells1')
print(k)
```

![](data:image/png;base64...)

## Nearby genes

We have seen that genes with similar annotation have a tendency to cluster. This suggests that nearby genes may have similar functions. To this end, we have supplied a function which finds nearby genes. This can be done geometrically using either PCA, UMAP or tSNE as the embedding or combinatorially using the nearest neighbor graph. The function returns a named vector whose values are the distances from the gene set and whose names are the genes. Here we find those genes which are within radius 0.2 in UMAP coordinates of genes in the HALLMARK\_INTERFERON\_ALPHA\_RESPONSE gene set. As you can see, the combinatorial radius of a gene set can grow quite quickly and need not have a close relation to UMAP distance. This function will also return weighted combinatorial distance from a single gene where distance is the reciprocal of edge weight.

```
geneSet = intersect(colnames(STranspose),
                    hallmark[['HALLMARK_INTERFERON_ALPHA_RESPONSE']])
geometricallyNearbyGenes = getNearbyGenes(STranspose,geneSet,radius=0.2,metric='umap')
theGeometricGenesThemselves = names(geometricallyNearbyGenes)
combinatoriallyNearbyGenes = getNearbyGenes(STranspose,geneSet,radius=1,metric='NN')
#> radius 1
#>     967
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
```

![](data:image/png;base64...)

## Predicting gene function

Given a particular gene, it is interesting to look at the annotations of nearby genes in the gene Seurat object. In this context, “annotations” might mean GO or Hallmark, “nearby” might mean in terms of UMAP or PCA coordinates or in the nearest neighbour graph in the gene Seurat object. Here we will look at Hallmark annotations and UMAP coordinates.

Gene annotation lists give lists of genes. For each gene, we can collect the annotations is belongs to. The function annotateGenesByGeneSet() inverts the gene sets to give a list of the sets each gene belongs to.

```
annotatedGenes = annotateGenesByGeneSet(hallmark)
names(annotatedGenes[['Myc']])
#>  [1] "HALLMARK_E2F_TARGETS"                "HALLMARK_ESTROGEN_RESPONSE_EARLY"
#>  [3] "HALLMARK_G2M_CHECKPOINT"             "HALLMARK_IL2_STAT5_SIGNALING"
#>  [5] "HALLMARK_INFLAMMATORY_RESPONSE"      "HALLMARK_MYC_TARGETS_V1"
#>  [7] "HALLMARK_MYC_TARGETS_V2"             "HALLMARK_TNFA_SIGNALING_VIA_NFKB"
#>  [9] "HALLMARK_UV_RESPONSE_DN"             "HALLMARK_WNT_BETA_CATENIN_SIGNALING"
```

We see that Myc belongs to ten hallmark sets. We can also give the annotations of a gene as a vector.

```
 Myc = annotateGeneAsVector('Myc',hallmark)
 MycNormalised = annotateGeneAsVector('Myc',hallmark,TRUE)
```

These are named vectors whose names are the Hallmark sets. Myc is a 0-1 vector indicating membership. MycNormalised gives these values normalised by the size of the sets in question. This is appropriate when we wish to weight the contributions of nearby genes as they are more likely to belong to larger gene sets.

```
predicted = predictAnnotation('Myc',hallmark,STranspose,radius=.5)
predicted$Myc[1:10]
#>            HALLMARK_ADIPOGENESIS     HALLMARK_ALLOGRAFT_REJECTION
#>                        0.0000000                        0.1395308
#>       HALLMARK_ANDROGEN_RESPONSE            HALLMARK_ANGIOGENESIS
#>                        0.0000000                        0.0000000
#>         HALLMARK_APICAL_JUNCTION          HALLMARK_APICAL_SURFACE
#>                        0.0938890                        0.0000000
#>               HALLMARK_APOPTOSIS    HALLMARK_BILE_ACID_METABOLISM
#>                        0.0000000                        0.0000000
#> HALLMARK_CHOLESTEROL_HOMEOSTASIS             HALLMARK_COAGULATION
#>                        0.5750117                        0.1417329
```

predictAnnotation() accepts a vector of genes and returns a list of prediction vectors. Here we have given it a single gene, Myc, and we see that it has predicted one of the gene sets listed for Myc.

Predictions made in this manner perform well above chance. Of the 2000 genes in STranspose, 922 have the property that they appear in at least one of the Hallmark gene sets and at least one of their nearby genes appears in a Hallmark gene set. This means that we are able to compare their actual annotation vectors with their predicted annotation vectors. After normalising both to unit vectors, we can take their dot prodcts as a measure of their closeness. Comparing the actual dot products for these 922 genes to those produced by 1000 randomised predictions produces the following comparison.

![](data:image/jpeg;base64...)

comparing real and randomised predictions

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
#> [1] pheatmap_1.0.13    ggplot2_4.0.1      Seurat_5.4.0       SeuratObject_5.3.0
#> [5] sp_2.2-0           future_1.68.0      CatsCradle_1.4.2
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