# sechm

Pierre-Luc Germain1,2

1D-HEST Institute for Neurosciences, ETH Zürich
2Laboratory of Statistical Bioinformatics, University Zürich

#### 30 October 2025

#### Abstract

Showcases the use of sechm to plot annotated heatmaps from SummarizedExperiment objects.

#### Package

sechm 1.18.0

# Contents

* [1 Getting started](#getting-started)
  + [1.1 Package installation](#package-installation)
  + [1.2 Example data](#example-data)
* [2 Example usage](#example-usage)
  + [2.1 Basic functionalities](#basic-functionalities)
  + [2.2 Row ordering](#row-ordering)
  + [2.3 Color scale](#color-scale)
  + [2.4 Annotation colors](#annotation-colors)
* [3 crossHm](#crosshm)
* [4 Other convenience functions](#other-convenience-functions)
* [Session info](#session-info)

# 1 Getting started

The *sechm* package is a wrapper around the
*[ComplexHeatmap](https://jokergoo.github.io/ComplexHeatmap-reference/book/)*
package to facilitate the creation of annotated heatmaps from objects of the
*Bioconductor* class *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*
(and extensions thereof).

## 1.1 Package installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("sechm")
```

## 1.2 Example data

To showcase the main functions, we will use an example object which contains (a
subset of) RNAseq of mouse hippocampi after Forskolin-induced long-term
potentiation:

```
suppressPackageStartupMessages({
  library(SummarizedExperiment)
  library(sechm)
})
data("Chen2017", package="sechm")
SE <- Chen2017
```

This is taken from
[Chen et al., 2017](https://doi.org/10.3389/fnmol.2017.00039).

# 2 Example usage

## 2.1 Basic functionalities

The `sechm` function simplifies the generation of heatmaps from
`SummarizedExperiment`. It minimally requires, as input, a
`SummarizedExperiment` object and a set of genes (or features, i.e. rows of
`sechm`) to plot:

```
g <- c("Egr1", "Nr4a1", "Fos", "Egr2", "Sgk1", "Arc", "Dusp1", "Fosb", "Sik1")
sechm(SE, features=g)
```

```
## Using assay 'logFC'
```

![](data:image/png;base64...)

```
# with row scaling:
sechm(SE, features=g, do.scale=TRUE)
```

```
## Using assay 'logFC'
```

![](data:image/png;base64...)

The assay can be selected, and any `rowData` or `colData` columns can be
specified as annotation:

```
rowData(SE)$meanLogCPM <- rowMeans(assays(SE)$logcpm)
sechm(SE, features=g, assayName="logFC", top_annotation=c("Condition","Time"), left_annotation=c("meanLogCPM"))
```

![](data:image/png;base64...)

Column names are ommitted by default, but can be displayed:

```
sechm(SE, features=g, do.scale=TRUE, show_colnames=TRUE)
```

```
## Using assay 'logFC'
```

![](data:image/png;base64...)

Since `sechm` uses the
*[ComplexHeatmap](https://jokergoo.github.io/ComplexHeatmap-reference/book/)*
engine for plotting, any argument of `ComplexHeatmap::Heatmap` can be passed:

```
sechm(SE, features=g, do.scale=TRUE, row_title="My genes")
```

```
## Using assay 'logFC'
```

![](data:image/png;base64...)
When plotting a lot of rows, by default row names are not shown (can be
overriden), but specific genes can be highlighted with the `mark` argument:

```
sechm(SE, features=row.names(SE), mark=g, do.scale=TRUE, top_annotation=c("Condition","Time"))
```

```
## Using assay 'logFC'
```

![](data:image/png;base64...)

We can also add gaps using the same columns:

```
sechm(SE, features=g, do.scale=TRUE, top_annotation="Time", gaps_at="Condition")
```

```
## Using assay 'logFC'
```

![](data:image/png;base64...)

## 2.2 Row ordering

By default, rows are *sorted* using the MDS angle method (can be altered with
the `sort.method` argument); this can be disabled with:

```
# reverts to clustering:
sechm(SE, features=row.names(SE), do.scale=TRUE, sortRowsOn=NULL)
```

```
## Using assay 'logFC'
```

![](data:image/png;base64...)

```
# no reordering:
sechm(SE, features=row.names(SE), do.scale=TRUE, sortRowsOn=NULL,
      cluster_rows=FALSE)
```

```
## Using assay 'logFC'
```

![](data:image/png;base64...)

It is also possible to combine sorting with clusters using the `toporder` argument, or using gaps:.

```
# we first cluster rows, and save the clusters in the rowData:
rowData(SE)$cluster <- as.character(kmeans(t(scale(t(assay(SE)))),5)$cluster)
sechm(SE, features=1:30, do.scale=TRUE, toporder="cluster",
      left_annotation="cluster", show_rownames=FALSE)
```

```
## Using assay 'logFC'
```

![](data:image/png;base64...)

```
sechm(SE, features=1:30, do.scale=TRUE, gaps_row="cluster",
      show_rownames=FALSE)
```

```
## Using assay 'logFC'
```

![](data:image/png;base64...)

## 2.3 Color scale

`sechm` tries to guess whether the data plotted are centered around zero, and
adjusts the scale accordingly (this can be disable with `breaks=FALSE`). It
also performs a quantile capping to avoid extreme values taking most of the
color scale, which is especially relevant when plotting for instance
fold-changes. This can be controlled with the `breaks` argument. Consider the
three following examples:

```
library(ComplexHeatmap)
g2 <- c(g,"Gm14288",tail(row.names(SE)))
draw(
    sechm(SE, features=g2, assayName="logFC", breaks=1, column_title="breaks=1") +
    sechm(SE, features=g2, assayName="logFC", breaks=0.995,
          column_title="breaks=0.995", name="logFC(2)") +
    sechm(SE, features=g2, assayName="logFC", breaks=0.985,
          column_title="breaks=0.985", name="logFC(3)"),
    merge_legends=TRUE)
```

![](data:image/png;base64...)

With `breaks=1`, the scale is made symmetric, but not quantile capping is
performed. In this way, most of the colorscale is taken by the difference
between one datapoint (first gene) and the rest, making it difficult to
distinguish patterns in the genes at the bottom. Instead, with `breaks=0.985`,
the color scale is linear up until the 0.985 quantile of the data, and ordinal
after this. This reduces our capacity to distinguish variations between the
extreme values, but enables us to visualize the others better.

Manual breaks can also be defined. The colors themselves can be passed as
follows:

```
# not run
sechm(SE, features=g2, hmcols=viridisLite::cividis(10))
```

## 2.4 Annotation colors

Annotation colors can be passed with the `anno_colors` argument, but the
simplest is to store them in the object’s metadata:

```
metadata(SE)$anno_colors
```

```
## $Time
##          30          60         120        <NA>
## "#90EE90FF" "#65BE61FF" "#3A9034FF" "#006400FF"
##
## $Condition
##     Control   Forskolin
## "lightgrey"   "Darkred"
```

```
metadata(SE)$anno_colors$Condition <- c(Control="white", Forskolin="black")
sechm(SE, features=g2, top_annotation="Condition")
```

```
## Using assay 'logFC'
```

![](data:image/png;base64...)

Heatmap colors can be passed on in the same way:

```
metadata(SE)$hmcols <- c("darkred","white","darkblue")
sechm(SE, g, do.scale = TRUE)
```

```
## Using assay 'logFC'
```

![](data:image/png;base64...)

The default assay to be displayed and the default annotation fields to show can
be specified in the `default_view` metadata element, as follows:

```
metadata(SE)$default_view <- list(
  assay="logFC",
  top_annotation="Condition"
)
```

Finally, it is also possible to set colors as package-wide options:

```
setSechmOption("hmcols", value=c("white","grey","black"))
sechm(SE, g, do.scale = TRUE)
```

![](data:image/png;base64...)

At the moment, the following arguments can be set as global options:
`assayName`, `hmcols`, `left_annotation`, `right_annotation`, `top_annotation`,
`bottom_annotation`, `anno_colors`, `gaps_at`, `breaks`.

To remove the predefined colors:

```
resetAllSechmOptions()
metadata(SE)$hmcols <- NULL
metadata(SE)$anno_colors <- NULL
```

In order of priority, the arguments in the function call trump the object’s
metadata, which trumps the global options.

# 3 crossHm

Because `sechm` produces a `Heatmap` object from
[ComplexHeatmap](https://jokergoo.github.io/ComplexHeatmap-reference/book/), it
is possible to combine them:

```
sechm(SE, features=g) + sechm(SE, features=g)
```

```
## Warning: Heatmap/annotation names are duplicated: logFC
```

![](data:image/png;base64...)

However, doing so involves manual work to ensure that the labels and colors are
nice and coherent, and that the rows names match. As a convenience, we provide
the `crossHm` function to handle these issues. `crossHm` works with a list of
`SummarizedExperiment` objects:

```
# we build another SE object and introduce some variation in it:
SE2 <- SE
assays(SE2)$logcpm <- jitter(assays(SE2)$logcpm, factor=1000)
crossHm(list(SE1=SE, SE2=SE2), g, do.scale = TRUE,
        top_annotation=c("Condition","Time"))
```

```
## Using assay 'logFC'
## Using assay 'logFC'
```

![](data:image/png;base64...)

Scaling is applied to the datasets separately. A unique color scale can be
enforced:

```
crossHm(list(SE1=SE, SE2=SE2), g, do.scale = TRUE,
        top_annotation=c("Condition","Time"), uniqueScale = TRUE)
```

```
## Using assay 'logFC'
## Using assay 'logFC'
```

![](data:image/png;base64...)

# 4 Other convenience functions

The package also includes a number of other convenience functions which we
briefly describe here (see the functions’ help for more information):

* `log2FC()` adds two assays to an SE object, containing per-sample
  log2-foldchanges, as well as scaledLFC (variance-scaled log2-foldchanges, but
  without centering, so that the controls stay around 0) relative to the mean
  of the (specified) controls.
* The `getDEA()` and `getDEGs()` functions can return a specific DEA or its set
  of differentially-expressed features, provided that the DEA results tables are
  each saved in a column of rowData (i.e. the whole table in one column), with a
  column name starting with `DEA.`.
* The `meltSE()` function can be used to extract a dataframe (suitable for
  ggplot) containing colData, rowData, and assay data for a given subset of
  features.

# Session info

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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] sechm_1.18.0                ComplexHeatmap_2.26.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] BiocGenerics_0.56.0         generics_0.1.4
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] circlize_0.4.16     shape_1.4.6.1       rjson_0.2.23
##  [4] xfun_0.53           bslib_0.9.0         GlobalOptions_0.1.2
##  [7] lattice_0.22-7      Cairo_1.7-0         tools_4.5.1
## [10] curl_7.0.0          parallel_4.5.1      ca_0.71.1
## [13] cluster_2.1.8.1     Matrix_1.7-4        randomcoloR_1.1.0.1
## [16] RColorBrewer_1.1-3  lifecycle_1.0.4     compiler_4.5.1
## [19] farver_2.1.2        stringr_1.5.2       tinytex_0.57
## [22] codetools_0.2-20    clue_0.3-66         seriation_1.5.8
## [25] htmltools_0.5.8.1   sass_0.4.10         yaml_2.3.10
## [28] crayon_1.5.3        jquerylib_0.1.4     DelayedArray_0.36.0
## [31] cachem_1.1.0        magick_2.9.0        iterators_1.0.14
## [34] TSP_1.2-5           abind_1.4-8         foreach_1.5.2
## [37] digest_0.6.37       Rtsne_0.17          stringi_1.8.7
## [40] bookdown_0.45       fastmap_1.2.0       colorspace_2.1-2
## [43] cli_3.6.5           SparseArray_1.10.0  magrittr_2.0.4
## [46] S4Arrays_1.10.0     dichromat_2.0-0.1   scales_1.4.0
## [49] registry_0.5-1      rmarkdown_2.30      XVector_0.50.0
## [52] png_0.1-8           GetoptLong_1.0.5    evaluate_1.0.5
## [55] knitr_1.50          V8_8.0.1            doParallel_1.0.17
## [58] rlang_1.1.6         Rcpp_1.1.0          glue_1.8.0
## [61] BiocManager_1.30.26 jsonlite_2.0.0      R6_2.6.1
```