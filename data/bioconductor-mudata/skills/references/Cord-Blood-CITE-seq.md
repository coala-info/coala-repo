# CITE-seq data with MultiAssayExperiment and MuData

Danila Bredikhin1\* and Ilia Kats2\*\*

1European Molecular Biology Laboratory, Heidelberg, Germany
2German Cancer Research Center, Heidelberg, Germany

\*danila.bredikhin@embl.de
\*\*i.kats@dkfz-heidelberg.de

#### 2025-10-30

## 0.1 Introduction

CITE-seq data provide RNA and surface protein counts for the same cells.
This tutorial shows how MuData can be integrated into with Bioconductor
workflows to analyse CITE-seq data.

## 0.2 Installation

The most recent dev build can be installed from GitHub:

```
library(remotes)
remotes::install_github("ilia-kats/MuData")
```

Stable version of `MuData` will be available in future bioconductor versions.

## 0.3 Loading libraries

```
library(MuData)
library(SingleCellExperiment)
library(MultiAssayExperiment)
library(SingleCellMultiModal)
library(scater)

library(rhdf5)
```

## 0.4 Loading data

We will use CITE-seq data accessible with the
[`SingleCellMultiModal` Bioconductor package](https://bioconductor.org/packages/release/data/experiment/vignettes/SingleCellMultiModal/inst/doc/CITEseq.html),
which was originally described in
[Stoeckius et al., 2017](https://www.nature.com/articles/nmeth.4380).

```
mae <- CITEseq(
    DataType="cord_blood", modes="*", dry.run=FALSE, version="1.0.0"
)
#> Dataset: cord_blood
#> Working on: scADT_Counts
#> Working on: scRNAseq_Counts
#> Working on: coldata_scRNAseq
#> Working on: scADT_clrCounts
#> see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
#> loading from cache
#> see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
#> loading from cache
#> see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
#> loading from cache
#> see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
#> loading from cache
#> Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
#>   potential for errors with mixed data types
#> harmonizing input:
#>   removing 2277 sampleMap rows with 'primary' not in colData

mae
#> A MultiAssayExperiment object of 3 listed
#>  experiments with user-defined names and respective classes.
#>  Containing an ExperimentList class object of length 3:
#>  [1] scADT: matrix with 13 rows and 7858 columns
#>  [2] scADT_clr: matrix with 13 rows and 7858 columns
#>  [3] scRNAseq: matrix with 36280 rows and 7858 columns
#> Functionality:
#>  experiments() - obtain the ExperimentList instance
#>  colData() - the primary/phenotype DataFrame
#>  sampleMap() - the sample coordination DataFrame
#>  `$`, `[`, `[[` - extract colData columns, subset, or experiment
#>  *Format() - convert into a long or wide DataFrame
#>  assays() - convert ExperimentList to a SimpleList of matrices
#>  exportClass() - save data to flat files
```

We see two modalities in the object — `scRNAseq` and `scADT`, the latter
providing counts for antibody-derived tags. Notably, each experiment is a matrix.

## 0.5 Processing ADT data

While CITE-seq analysis workflows such as
[CiteFuse](http://www.bioconductor.org/packages/release/bioc/html/CiteFuse.html)
should be consulted for more details, below we exemplify simple data
transformation in order to demonstrate how their output can be saved
to an H5MU file later on.

For ADT counts, we will apply CLR transformation following
[Hao et al., 2020](https://doi.org/10.1016/j.cell.2021.04.048):

```
# Define CLR transformation as in the Seurat workflow
clr <- function(data) t(
  apply(data, 1, function(x) log1p(
    x / (exp(sum(log1p(x[x > 0]), na.rm = TRUE) / length(x)))
  ))
)
```

We will make the ADT modality a `SingleCellExperiment` object and add an assay
with CLR-transformed counts:

```
adt_counts <- mae[["scADT"]]

mae[["scADT"]] <- SingleCellExperiment(adt_counts)
assay(mae[["scADT"]], "clr") <- clr(adt_counts)
```

We will also generate reduced dimensions taking advantage of the functionality
in the [`scater` package](https://bioconductor.org/packages/release/bioc/vignettes/scater/inst/doc/overview.html):

```
mae[["scADT"]] <- runPCA(
  mae[["scADT"]], exprs_values = "clr", ncomponents = 20
)
#> Warning in check_numbers(k = k, nu = nu, nv = nv, limit = min(dim(x)) - : more
#> singular values/vectors requested than available
#> Warning in (function (A, nv = 5, nu = nv, maxit = 1000, work = nv + 7, reorth =
#> TRUE, : You're computing too large a percentage of total singular values, use a
#> standard svd instead.
#> Warning in (function (A, nv = 5, nu = nv, maxit = 1000, work = nv + 7, reorth =
#> TRUE, : did not converge--results might be invalid!; try increasing work or
#> maxit
```

```
plotReducedDim(mae[["scADT"]], dimred = "PCA",
               by_exprs_values = "clr", colour_by = "CD3")
```

![](data:image/png;base64...)

```
plotReducedDim(mae[["scADT"]], dimred = "PCA",
               by_exprs_values = "clr", colour_by = "CD14")
```

![](data:image/png;base64...)

## 0.6 Writing H5MU files

We can write the contents of the MultiAssayExperiment object into an H5MU file:

```
writeH5MU(mae, "cord_blood_citeseq.h5mu")
```

We can check that both modalities were written to the file, whether it was a
`matrix` for RNA or `SingleCellExperiment` for ADT:

```
h5 <- rhdf5::H5Fopen("cord_blood_citeseq.h5mu")
h5ls(H5Gopen(h5, "mod"), recursive = FALSE)
#>   group      name     otype dclass dim
#> 0     /     scADT H5I_GROUP
#> 1     / scADT_clr H5I_GROUP
#> 2     /  scRNAseq H5I_GROUP
```

… both assays for ADT — raw counts are stored in `X` and CLR-transformed
counts are in the corresponding layer:

```
h5ls(H5Gopen(h5, "mod/scADT"), recursive = FALSE)
#>   group   name       otype  dclass       dim
#> 0     /      X H5I_DATASET INTEGER 13 x 7858
#> 1     / layers   H5I_GROUP
#> 2     /    obs   H5I_GROUP
#> 3     /   obsm   H5I_GROUP
#> 4     /    var   H5I_GROUP
h5ls(H5Gopen(h5, "mod/scADT/layers"), recursive = FALSE)
#>   group name       otype dclass       dim
#> 0     /  clr H5I_DATASET  FLOAT 13 x 7858
```

… as well as reduced dimensions (PCA):

```
h5ls(H5Gopen(h5, "mod/scADT/obsm"), recursive = FALSE)
#>   group name       otype dclass       dim
#> 0     /  PCA H5I_DATASET  FLOAT 12 x 7858
# There is an alternative way to access groups:
# h5&'mod'&'scADT'&'obsm'
rhdf5::H5close()
```

## 0.7 References

* [Muon: multimodal omics analysis framework](https://www.biorxiv.org/content/10.1101/2021.06.01.445670) preprint
* [mudata](https://mudata.readthedocs.io/) (Python) documentation
* muon [documentation](https://muon.readthedocs.io/) and [web page](https://gtca.github.io/muon/)
* Stoeckius, M., Hafemeister, C., Stephenson, W., Houck-Loomis, B., Chattopadhyay, P.K., Swerdlow, H., Satija, R. and Smibert, P., 2017. Simultaneous epitope and transcriptome measurement in single cells. *Nature methods*, 14(9), pp.865-868.
* Hao, Y., Hao, S., Andersen-Nissen, E., Mauck III, W.M., Zheng, S., Butler, A., Lee, M.J., Wilk, A.J., Darby, C., Zager, M. and Hoffman, P., 2021. Integrated analysis of multimodal single-cell data. *Cell*.

## 0.8 Session Info

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
#>  [1] SingleCellMultiModal_1.21.4 scater_1.38.0
#>  [3] ggplot2_4.0.0               scuttle_1.20.0
#>  [5] CiteFuse_1.22.0             MultiAssayExperiment_1.36.0
#>  [7] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#>  [9] Biobase_2.70.0              GenomicRanges_1.62.0
#> [11] Seqinfo_1.0.0               IRanges_2.44.0
#> [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [15] MuData_1.14.0               rhdf5_2.54.0
#> [17] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [19] generics_0.1.4              Matrix_1.7-4
#> [21] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3       tensorA_0.36.2.1         jsonlite_2.0.0
#>   [4] magrittr_2.0.4           ggbeeswarm_0.7.2         magick_2.9.0
#>   [7] farver_2.1.2             rmarkdown_2.30           vctrs_0.6.5
#>  [10] memoise_2.0.1            tinytex_0.57             htmltools_0.5.8.1
#>  [13] S4Arrays_1.10.0          BiocBaseUtils_1.12.0     curl_7.0.0
#>  [16] AnnotationHub_4.0.0      BiocNeighbors_2.4.0      Rhdf5lib_1.32.0
#>  [19] SparseArray_1.10.0       sass_0.4.10              bslib_0.9.0
#>  [22] htmlwidgets_1.6.4        httr2_1.2.1              plyr_1.8.9
#>  [25] plotly_4.11.0            cachem_1.1.0             igraph_2.2.1
#>  [28] lifecycle_1.0.4          pkgconfig_2.0.3          rsvd_1.0.5
#>  [31] R6_2.6.1                 fastmap_1.2.0            digest_0.6.37
#>  [34] AnnotationDbi_1.72.0     dqrng_0.4.1              irlba_2.3.5.1
#>  [37] ExperimentHub_3.0.0      RSQLite_2.4.3            beachmat_2.26.0
#>  [40] filelock_1.0.3           labeling_0.4.3           randomForest_4.7-1.2
#>  [43] httr_1.4.7               polyclip_1.10-7          abind_1.4-8
#>  [46] compiler_4.5.1           bit64_4.6.0-1            withr_3.0.2
#>  [49] S7_0.2.0                 BiocParallel_1.44.0      viridis_0.6.5
#>  [52] DBI_1.2.3                ggforce_0.5.0            MASS_7.3-65
#>  [55] bayesm_3.1-6             rappdirs_0.3.3           DelayedArray_0.36.0
#>  [58] rjson_0.2.23             bluster_1.20.0           tools_4.5.1
#>  [61] vipor_0.4.7              beeswarm_0.4.0           glue_1.8.0
#>  [64] dbscan_1.2.3             nlme_3.1-168             rhdf5filters_1.22.0
#>  [67] grid_4.5.1               Rtsne_0.17               cluster_2.1.8.1
#>  [70] reshape2_1.4.4           gtable_0.3.6             tidyr_1.3.1
#>  [73] data.table_1.17.8        BiocSingular_1.26.0      tidygraph_1.3.1
#>  [76] ScaledMatrix_1.18.0      metapod_1.18.0           XVector_0.50.0
#>  [79] BiocVersion_3.22.0       ggrepel_0.9.6            pillar_1.11.1
#>  [82] stringr_1.5.2            limma_3.66.0             robustbase_0.99-6
#>  [85] splines_4.5.1            dplyr_1.1.4              tweenr_2.0.3
#>  [88] BiocFileCache_3.0.0      lattice_0.22-7           bit_4.6.0
#>  [91] survival_3.8-3           compositions_2.0-9       tidyselect_1.2.1
#>  [94] locfit_1.5-9.12          Biostrings_2.78.0        knitr_1.50
#>  [97] gridExtra_2.3            bookdown_0.45            edgeR_4.8.0
#> [100] xfun_0.53                graphlayouts_1.2.2       mixtools_2.0.0.1
#> [103] statmod_1.5.1            DEoptimR_1.1-4           pheatmap_1.0.13
#> [106] stringi_1.8.7            lazyeval_0.2.2           yaml_2.3.10
#> [109] evaluate_1.0.5           codetools_0.2-20         kernlab_0.9-33
#> [112] ggraph_2.2.2             tibble_3.3.0             BiocManager_1.30.26
#> [115] cli_3.6.5                uwot_0.2.3               segmented_2.1-4
#> [118] jquerylib_0.1.4          dichromat_2.0-0.1        Rcpp_1.1.0
#> [121] dbplyr_2.5.1             png_0.1-8                parallel_4.5.1
#> [124] blob_1.2.4               scran_1.38.0             SpatialExperiment_1.20.0
#> [127] viridisLite_0.4.2        scales_1.4.0             ggridges_0.5.7
#> [130] crayon_1.5.3             purrr_1.1.0              rlang_1.1.6
#> [133] KEGGREST_1.50.0          cowplot_1.2.0
```