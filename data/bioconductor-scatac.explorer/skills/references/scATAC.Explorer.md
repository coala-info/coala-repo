# scATAC.Explorer

Arrian Gibson-Khademi

#### 4 November 2025

#### Package

scATAC.Explorer 1.16.0

# Contents

* [1 Introduction](#introduction)
* [2 Exploring available datasets](#exploring-available-datasets)
  + [2.1 Searching by year](#searching-by-year)
* [3 Getting datasets](#getting-datasets)
  + [3.1 Example: Returning all datasets with cell-type labels](#example-returning-all-datasets-with-cell-type-labels)
* [4 Saving Data](#saving-data)
* [5 Session Information](#session-information)

```
library(scATAC.Explorer)
#> Loading required package: SingleCellExperiment
#> Loading required package: SummarizedExperiment
#> Loading required package: MatrixGenerics
#> Loading required package: matrixStats
#>
#> Attaching package: 'MatrixGenerics'
#> The following objects are masked from 'package:matrixStats':
#>
#>     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
#>     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
#>     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
#>     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
#>     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
#>     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
#>     colWeightedMeans, colWeightedMedians, colWeightedSds,
#>     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
#>     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
#>     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
#>     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
#>     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
#>     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
#>     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
#>     rowWeightedSds, rowWeightedVars
#> Loading required package: GenomicRanges
#> Loading required package: stats4
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Loading required package: S4Vectors
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: IRanges
#> Loading required package: Seqinfo
#> Loading required package: Biobase
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#>
#> Attaching package: 'Biobase'
#> The following object is masked from 'package:MatrixGenerics':
#>
#>     rowMedians
#> The following objects are masked from 'package:matrixStats':
#>
#>     anyMissing, rowMedians
#> Loading required package: BiocFileCache
#> Loading required package: dbplyr
#> Loading required package: data.table
#>
#> Attaching package: 'data.table'
#> The following object is masked from 'package:SummarizedExperiment':
#>
#>     shift
#> The following object is masked from 'package:GenomicRanges':
#>
#>     shift
#> The following object is masked from 'package:IRanges':
#>
#>     shift
#> The following objects are masked from 'package:S4Vectors':
#>
#>     first, second
#> Loading required package: zellkonverter
#> Registered S3 method overwritten by 'zellkonverter':
#>   method                                             from
#>   py_to_r.pandas.core.arrays.categorical.Categorical reticulate
```

# 1 Introduction

scATAC.Explorer (Single Cell ATAC-seq Explorer) is a curated collection of publicly available scATAC-seq datasets.
It aims to provide a single point of entry for users looking to investigate epigenetics and chromatin accessibilty at a single cell resolution across many available datasets.

Users can quickly search available datasets using the metadata table, and then download any datasets they have discovered relevant to their research in a standard and easily accessible format.
Optionally, users can save the datasets for use in applications other than R.

This package will improve the ease of studying the epigenome across a variety of organisims, cell types, and diseases.
Developers may use this package to obtain data for validation of new algorithms, or to study differences between scATAC-seq datasets.

# 2 Exploring available datasets

Start by exploring the available datasets through metadata.

```
res = queryATAC(metadata_only = TRUE)
```

| X | Reference | Accession | Author | Journal |
| --- | --- | --- | --- | --- |
| 1 | Satpathy\_NatureBiotech\_2019 | GSE129785 | Satpathy | Nature Biotech |
| 2 | Satpathy\_NatureBiotech\_2019 | GSE129785 | Satpathy | Nature Biotech |
| 3 | Satpathy\_NatureBiotech\_2019 | GSE129785 | Satpathy | Nature Biotech |
| 4 | Satpathy\_NatureBiotech\_2019 | GSE129785 | Satpathy | Nature Biotech |
| 5 | Buenrostro\_Cell\_2018 | GSE96769 | Buenrostro | Cell |
| 6 | Corces\_NatureGenetics\_2016 | GSE74310 | Corces | Nature Genetics |

This will return a list containing a single dataframe of metadata for all available datasets.
View the metadata with `View(res[[1]])` and then check `?queryATAC` for a description of searchable fields.

Note: in order to keep the function’s interface consistent, `queryATAC` always returns a list of objects, even if there is only one object.
You may prefer running `res = queryATAC(metadata_only = TRUE)[[1]]` in order to save the dataframe directly.

The `metatadata_only` argument can be applied alongside any other argument in order to examine only datasets that have certain qualities.
You can, for instance, view only breast cancer datasets by using

```
res = queryATAC(disease = 'leukemia', metadata_only = TRUE)[[1]]
```

|  | X | Reference | Accession | Author | Journal |
| --- | --- | --- | --- | --- | --- |
| 6 | 6 | Corces\_NatureGenetics\_2016 | GSE74310 | Corces | Nature Genetics |
| 45 | 45 | Satpathy\_NatureMedicine\_2018 | GSE107817 | Satpathy | Nature Medicine |

Table 1: Search parameters for `queryATAC` alongside example values.

| Search Parameter | Description | Examples |
| --- | --- | --- |
| accession | Search by unique accession number or ID | GSE129785, GSE89362 |
| has\_cell\_types | Filter by presence of cell-type annotations | TRUE, FALSE |
| has\_clusters | Filter by presence of cluster results | TRUE, FALSE |
| disease | Search by disease | Carcinoma, Leukemia |
| broad\_cell\_category | Search by broad cell cateogries present in datasets | Neuronal, Immune |
| tissue\_cell\_type | Search by tissue or cell type when available | PBMC, glia, cerebral cortex |
| author | Search by first author | Satpathy, Cusanovich |
| journal | Search by publication journal | Science, Nature, Cell |
| year | Search by year of publication | <2015, >2015, 2013-2015 |
| pmid | Search by PubMed ID | 27526324, 32494068 |
| sequence\_tech | Search by sequencing technology | 10x Genomics Chromium |
| organism | Search by source organism | Mus musculus |
| genome\_build | Search by genome build | hg19, hg38, mm10 |
| sparse | Return expression in sparse matrices | TRUE, FALSE |

## 2.1 Searching by year

In order to search by single years and a range of years, the package looks for specific patterns.
‘2013-2015’ will search for datasets published between 2013 and 2015, inclusive.
‘<2015’ or ‘2015>’ will search for datasets published before or in 2015.
‘>2015’ or ‘2015<’ will search for datasets published in or after 2015.

# 3 Getting datasets

Once you’ve found a field to search on, you can get your data.
For this example, we’re pulling a specific dataset by its GEO accession ID.

```
res = queryATAC(accession = "GSE89362")
#> Error while performing HEAD request.
#>    Proceeding without cache information.
```

This will return a list containing dataset GSE89362.
The dataset is stored as a `SingleCellExperiment` object,
which has the following metadata attached to the object:

Table 2: Metadata attributes in the `SingleCellExperiment` object.

| Attribute | Description |
| --- | --- |
| cells | A list of cells included in the study |
| regions | A list of genomic regions (peaks) included in the study |
| pmid | The PubMed ID of the study |
| technology | The sequencing technology used |
| genome\_build | The genome build used for data generation |
| score\_type | The type of scoring or normalization used on the counts data |
| organism | The type of organism from which cells were sequenced |
| author | The first author of the paper presenting the data |
| disease | The diseases sampled cells were sampled from |
| summary | A broad summary of the study conditions the sample was assayed from |
| accession | The GEO accession ID for the dataset |

To access the chromatin accessibility counts data for a result, use

```
View(counts(res[[1]]))
```

|  | Ik0h.r1.A1 | Ik0h.r1.A2 | Ik0h.r1.A3 | Ik0h.r1.A4 | Ik0h.r1.A5 | Ik0h.r1.A6 | Ik0h.r1.B10 | Ik0h.r1.B12 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| chr1-63176687-63176922 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| chr1-125435762-125435907 | 1 | 1 | 1 | 0 | 0 | 0 | 1 | 0 |
| chr1-139067353-139067473 | 0 | 2 | 0 | 0 | 0 | 0 | 0 | 0 |
| chr1-152305577-152305725 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| chr1-9748401-9748588 | 1 | 2 | 0 | 0 | 0 | 0 | 1 | 2 |
| chr1-51478424-51478572 | 0 | 1 | 0 | 0 | 1 | 0 | 1 | 0 |
| chr1-53296958-53297153 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| chr1-53313523-53313648 | 0 | 0 | 0 | 0 | 0 | 0 | 2 | 0 |
| chr1-75251656-75251790 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| chr1-105971701-105971845 | 1 | 0 | 0 | 0 | 0 | 0 | 2 | 1 |

Cell type labels and/or cluster assignments are stored under `colData(res[[1]])` for datasets
for which cell type labels and cluster assignments are available.

Metadata is stored in a named list accessible by `metadata(res[[1]])`.
Specific entries can be accessed by attribute name.

```
metadata(res[[1]])$pmid
#> [1] "31682608"
```

## 3.1 Example: Returning all datasets with cell-type labels

Say you want to compare chromatin accessibility between known cell types.
To do this, you need datasets that have cell-type annotations available.
Be aware that returning a large amount of datasets like this will require a large amount of memory (greater than 16GB, if not more).

```
res = queryATAC(has_cell_type = TRUE)
```

This will return a list of all datasets that have cell-types annotations available.
You can see the cell types for the first dataset using the following command:

```
View(colData(res[[1]]))
```

|  |
| --- |
| Ik0h.r1.A1 |
| Ik0h.r1.A2 |
| Ik0h.r1.A3 |
| Ik0h.r1.A4 |
| Ik0h.r1.A5 |
| Ik0h.r1.A6 |

The first column of this dataframe contains the cell cluster assignment (if available), and the second contains the cell type assignment (if available). The row names of the dataframe specify the cell ID/barcode the annotation belongs to.

# 4 Saving Data

To facilitate the use of any or all datasets outside of R, you can use `saveATAC()`.
`saveATAC` takes two parameters. The first parameter is the `data` object to be saved (ie. a SingleCellExperiment object
from `queryATAC()`). The second paramter is a string specifying the directory you would like data to be saved in.
Note that the output directory should not already exist.

To save the data from the earlier example to disk, use the following commands.

```
res = queryATAC(accession = "GSE89362")[[1]]
saveATAC(res, '~/Downloads/GSE89362')
```

The result is three files saving the scATAC-seq dataset in the Matrix Market format that can be used in other programs.
A fourth csv file will be saved if cell type annotations or cluster assignments are available in the dataset.

# 5 Session Information

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
#>  [1] scATAC.Explorer_1.16.0      zellkonverter_1.20.0
#>  [3] data.table_1.17.8           BiocFileCache_3.0.0
#>  [5] dbplyr_2.5.1                SingleCellExperiment_1.32.0
#>  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [9] GenomicRanges_1.62.0        Seqinfo_1.0.0
#> [11] IRanges_2.44.0              S4Vectors_0.48.0
#> [13] BiocGenerics_0.56.0         generics_0.1.4
#> [15] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [17] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] dir.expiry_1.18.0   xfun_0.54           bslib_0.9.0
#>  [4] httr2_1.2.1         lattice_0.22-7      vctrs_0.6.5
#>  [7] tools_4.5.1         curl_7.0.0          parallel_4.5.1
#> [10] tibble_3.3.0        RSQLite_2.4.3       blob_1.2.4
#> [13] pkgconfig_2.0.3     Matrix_1.7-4        lifecycle_1.0.4
#> [16] compiler_4.5.1      htmltools_0.5.8.1   sass_0.4.10
#> [19] yaml_2.3.10         pillar_1.11.1       jquerylib_0.1.4
#> [22] DelayedArray_0.36.0 cachem_1.1.0        abind_1.4-8
#> [25] basilisk_1.22.0     tidyselect_1.2.1    digest_0.6.37
#> [28] purrr_1.1.0         dplyr_1.1.4         bookdown_0.45
#> [31] fastmap_1.2.0       grid_4.5.1          cli_3.6.5
#> [34] SparseArray_1.10.1  magrittr_2.0.4      S4Arrays_1.10.0
#> [37] filelock_1.0.3      rappdirs_0.3.3      bit64_4.6.0-1
#> [40] rmarkdown_2.30      XVector_0.50.0      bit_4.6.0
#> [43] reticulate_1.44.0   png_0.1-8           memoise_2.0.1
#> [46] evaluate_1.0.5      knitr_1.50          rlang_1.1.6
#> [49] Rcpp_1.1.0          glue_1.8.0          DBI_1.2.3
#> [52] BiocManager_1.30.26 jsonlite_2.0.0      R6_2.6.1
```