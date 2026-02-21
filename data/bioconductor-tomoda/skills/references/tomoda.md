# tomoda for tomo-seq data analysis

Wendao Liu

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
  + [1.1 Background](#background)
  + [1.2 Dataset](#dataset)
* [2 Preprocessing](#preprocessing)
  + [2.1 Create an object](#create-an-object)
  + [2.2 Normalize and scale data](#normalize-and-scale-data)
* [3 Find zones with different transcriptional profiles](#find-zones-with-different-transcriptional-profiles)
  + [3.1 Correlation analysis](#correlation-analysis)
  + [3.2 Dimensionality reduction analysis](#dimensionality-reduction-analysis)
  + [3.3 Clustering analysis](#clustering-analysis)
* [4 Analyze peak genes](#analyze-peak-genes)
  + [4.1 Find peak genes](#find-peak-genes)
  + [4.2 Find co-regulated genes](#find-co-regulated-genes)
* [5 Plot expression traces of genes](#plot-expression-traces-of-genes)
* [6 Modify plots](#modify-plots)
* [7 Session Information](#session-information)

# 1 Introduction

## 1.1 Background

The tomo-seq technique is based on cryosectioning of tissue and performing
RNA-seq on consecutive sections. Unlike common RNA-seq which is performed on
independent samples, tomo-seq is performed on consecutive sections from one
sample. Therefore tomo-seq data contain spatial information of transcriptome,
and it is a good approach to examine gene expression change across an anatomic
region.

This vignette will demonstrate the workflow to analyze and visualize tomo-seq
data using *[tomoda](https://bioconductor.org/packages/3.22/tomoda)*. The main purpose of the package
it to find anatomic zones with similar transcriptional profiles and spatially
expressed genes in a tomo-seq sample. Several visualization functions create
easy-to-modify plots are available to help users do this.

At the beginning, we load necessary libraries.

```
library(SummarizedExperiment)
library(tomoda)
```

## 1.2 Dataset

This package contains an examplary dataset geneated from 3 day post cryinjury
heart of zebrafish, obtained from
[GSE74652](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE74652). The
dataset contains the raw read count of 16495 genes across 40 sections. Here we
load the dataset and view the first several rows of it.

```
data(zh.data)
head(zh.data)
#>                    X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17
#> ENSDARG00000000002  1  0  0  0  0  2  0  3  1   1   3   0   0   4   2   7   3
#> ENSDARG00000000018  0  0  0  0  0  2  2  4  1   6   3   2   2   6   1   3   1
#> ENSDARG00000000019  4  0  1  2  1  0  4  1  4   0   6   9   2   9   1   8   3
#> ENSDARG00000000068  1  0  0  0  0  0  2  4  2   1   3   0   1   1   1   2   0
#> ENSDARG00000000069 13  0  1  0  0  1  5  4  5   7  14   8   3   8   2   8  10
#> ENSDARG00000000086  0  0  0  0  0  0  0  0  0   0   0   1   1   2   0   1   0
#>                    X18 X19 X20 X21 X22 X23 X24 X25 X26 X27 X28 X29 X30 X31 X32
#> ENSDARG00000000002   3   2   0   7   4   1   0   0   1   3   0   0   0   0   3
#> ENSDARG00000000018   0   1   1   2   1   5   1   0   2   1   5   0   0   0   2
#> ENSDARG00000000019  11   6   2   9   4  12   1   2   6   9   1   4   4   5   7
#> ENSDARG00000000068   0   0   0   0   2   1   0   1   0   0   0   0   0   1   0
#> ENSDARG00000000069   8   5   0   3   2   6   2   4   3   0   0   1   0   1   0
#> ENSDARG00000000086   2   0   1   2   0   2   1   0   0   0   0   1   0   0   0
#>                    X33 X34 X35 X36 X37 X38 X39 X40
#> ENSDARG00000000002   3   1   5   0  12   3   2   1
#> ENSDARG00000000018   1   1   3   3   6   4   3   7
#> ENSDARG00000000019  13  10  21   0  23   3  13   9
#> ENSDARG00000000068   0   0   3   0   0   0   1   0
#> ENSDARG00000000069   2   0   5   0   7   2   5   3
#> ENSDARG00000000086   0   0   1   0   7   2   0   2
```

When using your own tomo-seq dataset, try to make your data the same structure
as the examplary read count matrix. Each row corresponds to a gene and each row
correspond to a section. The row names of the matrix are gene names.
Importantly, the columns **MUST** be ordered according to the spatial sequence
of sections.

# 2 Preprocessing

## 2.1 Create an object

Now we create an object representing from the raw read count matrix. Genes
expressed in less than 3 sections are filtered out. You can change this
threshold by changing the parameter `min.section` of function `createTomo`. The
output object is an instance of *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*. If you have
additional information about sections, save them in `colData(object)`, a data
frame used to save meta data describing sections.

```
zh <- createTomo(zh.data)
#> Normalized count matrix is saved in assay 'normalized'.
#> Scaled count matrix is saved in assay 'scaled'.
zh
#> class: SummarizedExperiment
#> dim: 12865 40
#> metadata(0):
#> assays(3): count normalized scaled
#> rownames(12865): ENSDARG00000000002 ENSDARG00000000018 ...
#>   ENSDARG00000095236 ENSDARG00000095580
#> rowData names(1): gene
#> colnames(40): X1 X2 ... X39 X40
#> colData names(1): section
```

If you have a normalized expression matrix rather than raw read count matrix, it
can also be used for input.

```
your_object <- createTomo(matrix.normalized = normalized)
# Replace 'normalized' with your normalized expression matrix.
```

If you have an existing SummarizedExperiment object, `createTomo` also accepts
it as input. Just remember that the object must contain at least one of ‘count’
assay and ‘normalized’ assay.

```
your_object <- createTomo(se)
# Replace 'se' with a SummarizedExperiment object.
```

## 2.2 Normalize and scale data

By default, raw read count matrix is normalized and scaled across sections. The
raw read count, normalized read count matrix and scaled read count matrix are
saved in ‘count’, ‘normalized’ and ‘scale’ assays of the object. These matrices
can be accessed using function `assay`.

```
head(assay(zh, 'scaled'), 2)
#>                            X1         X2         X3         X4         X5
#> ENSDARG00000000002  0.2711605 -0.7486253 -0.7486253 -0.7486253 -0.7486253
#> ENSDARG00000000018 -0.7375048 -0.7375048 -0.7375048 -0.7375048 -0.7375048
#>                          X6         X7       X8          X9        X10
#> ENSDARG00000000002 4.725422 -0.7486253 1.145541  0.13187095 0.06301435
#> ENSDARG00000000018 3.300955  0.2058376 1.125715 -0.08792157 2.85520219
#>                          X11        X12        X13       X14        X15
#> ENSDARG00000000002 0.3100379 -0.7486253 -0.7486253 0.7223615  0.2350572
#> ENSDARG00000000018 0.0435205 -0.1800035  0.6251889 0.8903187 -0.3746505
#>                           X16        X17        X18        X19        X20
#> ENSDARG00000000002  1.2367534  0.4586294  0.3047269  0.2002146 -0.7486253
#> ENSDARG00000000018 -0.1097734 -0.4406221 -0.7375048 -0.3875030 -0.1266124
#>                           X21        X22         X23        X24        X25
#> ENSDARG00000000002  1.1313419  0.9039949 -0.52762436 -0.7486253 -0.7486253
#> ENSDARG00000000018 -0.3412363 -0.4327010  0.07770893 -0.3048022 -0.7375048
#>                           X26        X27        X28        X29        X30
#> ENSDARG00000000002 -0.4885558  0.5504044 -0.7486253 -0.7486253 -0.7486253
#> ENSDARG00000000018 -0.3537738 -0.4180532  3.0631010 -0.7375048 -0.7375048
#>                           X31        X32         X33        X34         X35
#> ENSDARG00000000002 -0.7486253  0.3513916 -0.05306309 -0.3883656  0.01307173
#> ENSDARG00000000018 -0.7375048 -0.1964822 -0.56645521 -0.4717243 -0.40034109
#>                           X36        X37         X38        X39        X40
#> ENSDARG00000000002 -0.7486253  0.8666370 -0.10033582 -0.3579938 -0.4763123
#> ENSDARG00000000018  0.2580826 -0.1416776 -0.09980686 -0.3052241  0.6687815
```

During normalization, the library sizes of all sections are set to the median of
all library sizes. They can also be normalized to 1 million counts to obtain
Count Per Million (CPM) value by setting parameter `normalize.method = "cpm"`.

```
zh <- createTomo(zh.data, normalize.method = "cpm")
```

We do not normalize gene lengths as we will not perform comparision between two
genes. If the normalized read count matrix is used as input, this step is
skipped.

Then the normalized data is scaled across sections for each gene. The normalized
read counts of each gene are subjected to Z score transformation such that they
have mean as 0 and standard deviation as 1.

# 3 Find zones with different transcriptional profiles

## 3.1 Correlation analysis

A good start to analyze tomo-seq data is correlation analysis. Here we calculate
the Pearson correlation coefficients between every pair of sections across all
genes and visualize them with a heatmap. Parameter `max.cor` defines the maximum
value for the heatmap, and coefficients bigger than it are clipped to it. This
is because diagonal coefficients are 1, usually much bigger than other
coefficients, so clipping them to a smaller value will show other coefficients
more clearly.

```
corHeatmap(zh, max.cor=0.3)
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`.
#> ℹ See also `vignette("ggplot2-in-packages")` for more information.
#> ℹ The deprecated feature was likely used in the tomoda package.
#>   Please report the issue at <https://github.com/liuwd15/tomoda/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)
We would expect that adjacent sections have similar transcriptional profiles and
thus have bigger correlation coefficients. Therefore, a pair of adjacent
sections with small correlation coefficients should be noted. They may act as
borders of two zones with different transcriptional profiles. A border of
different zones is usually a border of dark blue and light blue/green/yellow on
the heatmap. For example, section X13 and X20 are two borders in this dataset
according to the heatmap.

## 3.2 Dimensionality reduction analysis

Another method to visualize the similarity of sections is to perform
dimensionality reduction. Sections are embedded in a two-dimensional space and
plotted as points. similar sections are modeled by nearby points and dissimilar
sections are modeled by distant points with high probability.

We first try PCA, a classic linear dimensionality reduction algorithm. We can
see a general trend of bottom-left to upper-right with increasing section
indexes, but it is hard to find clear borders. The embeddings of sections output
by the function are saved in the Tomo object, and you can access them with
`colData(object)`.

```
zh <- runPCA(zh)
#> PC embeddings for sections are saved in column data.
embedPlot(zh, method="PCA")
#> Warning: ggrepel: 6 unlabeled data points (too many overlaps). Consider
#> increasing max.overlaps
```

![](data:image/png;base64...)

```
head(colData(zh))
#> DataFrame with 6 rows and 3 columns
#>        section       PC1       PC2
#>    <character> <numeric> <numeric>
#> X1          X1 0.0612488 -0.282025
#> X2          X2 0.0524679 -0.274253
#> X3          X3 0.0389170 -0.403186
#> X4          X4 0.0779290 -0.323700
#> X5          X5 0.0510980 -0.407276
#> X6          X6 0.0863790 -0.304588
```

Next we move to two popular non-linear dimensionality reduction algorithm, tSNE
and UMAP. These algorithms are designed to learn the underlying manifold of data
and project similar sections together in low-dimensional spaces. Users are
welcomed to tune the parameter of these algorithm to show better results with
custom dataset.

In the examplary dataset, two clusters of sections with a large margin are shown
in both tSNE and UMAP embedding plots. According to the labels of sections, we
could identify a border at X21 ~ X22.

```
set.seed(1)
zh <- runTSNE(zh)
#> TSNE embeddings for sections are saved in column data.
embedPlot(zh, method="TSNE")
```

![](data:image/png;base64...)

```
zh <- runUMAP(zh)
#> UMAP embeddings for sections are saved in column data.
embedPlot(zh, method="UMAP")
#> Warning: ggrepel: 3 unlabeled data points (too many overlaps). Consider
#> increasing max.overlaps
```

![](data:image/png;base64...)

## 3.3 Clustering analysis

Sometimes it is hard to find borders manually with results above, so we include
some clustering algorithms to help users do this.

Hierarchical clustering is good at build a hierachy of clusters. You can easily
find similar sections from adjacent nodes in the dendrogram. However, beware
that hierarchical clustering is based on greedy algorithm, so its partitions may
not be suitable to define a few clusters.

```
hc_zh <- hierarchClust(zh)
plot(hc_zh)
```

![](data:image/png;base64...)
If certain number of clusters of sections with large margins are observed in
embedding plots, or you already decide the number of zones, using K-Means for
clustering is a good choice. Input your expected number of clusters as parameter
`centers`, sections will be divided into clusters. The cluster labels output by
K-Means are saved in `colData(object)`. When plotting the embeddings of
sections, you can use K-Means cluster labels for the colors of sections.

```
zh <- kmeansClust(zh, centers=3)
#> K-Means clustering labels are saved in colData.
#> between_SS / total_SS =0.83750797944353
head(colData(zh))
#> DataFrame with 6 rows and 8 columns
#>        section       PC1       PC2     TSNE1     TSNE2     UMAP1     UMAP2
#>    <character> <numeric> <numeric> <numeric> <numeric> <numeric> <numeric>
#> X1          X1 0.0612488 -0.282025  -23.8959 -14.03177 -0.465414   5.25085
#> X2          X2 0.0524679 -0.274253  -23.6355 -11.93827 -0.312061   5.37060
#> X3          X3 0.0389170 -0.403186  -26.0703 -11.59223 -0.426064   5.82332
#> X4          X4 0.0779290 -0.323700  -21.4526 -14.10532 -0.721597   5.45968
#> X5          X5 0.0510980 -0.407276  -24.2006  -9.20225 -0.118228   5.53168
#> X6          X6 0.0863790 -0.304588  -18.0309 -14.39055 -1.072831   4.98961
#>    kmeans_cluster
#>         <integer>
#> X1              2
#> X2              2
#> X3              2
#> X4              2
#> X5              2
#> X6              2
embedPlot(zh, group='kmeans_cluster')
```

![](data:image/png;base64...)

# 4 Analyze peak genes

## 4.1 Find peak genes

As tomo-seq data contains spatial information, it is important to find spatially
expressed genes. These spatially expressed genes may have biological
implications in certain zones. We call spatially upregulated genes
**“peak genes”** and a function is used to find these genes. Here are two
parameters to judge whether a gene is a peak gene: `threshold` and `length`.
Genes with scaled read counts bigger than `threshold` in minimum `length`
consecutive sections are recognized as peak genes.

The output of this function is a data frame containing the *names*,
*start section indexes*, *end section indexes*, *center section indexes*,
*p values* and *adjusted p values* of peak genes. P values are calculated by
approximate permutation tests. Change the parameter `nperm` to change the number
of random permutations.

```
peak_genes <- findPeakGene(zh, threshold = 1, length = 4, nperm = 1e5)
#> 376peak genes (spatially upregulated genes) are found!
head(peak_genes)
#>                                  gene start end center       p       p.adj
#> ENSDARG00000002131 ENSDARG00000002131     1   4      2 0.01258 0.017454170
#> ENSDARG00000003061 ENSDARG00000003061     1   4      2 0.00188 0.008125057
#> ENSDARG00000003216 ENSDARG00000003216     1   4      2 0.02550 0.027710983
#> ENSDARG00000003570 ENSDARG00000003570     1   4      2 0.00599 0.013817423
#> ENSDARG00000007385 ENSDARG00000007385     1   4      2 0.00188 0.008125057
#> ENSDARG00000008867 ENSDARG00000008867     1   4      2 0.02550 0.027710983
```

After finding peak genes, we can visualize their expression across sections with
a heatmap. Parameter `size` controls the size of gene names. When there are too
many genes and showing overlapping names make the plot untidy, we set it to 0.

```
expHeatmap(zh, peak_genes$gene, size=0)
```

![](data:image/png;base64...)

## 4.2 Find co-regulated genes

After finding peak genes and taking a look of the output data frame, you may
notice that many genes have similar expression pattern. For example, the first
47 peak genes in this dataset all have peak expression at section 1~4. It is
intuitive to think that these genes are co-regulated by certain transcription
factors and involve in related pathways.

Like what we do for sections, we calculate the Pearson correlation coefficients
between every pair of genes across sections and visualize them with a heatmap.
Parameter `size` controls the size of gene names, which is same as that in
`expHeatmap`.

Notice that `geneCorHeatmap` takes a data frame describing genes as input. You
can use the output from `findPeakGenes` as input for this function. Variables in
the data frame can be used to plot a side bar above the heatmap. For example,
with default settings, the side bar describe peak centers of genes. Other
variables like `start` can also be used to group genes.

```
geneCorHeatmap(zh, peak_genes, size=0)
```

![](data:image/png;base64...)

```
# Use variable 'start' to group genes
geneCorHeatmap(zh, peak_genes, group='start', size=0)
```

![](data:image/png;base64...)

Similarly, we also visualize the two-dimensional embeddings of genes to find
clusters of genes with similar expression pattern.

```
zh <- runTSNE(zh, peak_genes$gene)
#> TSNE embeddings for genes are saved in row data.
geneEmbedPlot(zh, peak_genes)
```

![](data:image/png;base64...)

```
zh <- runUMAP(zh, peak_genes$gene)
#> UMAP embeddings for genes are saved in row data.
geneEmbedPlot(zh, peak_genes, method="UMAP")
```

![](data:image/png;base64...)

Users can then explore these co-regulated genes to address biological questions.

# 5 Plot expression traces of genes

You may get interested in some genes from analysis above, or you have already
identified some potential spatially expressed genes from external information.
Now you want to view how their expression change across sections. It is a good
idea to show the expression of these genes as line plots, which are called
**expression traces** of genes.

```
linePlot(zh, peak_genes$gene[1:3])
#> `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

By default, LOESS is used to smooth the lines. You can suppress smoothing by
adding parameter `span=0`.

```
linePlot(zh, peak_genes$gene[1:3], span=0)
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the tomoda package.
#>   Please report the issue at <https://github.com/liuwd15/tomoda/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

Sometimes it is good to show multiple genes in the same plot so we can directly
compare their expression traces. However, the expression levels of some genes
may have such a big difference that the expression traces of lowly expressed
genes are close to x-axis. In this situation, we suggest using facets. Different
gene are shown in different facets so they have different scales.

```
linePlot(zh, peak_genes$gene[1:3], facet=TRUE)
#> `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

# 6 Modify plots

All plots created in this package are ggplots. Therefore, you can easily modify
components in plots using the grammar and functions of *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)*,
such as colors, labels, themes and so on.

For example, if you do not like the default colors in `ExpHeatmap`, change them
using `scale_fill_gradient2` or `scale_fill_gradientn` with your preferred
colors.

```
library(ggplot2)
exp_heat <- expHeatmap(zh, peak_genes$gene, size=0)
exp_heat + scale_fill_gradient2(low='magenta', mid='black', high='yellow')
#> Scale for fill is already present.
#> Adding another scale for fill, which will replace the existing scale.
```

![](data:image/png;base64...)
If you prefer plots without grids, try other ggplot themes or change parameters
in `theme`.
If you do not want to show names of all sections but just some of them, change
parameters in `scale_x_discrete`.

```
line <- linePlot(zh, peak_genes$gene[1:3])
line +
  theme_classic() +
  scale_x_discrete(breaks=paste('X', seq(5,40,5), sep=''), labels=seq(5,40,5))
#> `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

# 7 Session Information

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
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
#>  [1] ggplot2_4.0.0               tomoda_1.20.0
#>  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [7] IRanges_2.44.0              S4Vectors_0.48.0
#>  [9] BiocGenerics_0.56.0         generics_0.1.4
#> [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [13] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
#>  [4] ggrepel_0.9.6       lattice_0.22-7      vctrs_0.6.5
#>  [7] tools_4.5.1         tibble_3.3.0        pkgconfig_2.0.3
#> [10] Matrix_1.7-4        RColorBrewer_1.1-3  S7_0.2.0
#> [13] lifecycle_1.0.4     compiler_4.5.1      farver_2.1.2
#> [16] stringr_1.5.2       tinytex_0.57        htmltools_0.5.8.1
#> [19] sass_0.4.10         yaml_2.3.10         pillar_1.11.1
#> [22] crayon_1.5.3        jquerylib_0.1.4     openssl_2.3.4
#> [25] DelayedArray_0.36.0 cachem_1.1.0        magick_2.9.0
#> [28] abind_1.4-8         nlme_3.1-168        RSpectra_0.16-2
#> [31] tidyselect_1.2.1    digest_0.6.37       Rtsne_0.17
#> [34] stringi_1.8.7       dplyr_1.1.4         reshape2_1.4.4
#> [37] bookdown_0.45       splines_4.5.1       labeling_0.4.3
#> [40] fastmap_1.2.0       grid_4.5.1          cli_3.6.5
#> [43] SparseArray_1.10.0  magrittr_2.0.4      S4Arrays_1.10.0
#> [46] dichromat_2.0-0.1   withr_3.0.2         scales_1.4.0
#> [49] rmarkdown_2.30      XVector_0.50.0      umap_0.2.10.0
#> [52] reticulate_1.44.0   askpass_1.2.1       png_0.1-8
#> [55] evaluate_1.0.5      knitr_1.50          mgcv_1.9-3
#> [58] rlang_1.1.6         Rcpp_1.1.0          glue_1.8.0
#> [61] BiocManager_1.30.26 jsonlite_2.0.0      R6_2.6.1
#> [64] plyr_1.8.9
```