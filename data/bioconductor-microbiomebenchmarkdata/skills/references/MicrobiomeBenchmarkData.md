# MicrobiomeBenchmarkData

Samuel Gamboa\* and Levi Waldron

\*Samuel.Gamboa.Tuz@gmail.com

#### 4 November 2025

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Sample metadata](#sample-metadata)
* [4 Accessing datasets](#accessing-datasets)
  + [4.1 Print avaialable datasets](#print-avaialable-datasets)
  + [4.2 Access a single dataset](#access-a-single-dataset)
  + [4.3 Access a few datasets](#access-a-few-datasets)
  + [4.4 Access all of the datasets](#access-all-of-the-datasets)
* [5 Annotations for each taxa are included in rowData](#annotations-for-each-taxa-are-included-in-rowdata)
* [6 Cache](#cache)
* [7 Session information](#session-information)

# 1 Introduction

The `MicrobiomeBenchamrkData` package provides access to a collection of
datasets with biological ground truth for benchmarking differential
abundance methods. The datasets are deposited on Zenodo:
<https://doi.org/10.5281/zenodo.6911026>

# 2 Installation

```
## Install BioConductor if not installed
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

## Release version (not yet in Bioc, so it doesn't work yet)
BiocManager::install("MicrobiomeBenchmarkData")

## Development version
BiocManager::install("waldronlab/MicrobiomeBenchmarkData")
```

```
library(MicrobiomeBenchmarkData)
library(purrr)
```

# 3 Sample metadata

All sample metadata is merged into a single data frame and provided as a data
object:

```
data('sampleMetadata', package = 'MicrobiomeBenchmarkData')
## Get columns present in all samples
sample_metadata <- sampleMetadata |>
    discard(~any(is.na(.x))) |>
    head()
knitr::kable(sample_metadata)
```

| dataset | sample\_id | body\_site | library\_size | pmid | study\_condition | sequencing\_method |
| --- | --- | --- | --- | --- | --- | --- |
| HMP\_2012\_16S\_gingival\_V13 | 700103497 | oral\_cavity | 5356 | 22699609 | control | 16S |
| HMP\_2012\_16S\_gingival\_V13 | 700106940 | oral\_cavity | 4489 | 22699609 | control | 16S |
| HMP\_2012\_16S\_gingival\_V13 | 700097304 | oral\_cavity | 3043 | 22699609 | control | 16S |
| HMP\_2012\_16S\_gingival\_V13 | 700099015 | oral\_cavity | 2832 | 22699609 | control | 16S |
| HMP\_2012\_16S\_gingival\_V13 | 700097644 | oral\_cavity | 2815 | 22699609 | control | 16S |
| HMP\_2012\_16S\_gingival\_V13 | 700097247 | oral\_cavity | 6333 | 22699609 | control | 16S |

# 4 Accessing datasets

Currently, there are 6
datasets available through the MicrobiomeBenchmarkData. These datasets are
accessed through the `getBenchmarkData` function.

## 4.1 Print avaialable datasets

If no arguments are provided, the list of available datasets is printed on
screen and a data.frame is returned with the description of the datasets:

```
dats <- getBenchmarkData()
#> 1 HMP_2012_16S_gingival_V13
#> 2 HMP_2012_16S_gingival_V35
#> 3 HMP_2012_16S_gingival_V35_subset
#> 4 HMP_2012_WMS_gingival
#> 5 Stammler_2016_16S_spikein
#> 6 Ravel_2011_16S_BV
#>
#> Use vignette('datasets', package = 'MicrobiomeBenchmarkData') for a detailed description of the datasets.
#>
#> Use getBenchmarkData(dryrun = FALSE) to import all of the datasets.
```

```
dats
#>                            Dataset  Dimensions Body.site
#> 1        HMP_2012_16S_gingival_V13 33127 x 311   Gingiva
#> 2        HMP_2012_16S_gingival_V35 17949 x 311   Gingiva
#> 3 HMP_2012_16S_gingival_V35_subset    892 x 76   Gingiva
#> 4            HMP_2012_WMS_gingival    235 x 16   Gingiva
#> 5        Stammler_2016_16S_spikein   247 x 394     Stool
#> 6                Ravel_2011_16S_BV   4036 x 17    Vagina
#>                                                                     Contrasts
#> 1                                        Subgingival vs Supragingival plaque.
#> 2                                        Subgingival vs Supragingival plaque.
#> 3                                        Subgingival vs Supragingival plaque.
#> 4                                        Subgingival vs Supragingival plaque.
#> 5 Pre-ASCT (allogeneic stem cell transplantation) vs 14 days after treatment.
#> 6                                              Healthy vs bacterial vaginosis
#>                                                                                                                                                                                               Biological.ground.truth
#> 1                                                                                                  Enrichment of aerobic taxa in the supragingival plaque and enrichment of anaerobic taxa in the subgingival plaque.
#> 2                                                                                                  Enrichment of aerobic taxa in the supragingival plaque and enrichment of anaerobic taxa in the subgingival plaque.
#> 3                                                                                                  Enrichment of aerobic taxa in the supragingival plaque and enrichment of anaerobic taxa in the subgingival plaque.
#> 4                                                                                                  Enrichment of aerobic taxa in the supragingival plaque and enrichment of anaerobic taxa in the subgingival plaque.
#> 5 Same bacterial loads of the spike-in bacteria across all samples: Salinibacter ruber (extreme halophilic), Rhizobium radiobacter (found in soils and plants), and Alicyclobacillus acidiphilu (thermo-acidophilic).
#> 6                                                                    Decrease of Lactobacillus and increase of bacteria isolated during bacterial vaginosis in samples with high Nugent scores (bacterial vaginosis).
```

## 4.2 Access a single dataset

In order to import a dataset, the `getBenchmarkData` function must be used with
the name of the dataset as the first argument (`x`) and the `dryrun` argument
set to `FALSE`. The output is a list vector with the dataset imported as a
TreeSummarizedExperiment object.

```
tse <- getBenchmarkData('HMP_2012_16S_gingival_V35_subset', dryrun = FALSE)[[1]]
#> Finished HMP_2012_16S_gingival_V35_subset.
tse
#> class: TreeSummarizedExperiment
#> dim: 892 76
#> metadata(0):
#> assays(1): counts
#> rownames(892): OTU_97.31247 OTU_97.44487 ... OTU_97.45365 OTU_97.45307
#> rowData names(7): kingdom phylum ... genus taxon_annotation
#> colnames(76): 700023057 700023179 ... 700114009 700114338
#> colData names(13): dataset subject_id ... sequencing_method
#>   variable_region_16s
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
#> rowLinks: a LinkDataFrame (892 rows)
#> rowTree: 1 phylo tree(s) (892 leaves)
#> colLinks: NULL
#> colTree: NULL
```

## 4.3 Access a few datasets

Several datasets can be imported simultaneously by giving the names of the
different datasets in a character vector:

```
list_tse <- getBenchmarkData(dats$Dataset[2:4], dryrun = FALSE)
#> Finished HMP_2012_16S_gingival_V35.
#> Finished HMP_2012_16S_gingival_V35_subset.
#> Finished HMP_2012_WMS_gingival.
str(list_tse, max.level = 1)
#> List of 3
#>  $ HMP_2012_16S_gingival_V35       :Formal class 'TreeSummarizedExperiment' [package "TreeSummarizedExperiment"] with 14 slots
#>  $ HMP_2012_16S_gingival_V35_subset:Formal class 'TreeSummarizedExperiment' [package "TreeSummarizedExperiment"] with 14 slots
#>  $ HMP_2012_WMS_gingival           :Formal class 'TreeSummarizedExperiment' [package "TreeSummarizedExperiment"] with 14 slots
```

## 4.4 Access all of the datasets

If all of the datasets must to be imported, this can be done by providing
the `dryrun = FALSE` argument alone.

```
mbd <- getBenchmarkData(dryrun = FALSE)
#> Finished HMP_2012_16S_gingival_V13.
#> Finished HMP_2012_16S_gingival_V35.
#> Finished HMP_2012_16S_gingival_V35_subset.
#> Finished HMP_2012_WMS_gingival.
#> Warning: No taxonomy_tree available for Ravel_2011_16S_BV.
#> Finished Ravel_2011_16S_BV.
#> Warning: No taxonomy_tree available for Stammler_2016_16S_spikein.
#> Finished Stammler_2016_16S_spikein.
str(mbd, max.level = 1)
#> List of 6
#>  $ HMP_2012_16S_gingival_V13       :Formal class 'TreeSummarizedExperiment' [package "TreeSummarizedExperiment"] with 14 slots
#>  $ HMP_2012_16S_gingival_V35       :Formal class 'TreeSummarizedExperiment' [package "TreeSummarizedExperiment"] with 14 slots
#>  $ HMP_2012_16S_gingival_V35_subset:Formal class 'TreeSummarizedExperiment' [package "TreeSummarizedExperiment"] with 14 slots
#>  $ HMP_2012_WMS_gingival           :Formal class 'TreeSummarizedExperiment' [package "TreeSummarizedExperiment"] with 14 slots
#>  $ Ravel_2011_16S_BV               :Formal class 'TreeSummarizedExperiment' [package "TreeSummarizedExperiment"] with 14 slots
#>  $ Stammler_2016_16S_spikein       :Formal class 'TreeSummarizedExperiment' [package "TreeSummarizedExperiment"] with 14 slots
```

# 5 Annotations for each taxa are included in rowData

The biological annotations of each taxa are provided as a column in the
`rowData` slot of the TreeSummarizedExperiment.

```
## In the case, the column is named as taxon_annotation
tse <- mbd$HMP_2012_16S_gingival_V35_subset
rowData(tse)
#> DataFrame with 892 rows and 7 columns
#>                  kingdom      phylum       class           order
#>              <character> <character> <character>     <character>
#> OTU_97.31247    Bacteria  Firmicutes     Bacilli Lactobacillales
#> OTU_97.44487    Bacteria  Firmicutes     Bacilli Lactobacillales
#> OTU_97.34979    Bacteria  Firmicutes     Bacilli Lactobacillales
#> OTU_97.34572    Bacteria  Firmicutes     Bacilli Lactobacillales
#> OTU_97.42259    Bacteria  Firmicutes     Bacilli Lactobacillales
#> ...                  ...         ...         ...             ...
#> OTU_97.44294    Bacteria  Firmicutes     Bacilli Lactobacillales
#> OTU_97.45429    Bacteria  Firmicutes     Bacilli Lactobacillales
#> OTU_97.44375    Bacteria  Firmicutes     Bacilli Lactobacillales
#> OTU_97.45365    Bacteria  Firmicutes     Bacilli Lactobacillales
#> OTU_97.45307    Bacteria  Firmicutes     Bacilli Lactobacillales
#>                        family         genus      taxon_annotation
#>                   <character>   <character>           <character>
#> OTU_97.31247 Streptococcaceae Streptococcus facultative_anaerobic
#> OTU_97.44487 Streptococcaceae Streptococcus facultative_anaerobic
#> OTU_97.34979 Streptococcaceae Streptococcus facultative_anaerobic
#> OTU_97.34572 Streptococcaceae Streptococcus facultative_anaerobic
#> OTU_97.42259 Streptococcaceae Streptococcus facultative_anaerobic
#> ...                       ...           ...                   ...
#> OTU_97.44294 Streptococcaceae Streptococcus facultative_anaerobic
#> OTU_97.45429 Streptococcaceae Streptococcus facultative_anaerobic
#> OTU_97.44375 Streptococcaceae Streptococcus facultative_anaerobic
#> OTU_97.45365 Streptococcaceae Streptococcus facultative_anaerobic
#> OTU_97.45307 Streptococcaceae Streptococcus facultative_anaerobic
```

# 6 Cache

The datasets are cached so they’re only downloaded once. The cache and all of
the files contained in it can be removed with the `removeCache` function.

```
removeCache()
```

# 7 Session information

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
#>  [1] purrr_1.1.0                     MicrobiomeBenchmarkData_1.12.0
#>  [3] TreeSummarizedExperiment_2.18.0 Biostrings_2.78.0
#>  [5] XVector_0.50.0                  SingleCellExperiment_1.32.0
#>  [7] SummarizedExperiment_1.40.0     Biobase_2.70.0
#>  [9] GenomicRanges_1.62.0            Seqinfo_1.0.0
#> [11] IRanges_2.44.0                  S4Vectors_0.48.0
#> [13] BiocGenerics_0.56.0             generics_0.1.4
#> [15] MatrixGenerics_1.22.0           matrixStats_1.5.0
#> [17] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] httr2_1.2.1         xfun_0.54           bslib_0.9.0
#>  [4] lattice_0.22-7      vctrs_0.6.5         tools_4.5.1
#>  [7] yulab.utils_0.2.1   curl_7.0.0          parallel_4.5.1
#> [10] tibble_3.3.0        RSQLite_2.4.3       blob_1.2.4
#> [13] pkgconfig_2.0.3     Matrix_1.7-4        dbplyr_2.5.1
#> [16] lifecycle_1.0.4     compiler_4.5.1      treeio_1.34.0
#> [19] codetools_0.2-20    htmltools_0.5.8.1   sass_0.4.10
#> [22] yaml_2.3.10         lazyeval_0.2.2      pillar_1.11.1
#> [25] crayon_1.5.3        jquerylib_0.1.4     tidyr_1.3.1
#> [28] BiocParallel_1.44.0 DelayedArray_0.36.0 cachem_1.1.0
#> [31] abind_1.4-8         nlme_3.1-168        tidyselect_1.2.1
#> [34] digest_0.6.37       dplyr_1.1.4         bookdown_0.45
#> [37] fastmap_1.2.0       grid_4.5.1          cli_3.6.5
#> [40] SparseArray_1.10.1  magrittr_2.0.4      S4Arrays_1.10.0
#> [43] ape_5.8-1           withr_3.0.2         filelock_1.0.3
#> [46] rappdirs_0.3.3      bit64_4.6.0-1       rmarkdown_2.30
#> [49] bit_4.6.0           memoise_2.0.1       evaluate_1.0.5
#> [52] knitr_1.50          BiocFileCache_3.0.0 rlang_1.1.6
#> [55] Rcpp_1.1.0          glue_1.8.0          tidytree_0.4.6
#> [58] DBI_1.2.3           BiocManager_1.30.26 jsonlite_2.0.0
#> [61] R6_2.6.1            fs_1.6.6
```