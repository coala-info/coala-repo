# Introduction using limma or edgeR

## Introduction

In this vignette we present the basic features of Glimma. Glimma is an interactive R widget for creating plots for differential expression analysis, created using the Vega and htmlwidgets frameworks. The created plots can be embedded in R Markdown, or exported as standalone HTML documents. The data presented here is slightly modified from the [RNAseq123](https://bioconductor.org/packages/release/workflows/html/RNAseq123.html) workflow and only a single contrast has been performed for simplicity. We can use either limma or edgeR to fit the models and they both share upstream steps in common.

To begin, the DGEList object from the workflow has been included with the package as internal data.

```
library(Glimma)
library(limma)
library(edgeR)

dge <- readRDS(system.file("RNAseq123/dge.rds", package = "Glimma"))
```

## MDS Plot

The multidimensional scaling (MDS) plot is frequently used to explore differences in samples. When data has been MDS transformed, the first two dimensions explain the greatest variance between samples, and the amount of variance decreases monotonically with increasing dimension.

The Glimma MDS plot contains two main components:

1. a plot showing two MDS dimensions, and
2. a plot of the eigenvalues of each dimension

The Glimma MDS allows different dimensions to be plotted against each other, and for the colours of the points to be changed based on predefined factors. The grouping variables are taken from the `samples` component of `DGEList` objects used in `limma` and `edgeR`.

```
glimmaMDS(dge)
```

### Interactions with the plot

In the plot above, try:

* Scaling the points by library size (lib\_size) using the `scale_by` field.
* Changing the colour of points by group using the `colour_by` field.
* Altering the shape of points by sample sequencing lane using the `shape_by` field.
* Changing to a different colour scheme using the `colourscheme` field.
* Changing the dimensions plotted on the x-axis to dim2 and y-axis to dim3 using the `x_axis` and `y_axis` fields.
* Saving the plots in either PNG or SVG formats using the “Save Plot” button.

### Modifications to the plot

***Adjusting plot size***

*Usage:* `glimmaMDS(dge, width=1200, height=1200)`

Users can specify the width and height of the MDS plot widget in pixels. The default width and height are 900 and 500 respectively.

***Continuous colour schemes***

*Usage:* `glimmaMDS(dge, continuous.color=TRUE)`

This argument specifies that continuous colour schemes should be used, which can be useful for colouring samples by their expression for a particular gene.

***Custom experimental groups***

*Usage:* `glimmaMDS(dge, groups=[vector or data frame])`

This allows the user to change the associated sample information such as experimental groups. This information is displayed in mouseover tooltips and can be used to adjust the plot using `scale_by`, `colour_by` and `shape_by` fields.

## MA Plot

The MA plot is a visualisation that plots the log-fold-change between experimental groups (M) against the average expression across all the samples (A) for each gene.

The Glimma MA plot contains two main components:

1. a plot of summary statistics across all genes that have been tested, and
2. a plot of gene expression from individual samples for a given gene

The second plot shows gene expression from the last selected sample, which can be selected from the table or directly from the summary plot.

To create this plot we need to run differential expression (DE) analysis for our data using either the `limma` package or the `edgeR` package (both are shown below). First, we load in design and contrast matrices generated from the RNAseq123 workflow.

```
design <- readRDS(
  system.file("RNAseq123/design.rds", package = "Glimma"))
contr.matrix <- readRDS(
  system.file("RNAseq123/contr.matrix.rds", package = "Glimma"))
```

### Using limma

We fit our DE analysis using `limma` to give us an object that contains test statistics for each gene.

```
v <- voom(dge, design)
vfit <- lmFit(v, design)
vfit <- contrasts.fit(vfit, contrasts = contr.matrix)
efit <- eBayes(vfit)
```

### Using edgeR

Alternatively, we can fit our DE analysis using `edgeR`.

```
dge <- estimateDisp(dge, design)
gfit <- glmFit(dge, design)
glrt <- glmLRT(gfit, design, contrast = contr.matrix)
```

The MA plot can then be created using the fitted object containing the statistics about the genes (either `efit` or `glrt`), and the `dge` object containing raw counts and information about the samples. We use results from `limma` in the following example:

```
glimmaMA(efit, dge = dge) # glimmaMA(glrt, dge = dge) to use edgeR results
```

### Interactions with the plot

In the plot above, try:

* Clicking points in the summary plot to plot the gene expression of the last selected gene.
  + The selected genes will be listed in the bar below the plots, as well as in the table.
  + Select “Clear” button to clear all selected genes.
* Clicking rows in the table to plot the gene expression of the last selected gene.
  + Clicking a row in the table after it has been selected will it from the list of selected genes.
  + Select “Clear” button to clear all selected genes.
* Using the “Search” bar to reduce the number of genes shown in the table, e.g. search for “Tnf” or “Ifn”.
  + If genes are currently selected, the search box will not function.
* Setting a maximum value for the y-axis of the expression plot using the `max_y_axis` field.
  + This allows for comparison of gene expression between genes on a comparable scale.
* Saving the all selected genes using the “Save Data” dropdown button.
  + From here, you can also choose to save the entire table.
* Saving the summary plot or expression plot in either PNG or SVG formats, using the “Save Data” dropdown button.

### Modifications to the plot

***Adjusting plot size***

*Usage:* `glimmaMA(efit, dge=dge, width=1200, height=1200)`

Users can specify the width and height of the MA plot widget in pixels. The default width and height are both 920px.

***Changing DE status colouring***

*Usage:* `glimmaMA(efit, dge=dge, status.cols=c("blue", "grey", "red")`

Users can customise the colours associated with the differential expression status of a gene using the `status.cols` argument. A vector of length three should be passed in, where each element must be a valid CSS colour string.

***Changing sample colours in expression plot***

*Usage:* `glimmaMA(efit, dge=dge, sample.cols=c("yellow", "yellow", "yellow", "red", "red", "red", "purple", "purple", "purple")`

Users can provide a vector of valid CSS colour strings of length `ncol(dge$counts)` or `ncol(counts)` which correspond to sample colours. The colours used in the example here reflect the sequencing lane.

***Overriding counts and groups***

*Usage:* `glimmaMA(efit, counts=counts, groups=groups)`

Glimma extracts counts and experimental data from the `dge` argument for limma and edgeR data types. However, users can optionally supply their own counts and experimental groups using the `counts` and `groups` arguments.

***Transforming counts values***

*Usage:* `glimmaMA(efit, dge=dge, transform.counts="rpkm")`

The `transform.counts` argument allows users to choose between strategies for transforming counts data displayed on the expression plot. The default argument is `"logcpm"` which log-transforms counts using `edgeR::cpm(counts, log=TRUE)`. Other options are "`rpkm"` for `edgeR::rpkm(counts)`, `cpm` for `edgeR::cpm(counts)` and `none` for no transformation.

***Changing displayed columns in gene annotation*** The gene annotations are pulled from the `DGEList` object by default. This can be overwritten by providing a different table of annotations via the `anno` argument, the substitute annotations must have the same number of rows as the counts matrix and the genes must be in the same order as in the counts.

Some annotations may contain too many columsn to be sensibly displayed. The `display.columns` argument can be used to control the columns displayed in the plot. A vector of column names are to be provided for selecting the columns that will be displayed in the interactive plot.

## Volcano Plot

A popular alternative to the MA plot for plotting the output of differential expression analysis the the volcano plot. This can be produced using the `glimmaVolcano` function and the same arguments as the `glimmaMA`.

```
glimmaVolcano(efit, dge = dge)
```

## Saving widgets

The plots created are automatically embedded into Rmarkdown reports, but having many interactive plots can significantly slow down the page. It is instead recommended to save the plots and link to them via markdown hyperlinks. Plots can be saved either by providing the `html` argument a filename, or by using `htmlwidgets::saveWidget`, which also provides further customisation options. Let us now create a html file named “ma-plot.html” in our working directory.

```
htmlwidgets::saveWidget(glimmaMA(efit, dge = dge), "ma-plot.html")
# you can link to it in Rmarkdown using [MA-plot](ma-plot.html)
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