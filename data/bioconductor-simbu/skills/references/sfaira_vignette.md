# Public Data Integration using Sfaira

#### Alexander Dietrich

```
library(SimBu)
```

# Sfaira Integeration

This vignette will cover the integration of the public database Sfaria.

## Setup

As a public database, sfaira (Fischer et al. [2020](#ref-Fischer2020)) is used, which is a dataset and model repository for single-cell RNA-sequencing data. It gives access to about multiple datasets from human and mouse with more than 3 million cells in total. You can browse them interactively here: <https://theislab.github.io/sfaira-portal/Datasets>. Note that only annotated datasets will be downloaded! Also there are cases of datasets, which have private URLs and cannot be automatically downloaded; SimBu will skip these datasets.
In order to use this database, we first need to install it. This can easily be done, by running the `setup_sfaira()` function for the first time. In the background we use the [basilisik](https://bioconductor.org/packages/release/bioc/html/basilisk.utils.html) package to establish a conda environment that has all sfaira dependencies installed. The installation will be only performed one single time, even if you close your R session and call `setup_sfaira()` again. The given directory serves as the storage for all future downloaded datasets from sfaira:

```
setup_list <- SimBu::setup_sfaira(basedir = tempdir())
```

## Creating a dataset

We will now create a dataset of samples from human pancreas using the `organisms` and `tissues` parameter. You can provide a single word (like we do here) or for example a list of tissues you want to download: `c("pancreas","lung")`. An additional parameter is the `assays` parameter, where you subset the database further to only download datasets from certain sequencing assays (for examples `Smart-seq2`).
The `name` parameter is used later on to give each sample (cell) a unique name.

```
ds_pancrease <- SimBu::dataset_sfaira_multiple(
  sfaira_setup = setup_list,
  organisms = "Homo sapiens",
  tissues = "pancreas",
  name = "human_pancreas"
)
```

Currently there are three datasets in sfaira from human pancreas, which have cell-type annotation. The package will download them for you automatically and merge them together into a single expression matrix and a streamlined annotation table, which we can use for our simulation.
It can happen, that some datasets from sfaira are not (yet) ready for the automatic download, an error message will then appear in R, telling you which file to download and where to put it.

If you wish to see all datasets which are included in sfaira you can use the following command:

```
all_datasets <- SimBu::sfaira_overview(setup_list = setup_list)
head(all_datasets)
```

This allows you to find the specific IDs of datasets, which you can download directly:

```
SimBu::dataset_sfaira(
  sfaira_id = "homosapiens_lungparenchyma_2019_10x3v2_madissoon_001_10.1186/s13059-019-1906-x",
  sfaira_setup = setup_list,
  name = "dataset_by_id"
)
```

```
utils::sessionInfo()
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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] SimBu_1.12.0
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.10                 generics_0.1.4
#>  [3] tidyr_1.3.1                 SparseArray_1.10.0
#>  [5] lattice_0.22-7              digest_0.6.37
#>  [7] magrittr_2.0.4              RColorBrewer_1.1-3
#>  [9] evaluate_1.0.5              sparseMatrixStats_1.22.0
#> [11] grid_4.5.1                  fastmap_1.2.0
#> [13] jsonlite_2.0.0              Matrix_1.7-4
#> [15] proxyC_0.5.2                purrr_1.1.0
#> [17] scales_1.4.0                codetools_0.2-20
#> [19] jquerylib_0.1.4             abind_1.4-8
#> [21] cli_3.6.5                   crayon_1.5.3
#> [23] rlang_1.1.6                 XVector_0.50.0
#> [25] Biobase_2.70.0              withr_3.0.2
#> [27] cachem_1.1.0                DelayedArray_0.36.0
#> [29] yaml_2.3.10                 S4Arrays_1.10.0
#> [31] tools_4.5.1                 parallel_4.5.1
#> [33] BiocParallel_1.44.0         dplyr_1.1.4
#> [35] ggplot2_4.0.0               SummarizedExperiment_1.40.0
#> [37] BiocGenerics_0.56.0         vctrs_0.6.5
#> [39] R6_2.6.1                    matrixStats_1.5.0
#> [41] stats4_4.5.1                lifecycle_1.0.4
#> [43] Seqinfo_1.0.0               S4Vectors_0.48.0
#> [45] IRanges_2.44.0              pkgconfig_2.0.3
#> [47] gtable_0.3.6                bslib_0.9.0
#> [49] pillar_1.11.1               data.table_1.17.8
#> [51] glue_1.8.0                  Rcpp_1.1.0
#> [53] xfun_0.53                   tibble_3.3.0
#> [55] GenomicRanges_1.62.0        tidyselect_1.2.1
#> [57] dichromat_2.0-0.1           MatrixGenerics_1.22.0
#> [59] knitr_1.50                  farver_2.1.2
#> [61] htmltools_0.5.8.1           labeling_0.4.3
#> [63] rmarkdown_2.30              compiler_4.5.1
#> [65] S7_0.2.0
```

Fischer, David S., Leander Dony, Martin König, Abdul Moeed, Luke Zappia, Sophie Tritschler, Olle Holmberg, Hananeh Aliee, and Fabian J. Theis. 2020. “Sfaira Accelerates Data and Model Reuse in Single Cell Genomics.” *bioRxiv*. <https://doi.org/10.1101/2020.12.16.419036>.