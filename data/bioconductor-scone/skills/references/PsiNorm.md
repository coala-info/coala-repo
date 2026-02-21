# PsiNorm: a scalable normalization for single-cellRNA-seq data

Matteo Borella, Chiara Romualdi, and Davide Risso

Department of Biology and Department of Statistical Sciences, University of Padova

#### Last modified: April 13, 2021; Compiled: October 30, 2025

# Contents

* [1 Introduction](#introduction)
* [2 Citation](#citation)
* [3 Data Simulation](#data-simulation)
* [4 PsiNorm data normalization](#psinorm-data-normalization)
* [5 Data Normalization with PsiNorm](#data-normalization-with-psinorm)
  + [5.1 Unsupervised approach: Adusted Rand Index](#unsupervised-approach-adusted-rand-index)
* [6 Supervised approach: Silhouette index](#supervised-approach-silhouette-index)
* [7 Correlation of PC1 and PC2 with sequencing depth](#correlation-of-pc1-and-pc2-with-sequencing-depth)
* [8 Using PsiNorm in `scone()`](#using-psinorm-in-scone)
* [9 Using PsiNorm with Seurat](#using-psinorm-with-seurat)
* [10 Using PsiNorm with HDF5 files](#using-psinorm-with-hdf5-files)
* [11 Session Information](#session-information)

# 1 Introduction

```
library(SingleCellExperiment)
library(splatter)
library(scater)
library(cluster)
library(scone)
```

PsiNorm is a scalable between-sample normalization for single cell RNA-seq count data based on the power-law Pareto type I distribution. It can be demonstrated that the Pareto parameter is inversely proportional to the sequencing depth, it is sample specific and its estimate can be obtained for each cell independently. PsiNorm computes the shape parameter for each cellular sample and then uses it as multiplicative size factor to normalize the data. The final goal of the transformation is to align the gene expression distribution especially for those genes characterised by high expression. Note that, similar to other global scaling methods, our method does not remove batch effects, which can be dealt with downstream tools.

To evaluate the ability of PsiNorm to remove technical bias and reveal the true cell similarity structure, we used both an unsupervised and a supervised approach.
We first simulate a scRNA-seq experiment with four known clusters using the *splatter* Bioconductor package. Then in the unsupervised approach, we i) reduce dimentionality using PCA, ii) identify clusters using the *clara* partitional method and then we iii) computed the Adjusted Rand Index (ARI) to compare the known and the estimated partition.

In the supervised approach, we i) reduce dimentionality using PCA, and we ii) compute the silhouette index of the known partition in the reduced dimensional space.

# 2 Citation

If you use `PsiNorm` in publications, please cite the following article:

Borella, M., Martello, G., Risso, D., & Romualdi, C. (2021). PsiNorm: a scalable normalization for single-cell RNA-seq data. bioRxiv. <https://doi.org/10.1101/2021.04.07.438822>.

# 3 Data Simulation

We simulate a matrix of counts with 2000 cellular samples and 10000 genes with splatter.

```
set.seed(1234)
params <- newSplatParams()
N=2000
sce <- splatSimulateGroups(params, batchCells=N, lib.loc=12,
                           group.prob = rep(0.25,4),
                           de.prob = 0.2, de.facLoc = 0.06,
                           verbose = FALSE)
```

`sce` is a SingleCellExperiment object with a single batch and four different cellular groups.

To visualize the data we used the first two Principal Components estimated starting from the raw log-count matrix.

```
set.seed(1234)
assay(sce, "lograwcounts") <- log1p(counts(sce))
sce <- runPCA(sce, exprs_values="lograwcounts", scale=TRUE, ncomponents = 2)
plotPCA(sce, colour_by="Group")
```

![](data:image/png;base64...)

# 4 PsiNorm data normalization

# 5 Data Normalization with PsiNorm

To normalize the raw counts we used the PsiNorm normalization and we visualized the data using the first two principal components.

```
sce<-PsiNorm(sce)
sce<-logNormCounts(sce)
head(sizeFactors(sce))
#>     Cell1     Cell2     Cell3     Cell4     Cell5     Cell6
#> 1.1017454 0.9667386 1.0169251 0.9343382 1.0966308 1.1845135
```

Note that running the `PsiNorm` function computes a set of size factors that are added to the SingleCellExperiment object.

The `logNormCounts` function can be then used to normalize the data by multiplying the raw counts and the size factors.

```
set.seed(1234)
sce<-runPCA(sce, exprs_values="logcounts", scale=TRUE, name = "PsiNorm_PCA",
            ncomponents = 2)
plotReducedDim(sce, dimred = "PsiNorm_PCA", colour_by = "Group")
```

![](data:image/png;base64...)

We can appreciate from the plot that PsiNorm allows a better separation among known cellular groups.

## 5.1 Unsupervised approach: Adusted Rand Index

We calculate ARI of both raw counts and PsiNorm normalized counts after PCA dimension reduction and \(clara\) clustering (with \(k\) equal to the simulated number of clusters); higher the ARI, better the normalization.

```
groups<-cluster::clara(reducedDim(sce, "PCA"), k=nlevels(sce$Group))
a<-paste("ARI from raw counts:",
         round(mclust::adjustedRandIndex(groups$clustering, sce$Group),
               digits = 3))

groups<-cluster::clara(reducedDim(sce, "PsiNorm_PCA"), k=nlevels(sce$Group))
b<-paste("ARI from PsiNorm normalized data:",
         round(mclust::adjustedRandIndex(groups$clustering, sce$Group),
               digits = 3))

kableExtra::kable(rbind(a,b), row.names = FALSE)
```

|  |
| --- |
| ARI from raw counts: 0.295 |
| ARI from PsiNorm normalized data: 0.788 |

Pareto normalization considerably increases the ARI index.

# 6 Supervised approach: Silhouette index

We calculate the Silhouette index of both raw counts and PsiNorm normalized counts after tSNE dimension reduction exploiting known simulated clusters; higher the Silhouette, better the normalization.

```
dist<-daisy(reducedDim(sce, "PCA"))
dist<-as.matrix(dist)
a<-paste("Silhouette from raw counts:", round(summary(
    silhouette(x=as.numeric(as.factor(sce$Group)),
               dmatrix = dist))$avg.width, digits = 3))

dist<-daisy(reducedDim(sce, "PsiNorm_PCA"))
dist<-as.matrix(dist)
b<-paste("Silhouette from PsiNorm normalized data:", round(summary(
    silhouette(x=as.numeric(as.factor(sce$Group)),
               dmatrix = dist))$avg.width, digits = 3))
kableExtra::kable(rbind(a,b), row.names = FALSE)
```

|  |
| --- |
| Silhouette from raw counts: 0.168 |
| Silhouette from PsiNorm normalized data: 0.534 |

Pareto normalization considerably increases the Silhouette index.

# 7 Correlation of PC1 and PC2 with sequencing depth

To check if PsiNorm is able to capture technical noise and remove unwanted variation within a dataset (due for instance to differences in sequencing depth), we check whether the first two PCs are capturing technical variance. We computed the maximum correlation obtained between PC1 and PC2 and cell sequencing depths; a higher correlation indicates that the normalization was not able to properly remove noise.

```
set.seed(4444)
PCA<-reducedDim(sce, "PCA")
PCAp<-reducedDim(sce, "PsiNorm_PCA")
depth<-apply(counts(sce), 2, sum)
a<-paste("The Correlation with the raw data is:",
            round(abs(max(cor(PCA[,1], depth), cor(PCA[,2], depth))), digits=3))
b<-paste("The Correlation with the PsiNorm normalized data is:",
            round(abs(max(cor(PCAp[,1], depth), cor(PCAp[,2], depth))), digits = 3))
kableExtra::kable(rbind(a,b), row.names = FALSE)
```

|  |
| --- |
| The Correlation with the raw data is: 0.269 |
| The Correlation with the PsiNorm normalized data is: 0.189 |

Our results demonstrate that the correlation significantly decreases after the PsiNorm normalization.

# 8 Using PsiNorm in `scone()`

As for other normalizations, `scone` includes a wrapper function to use PsiNorm in the SCONE evaluation framework.
See Section 3.2 of the “Introduction to SCONE” vignette for an example on how to use PsiNorm within the main `scone()` function.

# 9 Using PsiNorm with Seurat

The PsiNorm normalization method can be used as a replacement for Seurat’s default normalization methods. To do so, we need to first normalize the data stored in a `SingleCellExperiment` object and then coerce that object to a Seurat object. This can be done with the `as.Seurat` function provided in the `Seurat` package (tested with Seurat 4.0.3).

```
library(Seurat)
sce <- PsiNorm(sce)
sce <- logNormCounts(sce)
seu <- as.Seurat(sce)
```

From this point on, one can continue the analysis with the recommended Seurat workflow, but using PsiNorm log-normalized data.

# 10 Using PsiNorm with HDF5 files

Thanks to the `HDF5Array` and `DelayedArray` packages, PsiNorm can be applied directly to HDF5-backed matrices without the need for the user to change the code. As an example, we use a dataset from the `TENxPBMCData` package, which provides several SingleCellExperiment objects with HDF5-backed matrices as their assays.

```
library(TENxPBMCData)

sce <- TENxPBMCData("pbmc4k")
sce
#> class: SingleCellExperiment
#> dim: 33694 4340
#> metadata(0):
#> assays(1): counts
#> rownames(33694): ENSG00000243485 ENSG00000237613 ... ENSG00000277475
#>   ENSG00000268674
#> rowData names(3): ENSEMBL_ID Symbol_TENx Symbol
#> colnames: NULL
#> colData names(11): Sample Barcode ... Individual Date_published
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
```

In particular, we use the `pbmc4k` dataset that contains about 4,000 PBMCs from a healthy donor.

The `counts` assay of this object is a `DelayedMatrix` backed by a HDF5 file. Hence, the data are store on disk (out of memory).

```
counts(sce)
#> <33694 x 4340> sparse DelayedMatrix object of type "integer":
#>                    [,1]    [,2]    [,3]    [,4] ... [,4337] [,4338] [,4339]
#> ENSG00000243485       0       0       0       0   .       0       0       0
#> ENSG00000237613       0       0       0       0   .       0       0       0
#> ENSG00000186092       0       0       0       0   .       0       0       0
#> ENSG00000238009       0       0       0       0   .       0       0       0
#> ENSG00000239945       0       0       0       0   .       0       0       0
#>             ...       .       .       .       .   .       .       .       .
#> ENSG00000277856       0       0       0       0   .       0       0       0
#> ENSG00000275063       0       0       0       0   .       0       0       0
#> ENSG00000271254       0       0       0       0   .       0       0       0
#> ENSG00000277475       0       0       0       0   .       0       0       0
#> ENSG00000268674       0       0       0       0   .       0       0       0
#>                 [,4340]
#> ENSG00000243485       0
#> ENSG00000237613       0
#> ENSG00000186092       0
#> ENSG00000238009       0
#> ENSG00000239945       0
#>             ...       .
#> ENSG00000277856       0
#> ENSG00000275063       0
#> ENSG00000271254       0
#> ENSG00000277475       0
#> ENSG00000268674       0
seed(counts(sce))
#> An object of class "HDF5ArraySeed"
#> Slot "filepath":
#> [1] "/home/biocbuild/.cache/R/ExperimentHub/3f46ed75d27b9e_1611"
#>
#> Slot "name":
#> [1] "/counts"
#>
#> Slot "as_sparse":
#> [1] TRUE
#>
#> Slot "type":
#> [1] NA
#>
#> Slot "dim":
#> [1] 33694  4340
#>
#> Slot "chunkdim":
#> [1] 512  66
#>
#> Slot "first_val":
#> [1] 0
```

Thanks to the `DelayedArray` framework, we can apply PsiNorm using the same code that we have used in the case of in-memory data.

```
sce<-PsiNorm(sce)
sce<-logNormCounts(sce)
sce
#> class: SingleCellExperiment
#> dim: 33694 4340
#> metadata(0):
#> assays(2): counts logcounts
#> rownames(33694): ENSG00000243485 ENSG00000237613 ... ENSG00000277475
#>   ENSG00000268674
#> rowData names(3): ENSEMBL_ID Symbol_TENx Symbol
#> colnames: NULL
#> colData names(12): Sample Barcode ... Date_published sizeFactor
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
```

Note that `logNormCounts` is a delayed operation, meaning that the actual log-normalized values will be computed only when needed by the user. In other words, the data are still stored out-of-memory as the original count matrix and the log-normalized data will be computed only when `logcounts(sce)` is realized into memory.

```
seed(logcounts(sce))
#> An object of class "HDF5ArraySeed"
#> Slot "filepath":
#> [1] "/home/biocbuild/.cache/R/ExperimentHub/3f46ed75d27b9e_1611"
#>
#> Slot "name":
#> [1] "/counts"
#>
#> Slot "as_sparse":
#> [1] TRUE
#>
#> Slot "type":
#> [1] NA
#>
#> Slot "dim":
#> [1] 33694  4340
#>
#> Slot "chunkdim":
#> [1] 512  66
#>
#> Slot "first_val":
#> [1] 0
```

# 11 Session Information

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
#>  [1] TENxPBMCData_1.27.0         HDF5Array_1.38.0
#>  [3] h5mread_1.2.0               rhdf5_2.54.0
#>  [5] DelayedArray_0.36.0         SparseArray_1.10.0
#>  [7] S4Arrays_1.10.0             abind_1.4-8
#>  [9] Matrix_1.7-4                scone_1.34.0
#> [11] cluster_2.1.8.1             scater_1.38.0
#> [13] ggplot2_4.0.0               scuttle_1.20.0
#> [15] splatter_1.34.0             SingleCellExperiment_1.32.0
#> [17] SummarizedExperiment_1.40.0 Biobase_2.70.0
#> [19] GenomicRanges_1.62.0        Seqinfo_1.0.0
#> [21] IRanges_2.44.0              S4Vectors_0.48.0
#> [23] BiocGenerics_0.56.0         generics_0.1.4
#> [25] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [27] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] splines_4.5.1             BiocIO_1.20.0
#>   [3] bitops_1.0-9              filelock_1.0.3
#>   [5] tibble_3.3.0              R.oo_1.27.1
#>   [7] XML_3.99-0.19             lifecycle_1.0.4
#>   [9] httr2_1.2.1               pwalign_1.6.0
#>  [11] edgeR_4.8.0               lattice_0.22-7
#>  [13] prabclus_2.3-4            MASS_7.3-65
#>  [15] backports_1.5.0           magrittr_2.0.4
#>  [17] plotly_4.11.0             limma_3.66.0
#>  [19] sass_0.4.10               rmarkdown_2.30
#>  [21] jquerylib_0.1.4           yaml_2.3.10
#>  [23] flexmix_2.3-20            cowplot_1.2.0
#>  [25] bayesm_3.1-6              DBI_1.2.3
#>  [27] RColorBrewer_1.1-3        ShortRead_1.68.0
#>  [29] purrr_1.1.0               mixtools_2.0.0.1
#>  [31] R.utils_2.13.0            RCurl_1.98-1.17
#>  [33] nnet_7.3-20               tensorA_0.36.2.1
#>  [35] rappdirs_0.3.3            ggrepel_0.9.6
#>  [37] irlba_2.3.5.1             RSpectra_0.16-2
#>  [39] svglite_2.2.2             DelayedMatrixStats_1.32.0
#>  [41] codetools_0.2-20          xml2_1.4.1
#>  [43] tidyselect_1.2.1          farver_2.1.2
#>  [45] ScaledMatrix_1.18.0       viridis_0.6.5
#>  [47] BiocFileCache_3.0.0       GenomicAlignments_1.46.0
#>  [49] jsonlite_2.0.0            BiocNeighbors_2.4.0
#>  [51] survival_3.8-3            systemfonts_1.3.1
#>  [53] segmented_2.1-4           tools_4.5.1
#>  [55] progress_1.2.3            rARPACK_0.11-0
#>  [57] Rcpp_1.1.0                glue_1.8.0
#>  [59] gridExtra_2.3             xfun_0.53
#>  [61] dplyr_1.1.4               withr_3.0.2
#>  [63] BiocManager_1.30.26       fastmap_1.2.0
#>  [65] rhdf5filters_1.22.0       latticeExtra_0.6-31
#>  [67] boot_1.3-32               caTools_1.18.3
#>  [69] digest_0.6.37             rsvd_1.0.5
#>  [71] R6_2.6.1                  textshaping_1.0.4
#>  [73] gtools_3.9.5              jpeg_0.1-11
#>  [75] dichromat_2.0-0.1         biomaRt_2.66.0
#>  [77] RSQLite_2.4.3             cigarillo_1.0.0
#>  [79] diptest_0.77-2            R.methodsS3_1.8.2
#>  [81] tidyr_1.3.1               hexbin_1.28.5
#>  [83] data.table_1.17.8         rtracklayer_1.70.0
#>  [85] robustbase_0.99-6         class_7.3-23
#>  [87] htmlwidgets_1.6.4         prettyunits_1.2.0
#>  [89] httr_1.4.7                pkgconfig_2.0.3
#>  [91] gtable_0.3.6              modeltools_0.2-24
#>  [93] blob_1.2.4                S7_0.2.0
#>  [95] hwriter_1.3.2.1           XVector_0.50.0
#>  [97] htmltools_0.5.8.1         bookdown_0.45
#>  [99] kableExtra_1.4.0          scales_1.4.0
#> [101] png_0.1-8                 rstudioapi_0.17.1
#> [103] knitr_1.50                rjson_0.2.23
#> [105] nlme_3.1-168              checkmate_2.3.3
#> [107] curl_7.0.0                cachem_1.1.0
#> [109] stringr_1.5.2             BiocVersion_3.22.0
#> [111] KernSmooth_2.23-26        parallel_4.5.1
#> [113] vipor_0.4.7               RUVSeq_1.44.0
#> [115] AnnotationDbi_1.72.0      restfulr_0.0.16
#> [117] pillar_1.11.1             grid_4.5.1
#> [119] vctrs_0.6.5               gplots_3.2.0
#> [121] BiocSingular_1.26.0       dbplyr_2.5.1
#> [123] beachmat_2.26.0           beeswarm_0.4.0
#> [125] evaluate_1.0.5            magick_2.9.0
#> [127] tinytex_0.57              GenomicFeatures_1.62.0
#> [129] cli_3.6.5                 locfit_1.5-9.12
#> [131] compiler_4.5.1            Rsamtools_2.26.0
#> [133] rlang_1.1.6               crayon_1.5.3
#> [135] labeling_0.4.3            mclust_6.1.1
#> [137] interp_1.1-6              aroma.light_3.40.0
#> [139] ggbeeswarm_0.7.2          stringi_1.8.7
#> [141] viridisLite_0.4.2         deldir_2.0-4
#> [143] BiocParallel_1.44.0       Biostrings_2.78.0
#> [145] lazyeval_0.2.2            EDASeq_2.44.0
#> [147] compositions_2.0-9        ExperimentHub_3.0.0
#> [149] hms_1.1.4                 sparseMatrixStats_1.22.0
#> [151] bit64_4.6.0-1             Rhdf5lib_1.32.0
#> [153] KEGGREST_1.50.0           fpc_2.2-13
#> [155] statmod_1.5.1             AnnotationHub_4.0.0
#> [157] kernlab_0.9-33            memoise_2.0.1
#> [159] bslib_0.9.0               DEoptimR_1.1-4
#> [161] bit_4.6.0
```