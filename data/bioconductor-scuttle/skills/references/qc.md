# Quality control for single-cell RNA-seq data

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: February 6, 2021

#### Package

scuttle 1.20.0

# 1 Introduction

*[scuttle](https://bioconductor.org/packages/3.22/scuttle)* provides various low-level utilities for single-cell RNA-seq data analysis,
typically used at the start of the analysis workflows or within high-level functions in other packages.
This vignette will discuss one of the earliest steps, namely, quality control (QC) to remove damaged cells.

To demonstrate, we will obtain the classic Zeisel dataset from the *[scRNAseq](https://bioconductor.org/packages/3.22/scRNAseq)* package.
In this case, the dataset is provided as a `SingleCellExperiment` object.
However, most *[scuttle](https://bioconductor.org/packages/3.22/scuttle)* functions can also be used with raw expression matrices
or instances of the more general `SummarizedExperiment` class.

```
library(scRNAseq)
sce <- ZeiselBrainData()
sce
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

**Note:** A more comprehensive description of the use of *[scuttle](https://bioconductor.org/packages/3.22/scuttle)* functions
(along with other packages) in a scRNA-seq analysis workflow is available at <https://osca.bioconductor.org>.

# 2 Computing per-cell QC metrics

The `perCellQCMetrics()` function computes a variety of basic cell-level metrics,
including `sum`, total number of counts for the cell (i.e., the library size);
and `detected`, the number of features for the cell that have counts above the detection limit (default of zero).
Low values for either metric are indicative of poor cDNA capture.

```
library(scuttle)
is.mito <- grep("mt-", rownames(sce))
per.cell <- perCellQCMetrics(sce, subsets=list(Mito=is.mito))
summary(per.cell$sum)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##    2574    8130   12913   14954   19284   63505
```

```
summary(per.cell$detected)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##     785    2484    3656    3777    4929    8167
```

In addition, we can compute `subsets_X_percent`, percentage of counts that come from the feature control set named `X`;
and `altexps_Y_percent`, the percentage of all counts that come from an alternative feature set `Y`.
Here, `X` contains the mitochondrial genes and `Y` contains the set of spike-ins.
High proportions for either metric are indicative of cell damage.

```
summary(per.cell$subsets_Mito_percent)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   0.000   3.992   6.653   7.956  10.290  56.955
```

```
summary(per.cell$altexps_ERCC_percent)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   2.912  14.186  20.699  23.199  29.950  76.881
```

It is often convenient to store this in the `colData()` of our `SingleCellExperiment` object for future reference.
One can either do so manually:

```
colData(sce) <- cbind(colData(sce), per.cell)
```

… or just use the `addPerCellQCMetrics()` function, which does this automatically:

```
sce2 <- addPerCellQCMetrics(sce, subsets=list(Mito=is.mito))
colnames(colData(sce2))
```

```
##  [1] "tissue"                  "group #"
##  [3] "total mRNA mol"          "well"
##  [5] "sex"                     "age"
##  [7] "diameter"                "level1class"
##  [9] "level2class"             "sum"
## [11] "detected"                "subsets_Mito_sum"
## [13] "subsets_Mito_detected"   "subsets_Mito_percent"
## [15] "altexps_repeat_sum"      "altexps_repeat_detected"
## [17] "altexps_repeat_percent"  "altexps_ERCC_sum"
## [19] "altexps_ERCC_detected"   "altexps_ERCC_percent"
## [21] "total"                   "sum"
## [23] "detected"                "subsets_Mito_sum"
## [25] "subsets_Mito_detected"   "subsets_Mito_percent"
## [27] "altexps_repeat_sum"      "altexps_repeat_detected"
## [29] "altexps_repeat_percent"  "altexps_ERCC_sum"
## [31] "altexps_ERCC_detected"   "altexps_ERCC_percent"
## [33] "total"
```

# 3 Identifying outliers on QC metrics

We identify low-quality cells by setting a threshold on each of these metrics using the `isOutlier()` function.
This defines the threshold at a certain number of median absolute deviations (MADs) away from the median;
values beyond this threshold are considered outliers and can be filtered out, assuming that they correspond to low-quality cells.
Here, we define small outliers (using `type="lower"`) for the *log*-total counts at 3 MADs from the median.

```
low.total <- isOutlier(per.cell$sum, type="lower", log=TRUE)
summary(low.total)
```

```
##    Mode   FALSE
## logical    3005
```

Note that the attributes of the `isOutlier()` output contain the thresholds, if this is of interest.

```
attr(low.total, "threshold")
```

```
##   lower  higher
## 1928.56     Inf
```

Advanced users can set `batch=` to compute outliers within each batch, avoiding inflated MADs due to batch effects.

```
low.total.batched <- isOutlier(per.cell$sum, type="lower", log=TRUE, batch=sce$tissue)
summary(low.total.batched)
```

```
##    Mode   FALSE    TRUE
## logical    2996       9
```

In cases where entire batches contain a majority of low-quality cells, we can set `subset=` to only use high-quality batches for computing the thresholds.
Those thresholds are then extrapolated back to the low-quality batches for some more stringent QC.

# 4 Filtering out low-quality cells

We could manually apply `isOutlier()` to all of our metrics, but it is easier to use `perCellQCFilters()` to do this for us.
This identifies low-quality cells as those that are low outliers for the log-total count, low outliers for the log-number of detected features,
or high outliers for the percentage of counts in specified gene sets (e.g., mitochondrial genes, spike-in transcripts).
The `discard` column contains the final call for whether a particular cell should be discarded.

```
# An example with just mitochondrial filters.
qc.stats <- perCellQCFilters(per.cell, sub.fields="subsets_Mito_percent")
colSums(as.matrix(qc.stats))
```

```
##              low_lib_size            low_n_features high_subsets_Mito_percent
##                         0                         3                       128
##                   discard
##                       131
```

```
# Another example with mitochondrial + spike-in filters.
qc.stats2 <- perCellQCFilters(per.cell,
    sub.fields=c("subsets_Mito_percent", "altexps_ERCC_percent"))
colSums(as.matrix(qc.stats2))
```

```
##              low_lib_size            low_n_features high_subsets_Mito_percent
##                         0                         3                       128
## high_altexps_ERCC_percent                   discard
##                        65                       189
```

For typical scRNA-seq applications, `quickPerCellQC()` will wrap the `perCellQCMetrics()` and `perCellQCFilters()` calls.
This returns a filtered `SingleCellExperiment` that can be immediately used in downstream analyses.

```
filtered <- quickPerCellQC(sce, subsets=list(Mito=is.mito), sub.fields="subsets_Mito_percent")
filtered
```

```
## class: SingleCellExperiment
## dim: 20006 2874
## metadata(0):
## assays(1): counts
## rownames(20006): Tspan12 Tshz1 ... mt-Rnr1 mt-Nd4l
## rowData names(1): featureType
## colnames(2874): 1772071015_C02 1772071017_G12 ... 1772063068_D01
##   1772066098_A12
## colData names(37): tissue group # ... high_subsets_Mito_percent discard
## reducedDimNames(0):
## mainExpName: gene
## altExpNames(2): repeat ERCC
```

The outlier-based approach adjusts to experiment-specific aspects of the data, e.g., sequencing depth, amount of spike-in RNA added, differences in total RNA content between cell types.
In contrast, a fixed threshold would require manual adjustment to account for changes to the experimental protocol or system.
We refer readers to the [book](https://osca.bioconductor.org/quality-control.html) for more details.

# 5 Computing feature-level statistics

Some basic feature-level statistics are computed by the `perFeatureQCMetrics()` function.
This includes `mean`, the mean count of the gene/feature across all cells;
`detected`, the percentage of cells with non-zero counts for each gene;
`subsets_Y_ratio`, ratio of mean counts between the cell control set named Y and all cells.

```
# Pretending that the first 10 cells are empty wells, for demonstration.
per.feat <- perFeatureQCMetrics(sce, subsets=list(Empty=1:10))
summary(per.feat$mean)
```

```
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max.
##   0.00067   0.00965   0.13378   0.74749   0.57629 732.15241
```

```
summary(per.feat$detected)
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
##  0.03328  0.76539  9.01830 18.87800 31.24792 99.96672
```

```
summary(per.feat$subsets_Empty_ratio)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   0.000   0.000   0.601   1.872   2.016 300.500
```

A more refined calculation of the average is provided by the `calculateAverage()` function,
which adjusts the counts by the relative library size (or size factor) prior to taking the mean.

```
ave <- calculateAverage(sce)
summary(ave)
```

```
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max.
##   0.00021   0.01094   0.14432   0.74749   0.56737 850.68800
```

These metrics tend to be more useful for informing the analyst about the overall behavior of the experiment,
rather than being explicitly used to filter out genes.
For example, one would hope that the most abundant genes are the “usual suspects”, e.g., ribosomal proteins, actin, histones.

Users *may* wish to filter out very lowly or non-expressed genes to reduce the size of the dataset prior to downstream processing.
However, **be sure to publish the unfiltered count matrix!**
It is very difficult to re-use a count matrix where the features are filtered;
information from the filtered features cannot be recovered, complicating integration with other datasets.

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
##  [1] scran_1.38.0                ensembldb_2.34.0
##  [3] AnnotationFilter_1.34.0     GenomicFeatures_1.62.0
##  [5] AnnotationDbi_1.72.0        scuttle_1.20.0
##  [7] scRNAseq_2.24.0             SingleCellExperiment_1.32.0
##  [9] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [11] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [13] IRanges_2.44.0              S4Vectors_0.48.0
## [15] BiocGenerics_0.56.0         generics_0.1.4
## [17] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                bitops_1.0-9             httr2_1.2.1
##   [4] rlang_1.1.6              magrittr_2.0.4           gypsum_1.6.0
##   [7] compiler_4.5.1           RSQLite_2.4.3            png_0.1-8
##  [10] vctrs_0.6.5              ProtGenerics_1.42.0      pkgconfig_2.0.3
##  [13] crayon_1.5.3             fastmap_1.2.0            dbplyr_2.5.1
##  [16] XVector_0.50.0           Rsamtools_2.26.0         rmarkdown_2.30
##  [19] UCSC.utils_1.6.0         purrr_1.1.0              bit_4.6.0
##  [22] bluster_1.20.0           xfun_0.54                cachem_1.1.0
##  [25] beachmat_2.26.0          cigarillo_1.0.0          GenomeInfoDb_1.46.0
##  [28] jsonlite_2.0.0           blob_1.2.4               rhdf5filters_1.22.0
##  [31] DelayedArray_0.36.0      Rhdf5lib_1.32.0          BiocParallel_1.44.0
##  [34] cluster_2.1.8.1          irlba_2.3.5.1            parallel_4.5.1
##  [37] R6_2.6.1                 bslib_0.9.0              limma_3.66.0
##  [40] rtracklayer_1.70.0       jquerylib_0.1.4          Rcpp_1.1.0
##  [43] bookdown_0.45            knitr_1.50               igraph_2.2.1
##  [46] Matrix_1.7-4             tidyselect_1.2.1         abind_1.4-8
##  [49] yaml_2.3.10              codetools_0.2-20         curl_7.0.0
##  [52] lattice_0.22-7           alabaster.sce_1.10.0     tibble_3.3.0
##  [55] withr_3.0.2              KEGGREST_1.50.0          evaluate_1.0.5
##  [58] BiocFileCache_3.0.0      alabaster.schemas_1.10.0 ExperimentHub_3.0.0
##  [61] Biostrings_2.78.0        pillar_1.11.1            BiocManager_1.30.26
##  [64] filelock_1.0.3           RCurl_1.98-1.17          BiocVersion_3.22.0
##  [67] sparseMatrixStats_1.22.0 alabaster.base_1.10.0    glue_1.8.0
##  [70] alabaster.ranges_1.10.0  metapod_1.18.0           alabaster.matrix_1.10.0
##  [73] lazyeval_0.2.2           tools_4.5.1              AnnotationHub_4.0.0
##  [76] BiocIO_1.20.0            BiocNeighbors_2.4.0      ScaledMatrix_1.18.0
##  [79] locfit_1.5-9.12          GenomicAlignments_1.46.0 XML_3.99-0.19
##  [82] rhdf5_2.54.0             grid_4.5.1               edgeR_4.8.0
##  [85] BiocSingular_1.26.0      HDF5Array_1.38.0         restfulr_0.0.16
##  [88] rsvd_1.0.5               cli_3.6.5                rappdirs_0.3.3
##  [91] S4Arrays_1.10.0          dplyr_1.1.4              alabaster.se_1.10.0
##  [94] sass_0.4.10              digest_0.6.37            dqrng_0.4.1
##  [97] SparseArray_1.10.0       rjson_0.2.23             memoise_2.0.1
## [100] htmltools_0.5.8.1        lifecycle_1.0.4          h5mread_1.2.0
## [103] httr_1.4.7               statmod_1.5.1            bit64_4.6.0-1
```