# DESeq2

## Introduction

In this vignette we present the basic features of Glimma. Glimma is an interactive R widget for creating plots for differential expression analysis, created using the Vega and htmlwidgets frameworks. The created plots can be embedded in R Markdown, or exported as standalone HTML documents. The data presented here is slightly modified from the [RNAseq123](https://bioconductor.org/packages/release/workflows/html/RNAseq123.html) workflow with only a single contrast has been performed for simplicity. Here we use DESeq2 to fit the model.

To begin, the DGEList object from the workflow has been included with the package as internal data. We will convert this to a DESeq data object.

```
library(Glimma)
library(edgeR)
library(DESeq2)

dge <- readRDS(system.file("RNAseq123/dge.rds", package = "Glimma"))

dds <- DESeqDataSetFromMatrix(
  countData = dge$counts,
  colData = dge$samples,
  rowData = dge$genes,
  design = ~group
)
#> converting counts to integer mode
```

## MDS Plot

The multidimensional scaling (MDS) plot is frequently used to explore differences in samples. When data has been MDS transformed, the first two dimensions explain the greatest variance between samples, and the amount of variance decreases monotonically with increasing dimension.

The Glimma MDS contains two main components:

1. a plot showing two MDS dimensions, and
2. a plot of the eigenvalues of each dimension

The Glimma MDS allows different dimensions to be plotted against each other, with the proportion of variability explained by each dimension highlighted in the barplot alongside it. The interactive MDS plot can be created simply with a single argument for a DESeqDataSet object. The points in the MDS plot can have their size, colour and shape changed based on the information that is stored in the colData of the DESeqDataSet.

```
glimmaMDS(dds)
```

### Interactions with the plot

In the plot above, try:

* Scaling the points by library size (lib\_size).
* Changing the colour of points by group using the colour\_by field.
* Changing the colour scheme using to colour points using the colourscheme field.
* Altering the shape of points by sample sequencing lane using the shape\_by field.
* Changing the dimensions plotted on the x-axis (x\_axis) to dim2 and y-axis (y\_axis) to dim3.
* Saving the plots in either PNG or SVG formats using the “Save Plot” button.

### Modifications to the plot

***Adjusting plot size***

*Usage:* `glimmaMDS(dds, width=1200, height=1200)`

Users can specify the width and height of the MDS plot widget in pixels. The default width and height are 900 and 500 respectively.

***Continuous colour schemes***

*Usage:* `glimmaMDS(dds, continuous.color=TRUE)`

This argument specifies that continuous colour schemes should be used, which can be useful for colouring samples by their expression for a particular gene.

***Custom experimental groups***

*Usage:* `glimmaMDS(dds, groups=[vector or data frame])`

This allows the user to change the associated sample information such as experimental groups. This information is displayed in mouseover tooltips and can be used to adjust the plot using `scale_by`, `colour_by` and `shape_by` fields.

## MA Plot

The MA plot is a visualisation that plots the log-fold-change between experimental groups (M) against the mean expression across all the samples (A) for each gene.

The Glimma MA plot contains two main components:

1. a plot of summary statistics across all genes that have been tested, and
2. a plot of gene expression from individual samples for a given gene

The second plot shows gene expression from the last selected sample, which can be selected from the table or directly from the summary plot.

To create the MA plot we first need to run differential expression (DE) analysis for our data using the `DESeq` function.

```
dds <- DESeq(dds, quiet=TRUE)
```

The MA plot can then be created using the `dds` object that now contains fitted results and the gene counts.

```
glimmaMA(dds)
#> 15 of 16624 genes were filtered out in DESeq2 tests
```

### Interactions with the plot

In the plot above, try:

* Clicking points in the summary plot or rows in the table to plot the gene expression of the selection.
  + Clicking genes in the table after selecting individual points will remove the previous selection.
* Searching for individual genes using the search box. The search results are displayed in the table.
  + If genes are currently selected, the search box will not function.
* Setting a maximum value for the y-axis of the expression plot using the max\_y\_axis field.
  + This allows for comparison of gene expression between genes on a comparable scale.
* Saving the currently selected genes using the Save Data dropdown.
  + From here, you can also choose to save the entire table.
* Saving the summary plot or expression plot in either PNG or SVG formats, using the “Save Data” dropdown.

### Modifications to the plot

***Adjusting plot size***

*Usage:* `glimmaMA(dds, width=1200, height=1200)`

Users can specify the width and height of the MA plot widget in pixels. The default width and height are both 920px.

***Changing DE status colouring***

*Usage:* `glimmaMA(dds, status.cols=c("blue", "grey", "red")`

Users can customise the colours associated with the differential expression status of a gene using the `status.cols` argument. A vector of length three should be passed in, where each element must be a valid CSS colour string.

***Changing sample colours in expression plot***

*Usage:* `glimmaMA(dds, sample.cols=colours)`

The `sample.cols` argument colours each sample based on the character vector of valid CSS colour strings `colours`. The `colours` vector must be of length `ncol(counts)`.

***Overriding counts and groups***

*Usage:* `glimmaMA(dds, counts=counts, groups=groups)`

Glimma extracts counts from `DESeq2::counts(dds)` by default, and experimental groups from a `group` column in `colData(dds)` if it is available. However, users can optionally supply their own counts matrix and groups vector using the `counts` and `groups` arguments.

***Transforming counts values***

*Usage:* `glimmaMA(dds, transform.counts="rpkm")`

The `transform.counts` argument allows users to choose between strategies for transforming counts data displayed on the expression plot. The default argument is `"logcpm"` which log-transforms counts using `edgeR::cpm(counts, log=TRUE)`. Other options are "`rpkm"` for `edgeR::rpkm(counts)`, `cpm` for `edgeR::cpm(counts)` and `none` for no transformation.

***Changing displayed columns in gene annotation*** The gene annotations are pulled from the `DGEList` object by default. This can be overwritten by providing a different table of annotations via the `anno` argument, the substitute annotations must have the same number of rows as the counts matrix and the genes must be in the same order as in the counts.

Some annotations may contain too many columsn to be sensibly displayed. The `display.columns` argument can be used to control the columns displayed in the plot. A vector of column names are to be provided for selecting the columns that will be displayed in the interactive plot.

## Saving widgets

The plots created are automatically embedded into Rmarkdown reports, but having many interactive plots can significantly slow down the page. It is instead recommended to save the plots using `htmlwidgets::saveWidget` and linking to it via markdown hyperlinks.

```
# creates ma-plot.html in working directory
# link to it in Rmarkdown using [MA-plot](ma-plot.html)
htmlwidgets::saveWidget(glimmaMA(dds), "ma-plot.html")
```

## Session Info

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
#>  [1] DESeq2_1.50.0               SummarizedExperiment_1.40.0
#>  [3] Biobase_2.70.0              MatrixGenerics_1.22.0
#>  [5] matrixStats_1.5.0           GenomicRanges_1.62.0
#>  [7] Seqinfo_1.0.0               IRanges_2.44.0
#>  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [11] generics_0.1.4              edgeR_4.8.0
#> [13] limma_3.66.0                Glimma_2.20.0
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.10         SparseArray_1.10.0  lattice_0.22-7
#>  [4] magrittr_2.0.4      digest_0.6.37       evaluate_1.0.5
#>  [7] grid_4.5.1          RColorBrewer_1.1-3  fastmap_1.2.0
#> [10] jsonlite_2.0.0      Matrix_1.7-4        scales_1.4.0
#> [13] codetools_0.2-20    jquerylib_0.1.4     abind_1.4-8
#> [16] cli_3.6.5           rlang_1.1.6         XVector_0.50.0
#> [19] cachem_1.1.0        DelayedArray_0.36.0 yaml_2.3.10
#> [22] S4Arrays_1.10.0     tools_4.5.1         parallel_4.5.1
#> [25] BiocParallel_1.44.0 dplyr_1.1.4         ggplot2_4.0.0
#> [28] locfit_1.5-9.12     vctrs_0.6.5         R6_2.6.1
#> [31] lifecycle_1.0.4     htmlwidgets_1.6.4   pkgconfig_2.0.3
#> [34] pillar_1.11.1       bslib_0.9.0         gtable_0.3.6
#> [37] glue_1.8.0          Rcpp_1.1.0          statmod_1.5.1
#> [40] tidyselect_1.2.1    tibble_3.3.0        xfun_0.53
#> [43] knitr_1.50          dichromat_2.0-0.1   farver_2.1.2
#> [46] htmltools_0.5.8.1   rmarkdown_2.30      compiler_4.5.1
#> [49] S7_0.2.0
```