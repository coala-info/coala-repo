# SC3 package manual

Vladimir Kiselev

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 `SingleCellExperiment`, QC and `scater`](#singlecellexperiment-qc-and-scater)
* [3 Quick Start](#quick-start)
  + [3.1 `SC3` Input](#sc3-input)
  + [3.2 Run SC3](#run-sc3)
  + [3.3 colData](#coldata)
  + [3.4 rowData](#rowdata)
* [4 Number of Сells](#number-of-сells)
* [5 Plot Functions](#plot-functions)
  + [5.1 Consensus Matrix](#consensus-matrix)
  + [5.2 Silhouette Plot](#silhouette-plot)
  + [5.3 Expression Matrix](#expression-matrix)
  + [5.4 Cluster Stability](#cluster-stability)
  + [5.5 DE genes](#de-genes)
  + [5.6 Marker Genes](#marker-genes)
* [6 SC3 in Detail](#sc3-in-detail)
  + [6.1 `sc3_prepare`](#sc3_prepare)
  + [6.2 *(optional)* `sc3_estimate_k`](#optional-sc3_estimate_k)
  + [6.3 `sc3_calc_dists`](#sc3_calc_dists)
  + [6.4 `sc3_calc_transfs`](#sc3_calc_transfs)
  + [6.5 `sc3_kmeans`](#sc3_kmeans)
  + [6.6 `sc3_calc_consens`](#sc3_calc_consens)
  + [6.7 *(optional)* `sc3_calc_biology`](#optional-sc3_calc_biology)
    - [6.7.1 Cell Outliers](#cell-outliers)
    - [6.7.2 DE and marker genes](#de-and-marker-genes)
* [7 Hybrid `SVM` Approach](#hybrid-svm-approach)

# 1 Introduction

Single-Cell Consensus Clustering (`SC3`) is a tool for unsupervised clustering of scRNA-seq data. `SC3` achieves high accuracy and robustness by consistently integrating different clustering solutions through a consensus approach. An interactive graphical implementation makes `SC3` accessible to a wide audience of users. In addition, `SC3` also aids biological interpretation by identifying marker genes, differentially expressed genes and outlier cells. A manuscript describing `SC3` in details is published in [Nature Methods](http://dx.doi.org/10.1038/nmeth.4236).

# 2 `SingleCellExperiment`, QC and `scater`

`SC3` is a purely clustering tool and it does not provide functions for the sequencing quality control (QC) or normalisation. On the contrary it is expected that these preprocessing steps are performed by a user in advance. To encourage the preprocessing, `SC3` is built on top of the Bioconductor’s [SingleCellExperiment](http://bioconductor.org/packages/SingleCellExperiment) class and uses functionality of [scater](http://bioconductor.org/packages/scater) package for QC.

# 3 Quick Start

## 3.1 `SC3` Input

If you already have a `SingleCellExperiment` object created and QCed using `scater` then proceed to the next chapter.

If you have a matrix containing expression data that was QCed and normalised by some other tool, then we first need to form an `SingleCellExperiment` object containing the data. For illustrative purposes we will use an example expression matrix provided with `SC3`. The dataset (`yan`) represents **FPKM** gene expression of 90 cells derived from human embryo. The authors ([Yan et al.](http://dx.doi.org/10.1038/nsmb.2660)) have defined developmental stages of all cells in the original publication (`ann` data frame). The rows in the `yan` dataset correspond to genes and columns correspond to cells.

```
library(SingleCellExperiment)
library(SC3)
library(scater)

head(ann)
```

```
##                 cell_type1
## Oocyte..1.RPKM.     zygote
## Oocyte..2.RPKM.     zygote
## Oocyte..3.RPKM.     zygote
## Zygote..1.RPKM.     zygote
## Zygote..2.RPKM.     zygote
## Zygote..3.RPKM.     zygote
```

```
yan[1:3, 1:3]
```

```
##          Oocyte..1.RPKM. Oocyte..2.RPKM. Oocyte..3.RPKM.
## C9orf152             0.0             0.0             0.0
## RPS11             1219.9          1021.1           931.6
## ELMO2                7.0            12.2             9.3
```

The `ann` dataframe contains just `cell_type1` column which correspond to the cell labels provided by authors of the original publication. Note that in general it can also contain more information about the cells, such as plate, run, well, date etc.

Now we can create a `SingleCellExperiment` object from `yan` expression matrix.

Note that `SC3` requires both `counts` and `logcounts` slots to exist in the input `SingleCellExperiment` object. The `counts` slot is used for gene filtering, which is based on gene dropout rates. `logcounts` slot, which is supposed to contain both normalised and log-transformed expression matrix, is used in the main clustering algorithm. In the case of the `yan` dataset even though the `counts` are not available (we only have **FPKM** values) we can use the **FPKM** values for gene dropout rate calculations since **FPKM** normalisation does not change the dropout rate.

`SC3` also requires the `feature_symbol` column of the `rowData` slot of the input `SingleCellExperiment` object to contain preferable feature names (genes/transcript) which will be used in the futher visualisations.

```
# create a SingleCellExperiment object
sce <- SingleCellExperiment(
    assays = list(
        counts = as.matrix(yan),
        logcounts = log2(as.matrix(yan) + 1)
    ),
    colData = ann
)

# define feature names in feature_symbol column
rowData(sce)$feature_symbol <- rownames(sce)
# remove features with duplicated names
sce <- sce[!duplicated(rowData(sce)$feature_symbol), ]
```

`scater` allows a user to quickly visualize and assess any `SingleCellExperiment` object, for example using a PCA plot:

```
sce <- runPCA(sce)
```

```
## Warning in (function (A, nv = 5, nu = nv, maxit = 1000, work = nv + 7, reorth =
## TRUE, : You're computing too large a percentage of total singular values, use a
## standard svd instead.
```

```
plotPCA(sce, colour_by = "cell_type1")
```

![](data:image/png;base64...)

## 3.2 Run SC3

If you would like to explore clustering of your data in the range of `k`s (the number of clusters) from 2 to 4, you just need to run the main `sc3` method and define the range of `k`s using the `ks` parameter (here we also ask `SC3` to calculate biological features based on the identified cell clusters):

```
sce <- sc3(sce, ks = 2:4, biology = TRUE)
```

```
## Setting SC3 parameters...
```

```
## Calculating distances between the cells...
```

```
## Performing transformations and calculating eigenvectors...
```

```
## Performing k-means clustering...
```

```
## Calculating consensus matrix...
```

```
## Calculating biology...
```

> By default `SC3` will use all but one cores of your machine. You can manually set the number of cores to be used by setting the `n_cores` parameter in the `sc3` call.

To quickly and easily explore the `SC3` solutions using an interactive Shiny application use the following method:

```
sc3_interactive(sce)
```

Visual exploration can provide a reasonable estimate of the number of clusters `k`. Once a preferable `k` is chosen it is also possible to export the results into an Excel file:

```
sc3_export_results_xls(sce)
```

This will write all results to `sc3_results.xls` file. The name of the file can be controlled by the `filename` parameter.

## 3.3 colData

`SC3` writes all its results obtained for cells to the `colData` slot of the `sce` object by adding additional columns to it. This slot also contains all other cell features calculated by the `scater` package either automatically during the `sce` object creation or during the `calculateQCMetrics` call. One can identify the `SC3` results using the `"sc3_"` prefix:

```
col_data <- colData(sce)
head(col_data[ , grep("sc3_", colnames(col_data))])
```

```
## DataFrame with 6 rows and 6 columns
##                 sc3_2_clusters sc3_3_clusters sc3_4_clusters
##                       <factor>       <factor>       <factor>
## Oocyte..1.RPKM.              2              2              2
## Oocyte..2.RPKM.              2              2              2
## Oocyte..3.RPKM.              2              2              2
## Zygote..1.RPKM.              2              2              2
## Zygote..2.RPKM.              2              2              2
## Zygote..3.RPKM.              2              2              2
##                 sc3_2_log2_outlier_score sc3_3_log2_outlier_score
##                                <numeric>                <numeric>
## Oocyte..1.RPKM.                        0                  3.34623
## Oocyte..2.RPKM.                        0                  3.37839
## Oocyte..3.RPKM.                        0                  3.16723
## Zygote..1.RPKM.                        0                  0.00000
## Zygote..2.RPKM.                        0                  0.00000
## Zygote..3.RPKM.                        0                  0.00000
##                 sc3_4_log2_outlier_score
##                                <numeric>
## Oocyte..1.RPKM.                  3.34623
## Oocyte..2.RPKM.                  3.37839
## Oocyte..3.RPKM.                  3.16723
## Zygote..1.RPKM.                  0.00000
## Zygote..2.RPKM.                  0.00000
## Zygote..3.RPKM.                  0.00000
```

Additionally, having `SC3` results stored in the same slot makes it possible to highlight them during any of the `scater`’s plotting function call, for example:

```
sce <- runPCA(sce)
```

```
## Warning in (function (A, nv = 5, nu = nv, maxit = 1000, work = nv + 7, reorth =
## TRUE, : You're computing too large a percentage of total singular values, use a
## standard svd instead.
```

```
plotPCA(
    sce,
    colour_by = "sc3_3_clusters",
    size_by = "sc3_3_log2_outlier_score"
)
```

![](data:image/png;base64...)

## 3.4 rowData

`SC3` writes all its results obtained for features (genes/transcripts) to the `rowData` slot of the `sce` object by adding additional columns to it. This slot also contains all other feature values calculated by the `scater` package either automatically during the `sce` object creation or during the `calculateQCMetrics` call. One can identify the `SC3` results using the `"sc3_"` prefix:

```
row_data <- rowData(sce)
head(row_data[ , grep("sc3_", colnames(row_data))])
```

```
## DataFrame with 6 rows and 13 columns
##          sc3_gene_filter sc3_2_markers_clusts sc3_2_markers_padj
##                <logical>            <numeric>          <numeric>
## C9orf152           FALSE                   NA                 NA
## RPS11              FALSE                   NA                 NA
## ELMO2               TRUE                    2        3.43043e-06
## CREB3L1             TRUE                    2        1.00000e+00
## PNMA1              FALSE                   NA                 NA
## MMP2                TRUE                    1        1.00000e+00
##          sc3_2_markers_auroc sc3_3_markers_clusts sc3_3_markers_padj
##                    <numeric>            <numeric>          <numeric>
## C9orf152                  NA                   NA                 NA
## RPS11                     NA                   NA                 NA
## ELMO2               0.905833                    2        8.75271e-08
## CREB3L1             0.635833                    2        3.65118e-04
## PNMA1                     NA                   NA                 NA
## MMP2                0.549722                    1        1.00000e+00
##          sc3_3_markers_auroc sc3_4_markers_clusts sc3_4_markers_padj
##                    <numeric>            <numeric>          <numeric>
## C9orf152                  NA                   NA                 NA
## RPS11                     NA                   NA                 NA
## ELMO2               0.969697                    2        8.97773e-08
## CREB3L1             0.827020                    2        3.85412e-04
## PNMA1                     NA                   NA                 NA
## MMP2                0.549722                    3        1.00000e+00
##          sc3_4_markers_auroc sc3_2_de_padj sc3_3_de_padj sc3_4_de_padj
##                    <numeric>     <numeric>     <numeric>     <numeric>
## C9orf152                  NA            NA            NA            NA
## RPS11                     NA            NA            NA            NA
## ELMO2               0.969697   3.33801e-06   7.88682e-10   1.86624e-09
## CREB3L1             0.827020   1.00000e+00   2.03905e-03   6.16236e-03
## PNMA1                     NA            NA            NA            NA
## MMP2                0.543929   1.00000e+00   1.00000e+00   1.00000e+00
```

Because the biological features were also calculated for each `k`, one can find ajusted p-values for both differential expression and marker genes, as well as the area under the ROC curve values (see `?sc3_calc_biology` for more information).

# 4 Number of Сells

The default settings of `SC3` allow to cluster (using a single `k`) a dataset of 2,000 cells in about 20-30 minutes.

For datasets with more than 2,000 cells `SC3` automatically adjusts some of its parameters (see below). This allows to cluster a dataset of 5,000 cells in about 20-30 minutes. The parameters can also be manually adjusted for datasets with any number of cells.

For datasets with more than 5,000 cells `SC3` utilizes a hybrid approach that combines unsupervised and supervised clusterings (see below). Namely, `SC3` selects a subset of cells uniformly at random, and obtains clusters from this subset. Subsequently, the inferred labels are used to train a Support Vector Machine (SVM), which is employed to assign labels to the remaining cells. Training cells can also be manually selected by providing their indeces.

# 5 Plot Functions

`SC3` also provides methods for plotting all figures from the interactive session.

## 5.1 Consensus Matrix

The consensus matrix is a *N* by *N* matrix, where *N* is the number of cells in the input dataset. It represents similarity between the cells based on the averaging of clustering results from all combinations of clustering parameters. Similarity 0 (blue) means that the two cells are always assigned to different clusters. In contrast, similarity 1 (red) means that the two cells are always assigned to the same cluster. The consensus matrix is clustered by hierarchical clustering and has a diagonal-block structure. Intuitively, the perfect clustering is achieved when all diagonal blocks are completely red and all off-diagonal elements are completely blue.

```
sc3_plot_consensus(sce, k = 3)
```

![](data:image/png;base64...)

It is also possible to annotate cells (columns of the consensus matrix) with any column of the `colData` slot of the `sce` object.

```
sc3_plot_consensus(
    sce, k = 3,
    show_pdata = c(
        "cell_type1",
        "log10_total_features",
        "sc3_3_clusters",
        "sc3_3_log2_outlier_score"
    )
)
```

```
## Provided columns 'log10_total_features' do not exist in the phenoData table!
```

![](data:image/png;base64...)

## 5.2 Silhouette Plot

A silhouette is a quantitative measure of the diagonality of the consensus matrix. An average silhouette width (shown at the bottom left of the silhouette plot) varies from 0 to 1, where 1 represents a perfectly block-diagonal consensus matrix and 0 represents a situation where there is no block-diagonal structure. The best clustering is achieved when the average silhouette width is close to 1.

```
sc3_plot_silhouette(sce, k = 3)
```

![](data:image/png;base64...)

## 5.3 Expression Matrix

The expression panel represents the original input expression matrix (cells in columns and genes in rows) after cell and gene filters. Genes are clustered by kmeans with k = 100 (dendrogram on the left) and the heatmap represents the expression levels of the gene cluster centers after log2-scaling.

```
sc3_plot_expression(sce, k = 3)
```

![](data:image/png;base64...)

It is also possible to annotate cells (columns of the expression matrix) with any column of the `colData` slot of the `sce` object.

```
sc3_plot_expression(
    sce, k = 3,
    show_pdata = c(
        "cell_type1",
        "log10_total_features",
        "sc3_3_clusters",
        "sc3_3_log2_outlier_score"
    )
)
```

```
## Provided columns 'log10_total_features' do not exist in the phenoData table!
```

![](data:image/png;base64...)

## 5.4 Cluster Stability

Stability index shows how stable each cluster is accross the selected range of `k`s. The stability index varies between 0 and 1, where 1 means that the same cluster appears in every solution for different `k`.

```
sc3_plot_cluster_stability(sce, k = 3)
```

```
## Warning: Use of `d$Cluster` is discouraged.
## ℹ Use `Cluster` instead.
```

```
## Warning: Use of `d$Stability` is discouraged.
## ℹ Use `Stability` instead.
```

![](data:image/png;base64...)

## 5.5 DE genes

Differential expression is calculated using the non-parametric Kruskal-Wallis test. A significant p-value indicates that gene expression in at least one cluster stochastically dominates one other cluster. SC3 provides a list of all differentially expressed genes with adjusted p-values < 0.01 and plots gene expression profiles of the 50 genes with the lowest p-values. Note that the calculation of differential expression after clustering can introduce a bias in the distribution of p-values, and thus we advise to use the p-values for ranking the genes only.

```
sc3_plot_de_genes(sce, k = 3)
```

![](data:image/png;base64...)

It is also possible to annotate cells (columns of the matrix containing DE genes) with any column of the `colData` slot of the `sce` object.

```
sc3_plot_de_genes(
    sce, k = 3,
    show_pdata = c(
        "cell_type1",
        "log10_total_features",
        "sc3_3_clusters",
        "sc3_3_log2_outlier_score"
    )
)
```

```
## Provided columns 'log10_total_features' do not exist in the phenoData table!
```

![](data:image/png;base64...)

## 5.6 Marker Genes

To find marker genes, for each gene a binary classifier is constructed based on the mean cluster expression values. The classifier prediction is then calculated using the gene expression ranks. The area under the receiver operating characteristic (ROC) curve is used to quantify the accuracy of the prediction. A p-value is assigned to each gene by using the Wilcoxon signed rank test. By default the genes with the area under the ROC curve (AUROC) > 0.85 and with the p-value < 0.01 are selected and the top 10 marker genes of each cluster are visualized in this heatmap.

```
sc3_plot_markers(sce, k = 3)
```

![](data:image/png;base64...)

It is also possible to annotate cells (columns of the matrix containing marker genes) with any column of the `colData` slot of the `sce` object.

```
sc3_plot_markers(
    sce, k = 3,
    show_pdata = c(
        "cell_type1",
        "log10_total_features",
        "sc3_3_clusters",
        "sc3_3_log2_outlier_score"
    )
)
```

```
## Provided columns 'log10_total_features' do not exist in the phenoData table!
```

![](data:image/png;base64...)

# 6 SC3 in Detail

The main `sc3` method explained above is a wrapper that calls several other `SC3` methods in the following order:

* `sc3_prepare`
* *(optional)* `sc3_estimate_k`
* `sc3_calc_dists`
* `sc3_calc_transfs`
* `sc3_kmeans`
* `sc3_calc_consens`
* *(optional)* `sc3_calc_biology`

Let us go through each of them independently.

## 6.1 `sc3_prepare`

We start with `sc3_prepare`. This method prepares an object of `sce` class for `SC3` clustering. This method also defines all parameters needed for clustering and stores them in the `sc3` slot. The parameters have their own defaults but can be manually changed. For more information on the parameters please use `?sc3_prepare`.

```
sce <- sc3_prepare(sce)
```

```
## Setting SC3 parameters...
```

```
str(metadata(sce)$sc3)
```

```
## List of 5
##  $ kmeans_iter_max: num 1e+09
##  $ kmeans_nstart  : num 1000
##  $ n_dim          : int [1:5] 3 4 5 6 7
##  $ rand_seed      : num 1
##  $ n_cores        : num 71
```

> By default `SC3` will use all but one cores of your machine. You can manually set the number of cores to be used by setting the `n_cores` parameter in the `sc3_prepare` call.

## 6.2 *(optional)* `sc3_estimate_k`

When the `sce` object is prepared for clustering, `SC3` can also estimate the optimal number of clusters `k` in the dataset. `SC3` utilizes the Tracy-Widom theory on random matrices to estimate `k`. `sc3_estimate_k` method creates and populates the following items of the `sc3` slot:

* `k_estimation` - contains the estimated value of `k`.

```
sce <- sc3_estimate_k(sce)
```

```
## Estimating k...
```

```
str(metadata(sce)$sc3)
```

```
## List of 6
##  $ kmeans_iter_max: num 1e+09
##  $ kmeans_nstart  : num 1000
##  $ n_dim          : int [1:5] 3 4 5 6 7
##  $ rand_seed      : num 1
##  $ n_cores        : num 71
##  $ k_estimation   : num 6
```

## 6.3 `sc3_calc_dists`

Now we are ready to perform the clustering itself. First `SC3` calculates distances between the cells. Method `sc3_calc_dists` calculates the distances, creates and populates the following items of the `sc3` slot:

* `distances` - contains a list of distance matrices corresponding to Euclidean, Pearson and Spearman distances.

```
sce <- sc3_calc_dists(sce)
```

```
## Calculating distances between the cells...
```

```
names(metadata(sce)$sc3$distances)
```

```
## [1] "euclidean" "pearson"   "spearman"
```

## 6.4 `sc3_calc_transfs`

Next the distance matrices are transformed using PCA and graph Laplacian. Method `sc3_calc_transfs` calculates transforamtions of the distance matrices contained in
the `distances` item of the `sc3` slot. It then creates and populates the following items of the `sc3` slot:

* `transformations` - contains a list of transformations of the distance matrices corresponding to PCA and graph Laplacian transformations.

```
sce <- sc3_calc_transfs(sce)
```

```
## Performing transformations and calculating eigenvectors...
```

```
names(metadata(sce)$sc3$transformations)
```

```
## [1] "euclidean_pca"       "pearson_pca"         "spearman_pca"
## [4] "euclidean_laplacian" "pearson_laplacian"   "spearman_laplacian"
```

It also removes the previously calculated `distances` item from the `sc3` slot:

```
metadata(sce)$sc3$distances
```

```
## NULL
```

## 6.5 `sc3_kmeans`

kmeans should then be performed on the transformed distance matrices contained in the `transformations` item of the `sc3` slot. Method `sc3_kmeans` creates and populates the following items of the `sc3` slot:

* `kmeans` - contains a list of kmeans clusterings.

By default the `nstart` parameter passed to `kmeans` defined in `sc3_prepare` method, is set 1000 and written to `kmeans_nstart` item of the `sc3` slot. If the number of cells in the dataset is more than 2,000, this parameter is set to 50. A user can also manually define this parameter by changing the value of the `kmeans_nstart` item of the `sc3` slot.

```
sce <- sc3_kmeans(sce, ks = 2:4)
```

```
## Performing k-means clustering...
```

```
names(metadata(sce)$sc3$kmeans)
```

```
##  [1] "euclidean_pca_2_3"       "pearson_pca_2_3"
##  [3] "spearman_pca_2_3"        "euclidean_laplacian_2_3"
##  [5] "pearson_laplacian_2_3"   "spearman_laplacian_2_3"
##  [7] "euclidean_pca_3_3"       "pearson_pca_3_3"
##  [9] "spearman_pca_3_3"        "euclidean_laplacian_3_3"
## [11] "pearson_laplacian_3_3"   "spearman_laplacian_3_3"
## [13] "euclidean_pca_4_3"       "pearson_pca_4_3"
## [15] "spearman_pca_4_3"        "euclidean_laplacian_4_3"
## [17] "pearson_laplacian_4_3"   "spearman_laplacian_4_3"
## [19] "euclidean_pca_2_4"       "pearson_pca_2_4"
## [21] "spearman_pca_2_4"        "euclidean_laplacian_2_4"
## [23] "pearson_laplacian_2_4"   "spearman_laplacian_2_4"
## [25] "euclidean_pca_3_4"       "pearson_pca_3_4"
## [27] "spearman_pca_3_4"        "euclidean_laplacian_3_4"
## [29] "pearson_laplacian_3_4"   "spearman_laplacian_3_4"
## [31] "euclidean_pca_4_4"       "pearson_pca_4_4"
## [33] "spearman_pca_4_4"        "euclidean_laplacian_4_4"
## [35] "pearson_laplacian_4_4"   "spearman_laplacian_4_4"
## [37] "euclidean_pca_2_5"       "pearson_pca_2_5"
## [39] "spearman_pca_2_5"        "euclidean_laplacian_2_5"
## [41] "pearson_laplacian_2_5"   "spearman_laplacian_2_5"
## [43] "euclidean_pca_3_5"       "pearson_pca_3_5"
## [45] "spearman_pca_3_5"        "euclidean_laplacian_3_5"
## [47] "pearson_laplacian_3_5"   "spearman_laplacian_3_5"
## [49] "euclidean_pca_4_5"       "pearson_pca_4_5"
## [51] "spearman_pca_4_5"        "euclidean_laplacian_4_5"
## [53] "pearson_laplacian_4_5"   "spearman_laplacian_4_5"
## [55] "euclidean_pca_2_6"       "pearson_pca_2_6"
## [57] "spearman_pca_2_6"        "euclidean_laplacian_2_6"
## [59] "pearson_laplacian_2_6"   "spearman_laplacian_2_6"
## [61] "euclidean_pca_3_6"       "pearson_pca_3_6"
## [63] "spearman_pca_3_6"        "euclidean_laplacian_3_6"
## [65] "pearson_laplacian_3_6"   "spearman_laplacian_3_6"
## [67] "euclidean_pca_4_6"       "pearson_pca_4_6"
## [69] "spearman_pca_4_6"        "euclidean_laplacian_4_6"
## [71] "pearson_laplacian_4_6"   "spearman_laplacian_4_6"
## [73] "euclidean_pca_2_7"       "pearson_pca_2_7"
## [75] "spearman_pca_2_7"        "euclidean_laplacian_2_7"
## [77] "pearson_laplacian_2_7"   "spearman_laplacian_2_7"
## [79] "euclidean_pca_3_7"       "pearson_pca_3_7"
## [81] "spearman_pca_3_7"        "euclidean_laplacian_3_7"
## [83] "pearson_laplacian_3_7"   "spearman_laplacian_3_7"
## [85] "euclidean_pca_4_7"       "pearson_pca_4_7"
## [87] "spearman_pca_4_7"        "euclidean_laplacian_4_7"
## [89] "pearson_laplacian_4_7"   "spearman_laplacian_4_7"
```

## 6.6 `sc3_calc_consens`

In this step `SC3` will provide you with a clustering solution. Let’s first check that there are no `SC3` related columns in the `colData` slot:

```
col_data <- colData(sce)
head(col_data[ , grep("sc3_", colnames(col_data))])
```

```
## DataFrame with 6 rows and 0 columns
```

When calculating consensus for each value of `k` `SC3` averages the clustering results of `kmeans` using a consensus approach. Method `sc3_calc_consens` calculates consensus matrices based on the clustering solutions contained in the `kmeans` item of the `sc3` slot. It then creates and populates the following items of the `sc3` slot:

* `consensus` - for each value of `k` it contains: a consensus matrix, an `hclust` object, corresponding to hierarchical clustering of the consensus matrix and the Silhouette indeces of the clusters.

```
sce <- sc3_calc_consens(sce)
```

```
## Calculating consensus matrix...
```

```
names(metadata(sce)$sc3$consensus)
```

```
## [1] "2" "3" "4"
```

```
names(metadata(sce)$sc3$consensus$`3`)
```

```
## [1] "consensus"  "hc"         "silhouette"
```

It also removes the previously calculated `kmeans` item from the `sc3` slot:

```
metadata(sce)$sc3$kmeans
```

```
## NULL
```

As mentioned before all the clustering results (cell-related information) are written to the `colData` slot of the `sce` object:

```
col_data <- colData(sce)
head(col_data[ , grep("sc3_", colnames(col_data))])
```

```
## DataFrame with 6 rows and 3 columns
##                 sc3_2_clusters sc3_3_clusters sc3_4_clusters
##                       <factor>       <factor>       <factor>
## Oocyte..1.RPKM.              2              2              2
## Oocyte..2.RPKM.              2              2              2
## Oocyte..3.RPKM.              2              2              2
## Zygote..1.RPKM.              2              2              2
## Zygote..2.RPKM.              2              2              2
## Zygote..3.RPKM.              2              2              2
```

We can see that `SC3` calculated clusters for `k = 2, 3` and `4` and wrote them to the `colData` slot of the `sce` object.

## 6.7 *(optional)* `sc3_calc_biology`

`SC3` can also calculates DE genes, marker genes and cell outliers based on the calculated consensus clusterings. Similary to the clustering solutions, method `sc3_calc_biology` writes the results for the cell outliers (cell-related information) to the `colData` slot of the `sce` object. In contrast, DE and marker genes results (gene-related information) is are written to the `rowData` slot. In addition `biology` item of the `sc3` slot is set to `TRUE`.

```
sce <- sc3_calc_biology(sce, ks = 2:4)
```

```
## Calculating biology...
```

### 6.7.1 Cell Outliers

Now we can see that cell outlier scores have been calculated for each value of `k`:

```
col_data <- colData(sce)
head(col_data[ , grep("sc3_", colnames(col_data))])
```

```
## DataFrame with 6 rows and 6 columns
##                 sc3_2_clusters sc3_3_clusters sc3_4_clusters
##                       <factor>       <factor>       <factor>
## Oocyte..1.RPKM.              2              2              2
## Oocyte..2.RPKM.              2              2              2
## Oocyte..3.RPKM.              2              2              2
## Zygote..1.RPKM.              2              2              2
## Zygote..2.RPKM.              2              2              2
## Zygote..3.RPKM.              2              2              2
##                 sc3_2_log2_outlier_score sc3_3_log2_outlier_score
##                                <numeric>                <numeric>
## Oocyte..1.RPKM.                        0                  3.34623
## Oocyte..2.RPKM.                        0                  3.37839
## Oocyte..3.RPKM.                        0                  3.16723
## Zygote..1.RPKM.                        0                  0.00000
## Zygote..2.RPKM.                        0                  0.00000
## Zygote..3.RPKM.                        0                  0.00000
##                 sc3_4_log2_outlier_score
##                                <numeric>
## Oocyte..1.RPKM.                  3.34623
## Oocyte..2.RPKM.                  3.37839
## Oocyte..3.RPKM.                  3.16723
## Zygote..1.RPKM.                  0.00000
## Zygote..2.RPKM.                  0.00000
## Zygote..3.RPKM.                  0.00000
```

For more information on how the cell outliers are calculated please see `?get_outl_cells`.

### 6.7.2 DE and marker genes

We can also see that DE and marker genes characteristics (adjusted p-values and area under the ROC curve) have been calculated for each value of `k`

```
row_data <- rowData(sce)
head(row_data[ , grep("sc3_", colnames(row_data))])
```

```
## DataFrame with 6 rows and 13 columns
##          sc3_gene_filter sc3_2_markers_clusts sc3_2_markers_padj
##                <logical>            <numeric>          <numeric>
## C9orf152           FALSE                   NA                 NA
## RPS11              FALSE                   NA                 NA
## ELMO2               TRUE                    2        3.43043e-06
## CREB3L1             TRUE                    2        1.00000e+00
## PNMA1              FALSE                   NA                 NA
## MMP2                TRUE                    1        1.00000e+00
##          sc3_2_markers_auroc sc3_3_markers_clusts sc3_3_markers_padj
##                    <numeric>            <numeric>          <numeric>
## C9orf152                  NA                   NA                 NA
## RPS11                     NA                   NA                 NA
## ELMO2               0.905833                    2        8.75271e-08
## CREB3L1             0.635833                    2        3.65118e-04
## PNMA1                     NA                   NA                 NA
## MMP2                0.549722                    1        1.00000e+00
##          sc3_3_markers_auroc sc3_4_markers_clusts sc3_4_markers_padj
##                    <numeric>            <numeric>          <numeric>
## C9orf152                  NA                   NA                 NA
## RPS11                     NA                   NA                 NA
## ELMO2               0.969697                    2        8.97773e-08
## CREB3L1             0.827020                    2        3.85412e-04
## PNMA1                     NA                   NA                 NA
## MMP2                0.549722                    3        1.00000e+00
##          sc3_4_markers_auroc sc3_2_de_padj sc3_3_de_padj sc3_4_de_padj
##                    <numeric>     <numeric>     <numeric>     <numeric>
## C9orf152                  NA            NA            NA            NA
## RPS11                     NA            NA            NA            NA
## ELMO2               0.969697   3.33801e-06   7.88682e-10   1.86624e-09
## CREB3L1             0.827020   1.00000e+00   2.03905e-03   6.16236e-03
## PNMA1                     NA            NA            NA            NA
## MMP2                0.543929   1.00000e+00   1.00000e+00   1.00000e+00
```

For more information on how the DE and marker genes are calculated please see `?get_de_genes` and `?get_marker_genes`.

# 7 Hybrid `SVM` Approach

For datasets with more than 5,000 cells `SC3` automatically utilizes a hybrid approach that combines unsupervised and supervised clusterings. Namely, `SC3` selects a subset of cells uniformly at random (5,000), and obtains clusters from this subset. The inferred labels can be used to train a Support Vector Machine (`SVM`), which is employed to assign labels to the remaining cells.

The hybrid approach can also be triggered by defining either the `svm_num_cells` parameter (the number of training cells, which is different from 5,000) or `svm_train_inds` parameter (training cells are manually selected by providing their indexes).

Let us first save the `SC3` results for `k = 3` obtained without using the hybrid approach:

```
no_svm_labels <- colData(sce)$sc3_3_clusters
```

Now let us trigger the hybrid approach by asking for 50 training cells:

```
sce <- sc3(sce, ks = 2:4, biology = TRUE, svm_num_cells = 50)
```

```
## Setting SC3 parameters...
```

```
## Defining training cells for SVM using svm_num_cells parameter...
```

```
## Calculating distances between the cells...
```

```
## Performing transformations and calculating eigenvectors...
```

```
## Performing k-means clustering...
```

```
## Calculating consensus matrix...
```

```
## Calculating biology...
```

Note that when `SVM` is used all results (including marker genes, DE genes and cell outliers) correspond to the training cells only (50 cells), and values of all other cells are set to `NA`:

```
col_data <- colData(sce)
head(col_data[ , grep("sc3_", colnames(col_data))])
```

```
## DataFrame with 6 rows and 6 columns
##                 sc3_2_clusters sc3_3_clusters sc3_4_clusters
##                       <factor>       <factor>       <factor>
## Oocyte..1.RPKM.             NA             NA             NA
## Oocyte..2.RPKM.             NA             NA             NA
## Oocyte..3.RPKM.             2              1              2
## Zygote..1.RPKM.             2              1              2
## Zygote..2.RPKM.             NA             NA             NA
## Zygote..3.RPKM.             NA             NA             NA
##                 sc3_2_log2_outlier_score sc3_3_log2_outlier_score
##                                <numeric>                <numeric>
## Oocyte..1.RPKM.                       NA                       NA
## Oocyte..2.RPKM.                       NA                       NA
## Oocyte..3.RPKM.                        0                        0
## Zygote..1.RPKM.                        0                        0
## Zygote..2.RPKM.                       NA                       NA
## Zygote..3.RPKM.                       NA                       NA
##                 sc3_4_log2_outlier_score
##                                <numeric>
## Oocyte..1.RPKM.                       NA
## Oocyte..2.RPKM.                       NA
## Oocyte..3.RPKM.                  4.97346
## Zygote..1.RPKM.                  0.00000
## Zygote..2.RPKM.                       NA
## Zygote..3.RPKM.                       NA
```

Now we can run the `SVM` and predict labels of all the other cells:

```
sce <- sc3_run_svm(sce, ks = 2:4)
col_data <- colData(sce)
head(col_data[ , grep("sc3_", colnames(col_data))])
```

```
## DataFrame with 6 rows and 6 columns
##                 sc3_2_clusters sc3_3_clusters sc3_4_clusters
##                       <factor>       <factor>       <factor>
## Oocyte..1.RPKM.              2              1              2
## Oocyte..2.RPKM.              2              1              2
## Oocyte..3.RPKM.              2              1              2
## Zygote..1.RPKM.              2              1              2
## Zygote..2.RPKM.              2              1              2
## Zygote..3.RPKM.              2              1              2
##                 sc3_2_log2_outlier_score sc3_3_log2_outlier_score
##                                <numeric>                <numeric>
## Oocyte..1.RPKM.                       NA                       NA
## Oocyte..2.RPKM.                       NA                       NA
## Oocyte..3.RPKM.                        0                        0
## Zygote..1.RPKM.                        0                        0
## Zygote..2.RPKM.                       NA                       NA
## Zygote..3.RPKM.                       NA                       NA
##                 sc3_4_log2_outlier_score
##                                <numeric>
## Oocyte..1.RPKM.                       NA
## Oocyte..2.RPKM.                       NA
## Oocyte..3.RPKM.                  4.97346
## Zygote..1.RPKM.                  0.00000
## Zygote..2.RPKM.                       NA
## Zygote..3.RPKM.                       NA
```

Note that the cell outlier scores (and also DE and marker genes values) were not updated and they still contain `NA` values for non-training cells. To recalculate biological characteristics using the labels predicted by `SVM` one need to clear the `svm_train_inds` item in the `sc3` slot and rerun the `sc3_calc_biology` method:

```
metadata(sce)$sc3$svm_train_inds <- NULL
sce <- sc3_calc_biology(sce, ks = 2:4)
```

```
## Calculating biology...
```

```
col_data <- colData(sce)
head(col_data[ , grep("sc3_", colnames(col_data))])
```

```
## DataFrame with 6 rows and 6 columns
##                 sc3_2_clusters sc3_3_clusters sc3_4_clusters
##                       <factor>       <factor>       <factor>
## Oocyte..1.RPKM.              2              1              2
## Oocyte..2.RPKM.              2              1              2
## Oocyte..3.RPKM.              2              1              2
## Zygote..1.RPKM.              2              1              2
## Zygote..2.RPKM.              2              1              2
## Zygote..3.RPKM.              2              1              2
##                 sc3_2_log2_outlier_score sc3_3_log2_outlier_score
##                                <numeric>                <numeric>
## Oocyte..1.RPKM.                        0                  3.84562
## Oocyte..2.RPKM.                        0                  4.01241
## Oocyte..3.RPKM.                        0                  3.76866
## Zygote..1.RPKM.                        0                  0.00000
## Zygote..2.RPKM.                        0                  0.00000
## Zygote..3.RPKM.                        0                  0.00000
##                 sc3_4_log2_outlier_score
##                                <numeric>
## Oocyte..1.RPKM.                  3.34623
## Oocyte..2.RPKM.                  3.37839
## Oocyte..3.RPKM.                  3.16723
## Zygote..1.RPKM.                  0.00000
## Zygote..2.RPKM.                  0.00000
## Zygote..3.RPKM.                  0.00000
```

Now the biological characteristics are calculated for all cells (including those predicted by the `SVM`)

```
svm_labels <- colData(sce)$sc3_3_clusters
```

Now we can compare the labels using the adjusted rand index (`ARI`):

```
if (require("mclust")) {
  adjustedRandIndex(no_svm_labels, svm_labels)
}
```

```
## Loading required package: mclust
```

```
## Package 'mclust' version 6.1.1
## Type 'citation("mclust")' for citing this R package in publications.
```

```
## [1] 0.8736898
```

`ARI` is less than `1`, which means that `SVM` results are different from the non-`SVM` results, however `ARI` is still pretty close to `1` meaning that the solutions are very similar.