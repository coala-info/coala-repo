# Getting started with MuData for MultiAssayExperiment

Danila Bredikhin1\* and Ilia Kats2\*\*

1European Molecular Biology Laboratory, Heidelberg, Germany
2German Cancer Research Center, Heidelberg, Germany

\*danila.bredikhin@embl.de
\*\*i.kats@dkfz-heidelberg.de

#### 2025-10-30

## 0.1 Introduction

Multimodal data format — [MuData](https://mudata.readthedocs.io/) —
[has been introduced](https://www.biorxiv.org/content/10.1101/2021.06.01.445670v1)
to address the need for cross-platform standard for sharing
large-scale multimodal omics data. Importantly, it develops ideas of and is
compatible with [AnnData](https://anndata.readthedocs.io/) standard for storing
raw and derived data for unimodal datasets.

In Bioconductor, multimodal datasets have been stored in
[MultiAssayExperiment](https://bioconductor.org/packages/MultiAssayExperiment)
(MAE) objects. This `MuData` package provides functionality to read data from
MuData files into MAE objects as well as to save MAE objects into H5MU files.

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
library(MultiAssayExperiment)

library(rhdf5)
```

## 0.4 Writing H5MU files

We’ll use a simple MAE object from the `MultiAssayExperiment` package that
we’ll then save in a H5MU file.

```
data(miniACC)
miniACC
#> A MultiAssayExperiment object of 5 listed
#>  experiments with user-defined names and respective classes.
#>  Containing an ExperimentList class object of length 5:
#>  [1] RNASeq2GeneNorm: SummarizedExperiment with 198 rows and 79 columns
#>  [2] gistict: SummarizedExperiment with 198 rows and 90 columns
#>  [3] RPPAArray: SummarizedExperiment with 33 rows and 46 columns
#>  [4] Mutations: matrix with 97 rows and 90 columns
#>  [5] miRNASeqGene: SummarizedExperiment with 471 rows and 80 columns
#> Functionality:
#>  experiments() - obtain the ExperimentList instance
#>  colData() - the primary/phenotype DataFrame
#>  sampleMap() - the sample coordination DataFrame
#>  `$`, `[`, `[[` - extract colData columns, subset, or experiment
#>  *Format() - convert into a long or wide DataFrame
#>  assays() - convert ExperimentList to a SimpleList of matrices
#>  exportClass() - save data to flat files
```

We will now write its contents into an H5MU file with `WriteH5MU`:

```
writeH5MU(miniACC, "miniacc.h5mu")
```

## 0.5 Reading H5MU files

We can manually check the top level of the structure of the file:

```
rhdf5::h5ls("miniacc.h5mu", recursive = FALSE)
#>   group   name     otype dclass dim
#> 0     /    mod H5I_GROUP
#> 1     /    obs H5I_GROUP
#> 2     /   obsm H5I_GROUP
#> 3     / obsmap H5I_GROUP
#> 4     /    uns H5I_GROUP
#> 5     /    var H5I_GROUP
```

Or dig deeper into the file:

```
h5 <- rhdf5::H5Fopen("miniacc.h5mu")
h5&'mod'
#> HDF5 GROUP
#>         name /mod
#>     filename
#>
#>              name     otype dclass dim
#> 0 Mutations       H5I_GROUP
#> 1 RNASeq2GeneNorm H5I_GROUP
#> 2 RPPAArray       H5I_GROUP
#> 3 gistict         H5I_GROUP
#> 4 miRNASeqGene    H5I_GROUP
rhdf5::H5close()
```

### 0.5.1 Creating MAE objects from H5MU files

This package provides `ReadH5MU` to create an object with data from an H5MU
file. Since H5MU structure has been designed to accommodate more structured
information than MAE, only some data will be read. For instance, MAE has no
support for loading multimodal embeddings or pairwise graphs.

```
acc <- readH5MU("miniacc.h5mu")
#> Reading as SingleCellExperiment where the original object class is matrix
#> Warning: sampleMap[['assay']] coerced with as.factor()
acc
#> A MultiAssayExperiment object of 5 listed
#>  experiments with user-defined names and respective classes.
#>  Containing an ExperimentList class object of length 5:
#>  [1] RNASeq2GeneNorm: SummarizedExperiment with 198 rows and 79 columns
#>  [2] gistict: SummarizedExperiment with 198 rows and 90 columns
#>  [3] RPPAArray: SummarizedExperiment with 33 rows and 46 columns
#>  [4] Mutations: SingleCellExperiment with 97 rows and 90 columns
#>  [5] miRNASeqGene: SummarizedExperiment with 471 rows and 80 columns
#> Functionality:
#>  experiments() - obtain the ExperimentList instance
#>  colData() - the primary/phenotype DataFrame
#>  sampleMap() - the sample coordination DataFrame
#>  `$`, `[`, `[[` - extract colData columns, subset, or experiment
#>  *Format() - convert into a long or wide DataFrame
#>  assays() - convert ExperimentList to a SimpleList of matrices
#>  exportClass() - save data to flat files
```

Importantly, we recover the information from the original MAE object:

```
head(colData(miniACC)[,1:4])
#> DataFrame with 6 rows and 4 columns
#>                 patientID years_to_birth vital_status days_to_death
#>               <character>      <integer>    <integer>     <integer>
#> TCGA-OR-A5J1 TCGA-OR-A5J1             58            1          1355
#> TCGA-OR-A5J2 TCGA-OR-A5J2             44            1          1677
#> TCGA-OR-A5J3 TCGA-OR-A5J3             23            0            NA
#> TCGA-OR-A5J4 TCGA-OR-A5J4             23            1           423
#> TCGA-OR-A5J5 TCGA-OR-A5J5             30            1           365
#> TCGA-OR-A5J6 TCGA-OR-A5J6             29            0            NA
head(colData(acc)[,1:4])
#> DataFrame with 6 rows and 4 columns
#>                 patientID years_to_birth vital_status days_to_death
#>               <character>      <integer>    <integer>       <array>
#> TCGA-OR-A5J1 TCGA-OR-A5J1             58            1          1355
#> TCGA-OR-A5J2 TCGA-OR-A5J2             44            1          1677
#> TCGA-OR-A5J3 TCGA-OR-A5J3             23            0            NA
#> TCGA-OR-A5J4 TCGA-OR-A5J4             23            1           423
#> TCGA-OR-A5J5 TCGA-OR-A5J5             30            1           365
#> TCGA-OR-A5J6 TCGA-OR-A5J6             29            0            NA
```

Features metadata is also recovered:

```
head(rowData(miniACC[["gistict"]]))
#> DataFrame with 6 rows and 3 columns
#>        Gene.Symbol    Locus.ID    Cytoband
#>        <character> <character> <character>
#> DIRAS3      DIRAS3        9077      1p31.3
#> MAPK14      MAPK14        1432     6p21.31
#> YAP1          YAP1       10413     11q22.1
#> CDKN1B      CDKN1B        1027     12p13.1
#> ERBB2        ERBB2        2064       17q12
#> G6PD          G6PD        2539        Xq28
head(rowData(acc[["gistict"]]))
#> DataFrame with 6 rows and 3 columns
#>        Gene.Symbol    Locus.ID    Cytoband
#>        <character> <character> <character>
#> DIRAS3      DIRAS3        9077      1p31.3
#> MAPK14      MAPK14        1432     6p21.31
#> YAP1          YAP1       10413     11q22.1
#> CDKN1B      CDKN1B        1027     12p13.1
#> ERBB2        ERBB2        2064       17q12
#> G6PD          G6PD        2539        Xq28
```

#### 0.5.1.1 Backed objects

It is possible to read H5MU files while keeping matrices (both `.X` and
`.layers`) on disk.

```
acc_b <- readH5MU("miniacc.h5mu", backed = TRUE)
#> Reading as SingleCellExperiment where the original object class is matrix
#> Warning: sampleMap[['assay']] coerced with as.factor()
assay(acc_b, "RNASeq2GeneNorm")[1:5,1:3]
#> <5 x 3> DelayedMatrix object of type "double":
#>        TCGA-OR-A5J1-01A-11R-A29S-07 TCGA-OR-A5J2-01A-11R-A29S-07
#> DIRAS3                    1487.0317                       9.6631
#> MAPK14                     778.5783                    2823.6469
#> YAP1                      1009.6061                    2305.0590
#> CDKN1B                    2101.3449                    4248.9584
#> ERBB2                      651.2968                     246.4098
#>        TCGA-OR-A5J3-01A-11R-A29S-07
#> DIRAS3                      18.9602
#> MAPK14                    1061.7686
#> YAP1                      1561.2502
#> CDKN1B                    1348.5410
#> ERBB2                       90.0607
```

The data in the assay is a `DelayedMatrix` object:

```
class(assay(acc_b, "RNASeq2GeneNorm"))
#> [1] "DelayedMatrix"
#> attr(,"package")
#> [1] "DelayedArray"
```

This is in contrast to the `acc` object that has matrices in memory:

```
assay(acc, "RNASeq2GeneNorm")[1:5,1:3]
#>        TCGA-OR-A5J1-01A-11R-A29S-07 TCGA-OR-A5J2-01A-11R-A29S-07
#> DIRAS3                    1487.0317                       9.6631
#> MAPK14                     778.5783                    2823.6469
#> YAP1                      1009.6061                    2305.0590
#> CDKN1B                    2101.3449                    4248.9584
#> ERBB2                      651.2968                     246.4098
#>        TCGA-OR-A5J3-01A-11R-A29S-07
#> DIRAS3                      18.9602
#> MAPK14                    1061.7686
#> YAP1                      1561.2502
#> CDKN1B                    1348.5410
#> ERBB2                       90.0607
class(assay(acc, "RNASeq2GeneNorm"))
#> [1] "matrix" "array"
```

## 0.6 References

* [Muon: multimodal omics analysis framework](https://www.biorxiv.org/content/10.1101/2021.06.01.445670) preprint
* [mudata](https://mudata.readthedocs.io/) (Python) documentation
* muon [documentation](https://muon.readthedocs.io/) and [web page](https://gtca.github.io/muon/)

## 0.7 Session Info

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
#>   [1] splines_4.5.1            filelock_1.0.3           tibble_3.3.0
#>   [4] polyclip_1.10-7          lifecycle_1.0.4          httr2_1.2.1
#>   [7] edgeR_4.8.0              lattice_0.22-7           MASS_7.3-65
#>  [10] magrittr_2.0.4           limma_3.66.0             plotly_4.11.0
#>  [13] sass_0.4.10              rmarkdown_2.30           jquerylib_0.1.4
#>  [16] yaml_2.3.10              metapod_1.18.0           cowplot_1.2.0
#>  [19] bayesm_3.1-6             DBI_1.2.3                RColorBrewer_1.1-3
#>  [22] abind_1.4-8              Rtsne_0.17               purrr_1.1.0
#>  [25] mixtools_2.0.0.1         ggraph_2.2.2             tensorA_0.36.2.1
#>  [28] tweenr_2.0.3             rappdirs_0.3.3           ggrepel_0.9.6
#>  [31] irlba_2.3.5.1            pheatmap_1.0.13          dqrng_0.4.1
#>  [34] codetools_0.2-20         DelayedArray_0.36.0      ggforce_0.5.0
#>  [37] tidyselect_1.2.1         farver_2.1.2             ScaledMatrix_1.18.0
#>  [40] viridis_0.6.5            BiocFileCache_3.0.0      jsonlite_2.0.0
#>  [43] BiocNeighbors_2.4.0      tidygraph_1.3.1          ggridges_0.5.7
#>  [46] survival_3.8-3           dbscan_1.2.3             segmented_2.1-4
#>  [49] tools_4.5.1              Rcpp_1.1.0               glue_1.8.0
#>  [52] gridExtra_2.3            SparseArray_1.10.0       BiocBaseUtils_1.12.0
#>  [55] xfun_0.53                dplyr_1.1.4              HDF5Array_1.38.0
#>  [58] withr_3.0.2              BiocManager_1.30.26      fastmap_1.2.0
#>  [61] rhdf5filters_1.22.0      bluster_1.20.0           digest_0.6.37
#>  [64] rsvd_1.0.5               R6_2.6.1                 dichromat_2.0-0.1
#>  [67] RSQLite_2.4.3            h5mread_1.2.0            tidyr_1.3.1
#>  [70] data.table_1.17.8        robustbase_0.99-6        graphlayouts_1.2.2
#>  [73] httr_1.4.7               htmlwidgets_1.6.4        S4Arrays_1.10.0
#>  [76] uwot_0.2.3               pkgconfig_2.0.3          gtable_0.3.6
#>  [79] blob_1.2.4               S7_0.2.0                 XVector_0.50.0
#>  [82] htmltools_0.5.8.1        bookdown_0.45            scales_1.4.0
#>  [85] png_0.1-8                SpatialExperiment_1.20.0 scran_1.38.0
#>  [88] knitr_1.50               reshape2_1.4.4           rjson_0.2.23
#>  [91] nlme_3.1-168             curl_7.0.0               cachem_1.1.0
#>  [94] stringr_1.5.2            BiocVersion_3.22.0       parallel_4.5.1
#>  [97] vipor_0.4.7              AnnotationDbi_1.72.0     pillar_1.11.1
#> [100] grid_4.5.1               vctrs_0.6.5              randomForest_4.7-1.2
#> [103] BiocSingular_1.26.0      dbplyr_2.5.1             beachmat_2.26.0
#> [106] cluster_2.1.8.1          beeswarm_0.4.0           evaluate_1.0.5
#> [109] tinytex_0.57             magick_2.9.0             cli_3.6.5
#> [112] locfit_1.5-9.12          compiler_4.5.1           rlang_1.1.6
#> [115] crayon_1.5.3             labeling_0.4.3           plyr_1.8.9
#> [118] ggbeeswarm_0.7.2         stringi_1.8.7            viridisLite_0.4.2
#> [121] BiocParallel_1.44.0      Biostrings_2.78.0        lazyeval_0.2.2
#> [124] compositions_2.0-9       ExperimentHub_3.0.0      bit64_4.6.0-1
#> [127] Rhdf5lib_1.32.0          KEGGREST_1.50.0          statmod_1.5.1
#> [130] AnnotationHub_4.0.0      kernlab_0.9-33           igraph_2.2.1
#> [133] memoise_2.0.1            bslib_0.9.0              DEoptimR_1.1-4
#> [136] bit_4.6.0
```