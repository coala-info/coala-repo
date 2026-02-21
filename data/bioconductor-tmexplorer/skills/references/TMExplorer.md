# TMExplorer

Erik Christensen

#### 4 November 2025

#### Package

TMExplorer 1.20.0

# Contents

* [1 Introduction](#introduction)
* [2 Exploring available datasets](#exploring-available-datasets)
  + [2.1 Searching by year](#searching-by-year)
* [3 Getting datasets](#getting-datasets)
  + [3.1 Example: Returning all datasets with cell-type labels](#example-returning-all-datasets-with-cell-type-labels)
  + [3.2 Example: Returning all datasets with cell-type labels and cell-type gene signatures](#example-returning-all-datasets-with-cell-type-labels-and-cell-type-gene-signatures)
* [4 Saving Data](#saving-data)
* [5 Session Information](#session-information)

```
library(TMExplorer)
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
```

# 1 Introduction

TMExplorer (Tumour Microenvironment Explorer) is a curated collection of scRNAseq datasets sequenced from tumours.
It aims to provide a single point of entry for users looking to study the tumour microenvironment at the single-cell level.

Users can quickly search available datasets using the metadata table, and then download the datasets they are interested in for analysis.
Optionally, users can save the datasets for use in applications other than R.

This package will improve the ease of studying the tumour microenvironment with single-cell sequencing.
Developers may use this package to obtain data for validation of new algorithms and researchers interested in the tumour microenvironment may use it to study specific cancers more closely.

# 2 Exploring available datasets

Start by exploring the available datasets through metadata.

```
res = queryTME(metadata_only = TRUE)
```

| Reference | accession | author | journal | year |
| --- | --- | --- | --- | --- |
| Patel\_Science\_2014 | GSE57872 | Patel | Science | 2014 |
| Tirosh\_Science\_2016a | GSE72056 | Tirosh | Science | 2016 |
| Tirosh\_Nature\_ 2016b | GSE70630 | Tirosh | Nature | 2016 |
| Venteicher\_Science\_2017 | GSE89567 | Venteicher | Science | 2017 |
| Li\_Nature\_Genetics\_2017 | GSE81861 | Li | Nature Genetics | 2017 |
| Chung\_Nature\_Commun\_2017 | GSE75688 | Chung | Nature Comm | 2017 |

This will return a list containing a single dataframe of metadata for all available datasets.
View the metadata with `View(res[[1]])` and then check `?queryTME` for a description of searchable fields.

Note: in order to keep the function’s interface consistent, `queryTME` always returns a list of objects, even if there is only one object.
You may prefer running `res = queryTME(metadata_only = TRUE)[[1]]` in order to save the dataframe directly.

The `metatadata_only` argument can be applied alongside any other argument in order to examine only datasets that have certain qualities.
You can, for instance, view only breast cancer datasets by using

```
res = queryTME(tumour_type = 'Breast cancer', metadata_only = TRUE)[[1]]
```

| Reference | accession | author | journal | year |
| --- | --- | --- | --- | --- |
| Chung\_Nature\_Commun\_2017 | GSE75688 | Chung | Nature Comm | 2017 |
| Jordan\_Nature\_2016 | GSE75367 | Jordan | Nature | 2016 |
| Azizi\_Cell\_2018 | GSE114727 | Azizi | Cell | 2018 |
| Yeo\_Elife\_2020 | GSE123366 | Yeo | Elife | 2020 |

Table 1: Search parameters for `queryTME` alongside example values.

| Search Parameter | Description | Examples |
| --- | --- | --- |
| geo\_accession | Search by GEO accession number | GSE72056, GSE57872 |
| score\_type | Search by type of score shown in $expression | TPM, RPKM, FPKM |
| has\_signatures | Filter by presence of cell-type gene signatures | TRUE, FALSE |
| has\_truth | Filter by presence of cell-type labels | TRUE, FALSE |
| tumour\_type | Search by tumour type | Breast cancer, Melanoma |
| author | Search by first author | Patel, Tirosh, Chung |
| journal | Search by publication journal | Science, Nature, Cell |
| year | Search by year of publication | <2015, >2015, 2013-2015 |
| pmid | Search by publication ID | 24925914, 27124452 |
| sequence\_tech | Search by sequencing technology | SMART-seq, Fluidigm C1 |
| organism | Search by source organism | Human, Mice |
| sparse | Return expression in sparse matrices | TRUE, FALSE |

## 2.1 Searching by year

In order to search by single years and a range of years, the package looks for specific patterns.
‘2013-2015’ will search for datasets published between 2013 and 2015, inclusive.
‘<2015’ or ‘2015>’ will search for datasets published before or in 2015.
‘>2015’ or ‘2015<’ will search for datasets published in or after 2015.

# 3 Getting datasets

Once you’ve found a field to search on, you can get your data.
For this example, we’re pulling a specific dataset by its GEO ID.

```
res = queryTME(geo_accession = "GSE81861")
#> Error while performing HEAD request.
#>    Proceeding without cache information.
#> Error while performing HEAD request.
#>    Proceeding without cache information.
#> Error while performing HEAD request.
#>    Proceeding without cache information.
```

This will return a list containing dataset GSE72056.
The dataset is stored as a `SingleCellExperiment` object,
which has the following metadata list

Table 2: Metadata attributes in the `SingleCellExperiment` object.

| Attribute | Description |
| --- | --- |
| signatures | A `data.frame` containing the cell types and a list of genes that represent that cell type |
| cells | A list of cells included in the study |
| genes | A list of genes included in the study |
| pmid | The PubMed ID of the study |
| technology | The sequencing technology used |
| score\_type | The type of score shown in `tme_data$expression` |
| organism | The type of organism from which cells were sequenced |
| author | The first author of the paper presenting the data |
| tumour\_type | The type of tumour sequenced |
| patients | The number of patients included in the study |
| tumours | The number of tumours sampled by the study |
| geo\_accession | The GEO accession ID for the dataset |

To access the expression data for a result, use

```
View(counts(res[[1]]))
```

|  | RHC3546\_\_Tcell\_\_.C6E879 | RHC3552\_\_Epithelial\_\_.2749FE |
| --- | --- | --- |
| chrX:99883666-99894988\_TSPAN6\_ENSG00000000003.10 | 3 | 0 |
| chrX:99839798-99854882\_TNMD\_ENSG00000000005.5 | 0 | 0 |
| chr20:49505584-49575092\_DPM1\_ENSG00000000419.8 | 0 | 0 |
| chr1:169631244-169863408\_SCYL3\_ENSG00000000457.9 | 0 | 0 |
| chr1:169631244-169863408\_C1orf112\_ENSG00000000460.12 | 0 | 0 |
| chr1:27938574-27961788\_FGR\_ENSG00000000938.8 | 0 | 0 |

Cell type labels are stored under `colData(res[[1]])` for datasets
for which cell type labels are available

Metadata is stored in a named list accessible by `metadata(res[[1]])`.
Specific entries can be accessed by attribute name.

```
metadata(res[[1]])$pmid
#> # A tibble: 1 × 1
#>       PMID
#>      <dbl>
#> 1 28319088
```

## 3.1 Example: Returning all datasets with cell-type labels

Say you want to measure the performance of cell-type classification methods.
To do this, you need datasets that have the true cell-types available.

```
res = queryTME(has_truth = TRUE)
```

This will return a list of all datasets that have true cell-types available.
You can see the cell types for the first dataset using the following command:

```
View(colData(res[[1]]))
```

|  | label |
| --- | --- |
| RHC3546\_\_Tcell\_\_.C6E879 | Tcell |
| RHC3552\_\_Epithelial\_\_.2749FE | Epithelial |
| RHC3553\_\_Epithelial\_\_.2749FE | Epithelial |
| RHC3555\_\_Bcell\_\_.7DEA7B | Bcell |
| RHC3556\_\_Epithelial\_\_.2749FE | Epithelial |
| RHC3557\_\_Bcell\_\_.7DEA7B | Bcell |

The first column of this dataframe contains the cell barcode, and the second contains the cell type.

## 3.2 Example: Returning all datasets with cell-type labels and cell-type gene signatures

Some cell-type classification methods require a list of gene signatures, to return only datasets that have cell-type gene signatures available, use:

```
res = queryTME(has_truth = TRUE, has_signatures = TRUE)
View(metadata(res[[1]])$signatures)
```

| MYELOID | FIBROBLAST | TCELL |
| --- | --- | --- |
| ITGAX\_ENSG00000140678.12 | SPARC\_ENSG00000113140.6 | TRBC2\_ENSG00000211772.4 |
| CD68\_ENSG00000129226.9 | COL14A1\_ENSG00000187955.7 | TRBC2\_ENSG00000211772.4 |
| CD14\_ENSG00000170458.9 | COL13A1\_ENSG00000197467.9 | CD3E\_ENSG00000198851.5 |
| CCL3\_ENSG00000006075.11 | DCN\_ENSG00000011465.12 | CD3G\_ENSG00000160654.5 |

# 4 Saving Data

To facilitate the use of any or all datasets outside of R, you can use `saveTME()`.
`saveTME` takes two parameters, one a `tme_data` object to be saved, and the other the directory you would like data to be saved in.
Note that the output directory should not already exist.

To save the data from the earlier example to disk, use the following commands.

```
res = queryTME(geo_accession = "GSE72056")[[1]]
saveTME(res, '~/Downloads/GSE72056')
```

The result is three CSV files that can be used in other programs.
In the future we will support saving in other formats.

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
#>  [1] TMExplorer_1.20.0           BiocFileCache_3.0.0
#>  [3] dbplyr_2.5.1                SingleCellExperiment_1.32.0
#>  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [9] IRanges_2.44.0              S4Vectors_0.48.0
#> [11] BiocGenerics_0.56.0         generics_0.1.4
#> [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [15] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] rappdirs_0.3.3      sass_0.4.10         SparseArray_1.10.1
#>  [4] RSQLite_2.4.3       lattice_0.22-7      digest_0.6.37
#>  [7] magrittr_2.0.4      evaluate_1.0.5      grid_4.5.1
#> [10] bookdown_0.45       blob_1.2.4          fastmap_1.2.0
#> [13] jsonlite_2.0.0      Matrix_1.7-4        DBI_1.2.3
#> [16] BiocManager_1.30.26 purrr_1.1.0         httr2_1.2.1
#> [19] jquerylib_0.1.4     abind_1.4-8         cli_3.6.5
#> [22] rlang_1.1.6         XVector_0.50.0      bit64_4.6.0-1
#> [25] cachem_1.1.0        DelayedArray_0.36.0 yaml_2.3.10
#> [28] S4Arrays_1.10.0     tools_4.5.1         memoise_2.0.1
#> [31] dplyr_1.1.4         filelock_1.0.3      curl_7.0.0
#> [34] vctrs_0.6.5         R6_2.6.1            lifecycle_1.0.4
#> [37] bit_4.6.0           pkgconfig_2.0.3     bslib_0.9.0
#> [40] pillar_1.11.1       glue_1.8.0          xfun_0.54
#> [43] tibble_3.3.0        tidyselect_1.2.1    knitr_1.50
#> [46] htmltools_0.5.8.1   rmarkdown_2.30      compiler_4.5.1
```