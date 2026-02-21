# ccImpute Package Manual

Marcin Malec, Parichit Sharma, Hasan Kurban, Mehmet Dalkilic

#### 2025-10-29

# Contents

* [1 Introduction](#introduction)
  + [1.1 Installation](#installation)
* [2 Data Pre-Processing](#data-pre-processing)
* [3 Sample Usage](#sample-usage)
  + [3.1 Required libraries](#required-libraries)
  + [3.2 Input Data](#input-data)
  + [3.3 Pre-processing data](#pre-processing-data)
  + [3.4 Adjusted Rand Index (ARI)](#adjusted-rand-index-ari)
  + [3.5 Compute Adjusted Rand Index (ARI) without imputation.](#compute-adjusted-rand-index-ari-without-imputation.)
  + [3.6 Perform the imputation with 2 CPU cores and fill in the ‘imputed’ assay.](#perform-the-imputation-with-2-cpu-cores-and-fill-in-the-imputed-assay.)
  + [3.7 Re-compute Adjusted Rand Index (ARI) with imputation.](#re-compute-adjusted-rand-index-ari-with-imputation.)
* [4 ccImpute Algorithm Overview](#ccimpute-algorithm-overview)
* [5 Key Analytical Choices](#key-analytical-choices)
  + [5.1 Distance/Similarity Measures](#distancesimilarity-measures)
  + [5.2 Singular Value Decomposition (SVD)](#singular-value-decomposition-svd)
  + [5.3 Clustering: k, kmMaxIter, kmNStart](#clustering-k-kmmaxiter-kmnstart)
* [6 Runtime Performance](#runtime-performance)
* [7 R session information.](#r-session-information.)
* [References](#references)

# 1 Introduction

Single-cell RNA sequencing (scRNA-seq) is a powerful technique, but its
analysis is hampered by dropout events. These events occur when expressed genes
are missed and recorded as zero. This makes distinguishing true
zero expression from low expression difficult, affecting downstream analyses
like cell type classification. To address this challenge, we introduce ccImpute
(Malec, Kurban, and Dalkilic [2022](#ref-malec2022ccimpute)), an R package that leverages consensus clustering. This
approach measures cell similarity effectively, allowing ccImpute to identify
and impute the most probable dropout events. Compared to existing methods,
ccImpute excels in two ways: it delivers superior performance and introduces
minimal additional noise, as evidenced by improved clustering on datasets with
known cell identities.

## 1.1 Installation

```
To install this package, start R (version "4.2") and enter:
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ccImpute")
```

# 2 Data Pre-Processing

`ccImpute` is an imputation tool that does not provide functions for
pre-processing the data. This tool expects the user to pre-process the data
before using it. The input data is expected to be in a log-normalized format
and accessible through the SingleCellExperiment object logcounts method. This
manual includes sample minimal pre-processing of a dataset from
[scRNAseq database](http://bioconductor.org/packages/scRNAseq) using the
[scater tool](http://bioconductor.org/packages/scater).

# 3 Sample Usage

## 3.1 Required libraries

```
library(scRNAseq)
library(scater)
library(ccImpute)
library(SingleCellExperiment)
library(stats)
library(mclust)
```

## 3.2 Input Data

The code below loads the raw mouse neuron dataset from (Usoskin et al. [2015](#ref-usoskin2015unbiased))
and performs preprocessing steps to facilitate meaningful analysis, including
the computation of log-transformed normalized counts.

```
sce <- UsoskinBrainData()
X <- cpm(sce)
labels <- colData(sce)$"Level 1"

#Filter bad cells
filt <- !grepl("Empty well", labels) &
        !grepl("NF outlier", labels) &
        !grepl("TH outlier", labels) &
        !grepl("NoN outlier", labels) &
        !grepl("NoN", labels) &
        !grepl("Central, unsolved", labels) &
        !grepl(">1 cell", labels) &
        !grepl("Medium", labels)

labels <-labels[filt]
X <- as.matrix(X[,filt])

#Remove genes that are not expressed in any cells:
X <- X[rowSums(X)>0,]

#Recreate the SingleCellExperiment and add log-transformed data:
ann <- data.frame(cell_id = labels)
sce <- SingleCellExperiment(assays = list(normcounts = as.matrix(X)),
                            colData = ann)
logcounts(sce) <- log(normcounts(sce) + 1)
```

## 3.3 Pre-processing data

A user may consider performing [feature selection](https://bioconductor.org/books/3.15/OSCA.basic/feature-selection.html)
before running the imputation. ccImpute only imputes the most probable
dropout events and is unlikely to benefit from the presence of scarcely
expressed genes nor make any corrections to their expression.

## 3.4 Adjusted Rand Index (ARI)

Adjusted Rand Index measures the similarity between two data clusterings
adjusted for the chance grouping of elements. This measure allows us to
evaluate the performance of the clustering algorithm as a similarity to the
optimal clustering assignments derived from cell labels.

## 3.5 Compute Adjusted Rand Index (ARI) without imputation.

```
# Set seed for reproducibility purposes.
set.seed(0)
# Compute PCA reduction of the dataset
reducedDims(sce) <- list(PCA=prcomp(t(logcounts(sce)))$x)

# Get an actual number of cell types
k <- length(unique(colData(sce)$cell_id))

# Cluster the PCA reduced dataset and store the assignments
set.seed(0)
assgmts <- kmeans(reducedDim(sce, "PCA"), centers = k, iter.max = 1e+09,
                    nstart = 1000)$cluster

# Use ARI to compare the k-means assignments to label assignments
adjustedRandIndex(assgmts, colData(sce)$cell_id)
#> [1] 0.2319002
```

## 3.6 Perform the imputation with 2 CPU cores and fill in the ‘imputed’ assay.

```
library(BiocParallel)
BPPARAM = MulticoreParam(2)
sce <- ccImpute(sce, BPPARAM = BPPARAM)
#> Running ccImpute on dataset (622 cells) with 2
#>                             cores.
#> [Elapsed time: 12.62s] Distance matrix has been computed.
#> [Elapsed time: 12.91s] SVD completed.
#> Warning in runKM(logX, v, maxSets, k, consMin, kmNStart, kmMax, BPPARAM): For potentially better imputation results, please specify the
#>                 number of clusters (k). Currently estimating k using the
#>                 Tracy-Widom bound.
#> [Elapsed time: 31.54s] Clustering completed.
#> [Elapsed time: 41.47s] Dropouts identified.
#> [Elapsed time: 42.03s] Dropouts imputed.
```

## 3.7 Re-compute Adjusted Rand Index (ARI) with imputation.

```
# Recompute PCA reduction of the dataset
reducedDim(sce, "PCA_imputed") <- prcomp(t(assay(sce, "imputed")))$x

# Cluster the PCA reduced dataset and store the assignments
assgmts <- kmeans(reducedDim(sce, "PCA_imputed"), centers = k,
                    iter.max = 1e+09, nstart = 1000)$cluster

# Use ARI to compare the k-means assignments to label assignments
adjustedRandIndex(assgmts, colData(sce)$cell_id)
#> [1] 0.9003329
```

# 4 ccImpute Algorithm Overview

![](data:image/png;base64...)

ccImpute’s takes the following steps:

**(1) Input:** ccImpute starts with
a log-normalized expression matrix.

**(2) Distance calculation:** Next,
ccImpute first computes the weighted Spearman distance between all the cells in
the data.

**(3) Dimensionality reduction:** This is followed by a single
value decomposition (SVD) to reduce the distance matrix to the top \(l\) most
informative singular vectors (typically \(l = 0.08 \times min(n,2000)\)).

**(4) Clustering:** The algorithm then runs multiple instances of the
k-means clustering algorithm in parallel (default: eight runs) on different
subsets of these singular vectors with the results form to create a consensus
matrix.

**(5) Dropout identification:** Using the consensus matrix and modified
expression matrix, ccImpute identifies the most likely dropout events that need
imputed.

**(6) Imputation:** Finally, ccImpute imputes the dropouts using a
weighted mean approach. It considers the influence of surrounding values,
assigning them weights from the consensus matrix. There are two options for
handling dropout values: either they are included in the weighting calculation
(Method I-II), or their influence is deliberately skipped (Method III).

# 5 Key Analytical Choices

In the preceding section, we utilized the ccImpute method by providing only one
argument: the SingleCellExperiment object containing the scRNA-seq data.
Nevertheless, numerous parameters can be explicitly specified instead of
relying on default values. Here, we present the invocation of the ccImpute
method, including all the parameters with default values assigned:

```
ccImpute(sce, dist, nCeil = 2000, svdMaxRatio = 0.08,
            maxSets = 8, k, consMin=0.75, kmNStart, kmMax=1000,
            fastSolver = TRUE, BPPARAM=bpparam(), verbose = TRUE)
```

This function can be decomposed into a series of steps, providing finer control
over the execution of the ccImpute algorithm:

```
cores <- 2
BPPARAM = MulticoreParam(cores)

w <- rowVars_fast(logcounts(sce), cores)
corMat <- getCorM("spearman", logcounts(sce), w, cores)

v <- doSVD(corMat, svdMaxRatio=.08, nCeil=2000, nCores=cores)

consMtx <- runKM(logX, v, maxSets = 8, k, consMin=0.75, kmNStart, kmMax=1000,
                    BPPARAM=bpparam())

dropIds <- findDropouts(logX, consMtx)

iLogX <- computeDropouts(consMtx, logX, dropIds,
                            fastSolver=TRUE, nCores=cores)
assay(sce, "imputed") <- iLogX
```

In the following sections, we will examine these parameters in more detail and
clarify their influence on the imputation performance. For a detailed
description of each input argument, please consult the reference manual.

## 5.1 Distance/Similarity Measures

By default, if the dist parameter is not specified in the ccImpute function,
the ccImpute algorithm employs a weighted Spearman correlation measure between
cells, with weights corresponding to gene variances. However, any distance or
correlation matrix can be utilized for this parameter. Furthermore, the package
provides the getCorM function, which can efficiently compute correlations and
weighted correlations. Here is an example of using this method to compute
Pearson correlation in parallel using 2 cores:

```
corMat <- getCorM("pearson", logcounts(sce), nCores=2)
```

## 5.2 Singular Value Decomposition (SVD)

In the singular value decomposition step that follows the computing of the
distance matrix, the \(nCeil\) parameter specifies the maximum number of cells
used to compute the range of top singular vectors. The number of singular
vectors used in clustering runs is in
\([.5N \times svdMaxRatio, N \times svdMaxRatio]\). However, with high enough N,
the imputation performance drops due to increased noise that is introduced.
Experimental data suggest that parameters \(NCeil = 2000\), and
\(svdMaxRatio = 0.08\) results in optimal performance. However, different values
may work better depending on the distance measure used and how other
parameters are modified.

## 5.3 Clustering: k, kmMaxIter, kmNStart

The clustering step employs the k-means algorithm, which requires choosing the
number of clusters (k), the maximum number of iterations (kmMaxIter), and the
number of times the algorithm is repeated (kmNStart). Ideally, k should match
the actual number of cell types in the dataset. However, overestimating k can
still result in good imputation quality. If k is not specified, it is estimated
using the Tracy-Widom bound but should be reviewed for correctness.

kmMaxIter sets the maximum iterations for each k-means run and defaults
to 1000. kmNStart determines how many times the k-means algorithm is repeated.
Repetition allows for different initial cluster selections, which can improve
clustering quality. K-means is sensitive to initial centroid choices, typically
random data points, and repetition mitigates the risk of suboptimal results.
If kmNStart is not set, k-means runs \(1000\) times for \(N <= 2000\) and \(50\)
times otherwise.

The bpparam parameter controls parallel execution within this package,
leveraging the BiocParallel package’s capabilities. BiocParallel manages
parallel execution for k-means clustering and determines the number of cores
available for subsequent computations using the openMP library
(if ccImpute function is used) or a user-specified value. It’s recommended to
set the number of cores parameters to match the number of physical cores on
your system for optimal performance.
This is an example of threaded parallel computation with 4 cores:

```
BPPARAM = MulticoreParam(4)
sce <- ccImpute(sce, BPPARAM = BPPARAM)
```

Additionally, using parallel and fast BLAS libraries linked to R can
significantly speed up the imputation. The RhpcBLASctl library allows you to
control the number of threads used by the BLAS library. For example, to use
4 cores:

```
library(RhpcBLASctl)
blas_set_num_threads(4)
```

# 6 Runtime Performance

![](data:image/png;base64...)

The latest release of ccImpute demonstrates substantial performance
improvements over its initial version, particularly when handling larger
datasets. To quantify these enhancements, we measured runtime (RT) in minutes
across various combinations of processing cores and dataset sizes
(denoted by n).

A heatmap visualization reveals that runtime is indicated by red shades, with
lighter shades signifying faster performance. The benchmark was conducted on a
system equipped with an Intel Xeon Platinum 8268 24-core CPU, 1.5 TB of RAM,
and utilized R 4.3.3 with OpenBlas v0.3.20 (pthread variant).

The results unequivocally demonstrate that the current release of ccImpute
significantly outperforms its predecessor, especially with larger datasets.
This performance gain is consistent across all tested core configurations,
underscoring the effectiveness of the enhancements in optimizing ccImpute for
practical, real-world applications.

# 7 R session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-29
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package              * version   date (UTC) lib source
#>  abind                  1.4-8     2024-09-12 [2] CRAN (R 4.5.1)
#>  alabaster.base         1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  alabaster.matrix       1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  alabaster.ranges       1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  alabaster.sce          1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  alabaster.schemas      1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  alabaster.se           1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  AnnotationDbi          1.72.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  AnnotationFilter       1.34.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  AnnotationHub          4.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  beachmat               2.26.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  beeswarm               0.4.0     2021-06-01 [2] CRAN (R 4.5.1)
#>  Biobase              * 2.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocFileCache          3.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocIO                 1.20.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26   2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocNeighbors          2.4.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocParallel         * 1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocSingular           1.26.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle            * 2.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocVersion            3.22.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings             2.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                    4.6.0     2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                  4.6.0-1   2025-01-16 [2] CRAN (R 4.5.1)
#>  bitops                 1.0-9     2024-10-03 [2] CRAN (R 4.5.1)
#>  blob                   1.2.4     2023-03-17 [2] CRAN (R 4.5.1)
#>  bookdown               0.45      2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0     2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0     2024-05-16 [2] CRAN (R 4.5.1)
#>  ccImpute             * 1.12.0    2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  cigarillo              1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  cli                    3.6.5     2025-04-23 [2] CRAN (R 4.5.1)
#>  codetools              0.2-20    2024-03-31 [3] CRAN (R 4.5.1)
#>  crayon                 1.5.3     2024-06-20 [2] CRAN (R 4.5.1)
#>  curl                   7.0.0     2025-08-19 [2] CRAN (R 4.5.1)
#>  DBI                    1.2.3     2024-06-02 [2] CRAN (R 4.5.1)
#>  dbplyr                 2.5.1     2025-09-10 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  dichromat              2.0-0.1   2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37    2024-08-19 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
#>  ensembldb              2.34.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  evaluate               1.0.5     2025-08-27 [2] CRAN (R 4.5.1)
#>  ExperimentHub          3.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  farver                 2.1.2     2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
#>  filelock               1.0.3     2023-12-11 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomeInfoDb           1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicAlignments      1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicFeatures        1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicRanges        * 1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  ggbeeswarm             0.7.2     2023-04-29 [2] CRAN (R 4.5.1)
#>  ggplot2              * 4.0.0     2025-09-11 [2] CRAN (R 4.5.1)
#>  ggrepel                0.9.6     2024-09-07 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0     2024-09-30 [2] CRAN (R 4.5.1)
#>  gridExtra              2.3       2017-09-09 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6     2024-10-25 [2] CRAN (R 4.5.1)
#>  gypsum                 1.6.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  h5mread                1.2.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  HDF5Array              1.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  htmltools              0.5.8.1   2024-04-04 [2] CRAN (R 4.5.1)
#>  httr                   1.4.7     2023-08-15 [2] CRAN (R 4.5.1)
#>  httr2                  1.2.1     2025-07-22 [2] CRAN (R 4.5.1)
#>  IRanges              * 2.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  irlba                  2.3.5.1   2022-10-03 [2] CRAN (R 4.5.1)
#>  jquerylib              0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
#>  KEGGREST               1.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  knitr                  1.50      2025-03-16 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
#>  lazyeval               0.2.2     2019-03-15 [2] CRAN (R 4.5.1)
#>  lifecycle              1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4     2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4     2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics       * 1.22.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats          * 1.5.0     2025-01-07 [2] CRAN (R 4.5.1)
#>  mclust               * 6.1.1     2024-04-29 [2] CRAN (R 4.5.1)
#>  memoise                2.0.1     2021-11-26 [2] CRAN (R 4.5.1)
#>  pillar                 1.11.1    2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3     2019-09-22 [2] CRAN (R 4.5.1)
#>  png                    0.1-8     2022-11-29 [2] CRAN (R 4.5.1)
#>  ProtGenerics           1.42.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  R6                     2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
#>  rappdirs               0.3.3     2021-01-31 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3     2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
#>  RCurl                  1.98-1.17 2025-03-22 [2] CRAN (R 4.5.1)
#>  restfulr               0.0.16    2025-06-27 [2] CRAN (R 4.5.1)
#>  rhdf5                  2.54.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  rhdf5filters           1.22.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Rhdf5lib               1.32.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  rjson                  0.2.23    2024-09-16 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30      2025-09-28 [2] CRAN (R 4.5.1)
#>  Rsamtools              2.26.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  RSQLite                2.4.3     2025-08-20 [2] CRAN (R 4.5.1)
#>  rsvd                   1.0.5     2021-04-16 [2] CRAN (R 4.5.1)
#>  rtracklayer            1.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Arrays               1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0     2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10    2025-04-11 [2] CRAN (R 4.5.1)
#>  ScaledMatrix           1.18.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  scales                 1.4.0     2025-04-24 [2] CRAN (R 4.5.1)
#>  scater               * 1.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  scRNAseq             * 2.23.1    2025-10-28 [2] Bioconductor 3.22 (R 4.5.1)
#>  scuttle              * 1.20.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Seqinfo              * 1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo          * 1.2.3     2025-02-05 [2] CRAN (R 4.5.1)
#>  SingleCellExperiment * 1.32.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  SparseArray            1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sparseMatrixStats      1.22.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  SummarizedExperiment * 1.40.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble                 3.3.0     2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1     2024-03-11 [2] CRAN (R 4.5.1)
#>  UCSC.utils             1.6.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  vctrs                  0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
#>  vipor                  0.4.7     2023-12-18 [2] CRAN (R 4.5.1)
#>  viridis                0.6.5     2024-01-29 [2] CRAN (R 4.5.1)
#>  viridisLite            0.4.2     2023-05-02 [2] CRAN (R 4.5.1)
#>  withr                  3.0.2     2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                   0.53      2025-08-19 [2] CRAN (R 4.5.1)
#>  XML                    3.99-0.19 2025-08-22 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10    2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpeBqBJb/Rinst37a58386179fe
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# References

Malec, Marcin, Hasan Kurban, and Mehmet Dalkilic. 2022. “CcImpute: An Accurate and Scalable Consensus Clustering Based Algorithm to Impute Dropout Events in the Single-Cell Rna-Seq Data.” *BMC Bioinformatics* 23 (1): 1–17.

Usoskin, Dmitry, Alessandro Furlan, Saiful Islam, Hind Abdo, Peter Lönnerberg, Daohua Lou, Jens Hjerling-Leffler, et al. 2015. “Unbiased Classification of Sensory Neuron Types by Large-Scale Single-Cell Rna Sequencing.” *Nature Neuroscience* 18 (1): 145–53.