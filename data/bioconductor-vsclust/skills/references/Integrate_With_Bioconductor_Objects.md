# VSClust with Bioconductor objects

Veit Schwämmle

#### 30 October 2025

#### Abstract

Here, we describe the workflow to run variance-sensitive clustering on data stored in a SummarizedExperiment, QFeatures or MultiAssayExperiment object. This vignette is distributed under a CC BY-SA license.

#### Package

vsclust 1.12.0

# 1 Introduction

For a more detailed explanation of the VSClust function and the workflow, please
take a look on the vignette for running the VSClust workflow.

Here, we present an example script to integrate the clustering with data object
from Bioconductor, such as `QFeatures`, `SummarizedExperiment` and
`MultiAssayExperiment`.

# 2 Installation and additional packages

Use the common Bioconductor commands for installation:

```
# uncomment in case you have not installed vsclust yet
#if (!require("BiocManager", quietly = TRUE))
#    install.packages("BiocManager")
#BiocManager::install("vsclust")
```

The full functionality can be obtained by additionally installing and loading the
packages `yaml`, `shiny`, `clusterProfiler`, and `matrixStats`.

# 3 Initialization

Here, we define the different parameters for the data set `RNASeq2GeneNorm` from
the `miniACC` object.

The number of replicates and experimental conditions will be retrieved
automatically by specifying the metadata for the grouping.

```
#### Input parameters, only read when now parameter file was provided #####
## All principal parameters for running VSClust can be defined as in the
## shiny app at computproteomics.bmb.sdu.dk/Apps/VSClust
# name of study
Experiment <- "miniACC"
# Paired or unpaired statistical tests when carrying out LIMMA for
# statistical testing
isPaired <- FALSE
# Number of threads to accelerate the calculation (use 1 in doubt)
cores <- 1

# If 0 (default), then automatically estimate the cluster number for the
# vsclust run from the Minimum Centroid Distance
PreSetNumClustVSClust <- 0
# If 0 (default), then automatically estimate the cluster number for the
# original fuzzy c-means from the Minimum Centroid Distance
PreSetNumClustStand <- 0

# max. number of clusters when estimating the number of clusters.
# Higher numbers can drastically extend the computation time.
maxClust <- 10
```

# 4 Statistics and data preprocessing

At first, we load will log-transform the original data and normalize it to the
median. Statistical testing will be applied on the resulting object.
After estimating the standard deviations, the matrix consists of the averaged
quantitative feature values and a last column for the standard deviations of the
features.

We will separate the samples according to their `OncoSign`.

```
data(miniACC, package="MultiAssayExperiment")
# log-transformation and remove of -Inf values
logminiACC <- log2(assays(miniACC)$RNASeq2GeneNorm)
logminiACC[!is.finite(logminiACC)] <- NA
# normalize to median
logminiACC <- t(t(logminiACC) - apply(logminiACC, 2, median, na.rm=TRUE))

miniACC2 <- c(miniACC, log2rnaseq = logminiACC, mapFrom=1L)
```

```
## Warning: Assuming column order in the data provided
##  matches the order in 'mapFrom' experiment(s) colnames
```

```
boxplot(logminiACC)
```

![](data:image/png;base64...)

```
#### running statistical analysis and estimation of individual variances
statOut <- PrepareSEForVSClust(miniACC2, "log2rnaseq",
                               coldatname = "OncoSign",
                               isPaired=isPaired, isStat=TRUE)
```

```
## -- The following categories will be used as experimental
##               conditions:
## CN2
## TP53/NF1
## TERT/ZNRF3
## CN1
## Unclassified
## NA
## CTNNB1
```

```
## -- Extracted NumReps: 21 and NumCond: 7
```

![](data:image/png;base64...)

We can see that there is no good separation of cancer signatures on the PCA
plot.

# 5 Estimation of cluster number

There is no simple way to find the optimal number of clusters in a data set. For
obtaining this number, we run the clustering for different cluster numbers and
evaluate them via so-called validity indices, which provide information about
suitable cluster numbers. VSClust uses mainly the “Maximum centroid distances”
that denotes the shortest distance between any of the centroids. Alternatively,
one can inspect the Xie Beni index.

The output of `estimClustNum` contains the suggestion for the number of
clusters.

We further visualize the outcome.

```
#### Estimate number of clusters with maxClust as maximum number clusters to run
#### the estimation with
ClustInd <- estimClustNum(statOut$dat, maxClust=maxClust, cores=cores)
```

```
## Running cluster number 3
```

```
## Running cluster number 4
```

```
## Running cluster number 5
```

```
## Running cluster number 6
```

```
## Running cluster number 7
```

```
## Running cluster number 8
```

```
## Running cluster number 9
```

```
## Running cluster number 10
```

```
#### Use estimate cluster number or use own
if (PreSetNumClustVSClust == 0)
  PreSetNumClustVSClust <- optimalClustNum(ClustInd)
if (PreSetNumClustStand == 0)
  PreSetNumClustStand <- optimalClustNum(ClustInd, method="FCM")
#### Visualize
  estimClust.plot(ClustInd)
```

![](data:image/png;base64...)
Both validity indices agree with each other and suggest 7 as the most reasonable
estimate for the cluster number. However, we can also see that this decreases
the number of clustered features quite drastically from over 150 to about 90.

# 6 Run final clustering

Now we run the clustering again with the optimal parameters from the estimation.
One can
take alternative numbers of clusters corresponding to large decays in the
Minimum Centroid Distance or low values of the Xie Beni
index.

First, we carry out the variance-sensitive method

```
#### Run clustering (VSClust and standard fcm clustering
ClustOut <- runClustWrapper(statOut$dat,
                            PreSetNumClustVSClust, NULL,
                            VSClust=TRUE,
                            cores=cores)
Bestcl <- ClustOut$Bestcl
VSClust_cl <- Bestcl
```

![](data:image/png;base64...)

We see how different groups of genes show distinctive pattern of their
expression in different oncological signatures.

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
##  [1] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
##  [9] generics_0.1.4              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           vsclust_1.12.0
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3               gson_0.1.0              rlang_1.1.6
##   [4] magrittr_2.0.4          DOSE_4.4.0              otel_0.2.0
##   [7] compiler_4.5.1          RSQLite_2.4.3           systemfonts_1.3.1
##  [10] png_0.1-8               vctrs_0.6.5             reshape2_1.4.4
##  [13] stringr_1.5.2           pkgconfig_2.0.3         crayon_1.5.3
##  [16] fastmap_1.2.0           magick_2.9.0            XVector_0.50.0
##  [19] promises_1.4.0          rmarkdown_2.30          enrichplot_1.30.0
##  [22] tinytex_0.57            purrr_1.1.0             bit_4.6.0
##  [25] xfun_0.53               cachem_1.1.0            aplot_0.2.9
##  [28] jsonlite_2.0.0          blob_1.2.4              later_1.4.4
##  [31] DelayedArray_0.36.0     BiocParallel_1.44.0     parallel_4.5.1
##  [34] R6_2.6.1                bslib_0.9.0             stringi_1.8.7
##  [37] RColorBrewer_1.1-3      limma_3.66.0            jquerylib_0.1.4
##  [40] GOSemSim_2.36.0         Rcpp_1.1.0              bookdown_0.45
##  [43] knitr_1.50              ggtangle_0.0.7          R.utils_2.13.0
##  [46] BiocBaseUtils_1.12.0    httpuv_1.6.16           Matrix_1.7-4
##  [49] splines_4.5.1           igraph_2.2.1            tidyselect_1.2.1
##  [52] qvalue_2.42.0           dichromat_2.0-0.1       abind_1.4-8
##  [55] yaml_2.3.10             codetools_0.2-20        lattice_0.22-7
##  [58] tibble_3.3.0            plyr_1.8.9              shiny_1.11.1
##  [61] treeio_1.34.0           KEGGREST_1.50.0         S7_0.2.0
##  [64] evaluate_1.0.5          gridGraphics_0.5-1      Biostrings_2.78.0
##  [67] pillar_1.11.1           BiocManager_1.30.26     ggtree_4.0.0
##  [70] clusterProfiler_4.18.0  ggfun_0.2.0             ggplot2_4.0.0
##  [73] tidytree_0.4.6          scales_1.4.0            xtable_1.8-4
##  [76] glue_1.8.0              gdtools_0.4.4           lazyeval_0.2.2
##  [79] tools_4.5.1             data.table_1.17.8       fgsea_1.36.0
##  [82] ggiraph_0.9.2           fs_1.6.6                fastmatch_1.1-6
##  [85] cowplot_1.2.0           grid_4.5.1              tidyr_1.3.1
##  [88] ape_5.8-1               AnnotationDbi_1.72.0    nlme_3.1-168
##  [91] patchwork_1.3.2         cli_3.6.5               rappdirs_0.3.3
##  [94] fontBitstreamVera_0.1.1 S4Arrays_1.10.0         dplyr_1.1.4
##  [97] gtable_0.3.6            R.methodsS3_1.8.2       yulab.utils_0.2.1
## [100] fontquiver_0.2.1        sass_0.4.10             digest_0.6.37
## [103] SparseArray_1.10.0      ggrepel_0.9.6           ggplotify_0.1.3
## [106] htmlwidgets_1.6.4       farver_2.1.2            memoise_2.0.1
## [109] htmltools_0.5.8.1       R.oo_1.27.1             lifecycle_1.0.4
## [112] httr_1.4.7              mime_0.13               GO.db_3.22.0
## [115] statmod_1.5.1           fontLiberation_0.1.0    bit64_4.6.0-1
```