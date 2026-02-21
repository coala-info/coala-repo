# countsimQC - Comparing characteristic features across count data sets

#### Charlotte Soneson

#### 2026-02-09

## Introduction

The `countsimQC` package provides a simple way to compare the characteristic features of a collection of (e.g., RNA-seq) count data sets. An important application is in situations where a synthetic count data set has been generated using a real count data set as an underlying source of parameters, in which case it is often important to verify that the final synthetic data captures the main features of the original data set. However, the package can be used to create a visual overview of any collection of one or more count data sets.

## Data preparation

In this vignette we will show how to generate a comparative report from a collection of two simulated data sets and the original, underlying real data set. First, we load the object containing the three data sets. The object is a named list, where each element is a `DESeqDataSet` object, containing the count matrix, a sample information data frame and a model formula (necessary to calculate dispersions). For more information about the `DESeqDataSet` class, please see the [`DESeq2`](http://bioconductor.org/packages/release/bioc/html/DESeq2.html) Bioconductor package. For speed reasons, we use only a subset of the features in each data set for the following calculations.

```
suppressPackageStartupMessages({
  library(countsimQC)
  library(DESeq2)
})

data(countsimExample)
countsimExample
```

```
## $Original
## class: DESeqDataSet
## dim: 10000 11
## metadata(1): version
## assays(1): counts
## rownames(10000): ENSMUSG00000000001.4 ENSMUSG00000000028.14 ...
##   ENSMUSG00000048027.7 ENSMUSG00000048029.10
## rowData names(0):
## colnames(11): GSM1923445 GSM1923446 ... GSM1923578 GSM1923579
## colData names(2): group sample
##
## $Sim1
## class: DESeqDataSet
## dim: 10000 11
## metadata(1): version
## assays(1): counts
## rownames(10000): Gene1 Gene2 ... Gene9999 Gene10000
## rowData names(0):
## colnames(11): Cell1 Cell2 ... Cell88 Cell89
## colData names(4): Cell Batch Group ExpLibSize
##
## $Sim2
## class: DESeqDataSet
## dim: 10000 11
## metadata(1): version
## assays(1): counts
## rownames(10000): Gene1 Gene2 ... Gene9999 Gene10000
## rowData names(0):
## colnames(11): Cell1 Cell2 ... Cell88 Cell89
## colData names(3): Cell CellFac Group
```

```
countsimExample <- lapply(countsimExample, function(cse) {
  cse[seq_len(1500), ]
})
```

## Report generation

Next, we generate the report using the `countsimQCReport()` function. Depending on the level of detail and the type of information that are required for the final report, this function can be run in different “modes”:

* by setting `calculateStatistics = FALSE`, only plots will be generated. This is the fastest way of running `countsimQCReport()`, and in many cases generates enough information for the user to make a visual evaluation of the count data set(s).
* by setting `calculateStatistics = TRUE` and `permutationPvalues = FALSE`, some quantitative pairwise comparisons between data sets will be performed. In particular, the Kolmogorov-Smirnov test and the Wald-Wolfowitz runs test will be used to compare distributions, and additional statistics will be calculated to evaluate how similar the evaluated aspects are between pairs of data sets.
* by setting `calculateStatistics = TRUE` and `permutationPvalues = TRUE` (and giving the requested number of permutations via the `nPermutations` argument), permutation of data set labels will be used to evaluate the significance of the statistics calculated in the previous point. Naturally, this increases the run time of the analysis considerably.

Here, for the sake of speed, we calculate statistics for a small subset of the observations (`subsampleSize = 25`) and refrain from calculating permutation p-values.

```
tempDir <- tempdir()
countsimQCReport(ddsList = countsimExample, outputFile = "countsim_report.html",
                 outputDir = tempDir, outputFormat = "html_document",
                 showCode = FALSE, forceOverwrite = TRUE,
                 savePlots = TRUE, description = "This is my test report.",
                 maxNForCorr = 25, maxNForDisp = Inf,
                 calculateStatistics = TRUE, subsampleSize = 25,
                 kfrac = 0.01, kmin = 5,
                 permutationPvalues = FALSE, nPermutations = NULL)
```

The `countsimQCReport()` function can generate either an HTML file (by setting `outputFormat = "html_document"` or `outputFormat = NULL`) or a pdf file (by setting `outputFormat = "pdf_document"`). The `description` argument can be used to provide a more extensive description of the data set(s) that are included in the report.

## Generation of individual figures

If the argument `savePlots` is set to TRUE, an .rds file containing the individual ggplot objects will be generated. These objects can be used to perform fine-tuning of the visualizations if desired. Note, however, that the .rds file can become large if the number of data sets is large, or if the individual data sets have many samples or features. The convenience function `generateIndividualPlots()` can be used to quickly generate individual figures for all plots included in the report, using a variety of devices. For example, to generate each plot in pdf format:

```
ggplots <- readRDS(file.path(tempDir, "countsim_report_ggplots.rds"))
if (!dir.exists(file.path(tempDir, "figures"))) {
  dir.create(file.path(tempDir, "figures"))
}
generateIndividualPlots(ggplots, device = "pdf", nDatasets = 3,
                        outputDir = file.path(tempDir, "figures"))
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

## Input data format

In the example above, all data sets were provided as `DESeqDataSet` objects. The advantage of this is that it allows the specification of the experimental design, which is used in the dispersion calculations. `countsimQC` also allows a data set to be provided as either a `data.frame` or a `matrix`. However, in these situations, it will be assumed that all samples are replicates (i.e., a design `~1`). An example is provided in the `countsimExample_dfmat` data set, provided with the package.

```
data(countsimExample_dfmat)
names(countsimExample_dfmat)
```

```
## [1] "Original" "Sim1"     "Sim2"
```

```
lapply(countsimExample_dfmat, class)
```

```
## $Original
## [1] "DESeqDataSet"
## attr(,"package")
## [1] "DESeq2"
##
## $Sim1
## [1] "matrix" "array"
##
## $Sim2
## [1] "data.frame"
```

```
tempDir <- tempdir()
countsimQCReport(ddsList = countsimExample_dfmat,
                 outputFile = "countsim_report_dfmat.html",
                 outputDir = tempDir, outputFormat = "html_document",
                 showCode = FALSE, forceOverwrite = TRUE,
                 savePlots = TRUE, description = "This is my test report.",
                 maxNForCorr = 25, maxNForDisp = Inf,
                 calculateStatistics = TRUE, subsampleSize = 25,
                 kfrac = 0.01, kmin = 5,
                 permutationPvalues = FALSE, nPermutations = NULL)
```

## Session info

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
##  [1] DESeq2_1.50.2               SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              MatrixGenerics_1.22.0
##  [5] matrixStats_1.5.0           GenomicRanges_1.62.1
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              countsimQC_1.28.1
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1        dplyr_1.2.0             farver_2.1.2
##  [4] blob_1.3.0              bitops_1.0-9            Biostrings_2.78.0
##  [7] S7_0.2.1                fastmap_1.2.0           XML_3.99-0.20
## [10] digest_0.6.39           lifecycle_1.0.5         survival_3.8-6
## [13] statmod_1.5.1           KEGGREST_1.50.0         RSQLite_2.4.6
## [16] magrittr_2.0.4          genefilter_1.92.0       compiler_4.5.2
## [19] rlang_1.1.7             sass_0.4.10             tools_4.5.2
## [22] yaml_2.3.12             knitr_1.51              labeling_0.4.3
## [25] S4Arrays_1.10.1         htmlwidgets_1.6.4       bit_4.6.0
## [28] DelayedArray_0.36.0     RColorBrewer_1.1-3      abind_1.4-8
## [31] BiocParallel_1.44.0     withr_3.0.2             purrr_1.2.1
## [34] grid_4.5.2              caTools_1.18.3          xtable_1.8-4
## [37] edgeR_4.8.2             ggplot2_4.0.2           scales_1.4.0
## [40] dichromat_2.0-0.1       cli_3.6.5               rmarkdown_2.30
## [43] crayon_1.5.3            ragg_1.5.0              otel_0.2.0
## [46] httr_1.4.7              DBI_1.2.3               cachem_1.1.0
## [49] splines_4.5.2           parallel_4.5.2          AnnotationDbi_1.72.0
## [52] XVector_0.50.0          vctrs_0.7.1             Matrix_1.7-4
## [55] jsonlite_2.0.0          bit64_4.6.0-1           crosstalk_1.2.2
## [58] systemfonts_1.3.1       locfit_1.5-9.12         limma_3.66.0
## [61] tidyr_1.3.2             jquerylib_0.1.4         annotate_1.88.0
## [64] glue_1.8.0              randtests_1.0.2         codetools_0.2-20
## [67] DT_0.34.0               gtable_0.3.6            tibble_3.3.1
## [70] pillar_1.11.1           htmltools_0.5.9         GenomeInfoDbData_1.2.15
## [73] R6_2.6.1                textshaping_1.0.4       evaluate_1.0.5
## [76] lattice_0.22-9          png_0.1-8               memoise_2.0.1
## [79] bslib_0.10.0            Rcpp_1.1.1              nlme_3.1-168
## [82] SparseArray_1.10.8      mgcv_1.9-4              xfun_0.56
## [85] pkgconfig_2.0.3
```