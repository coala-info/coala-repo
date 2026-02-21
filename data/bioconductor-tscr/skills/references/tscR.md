# Clustering time series data with tscR

## A R package to cluster time series data, base on slope and Fréchet distance

### Pérez-Sanz, Fernando. Murcian Institute of biomedical research

### Riquelme-Pérez, Miriam. CNRS - CEA, Univ. Paris-Saclay. MIRCen

* [Overview](#overview)
* [Getting started](#getting-started)
* [Simple clustering](#simple-clustering)
  + [Based on slope distance](#based-on-slope-distance)
  + [Based on Fréchet distance](#based-on-fréchet-distance)
  + [Combined clusters](#combined-clusters)
* [Clustering large data](#clustering-large-data)
* [Integration with SummarizedExperiment](#integration-with-summarizedexperiment)
* [Session info](#session-info)
* [References](#references)

# Overview

Clustering is an unsupervised learning technique widely used in several disciplines, such as machine learning, bioinformatics, image analysis or pattern recognition. Gene expression data clustering – as well as in other omic disciplines – is useful to find groups of genes with similar behavior and may provide very useful information for the understanding of certain biological processes.

This clustering of gene expression data can be performed onto genes, samples or over the time variable. In the last case, called ‘time series genes expression’, it is possible to identify genes with similar conduct and obtain sets of responses to certain situations. This has allowed to highlight environmental stress response, circadian rhythms pathway, treatment response, etc.

Despite the fact that there are several generic R packages for the analysis of clustering time series – *kmlShape* , *dtwclust*, *clue*, *TSclust* –, there is no a single algorithm that satisfactorily solves all problems and each clustering problem requires a specific approach. There are other specific packages to clustering time series in gene expression which seek minimize the high sensitivity to noise of other generic algorithms – *TSMixclust*, *ctsGE*, *MFuzz* – . *MFuzz* minimizes the high noise sensitivity of other algorithms through a fuzzy clustering, on the other hand *TSMixclust* is a soft-clustering that uses mixed-effects models with non-parametric smoothing spline fitting. *ctsGE* seeks to minimize noisy data in two steps, first define groups based on their expression profiles (expression index) and then, genes with same index are clustered by applying kmeans. Despite the fact that these methods attempt to solve the important task of minimizing the impact of the noise on clustering, genes with similar expression – in magnitude – typically end up in the same groups, even though they have different temporal evolutions.

Occasionally, however, the researcher’s main interest lies in finding genes with similar patterns (similar trajectories) although these occur at different levels of expression. Therefore, genes with a similar temporal evolution are therefore sought regardless of their magnitude of expression.

Let us suppose that we subject an individual to a treatment and measure the expression of three (or ten thousand) of his genes at the time the treatment begins, at one week, two weeks and three weeks after (Fig. 1).

The lines in figure 1 (`a`,`b`,`c`) represent 3 tracks (e.g. the expression of 3 genes at 4 different times). The trajectories \(T\_a\) and \(T\_c\) are identical in terms of slopes, they only differ in the magnitude of their expression. On the other hand the track \(T\_b\) would be closer to the track \(T\_a\) than to \(T\_c\).

![Figure 1. Three different trajectories at four times to exemplify the possible relationships or classifications of the data.](data:image/png;base64...)

Figure 1. Three different trajectories at four times to exemplify the possible relationships or classifications of the data.

Intuitively, if we had to determine the distance between these trajectories, we would think that \(T\_a\) is closer to \(T\_b\) than to \(T\_c\). In addition, \(T\_c\) is closer to \(T\_b\) than to \(T\_a\). You could quantify those distances with different metrics:

* Euclidean distance

\[
\begin{matrix}
& a &b \\
b & 21.24 & \\
c & 54.00 & 39.41
\end{matrix}
\]

Other distance metrics based more specifically on time series such as Fréchet or DTW provide similar results:

* Fréchet Distance

\[
\begin{matrix}
& a &b \\
b & 16 & \\
c & 29 & 24
\end{matrix}
\]

* DTW Distance

\[
\begin{matrix}
& a & b \\
b & 42 & \\
c & 158 & 104
\end{matrix}
\]

However, if the main interest is to determine which trajectories have similar behaviour over time regardless of the magnitude of their expression, it is necessary to use purely geometric criteria and look for similarities based on their slopes. In this case, the distance matrix would look as follows:

\[
\begin{matrix}
& a & b \\
b & 6.71 & \\
c & 0.00 & 6.71
\end{matrix}
\] Where it can be seen that the distance between the \(a\) and \(c\) trajectory is zero because these are two lines with identical slopes and the distance from both to \(b\) is the same.

Therefore, we might find a researcher interested in identifying and grouping sets of genes with similar behaviours according to different points of view:

* Genes clustered with similar levels of expression, i.e. genes whose trajectories are close in terms of physical distance (fig.2 B).
* Genes grouped with similar evolution regardless of their physical distance. In this second scenario, we are dealing with genes that respond in a similar way, but with different intensity (fig.2 C).
* It might also be interesting to group genes according to both factors (distance + tendency) (fig.2 D).

![Figure 2. Different possibilities of classifying the tracks from the whole data set (a) according to its Fréchet distances (b), according to its slopes (c) or a combination of both (d).](data:image/png;base64...)

Figure 2. Different possibilities of classifying the tracks from the whole data set (a) according to its Fréchet distances (b), according to its slopes (c) or a combination of both (d).

Through this package we propose a methodology that allows to group these paths based on physical distances by using distance metrics adapted to time series (Fréchet’s distance) and a new approach based on similarity of slopes between trajectories, where the trajectories are grouped according to this proximity regardless of the distance between them.

Furthermore, a combination of both classifications is available, so that the final result would be trajectories grouped according to their values and their evolutions.

Since in many studies (especially in different comic disciplines), the number of trajectories can be very large (thousands or tens of thousands), a methodology has been developed based on the existing one in the *kmlShape* package. By means of a pre-grouping, a series of “representatives” of the trajectories is obtained, called senators; these senators are then classified by means of some of the proposed algorithms. At last, the set of trajectories is assigned to the cluster to which its senator has been assigned. In this way the computational cost and the risk of overflowing the memory is reduced.

# Getting started

Install from Bioconductor

```
if (!requireNamespace("BiocManager"))
install.packages("BiocManager")
BiocManager::install("tscR")
```

Install the latest development version in `install_github`.

```
devtools::install_github("fpsanz/tscR")
```

Read the vignette (this document):

```
library(tscR)
```

```
browseVignettes("tscR")
```

# Simple clustering

## Based on slope distance

The input data has to be a dataframe or matrix where the rows will be each of the trajectories and the columns the times (Table 1).

Initially, we are going to load a set of example trajectories included in the library.

```
data(tscR)
df <- tscR
```

Table 1. First six rows from the example data matrix at three different times that have been studied for one sample.

| T1 | T2 | T3 |
| --- | --- | --- |
| 6.162 | 5.900 | 6.602 |
| 3.344 | 3.676 | 2.948 |
| 1.058 | 0.881 | -0.513 |
| 4.417 | 6.741 | 7.196 |
| 2.409 | 3.799 | 2.190 |
| 1.057 | 1.880 | -1.038 |

tscR includes 300 observations (trajectories) with data taken at 3 regular time-points (day 1, day 2, day 3).

![Figure 3. Set ot 300 example trajectories that tscR package includes to work with.](data:image/png;base64...)

Figure 3. Set ot 300 example trajectories that tscR package includes to work with.

Following this, the similarity matrix is calculated and its size will be n x n, where n represents the number of rows in the input matrix. This matrix is an object of ‘’dist’’ class and contains the similarities between trajectories based on similar slopes.

```
time <- c(1,2,3)
sDist <- slopeDist(df, time)
```

The next step would involve grouping the trajectories based on similarities in their slopes regardless of the distance between them *(meter referencia al paper)*.

```
sclust <- getClusters(sDist, k = 3)
```

The result may be displayed with the `plotCluster` function. This function assumes as parameters the original data (data), the object obtained from `getClusters` (clust) and the clusters to be displayed: “all” to display them all in a single graphic, an integer to display the trajectories of that cluster or a vector defining which clusters should be displayed (one per subplot).

```
plotCluster(data = df,
clust = sclust,
ncluster = "all")
```

![](data:image/png;base64...)

```
plotCluster(df, sclust, 1)
```

![](data:image/png;base64...)

```
plotCluster(df, sclust, c(1:2))
```

![](data:image/png;base64...)

As it can be appreciated in this last graph, the trajectories with descending - ascending evolution have been grouped on one side, independently of their distance (left plot) and those with ascending - descending evolution on the other side (right plot).

## Based on Fréchet distance

This is a measure of similarity between curves that takes into account the location and order of the points along the curve.

The procedure seems to be similar to the previous case:

* Calculate distance matrix.
* Get the clusters.
* Display the results.

```
fdist <- frechetDistC(df, time)
fclust <- getClusters(fdist, 3)
plotCluster(df, fclust, "all")
```

![](data:image/png;base64...)

Note that the clustering has more to do with the distance (in Euclidean terms) between trajectories rather than with the slopes themselves, as illustrated in the overview. In particular circumstances, this may be the classification of interest.

## Combined clusters

A third option would be to combine the results of both clusters in such a way that groups of trajectories would be obtained based on both distance and similarity of slopes.

To this end, the `combineCluster` function takes as input the objects generated by getClusters, producing a combined classification.

Consequently, it is possible to classify very close tracks with different slopes into different groups, and tracks with similar slopes but farther away into different groups. This gives a more accurate classification of the trajectories.

```
ccluster <- combineCluster(sclust, fclust)
plotCluster(df, ccluster, c(1:6))
```

![](data:image/png;base64...)

```
plotCluster(df, ccluster, "all")
```

![](data:image/png;base64...)

# Clustering large data

In cases where there are large amount of trajectories (> ~10000), computational cost in terms of CPU and RAM memory can be very high, especially when distance matrix is being computed.

Here we proposed to perform a pre-clustering with `clara` function implemented within `imputeSenators`, with a high number \(N\) of clusters (e.g. 100). This will generate \(N\) (e.g. 100) centroids assuming that those centroids can represent the shapes of all trajectories.

Once the senator clusters are obtained, each original trajectory is assigned to the final cluster to which its senator has been assigned.

This methodology (inspired by senators of *kmlShape* package) makes it possible to classify a very high number of trajectories with a relatively low computational cost.

The method would be as follows:

First, the senators are obtained.

```
data( "tscR" )
bigDF <- tscR
senators <- imputeSenators( bigDF, k = 100 )
#> Setting k to 30. 10% of total data
```

The created object (`senators`) is a list with 3 components.

* $data: Data frame with original data
* $senatorData: Matrix with senators’ trayectories
* $senatorCluster: Vector with senators’ clusters

As an example, the trajectories will be classified using the distance based on slopes, although as mentioned above it could be done either based on Fréchet’s distance or even combining both.

```
sdistSen <- frechetDistC(senators$senatorData,
time = c( 1, 2, 3 ) )

cSenators <- getClusters( sdistSen, k = 4 )
```

It is possible to observe the classification made to senators.

```
plotCluster(senators$senatorData,
cSenators, "all")
```

![](data:image/png;base64...)

```
plotCluster(senators$senatorData,
cSenators, c(1,2,3,4))
```

![](data:image/png;base64...)

Finally, it is necesssary to assign original data to new clusters.

```
endCluster <- imputeSenatorToData(senators,
cSenators)
```

This creates an object of imputeSenator class with 3 slots

* @data: Contains data.frame with original data.
* @senators: Identifies each data into @data with senator it belong to.
* @endcluster: Contains final clusters to which the data has been assigned.

The result:

```
plotClusterSenator(endCluster, "all")
```

![](data:image/png;base64...)

```
plotClusterSenator(endCluster, c(1,2,3,4))
```

![](data:image/png;base64...)

# Integration with SummarizedExperiment

The SummarizedExperiment container includes one or more tests, each represented by a matrix type object in a quantitative or non- quantitative way. Among all the elements in this object, the one that contains the more relevant data to our study is the assay slot, which is composed of a list of data frames. The rows in every data frame usually represent a genomic interesting range (genes, probes, etc) and the columns might represent the samples, individuals, time and so on.

To provide an easier usage of this sort of objects directly with tscR, because the assay slot may be quite complex and replete with data, we have implemented the `importFromSE()` function. This function is integrated within the rest of the functions of the package as well. Thus, it is not necessary to invoke it ad-hoc; but for a greater control it can be called to obtain the individual matrix corresponding to a sample, where the rows correspond to a genomic range and the columns will be different times. Exactly as downtream analysis functions would expect.

There are two possible arrangements of temporal data within SummarizedExperiment (Fig. 4):

![Figure 4. Two options of how the summarizedexperiment object can be introduced to extract the data matrix for later analysis.](data:image/svg+xml;base64...)

Figure 4. Two options of how the summarizedexperiment object can be introduced to extract the data matrix for later analysis.

1. `SE_byTime = TRUE`: if each matrix in the assays slot corresponds to a sample or individual and each column is a time. In this scenario, the extraction of the matrix is direct because it is what the tscR function requires. Here the argument *sample* refers to the name of the matrix `assays(se) [[col]]` or the matrix number `assay(se, i=col)` in the slot assays.
2. `SE_byTime = FALSE`: if each matrix in the assays slot corresponds to a certain time and each column to a particular sample — this is the most common situation —. In this case, in order to obtain a matrix of a single sample with all its times, as the program expects, the corresponding column of time must be extracted from each matrix and assembled into a new matrix (Fig 4.B). With this, the argument *sample* refers to the sample name (column name) or the column number corresponding to that sample `lapply(assays(se), function(se) se[, col])`.

# Session info

```
sessionInfo()
#> R version 4.0.2 (2020-06-22)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 18.04.4 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.11-bioc/R/lib/libRblas.so
#> LAPACK: /home/biocbuild/bbs-3.11-bioc/R/lib/libRlapack.so
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> attached base packages:
#> [1] grid      stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#> [1] dtw_1.21-3      proxy_0.4-24    latex2exp_0.4.0 ggplot2_3.3.2
#> [5] tscR_1.0.1      dplyr_1.0.0
#>
#> loaded via a namespace (and not attached):
#>  [1] Biobase_2.48.0              jsonlite_1.7.0
#>  [3] prettydoc_0.3.1             kml_2.4.1
#>  [5] shiny_1.5.0                 highr_0.8
#>  [7] stats4_4.0.2                GenomeInfoDbData_1.2.3
#>  [9] yaml_2.2.1                  pillar_1.4.6
#> [11] lattice_0.20-41             glue_1.4.1
#> [13] digest_0.6.25               GenomicRanges_1.40.0
#> [15] manipulateWidget_0.10.1     RColorBrewer_1.1-2
#> [17] promises_1.1.1              XVector_0.28.0
#> [19] colorspace_1.4-1            htmltools_0.5.0
#> [21] httpuv_1.5.4                Matrix_1.2-18
#> [23] pkgconfig_2.0.3             misc3d_0.8-4
#> [25] longitudinalData_2.4.1      zlibbioc_1.34.0
#> [27] purrr_0.3.4                 xtable_1.8-4
#> [29] scales_1.1.1                webshot_0.5.2
#> [31] later_1.1.0.1               tibble_3.0.3
#> [33] farver_2.0.3                generics_0.0.2
#> [35] IRanges_2.22.2              ellipsis_0.3.1
#> [37] withr_2.2.0                 SummarizedExperiment_1.18.2
#> [39] BiocGenerics_0.34.0         magrittr_1.5
#> [41] crayon_1.3.4                mime_0.9
#> [43] evaluate_0.14               class_7.3-17
#> [45] tools_4.0.2                 lifecycle_0.2.0
#> [47] matrixStats_0.56.0          stringr_1.4.0
#> [49] clv_0.3-2.2                 S4Vectors_0.26.1
#> [51] munsell_0.5.0               cluster_2.1.0
#> [53] DelayedArray_0.14.1         compiler_4.0.2
#> [55] GenomeInfoDb_1.24.2         rlang_0.4.7
#> [57] RCurl_1.98-1.2              htmlwidgets_1.5.1
#> [59] crosstalk_1.1.0.1           miniUI_0.1.1.1
#> [61] labeling_0.3                bitops_1.0-6
#> [63] rmarkdown_2.3               gtable_0.3.0
#> [65] kmlShape_0.9.5              R6_2.4.1
#> [67] gridExtra_2.3               knitr_1.29
#> [69] fastmap_1.0.1               stringi_1.4.6
#> [71] parallel_4.0.2              Rcpp_1.0.5
#> [73] vctrs_0.3.2                 rgl_0.100.54
#> [75] tidyselect_1.1.0            xfun_0.15
```

# References

Abanda, A. et al. (2019). A review on distance based time series classification. Data Mining and Knowledge Discovery, 33 (2), 378–412.

Ceccarello, M. et al. (2019). FRESH: Fréchet Similarity with Hashing. In Algorithms and data structures , pages 254–268. Springer.

Eiter, T. and Mannila, H. (1994). Computing discrete Fréchet distance. Notes, 94, 64.

Genolini, C. et al. (2016). kmlShape: An efficient method to cluster longitudinal data (Time-Series) according to their shapes. PLoS ONE, 11 (6), e0150738.

Golumbeanu, M. (2019). TMixClust: Time Series Clustering of Gene Expression with Gaussian Mixed-Effects Models and Smoothing Splines. Hornik, K. (2005). A {CLUE} for {CLUster Ensembles}. Journal of Statistical Software, 14 (12).

Kumar, L. and Futschik, M. E. (2007). Mfuzz: A software package for soft clustering of microarray data. Bioinformation ,2 (1), 5–7.

Maechler, M. et al. (2019). cluster: Cluster Analysis Basics and Extensions.

McDowell, I. C. et al. (2018). Clustering gene expression time series data using an infinite Gaussian process mixture model.PLoS Computational Biology, 14 (1), e1005896.

Montero, P. and Vilar, J. A. (2014). TSclust: An R package for time series clustering. Journal of Statistical Software, 62 (1), 1–43.

Morgan M, Obenchain V, Hester J, Pagès H (2019). SummarizedExperiment: SummarizedExperiment container. R package version 1.16.1.

Oyelade, J. et al. (2016). Clustering algorithms: Their application to gene expression data. Bioinformatics and Biology Insights, 10, 237–253.

R Core Team (2019). R: A Language and Environment for Statistical Computing.

Sardá-Espinosa, A.(2019). Time-Series Clustering in R Using the dtwclust Package. The R Journal.

Sharabi-Schwager, M. and Ophir, R. (2019). ctsGE: Clustering of Time Series Gene Expression data.

Toohey, K. (2015). SimilarityMeasures: Trajectory Similari ty Measures