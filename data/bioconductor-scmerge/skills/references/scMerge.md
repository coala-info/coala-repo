# An introduction to the scMerge package

Yingxin Lin1 and Kevin Y.X. Wang1

1School of Mathematics and Statistics, The University of Sydney, Australia

#### 30 October 2025

#### Package

BiocStyle 2.38.0

# 1 Introduction

The scMerge algorithm allows batch effect removal and normalisation for single cell RNA-Seq data. It comprises of three key components including:

1. The identification of stably expressed genes (SEGs) as “negative controls” for estimating unwanted factors;
2. The construction of pseudo-replicates to estimate the effects of unwanted factors; and
3. The adjustment of the datasets with unwanted variation using a fastRUVIII model.

The purpose of this vignette is to illustrate some uses of `scMerge` and explain its key components.

# 2 Loading Packages and Data

We will load the `scMerge` package. We designed our package to be consistent with the popular BioConductor’s single cell analysis framework, namely the `SingleCellExperiment` and `scater` package.

```
suppressPackageStartupMessages({
  library(SingleCellExperiment)
  library(scMerge)
  library(scater)
  })
```

We provided an illustrative mouse embryonic stem cell (mESC) data in our package, as well as a set of pre-computed stably expressed gene (SEG) list to be used as negative control genes.

The full curated, unnormalised mESC data can be found [here](http://www.maths.usyd.edu.au/u/yingxinl/wwwnb/scMergeData/sce_mESC.rda). The `scMerge` package comes with a sub-sampled, two-batches version of this data (named “batch2” and “batch3” to be consistent with the full data) .

```
## Subsetted mouse ESC data
data("example_sce", package = "scMerge")
```

In this mESC data, we pooled data from 2 different batches from three different cell types. Using a PCA plot, we can see that despite strong separation of cell types, there is also a strong separation due to batch effects. This information is stored in the `colData` of `example_sce`.

```
example_sce = runPCA(example_sce, exprs_values = "logcounts")

scater::plotPCA(
  example_sce,
  colour_by = "cellTypes",
  shape_by = "batch")
```

![](data:image/png;base64...)

# 3 Illustrating pseudo-replicates constructions

The first major component of `scMerge` is to obtain negative controls for our normalisation. In this vignette, we will be using a set of pre-computed SEGs from a single cell mouse data made available through the `segList_ensemblGeneID` data in our package. For more information about the selection of negative controls and SEGs, please see Section [select SEGs](#selectnc).

```
## single-cell stably expressed gene list
data("segList_ensemblGeneID", package = "scMerge")
head(segList_ensemblGeneID$mouse$mouse_scSEG)
#> [1] "ENSMUSG00000058835" "ENSMUSG00000026842" "ENSMUSG00000027671"
#> [4] "ENSMUSG00000020152" "ENSMUSG00000054693" "ENSMUSG00000049470"
```

The second major component of `scMerge` is to compute pseudo-replicates for cells so we can perform normalisation. We offer three major ways of computing this pseudo-replicate information:

1. Unsupervised clustering, using k-means clustering;
2. Supervised clustering, using known cell type information; and
3. Semi-supervised clustering, using partially known cell type information.

# 4 Unsupervised `scMerge`

In unsupervised `scMerge`, we will perform a k-means clustering to obtain pseudo-replicates. This requires the users to supply a `kmeansK` vector with each element indicating number of clusters in each of the batches. For example, we know “batch2” and “batch3” both contain three cell types. Hence, `kmeansK = c(3, 3)` in this case.

```
scMerge_unsupervised <- scMerge(
  sce_combine = example_sce,
  ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
  kmeansK = c(3, 3),
  assay_name = "scMerge_unsupervised")
#> Step 2: Performing RUV normalisation. This will take minutes to hours.
#> scMerge complete!
```

We now colour construct the PCA plot again on our normalised data. We can observe a much better separation by cell type and less separation by batches.

```
scMerge_unsupervised = runPCA(scMerge_unsupervised, exprs_values = "scMerge_unsupervised")
scater::plotPCA(
  scMerge_unsupervised,
  colour_by = "cellTypes",
  shape_by = "batch")
```

![](data:image/png;base64...)

# 5 Selecting all cells

By default, `scMerge` only uses 50% of the cells to perform kmeans clustering. While this is sufficient to perform a satisfactory normalisation in most cases, users can control if they wish all cells be used in the kmeans clustering.

```
scMerge_unsupervised_all <- scMerge(
  sce_combine = example_sce,
  ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
  kmeansK = c(3, 3),
  assay_name = "scMerge_unsupervised_all",
  replicate_prop = 1)
#> Step 2: Performing RUV normalisation. This will take minutes to hours.
#> scMerge complete!
```

```
scMerge_unsupervised_all = runPCA(scMerge_unsupervised_all,
                                  exprs_values = "scMerge_unsupervised_all")

scater::plotPCA(
  scMerge_unsupervised_all,
  colour_by = "cellTypes",
  shape_by = "batch")
```

![](data:image/png;base64...)

# 6 Supervised `scMerge`

If **all** cell type information is available to the user, then it is possible to use this information to create pseudo-replicates. This can be done through the `cell_type` argument in the `scMerge` function.

```
scMerge_supervised <- scMerge(
  sce_combine = example_sce,
  ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
  kmeansK = c(3, 3),
  assay_name = "scMerge_supervised",
  cell_type = example_sce$cellTypes)
#> Step 2: Performing RUV normalisation. This will take minutes to hours.
#> scMerge complete!
```

```
scMerge_supervised = runPCA(scMerge_supervised,
                            exprs_values = "scMerge_supervised")

scater::plotPCA(
  scMerge_supervised,
  colour_by = "cellTypes",
  shape_by = "batch")
```

![](data:image/png;base64...)

# 7 Semi-supervised scMerge I

If the user is only able to access **partial** cell type information, then it is still possible to use this information to create pseudo-replicates. This can be done through the `cell_type` and `cell_type_inc` arguments in the `scMerge` function. `cell_type_inc` should contain a vector of indices indicating which elements in the `cell_type` vector should be used to perform semi-supervised scMerge.

```
scMerge_semisupervised1 <- scMerge(
  sce_combine = example_sce,
  ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
  kmeansK = c(3,3),
  assay_name = "scMerge_semisupervised1",
  cell_type = example_sce$cellTypes,
  cell_type_inc = which(example_sce$cellTypes == "2i"),
  cell_type_match = FALSE)
#> Step 2: Performing RUV normalisation. This will take minutes to hours.
#> scMerge complete!
```

```
scMerge_semisupervised1 = runPCA(scMerge_semisupervised1,
                                 exprs_values = "scMerge_semisupervised1")

scater::plotPCA(
  scMerge_semisupervised1,
  colour_by = "cellTypes",
  shape_by = "batch")
```

![](data:image/png;base64...)

# 8 Semi-supervised scMerge II

There is alternative semi-supervised method to create pseudo-replicates for `scMerge`. This uses known cell type information to identify mutual nearest clusters and it is achieved via the `cell_type` and `cell_type_match = TRUE` options in the `scMerge` function.

```
scMerge_semisupervised2 <- scMerge(
  sce_combine = example_sce,
  ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
  kmeansK = c(3, 3),
  assay_name = "scMerge_semisupervised2",
  cell_type = example_sce$cellTypes,
  cell_type_inc = NULL,
  cell_type_match = TRUE)
#> Step 2: Performing RUV normalisation. This will take minutes to hours.
#> scMerge complete!
```

```
scMerge_semisupervised2 = runPCA(scMerge_semisupervised2,
                                 exprs_values = "scMerge_semisupervised2")

scater::plotPCA(
  scMerge_semisupervised2,
  colour_by = "cellTypes",
  shape_by = "batch")
```

![](data:image/png;base64...)

# 9 Selecting negative controls

In simple terms, a negative control is a gene that has expression values relatively constant across these datasets. The concept of using these negative control genes for normalisation was most widely used in the RUV method family (e.g. [Gagnon-Bartsch & Speed (2012)](https://academic.oup.com/biostatistics/article/13/3/539/248166) and [Risso et. al. (2014)](https://www.nature.com/articles/nbt.2931)) and there exist multiple methods to find these negative controls. In our paper, we recommened the SEGs as negative controls for scRNA-Seq data and SEGs can be found using either a data-adaptive computational method or external knowledge.

* Computation method: We provide the function `scSEGIndex` to calculate the SEG from a data matrix. The output of this function is a `data.frame` with a SEG index calculated for each gene. See [Lin et. al. (2018)](https://www.biorxiv.org/content/10.1101/229815v2) for more details.

```
exprs_mat = SummarizedExperiment::assay(example_sce, 'counts')
result = scSEGIndex(exprs_mat = exprs_mat)
```

* External knowledge: We have applied the SEG computational methodology on multiple human and mouse scRNA-Seq data and made these available as data objects in our package. The end-users can simply use these pre-computed results. There are also additional negative controls from bulk microarray and bulkd RNA-Seq data.

```
## SEG list in ensemblGene ID
data("segList_ensemblGeneID", package = "scMerge")
## SEG list in official gene symbols
data("segList", package = "scMerge")

## SEG list for human scRNA-Seq data
head(segList$human$human_scSEG)
#> [1] "AAR2"  "AATF"  "ABCF3" "ABHD2" "ABT1"  "ACAP2"

## SEG list for human bulk microarray data
head(segList$human$bulkMicroarrayHK)
#> [1] "AATF"  "ABL1"  "ACAT2" "ACTB"  "ACTG1" "ACTN4"

## SEG list for human bulk RNASeq data
head(segList$human$bulkRNAseqHK)
#> [1] "AAGAB"  "AAMP"   "AAR2"   "AARS"   "AARS2"  "AARSD1"
```

# 10 Achieving fast and memory-efficient computation

## 10.1 Using approximated SVD

Under most circumstances, `scMerge` is fast enough to be used on a personal laptop for a moderately large data. However, we do recognise the difficulties associated with computation when dealing with larger data. To this end, we devised a fast version of `scMerge`. The major difference between the two versions lies on the noise estimation component, which utilised singular value decomposition (SVD). In order to speed up `scMerge`, we used `BiocSingular` package that offers several SVD speed improvements. This computational method is able to speed up `scMerge` by obtain a very accurate approximation of the noise structure in the data. This option is achieved via the option `BSPARAM = IrlbaParam()` or `BSPARAM = RandomParam()`. Additionally, `svd_k` is a parameter that controlling the degree of approximations.

We recommend using this option in the case where the number of cells is large in your single cell data. The speed advantage we obtain for large single cell data is much more dramatic than on a smaller dataset like the example mESC data. For example, a single run of normal `scMerge` on a human [pancreas data](https://sydneybiox.github.io/scMerge/articles/Pancreas4_Data/Pancreas4_Data.html) (23699 features and 4566 cells) takes about 10 minutes whereas the speed up version takes just under 4 minutes.

```
library(BiocSingular)
scMerge_fast <- scMerge(
  sce_combine = example_sce,
  ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
  kmeansK = c(3, 3),
  assay_name = "scMerge_fast",
  BSPARAM = IrlbaParam(),
  svd_k = 20)
#> Step 2: Performing RUV normalisation. This will take minutes to hours.
#> Warning in (function (A, nv = 5, nu = nv, maxit = 1000, work = nv + 7, reorth =
#> TRUE, : You're computing too large a percentage of total singular values, use a
#> standard svd instead.
#> scMerge complete!
```

```
paste("Normally, scMerge takes ", round(t2 - t1, 2), " seconds")
#> [1] "Normally, scMerge takes  1.84  seconds"
paste("Fast version of scMerge takes ", round(t4 - t3, 2), " seconds")
#> [1] "Fast version of scMerge takes  9.88  seconds"

scMerge_fast = runPCA(scMerge_fast, exprs_values = "scMerge_fast")

scater::plotPCA(
  scMerge_fast,
  colour_by = "cellTypes",
  shape_by = "batch") +
  labs(title = "fast scMerge yields similar results to the default version")
```

![](data:image/png;base64...)

## 10.2 Parallelised computing

`scMerge` is implemented with a parallelised computational option via the [BiocParallel](https://bioconductor.org/packages/release/bioc/html/BiocParallel.html) package. You can enable this option using the `BPPARAM` argument with various `BiocParallelParam` objects that is suitable for your operating system.

Please note that any parallelisation would incur a small overhead. Hence we recommend you do not use parallelisation for small data.

```
library(BiocParallel)
scMerge_parallel <- scMerge(
  sce_combine = example_sce,
  ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
  kmeansK = c(3, 3),
  assay_name = "scMerge_parallel",
  BPPARAM = MulticoreParam(workers = 2)
)
```

## 10.3 Sparse array

`scMerge` also supports sparse array input, which could be very helpful in speeding up computations and saving RAM. `scMerge` does not perform internal matrix conversion, so you may use the following codes as an example of converting typical `matrix` class to sparse matrices before running `scMerge`.

```
library(Matrix)
library(DelayedArray)

sparse_input = example_sce

assay(sparse_input, "counts") = as(counts(sparse_input), "dgeMatrix")
assay(sparse_input, "logcounts") = as(logcounts(sparse_input), "dgeMatrix")

scMerge_sparse = scMerge(
  sce_combine = sparse_input,
  ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
  kmeansK = c(3, 3),
  assay_name = "scMerge_sparse")
```

## 10.4 Out-of-memory computations (through `HDF5Array`)

Bioconductor provides an infrastructure for out-of-memory computation through `HDF5Array`. In simple terms, we can load an on-disk data into RAM, make computations and write to hard disk. This is particularly helpful when the data is too large for in-RAM computations. You may use the following codes as an example of converting typical `matrix` class to `HDF5Array` matrices before running `scMerge`.

```
library(HDF5Array)
library(DelayedArray)

DelayedArray:::set_verbose_block_processing(TRUE) ## To monitor block processing

hdf5_input = example_sce

assay(hdf5_input, "counts") = as(counts(hdf5_input), "HDF5Array")
assay(hdf5_input, "logcounts") = as(logcounts(hdf5_input), "HDF5Array")

scMerge_hdf5 = scMerge(
  sce_combine = sparse_input,
  ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
  kmeansK = c(3, 3),
  assay_name = "scMerge_hdf5")
```

# 11 Reference

Please check out our paper for detailed analysis and results on multiple scRNA-Seq data. <https://doi.org/10.1073/pnas.1820006116>.

```
citation("scMerge")
#> To cite scMerge in publications please use:
#>
#>   Lin Y, Ghazanfar S, Wang K, Gagnon-Bartsch J, Lo K, Su X, Han Z,
#>   Ormerod J, Speed T, Yang P, Yang J (2019). "scMerge leverages factor
#>   analysis, stable expression, and pseudoreplication to merge multiple
#>   single-cell RNA-seq datasets." _Proceedings of the National Academy
#>   of Sciences_. doi:10.1073/pnas.1820006116
#>   <https://doi.org/10.1073/pnas.1820006116>,
#>   <http://www.pnas.org/lookup/doi/10.1073/pnas.1820006116>.
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Article{,
#>     title = {{scMerge leverages factor analysis, stable expression, and pseudoreplication to merge multiple single-cell RNA-seq datasets}},
#>     author = {Yingxin Lin and Shila Ghazanfar and Kevin Wang and Johann Gagnon-Bartsch and Kitty Lo and Xianbin Su and Ze-Guang Han and John Ormerod and Terence Speed and Pengyi Yang and Jean Yang},
#>     year = {2019},
#>     journal = {Proceedings of the National Academy of Sciences},
#>     doi = {https://doi.org/10.1073/pnas.1820006116},
#>     url = {http://www.pnas.org/lookup/doi/10.1073/pnas.1820006116},
#>   }
```

# 12 Session Info

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
#>  [1] BiocSingular_1.26.0         scater_1.38.0
#>  [3] ggplot2_4.0.0               scuttle_1.20.0
#>  [5] scMerge_1.26.0              SingleCellExperiment_1.32.0
#>  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [9] GenomicRanges_1.62.0        Seqinfo_1.0.0
#> [11] IRanges_2.44.0              S4Vectors_0.48.0
#> [13] BiocGenerics_0.56.0         generics_0.1.4
#> [15] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [17] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3        rstudioapi_0.17.1
#>   [3] jsonlite_2.0.0            magrittr_2.0.4
#>   [5] magick_2.9.0              ggbeeswarm_0.7.2
#>   [7] farver_2.1.2              rmarkdown_2.30
#>   [9] vctrs_0.6.5               DelayedMatrixStats_1.32.0
#>  [11] base64enc_0.1-3           tinytex_0.57
#>  [13] htmltools_0.5.8.1         S4Arrays_1.10.0
#>  [15] curl_7.0.0                BiocNeighbors_2.4.0
#>  [17] SparseArray_1.10.0        Formula_1.2-5
#>  [19] sass_0.4.10               StanHeaders_2.32.10
#>  [21] reldist_1.7-2             KernSmooth_2.23-26
#>  [23] bslib_0.9.0               htmlwidgets_1.6.4
#>  [25] cachem_1.1.0              ResidualMatrix_1.20.0
#>  [27] sfsmisc_1.1-22            igraph_2.2.1
#>  [29] lifecycle_1.0.4           startupmsg_1.0.0
#>  [31] pkgconfig_2.0.3           M3Drop_1.36.0
#>  [33] rsvd_1.0.5                Matrix_1.7-4
#>  [35] R6_2.6.1                  fastmap_1.2.0
#>  [37] digest_0.6.37             numDeriv_2016.8-1.1
#>  [39] colorspace_2.1-2          dqrng_0.4.1
#>  [41] irlba_2.3.5.1             Hmisc_5.2-4
#>  [43] beachmat_2.26.0           labeling_0.4.3
#>  [45] abind_1.4-8               mgcv_1.9-3
#>  [47] compiler_4.5.1            withr_3.0.2
#>  [49] htmlTable_2.4.3           S7_0.2.0
#>  [51] backports_1.5.0           inline_0.3.21
#>  [53] BiocParallel_1.44.0       viridis_0.6.5
#>  [55] QuickJSR_1.8.1            pkgbuild_1.4.8
#>  [57] gplots_3.2.0              MASS_7.3-65
#>  [59] proxyC_0.5.2              DelayedArray_0.36.0
#>  [61] bluster_1.20.0            gtools_3.9.5
#>  [63] caTools_1.18.3            loo_2.8.0
#>  [65] distr_2.9.7               tools_4.5.1
#>  [67] vipor_0.4.7               foreign_0.8-90
#>  [69] beeswarm_0.4.0            nnet_7.3-20
#>  [71] glue_1.8.0                batchelor_1.26.0
#>  [73] nlme_3.1-168              cvTools_0.3.3
#>  [75] grid_4.5.1                checkmate_2.3.3
#>  [77] cluster_2.1.8.1           gtable_0.3.6
#>  [79] data.table_1.17.8         metapod_1.18.0
#>  [81] ScaledMatrix_1.18.0       XVector_0.50.0
#>  [83] ggrepel_0.9.6             pillar_1.11.1
#>  [85] stringr_1.5.2             limma_3.66.0
#>  [87] robustbase_0.99-6         splines_4.5.1
#>  [89] dplyr_1.1.4               lattice_0.22-7
#>  [91] densEstBayes_1.0-2.2      ruv_0.9.7.1
#>  [93] tidyselect_1.2.1          locfit_1.5-9.12
#>  [95] knitr_1.50                gridExtra_2.3
#>  [97] V8_8.0.1                  bookdown_0.45
#>  [99] edgeR_4.8.0               xfun_0.53
#> [101] statmod_1.5.1             DEoptimR_1.1-4
#> [103] rstan_2.32.7              stringi_1.8.7
#> [105] yaml_2.3.10               evaluate_1.0.5
#> [107] codetools_0.2-20          bbmle_1.0.25.1
#> [109] tibble_3.3.0              BiocManager_1.30.26
#> [111] cli_3.6.5                 RcppParallel_5.1.11-1
#> [113] rpart_4.1.24              jquerylib_0.1.4
#> [115] dichromat_2.0-0.1         Rcpp_1.1.0
#> [117] bdsmatrix_1.3-7           parallel_4.5.1
#> [119] rstantools_2.5.0          scran_1.38.0
#> [121] sparseMatrixStats_1.22.0  bitops_1.0-9
#> [123] viridisLite_0.4.2         mvtnorm_1.3-3
#> [125] scales_1.4.0              rlang_1.1.6
#> [127] cowplot_1.2.0
```