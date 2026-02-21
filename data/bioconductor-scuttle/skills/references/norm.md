# Normalizing single-cell RNA-seq data

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: February 6, 2021

#### Package

scuttle 1.20.0

# 1 Introduction

*[scuttle](https://bioconductor.org/packages/3.22/scuttle)* provides various low-level utilities for single-cell RNA-seq data analysis,
typically used at the start of the analysis workflows or within high-level functions in other packages.
This vignette will discuss the use of scaling normalization for removing cell-specific biases.
To demonstrate, we will obtain the classic Zeisel dataset from the *[scRNAseq](https://bioconductor.org/packages/3.22/scRNAseq)* package
and apply some quick quality control to remove damaged cells.

```
library(scRNAseq)
sce <- ZeiselBrainData()

library(scuttle)
sce <- quickPerCellQC(sce, subsets=list(Mito=grep("mt-", rownames(sce))),
    sub.fields=c("subsets_Mito_percent", "altexps_ERCC_percent"))

sce
```

```
## class: SingleCellExperiment
## dim: 20006 2816
## metadata(0):
## assays(1): counts
## rownames(20006): Tspan12 Tshz1 ... mt-Rnr1 mt-Nd4l
## rowData names(1): featureType
## colnames(2816): 1772071015_C02 1772071017_G12 ... 1772063068_D01
##   1772066098_A12
## colData names(26): tissue group # ... high_altexps_ERCC_percent discard
## reducedDimNames(0):
## mainExpName: gene
## altExpNames(2): repeat ERCC
```

**Note:** A more comprehensive description of the use of *[scuttle](https://bioconductor.org/packages/3.22/scuttle)* functions
(along with other packages) in a scRNA-seq analysis workflow is available at <https://osca.bioconductor.org>.

# 2 Computing size factors

Scaling normalization involves dividing the counts for each cell by a cell-specific “size factor” to adjust for uninteresting differences in sequencing depth and capture efficiency.
The `librarySizeFactors()` function provides a simple definition of the size factor for each cell,
computed as the library size of each cell after scaling them to have a mean of 1 across all cells.
This is fast but inaccurate in the presence of differential expression between cells that introduce composition biases.

```
summary(librarySizeFactors(sce))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.1757  0.5680  0.8680  1.0000  1.2783  4.0839
```

The `geometricSizeFactors()` function instead computes the geometric mean within each cell.
This is more robust to composition biases but is only accurate when the counts are large and there are few zeroes.

```
summary(geometricSizeFactors(sce))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.8261  0.9104  0.9758  1.0000  1.0640  1.5189
```

The `medianSizeFactors()` function uses a *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*-esque approach based on the median ratio from an average pseudo-cell.
Briefly, we assume that most genes are non-DE, such that any systematic fold difference in coverage (as defined by the median ratio) represents technical biases that must be removed.
This is highly robust to composition biases but relies on sufficient sequencing coverage to obtain well-defined ratios.

```
summary(medianSizeFactors(sce))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's
##      NA      NA      NA     NaN      NA      NA    2816
```

All of these size factors can be stored in the `SingleCellExperiment` via the `sizeFactors<-()` setter function.
Most downstream functions will pick these up automatically for any calculations that rely on size factors.

```
sizeFactors(sce) <- librarySizeFactors(sce)
```

Alternatively, functions like `computeLibraryFactors()` can automatically compute and attach the size factors to our `SingleCellExperiment` object.

```
sce <- computeLibraryFactors(sce)
summary(sizeFactors(sce))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.1757  0.5680  0.8680  1.0000  1.2783  4.0839
```

# 3 Pooling normalization

The `computePooledFactors` method implements the [pooling strategy for scaling normalization](https://doi.org/10.1186/s13059-016-0947-7).
This uses an approach similar to `medianSizeFactors()` to remove composition biases,
but pools cells together to overcome problems with discreteness at low counts.
Per-cell factors are then obtained from the pools using a deconvolution strategy.

```
library(scran)
clusters <- quickCluster(sce)

sce <- computePooledFactors(sce, clusters=clusters)
summary(sizeFactors(sce))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.1340  0.4910  0.8281  1.0000  1.3181  4.4579
```

For larger data sets, a rough clustering should be performed prior to normalization.
`computePooledFactors()` will then automatically apply normalization within each cluster first, before adjusting the scaling factors to be comparable across clusters.
This reduces the risk of violating our assumptions (of a non-DE majority of genes) when many genes are DE between clusters in a heterogeneous population.
In this case, we use the `quickCluster()` function from the *[scran](https://bioconductor.org/packages/3.22/scran)* package, but any clustering function can be used, for example:

```
sce <- computePooledFactors(sce, clusters=sce$level1class)
summary(sizeFactors(sce))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.1322  0.4797  0.8265  1.0000  1.3355  4.4953
```

We assume that quality control on the cells has already been performed prior to running this function.
Low-quality cells with few expressed genes can often have negative size factor estimates.

# 4 Spike-in normalization

An alternative approach is to normalize based on the spike-in counts.
The idea is that the same quantity of spike-in RNA was added to each cell prior to library preparation.
Size factors are computed to scale the counts such that the total coverage of the spike-in transcripts is equal across cells.

```
sce2 <- computeSpikeFactors(sce, "ERCC")
summary(sizeFactors(sce2))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.1600  0.7746  0.9971  1.0000  1.1851  3.4923
```

The main practical difference from the other strategies is that spike-in normalization preserves differences in total RNA content between cells, whereas `computePooledFactors` and other non-DE methods do not.
This can be important in certain applications where changes in total RNA content are associated with a biological phenomenon of interest.

# 5 Computing normalized expression matrices

Regardless of which size factor calculation we pick, the calculation of normalized expression values simply involves dividing each count by the size factor for the cell.
This eliminates the cell-specific scaling effect for valid comparisons between cells in downstream analyses.
The simplest approach to computing these values is to use the `logNormCounts()` function:

```
sce <- logNormCounts(sce)
assayNames(sce)
```

```
## [1] "counts"    "logcounts"
```

This computes log2-transformed normalized expression values by adding a constant pseudo-count and log-transforming.
The resulting values can be roughly interpreted on the same scale as log-transformed counts and are stored in `"logcounts"`.
This is the most common expression measure for downstream analyses as differences between values can be treated as log-fold changes.
For example, Euclidean distances between cells are analogous to the average log-fold change across genes.

Of course, users can construct any arbitrary matrix of the same dimensions as the count matrix and store it as an assay.
Here, we use the `normalizeCounts()` function to perform some custom normalization with random size factors.

```
assay(sce, "normed") <- normalizeCounts(sce, log=FALSE,
    size.factors=runif(ncol(sce)), pseudo.count=1.5)
```

*[scuttle](https://bioconductor.org/packages/3.22/scuttle)* can also calculate counts-per-million using the aptly-named `calculateCPM()` function.
The output is most appropriately stored as an assay named `"cpm"` in the assays of the `SingleCellExperiment` object.
Related functions include `calculateTPM()` and `calculateFPKM()`, which do pretty much as advertised.

```
assay(sce, "cpm") <- calculateCPM(sce)
```

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