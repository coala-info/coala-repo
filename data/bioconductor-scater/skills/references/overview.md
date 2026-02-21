# Single-cell analysis toolkit for expression in R

Davis McCarthy1 and Aaron Lun\*

1EMBL European Bioinformatics Institute

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: February 4, 2020

#### Package

scater 1.38.0

# 1 Introduction

*[scater](https://bioconductor.org/packages/3.22/scater)* provides tools for visualization of single-cell transcriptomic data.
It is based on the `SingleCellExperiment` class (from the *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* package),
and thus is interoperable with many other Bioconductor packages such as *[scran](https://bioconductor.org/packages/3.22/scran)*,
*[scuttle](https://bioconductor.org/packages/3.22/scuttle)* and *[iSEE](https://bioconductor.org/packages/3.22/iSEE)*.
To demonstrate the use of the various *[scater](https://bioconductor.org/packages/3.22/scater)* functions,
we will load in the classic Zeisel dataset:

```
library(scRNAseq)
example_sce <- ZeiselBrainData()
example_sce
```

```
## class: SingleCellExperiment
## dim: 20006 3005
## metadata(0):
## assays(1): counts
## rownames(20006): Tspan12 Tshz1 ... mt-Rnr1 mt-Nd4l
## rowData names(1): featureType
## colnames(3005): 1772071015_C02 1772071017_G12 ... 1772066098_A12
##   1772058148_F03
## colData names(9): tissue group # ... level1class level2class
## reducedDimNames(0):
## mainExpName: gene
## altExpNames(2): repeat ERCC
```

**Note:** A more comprehensive description of the use of *[scater](https://bioconductor.org/packages/3.22/scater)*
(along with other packages) in a scRNA-seq analysis workflow is available at <https://osca.bioconductor.org>.

# 2 Diagnostic plots for quality control

Quality control to remove damaged cells and poorly sequenced libraries is a common step in single-cell analysis pipelines.
We will use some utilities from the *[scuttle](https://bioconductor.org/packages/3.22/scuttle)* package
(conveniently loaded for us when we load *[scater](https://bioconductor.org/packages/3.22/scater)*)
to compute the usual quality control metrics for this dataset.

```
library(scater)
example_sce <- addPerCellQC(example_sce,
    subsets=list(Mito=grep("mt-", rownames(example_sce))))
```

Metadata variables can be plotted against each other using the `plotColData()` function, as shown below.
We expect to see an increasing number of detected genes with increasing total count.
Each point represents a cell that is coloured according to its tissue of origin.

```
plotColData(example_sce, x = "sum", y="detected", colour_by="tissue")
```

![](data:image/png;base64...)

Here, we have plotted the total count for each cell against the mitochondrial content.
Well-behaved cells should have a large number of expressed features and and a low percentage of expression from feature controls.
High percentage expression from feature controls and few expressed features are indicative of blank and failed cells.
For some variety, we have faceted by the tissue of origin.

```
plotColData(example_sce, x = "sum", y="subsets_Mito_percent",
    other_fields="tissue") + facet_wrap(~tissue)
```

![](data:image/png;base64...)

On the gene level, we can look at a plot that shows the top 50 (by default) most-expressed features.
Each row in the plot below corresponds to a gene; each bar corresponds to the expression of a gene in a single cell;
and the circle indicates the median expression of each gene, with which genes are sorted.
We expect to see the “usual suspects”, i.e., mitochondrial genes, actin, ribosomal protein, MALAT1.
A few spike-in transcripts may also be present here, though if all of the spike-ins are in the top 50, it suggests that too much spike-in RNA was added.
A large number of pseudo-genes or predicted genes may indicate problems with alignment.

```
plotHighestExprs(example_sce, exprs_values = "counts")
```

![](data:image/png;base64...)

Variable-level metrics are computed by the `getVarianceExplained()` function (after normalization, see below).
This calculates the percentage of variance of each gene’s expression that is explained by each variable in the `colData` of the `SingleCellExperiment` object.
We can then use this to determine which experimental factors are contributing most to the variance in expression.
This is useful for diagnosing batch effects or to quickly verify that a treatment has an effect.

```
# Computing variance explained on the log-counts,
# so that the statistics reflect changes in relative expression.
example_sce <- logNormCounts(example_sce)

vars <- getVarianceExplained(example_sce,
    variables=c("tissue", "total mRNA mol", "sex", "age"))
head(vars)
```

```
##              tissue total mRNA mol         sex        age
## Tspan12  0.02207262    0.003532711 0.146344996 0.11264880
## Tshz1    3.36083014    0.003641463 0.001079356 0.32263515
## Fnbp1l   0.43597185    2.617958068 0.003071630 0.46387469
## Adamts15 0.54233888    0.004958976 0.030821621 0.02045916
## Cldn12   0.03506751    1.389789185 0.008341408 0.02098451
## Rxfp1    0.18559637    0.839362667 0.055646799 0.02012965
```

```
plotExplanatoryVariables(vars)
```

![](data:image/png;base64...)

# 3 Visualizing expression values

The `plotExpression()` function makes it easy to plot expression values for a subset of genes or features.
This can be particularly useful for further examination of features identified from differential expression testing, pseudotime analysis or other analyses.
By default, it uses expression values in the `"logcounts"` assay, but this can be changed through the `exprs_values` argument.

```
plotExpression(example_sce, rownames(example_sce)[1:6], x = "level1class")
```

![](data:image/png;base64...)

Setting `x` will determine the covariate to be shown on the x-axis.
This can be a field in the column metadata or the name of a feature (to obtain the expression profile across cells).
Categorical covariates will yield grouped violins as shown above, with one panel per feature.
By comparison, continuous covariates will generate a scatter plot in each panel, as shown below.

```
plotExpression(example_sce, rownames(example_sce)[1:6],
    x = rownames(example_sce)[10])
```

![](data:image/png;base64...)

The points can also be coloured, shaped or resized by the column metadata or expression values.

```
plotExpression(example_sce, rownames(example_sce)[1:6],
    x = "level1class", colour_by="tissue")
```

![](data:image/png;base64...)

Directly plotting the gene expression without any `x` or other visual parameters will generate a set of grouped violin plots, coloured in an aesthetically pleasing manner.

```
plotExpression(example_sce, rownames(example_sce)[1:6])
```

![](data:image/png;base64...)

# 4 Dimensionality reduction

## 4.1 Principal components analysis

Principal components analysis (PCA) is often performed to denoise and compact the data prior to downstream analyses.
The `runPCA()` function provides a simple wrapper around the base machinery in *[BiocSingular](https://bioconductor.org/packages/3.22/BiocSingular)* for computing PCs from log-transformed expression values.
This stores the output in the `reducedDims` slot of the `SingleCellExperiment`, which can be easily retrieved (along with the percentage of variance explained by each PC) as shown below:

```
example_sce <- runPCA(example_sce)
str(reducedDim(example_sce, "PCA"))
```

```
##  num [1:3005, 1:50] -15.4 -15 -17.2 -16.9 -18.4 ...
##  - attr(*, "dimnames")=List of 2
##   ..$ : chr [1:3005] "1772071015_C02" "1772071017_G12" "1772071017_A05" "1772071014_B06" ...
##   ..$ : chr [1:50] "PC1" "PC2" "PC3" "PC4" ...
##  - attr(*, "varExplained")= num [1:50] 478 112.8 51.1 47 33.2 ...
##  - attr(*, "percentVar")= num [1:50] 39.72 9.38 4.25 3.9 2.76 ...
##  - attr(*, "rotation")= num [1:500, 1:50] 0.1471 0.1146 0.1084 0.0958 0.0953 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : chr [1:500] "Plp1" "Trf" "Mal" "Apod" ...
##   .. ..$ : chr [1:50] "PC1" "PC2" "PC3" "PC4" ...
```

By default, `runPCA()` uses the top 500 genes with the highest variances to compute the first PCs.
This can be tuned by specifying `subset_row` to pass in an explicit set of genes of interest,
and by using `ncomponents` to determine the number of components to compute.
The `name` argument can also be used to change the name of the result in the `reducedDims` slot.

```
example_sce <- runPCA(example_sce, name="PCA2",
    subset_row=rownames(example_sce)[1:1000],
    ncomponents=25)
str(reducedDim(example_sce, "PCA2"))
```

```
##  num [1:3005, 1:25] -20 -21 -23 -23.7 -21.5 ...
##  - attr(*, "dimnames")=List of 2
##   ..$ : chr [1:3005] "1772071015_C02" "1772071017_G12" "1772071017_A05" "1772071014_B06" ...
##   ..$ : chr [1:25] "PC1" "PC2" "PC3" "PC4" ...
##  - attr(*, "varExplained")= num [1:25] 153 35 23.5 11.6 10.8 ...
##  - attr(*, "percentVar")= num [1:25] 22.3 5.11 3.42 1.69 1.58 ...
##  - attr(*, "rotation")= num [1:1000, 1:25] -2.24e-04 -8.52e-05 -2.43e-02 -5.92e-04 -6.35e-03 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : chr [1:1000] "Tspan12" "Tshz1" "Fnbp1l" "Adamts15" ...
##   .. ..$ : chr [1:25] "PC1" "PC2" "PC3" "PC4" ...
```

## 4.2 Other dimensionality reduction methods

\(t\)-distributed stochastic neighbour embedding (\(t\)-SNE) is widely used for visualizing complex single-cell data sets.
The same procedure described for PCA plots can be applied to generate \(t\)-SNE plots using `plotTSNE`, with coordinates obtained using `runTSNE` via the *[Rtsne](https://CRAN.R-project.org/package%3DRtsne)* package.
We strongly recommend generating plots with different random seeds and perplexity values, to ensure that any conclusions are robus
t to different visualizations.

```
# Perplexity of 10 just chosen here arbitrarily.
set.seed(1000)
example_sce <- runTSNE(example_sce, perplexity=10)
head(reducedDim(example_sce, "TSNE"))
```

```
##                    TSNE1      TSNE2
## 1772071015_C02 -52.20650 -11.388339
## 1772071017_G12 -55.13973 -10.384870
## 1772071017_A05 -51.84183 -11.289268
## 1772071014_B06 -54.70043 -10.173423
## 1772067065_H06 -54.25904  -9.833723
## 1772071017_E02 -55.25140  -9.888935
```

A more common pattern involves using the pre-existing PCA results as input into the \(t\)-SNE algorithm.
This is useful as it improves speed by using a low-rank approximation of the expression matrix; and reduces random noise, by focusing on the major factors of variation.
The code below uses the first 10 dimensions of the previously computed PCA result to perform the \(t\)-SNE.

```
set.seed(1000)
example_sce <- runTSNE(example_sce, perplexity=50,
    dimred="PCA", n_dimred=10)
head(reducedDim(example_sce, "TSNE"))
```

```
##                    TSNE1      TSNE2
## 1772071015_C02 -37.71619  0.7430715
## 1772071017_G12 -35.59298 -0.1037881
## 1772071017_A05 -38.11153  1.1938125
## 1772071014_B06 -38.16173 -0.4875209
## 1772067065_H06 -40.50246 -1.1206144
## 1772071017_E02 -38.40188  2.3384489
```

The same can be done for uniform manifold with approximate projection (UMAP) via the `runUMAP()` function, itself based on the *[uwot](https://CRAN.R-project.org/package%3Duwot)* package.

```
example_sce <- runUMAP(example_sce)
head(reducedDim(example_sce, "UMAP"))
```

```
##                   UMAP1     UMAP2
## 1772071015_C02 13.39035 -3.603727
## 1772071017_G12 13.43977 -3.512446
## 1772071017_A05 13.36352 -3.616711
## 1772071014_B06 13.39616 -3.558855
## 1772067065_H06 13.44166 -3.505640
## 1772071017_E02 13.43508 -3.514699
```

## 4.3 Visualizing reduced dimensions

Any dimensionality reduction result can be plotted using the `plotReducedDim` function.
Here, each point represents a cell and is coloured according to its cell type label.

```
plotReducedDim(example_sce, dimred = "PCA", colour_by = "level1class")
```

![](data:image/png;base64...)

Some result types have dedicated wrappers for convenience, e.g., `plotTSNE()` for \(t\)-SNE results:

```
plotTSNE(example_sce, colour_by = "Snap25")
```

![](data:image/png;base64...)

The dedicated `plotPCA()` function also adds the percentage of variance explained to the axes:

```
plotPCA(example_sce, colour_by="Mog")
```

![](data:image/png;base64...)

Multiple components can be plotted in a series of pairwise plots.
When more than two components are plotted, the diagonal boxes in the scatter plot matrix show the density for each component.

```
example_sce <- runPCA(example_sce, ncomponents=20)
plotPCA(example_sce, ncomponents = 4, colour_by = "level1class")
```

![](data:image/png;base64...)

We separate the execution of these functions from the plotting to enable the same coordinates to be re-used across multiple plots.
This avoids repeatedly recomputing those coordinates just to change an aesthetic across plots.

# 5 Utilities for custom visualization

We provide some helper functions to easily convert from a `SingleCellExperiment` object to a `data.frame` for use in, say, *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* functions.
This allows users to create highly customized plots that are not covered by the existing *[scater](https://bioconductor.org/packages/3.22/scater)* functions.
The `ggcells()` function will intelligently retrieve fields from the `colData()`, `assays()`, `altExps()` or `reducedDims()` to create a single `data.frame` for immediate use.
In the example below, we create boxplots of *Snap25* expression stratified by cell type and tissue of origin:

```
ggcells(example_sce, mapping=aes(x=level1class, y=Snap25)) +
    geom_boxplot() +
    facet_wrap(~tissue)
```

![](data:image/png;base64...)

Reduced dimension results are easily pulled in to create customized equivalents of the `plotReducedDim()` output.
In this example, we create a \(t\)-SNE plot faceted by tissue and coloured by *Snap25* expression:

```
ggcells(example_sce, mapping=aes(x=TSNE.1, y=TSNE.2, colour=Snap25)) +
    geom_point() +
    stat_density_2d() +
    facet_wrap(~tissue) +
    scale_colour_distiller(direction=1)
```

![](data:image/png;base64...)

It is also straightforward to examine the relationship between the size factors on the normalized gene expression:

```
ggcells(example_sce, mapping=aes(x=sizeFactor, y=Actb)) +
    geom_point() +
    geom_smooth()
```

![](data:image/png;base64...)

Similar operations can be performed on the features using the `ggfeatures()` function,
which will retrieve values either from `rowData` or from the columns of the `assays`.
Here, we examine the relationship between the feature type and the expression within a given cell;
note the renaming of the otherwise syntactically invalid cell name.

```
colnames(example_sce) <- make.names(colnames(example_sce))
ggfeatures(example_sce, mapping=aes(x=featureType, y=X1772062111_E06)) +
    geom_violin()
```

![](data:image/png;base64...)

# Session information

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] scater_1.38.0               ggplot2_4.0.0
##  [3] scuttle_1.20.0              scRNAseq_2.23.1
##  [5] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [13] generics_0.1.4              MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3       jsonlite_2.0.0           magrittr_2.0.4
##   [4] magick_2.9.0             ggbeeswarm_0.7.2         GenomicFeatures_1.62.0
##   [7] gypsum_1.6.0             farver_2.1.2             rmarkdown_2.30
##  [10] BiocIO_1.20.0            vctrs_0.6.5              memoise_2.0.1
##  [13] Rsamtools_2.26.0         RCurl_1.98-1.17          tinytex_0.57
##  [16] htmltools_0.5.8.1        S4Arrays_1.10.0          AnnotationHub_4.0.0
##  [19] curl_7.0.0               BiocNeighbors_2.4.0      Rhdf5lib_1.32.0
##  [22] SparseArray_1.10.0       rhdf5_2.54.0             sass_0.4.10
##  [25] alabaster.base_1.10.0    bslib_0.9.0              alabaster.sce_1.10.0
##  [28] httr2_1.2.1              cachem_1.1.0             GenomicAlignments_1.46.0
##  [31] lifecycle_1.0.4          pkgconfig_2.0.3          rsvd_1.0.5
##  [34] Matrix_1.7-4             R6_2.6.1                 fastmap_1.2.0
##  [37] digest_0.6.37            AnnotationDbi_1.72.0     irlba_2.3.5.1
##  [40] ExperimentHub_3.0.0      RSQLite_2.4.3            beachmat_2.26.0
##  [43] labeling_0.4.3           filelock_1.0.3           mgcv_1.9-3
##  [46] httr_1.4.7               abind_1.4-8              compiler_4.5.1
##  [49] bit64_4.6.0-1            withr_3.0.2              S7_0.2.0
##  [52] BiocParallel_1.44.0      viridis_0.6.5            DBI_1.2.3
##  [55] HDF5Array_1.38.0         alabaster.ranges_1.10.0  alabaster.schemas_1.10.0
##  [58] MASS_7.3-65              rappdirs_0.3.3           DelayedArray_0.36.0
##  [61] rjson_0.2.23             tools_4.5.1              vipor_0.4.7
##  [64] beeswarm_0.4.0           glue_1.8.0               h5mread_1.2.0
##  [67] restfulr_0.0.16          nlme_3.1-168             rhdf5filters_1.22.0
##  [70] grid_4.5.1               Rtsne_0.17               isoband_0.2.7
##  [73] gtable_0.3.6             ensembldb_2.34.0         BiocSingular_1.26.0
##  [76] ScaledMatrix_1.18.0      XVector_0.50.0           ggrepel_0.9.6
##  [79] BiocVersion_3.22.0       pillar_1.11.1            splines_4.5.1
##  [82] dplyr_1.1.4              BiocFileCache_3.0.0      lattice_0.22-7
##  [85] FNN_1.1.4.1              rtracklayer_1.70.0       bit_4.6.0
##  [88] tidyselect_1.2.1         Biostrings_2.78.0        knitr_1.50
##  [91] gridExtra_2.3            bookdown_0.45            ProtGenerics_1.42.0
##  [94] xfun_0.53                UCSC.utils_1.6.0         lazyeval_0.2.2
##  [97] yaml_2.3.10              evaluate_1.0.5           codetools_0.2-20
## [100] cigarillo_1.0.0          tibble_3.3.0             alabaster.matrix_1.10.0
## [103] BiocManager_1.30.26      cli_3.6.5                uwot_0.2.3
## [106] jquerylib_0.1.4          dichromat_2.0-0.1        Rcpp_1.1.0
## [109] GenomeInfoDb_1.46.0      dbplyr_2.5.1             png_0.1-8
## [112] XML_3.99-0.19            parallel_4.5.1           blob_1.2.4
## [115] AnnotationFilter_1.34.0  sparseMatrixStats_1.22.0 bitops_1.0-9
## [118] alabaster.se_1.10.0      viridisLite_0.4.2        scales_1.4.0
## [121] crayon_1.5.3             rlang_1.1.6              cowplot_1.2.0
## [124] KEGGREST_1.50.0
```