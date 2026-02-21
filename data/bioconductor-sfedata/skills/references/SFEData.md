# Example SpatialFeatureExperiment datasets

#### 4 November 2025

# Contents

* [1 Installation](#installation)
* [2 Usage](#usage)

# 1 Installation

This package can be installed from Bioconductor with the following command:

```
if (!requireNamespace(BiocManager, quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("SFEData")
```

# 2 Usage

```
library(SFEData)
```

Example spatial transcriptomics datasets with [Simple Features](https://r-spatial.github.io/sf/) annotations as `SpatialFeatureExperiment` objects. These are the datasets available from this package and functions to download the datasets:

Visium:

* Full Visium dataset of the first time point, including spots outside tissue (`McKellarMuscleData()`)
* Small subset of the full Visium dataset for function examples. (`McKellarMuscleData()`)
* A second small subset of the full Visium dataset with a different `sample_id` used for function examples involving multiple samples (`McKellarMuscleData()`)

Slide-seq2:

* Slide-seq2 human melanoma brain metastasis dataset (`BiermannMelaMetasData()`)
* Slide-seq2 human melanoma extracranial metastasis dataset (`BiermannMelaMetasData()`)

Xenium:

* 10X Xenium formalin fixed paraffin embedded (FFPE) Xenium dataset for human
  breast cancer (2 biological replica, `JanesickBreastData()`)

CosMX:

* Nanostring CosMX FFPE human non small cell lung cancer data (`HeNSCLCData()`)
* CosMX output subset from mouse quarter brain (`CosMXOutput()`)

MERFISH:

* Vizgen MERFISH mouse liver data (`VizgenLiverData()`)
* Vizgen output subset of unpublished brain cancer data (`VizgenOutput()`)

seqFISH:

* seqFISH mouse gastrulation data (`LohoffGastrulationData()`)

Xenium:
\* Xenium output subset of mouse brain data (`XeniumOutput()`)

This package is used extensively in examples and vignettes of the `SpatialFeatureExperiment` and `Voyager` packages. The same function is used for different samples from the same study, and the `dataset` argument determines which sample is downloaded:

```
sfe <- McKellarMuscleData(dataset = "small")
#> see ?SFEData and browseVignettes('SFEData') for documentation
#> loading from cache
#> require("SpatialFeatureExperiment")
```

The outputs (in `*Output()`) are not SFE objects, but a small subset in the format of the standard output of the technology, used to unit test read functions. Where the files are saved is controlled by the `file_path` argument.

```
(fp <- CosMXOutput(file_path = "foo"))
#> see ?SFEData and browseVignettes('SFEData') for documentation
#> loading from cache
#> The downloaded files are in /tmp/RtmpT0J5Gw/Rbuild8942a776fd59b/SFEData/vignettes/foo/cosmx
#> [1] "/tmp/RtmpT0J5Gw/Rbuild8942a776fd59b/SFEData/vignettes/foo/cosmx"
```

```
unlink("foo", recursive = TRUE)
```

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] SpatialFeatureExperiment_1.12.0 SFEData_1.12.0
#> [3] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] jsonlite_2.0.0              wk_0.9.4
#>   [3] magrittr_2.0.4              TH.data_1.1-4
#>   [5] magick_2.9.0                rmarkdown_2.30
#>   [7] vctrs_0.6.5                 spdep_1.4-1
#>   [9] memoise_2.0.1               DelayedMatrixStats_1.32.0
#>  [11] RCurl_1.98-1.17             terra_1.8-70
#>  [13] htmltools_0.5.8.1           S4Arrays_1.10.0
#>  [15] AnnotationHub_4.0.0         curl_7.0.0
#>  [17] BiocNeighbors_2.4.0         Rhdf5lib_1.32.0
#>  [19] s2_1.1.9                    SparseArray_1.10.1
#>  [21] rhdf5_2.54.0                LearnBayes_2.15.1
#>  [23] sass_0.4.10                 spData_2.3.4
#>  [25] KernSmooth_2.23-26          bslib_0.9.0
#>  [27] htmlwidgets_1.6.4           sandwich_3.1-1
#>  [29] httr2_1.2.1                 zoo_1.8-14
#>  [31] cachem_1.1.0                lifecycle_1.0.4
#>  [33] pkgconfig_2.0.3             Matrix_1.7-4
#>  [35] R6_2.6.1                    fastmap_1.2.0
#>  [37] MatrixGenerics_1.22.0       digest_0.6.37
#>  [39] AnnotationDbi_1.72.0        S4Vectors_0.48.0
#>  [41] dqrng_0.4.1                 ExperimentHub_3.0.0
#>  [43] GenomicRanges_1.62.0        RSQLite_2.4.3
#>  [45] beachmat_2.26.0             filelock_1.0.3
#>  [47] spatialreg_1.4-2            httr_1.4.7
#>  [49] abind_1.4-8                 compiler_4.5.1
#>  [51] proxy_0.4-27                bit64_4.6.0-1
#>  [53] withr_3.0.2                 tiff_0.1-12
#>  [55] BiocParallel_1.44.0         DBI_1.2.3
#>  [57] HDF5Array_1.38.0            R.utils_2.13.0
#>  [59] MASS_7.3-65                 rappdirs_0.3.3
#>  [61] DelayedArray_0.36.0         rjson_0.2.23
#>  [63] classInt_0.4-11             tools_4.5.1
#>  [65] units_1.0-0                 R.oo_1.27.1
#>  [67] glue_1.8.0                  h5mread_1.2.0
#>  [69] nlme_3.1-168                EBImage_4.52.0
#>  [71] rhdf5filters_1.22.0         grid_4.5.1
#>  [73] sf_1.0-21                   generics_0.1.4
#>  [75] R.methodsS3_1.8.2           class_7.3-23
#>  [77] data.table_1.17.8           sp_2.2-0
#>  [79] XVector_0.50.0              BiocGenerics_0.56.0
#>  [81] BiocVersion_3.22.0          pillar_1.11.1
#>  [83] limma_3.66.0                splines_4.5.1
#>  [85] dplyr_1.1.4                 BiocFileCache_3.0.0
#>  [87] lattice_0.22-7              survival_3.8-3
#>  [89] bit_4.6.0                   deldir_2.0-4
#>  [91] tidyselect_1.2.1            SingleCellExperiment_1.32.0
#>  [93] locfit_1.5-9.12             Biostrings_2.78.0
#>  [95] scuttle_1.20.0              sfheaders_0.4.4
#>  [97] knitr_1.50                  bookdown_0.45
#>  [99] IRanges_2.44.0              Seqinfo_1.0.0
#> [101] edgeR_4.8.0                 SummarizedExperiment_1.40.0
#> [103] stats4_4.5.1                xfun_0.54
#> [105] Biobase_2.70.0              statmod_1.5.1
#> [107] DropletUtils_1.30.0         matrixStats_1.5.0
#> [109] fftwtools_0.9-11            yaml_2.3.10
#> [111] boot_1.3-32                 evaluate_1.0.5
#> [113] codetools_0.2-20            tibble_3.3.0
#> [115] BiocManager_1.30.26         cli_3.6.5
#> [117] jquerylib_0.1.4             Rcpp_1.1.0
#> [119] zeallot_0.2.0               dbplyr_2.5.1
#> [121] coda_0.19-4.1               png_0.1-8
#> [123] parallel_4.5.1              blob_1.2.4
#> [125] jpeg_0.1-11                 sparseMatrixStats_1.22.0
#> [127] bitops_1.0-9                SpatialExperiment_1.20.0
#> [129] mvtnorm_1.3-3               e1071_1.7-16
#> [131] purrr_1.1.0                 crayon_1.5.3
#> [133] rlang_1.1.6                 multcomp_1.4-29
#> [135] KEGGREST_1.50.0
```