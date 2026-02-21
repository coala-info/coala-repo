# HoloFoodR: interface to HoloFoodR database

#### 2025-10-30

#### Package

HoloFoodR 1.4.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Load the package](#load-the-package)
* [4 Functionalities](#functionalities)
  + [4.1 Search data](#search-data)
  + [4.2 Get data](#get-data)
  + [4.3 Get data on samples](#get-data-on-samples)
  + [4.4 Incorporate with MGnify data](#incorporate-with-mgnify-data)
  + [4.5 Extra: Get data from MetaboLights database](#extra-get-data-from-metabolights-database)
* [5 Session info](#session-info)

# 1 Introduction

`HoloFoodR` is a package designed to ease access to the EBI’s
[HoloFoodR](https://www.holofooddata.org/) resource, allowing searching and
retrieval of multiple datasets for downstream analysis.

The HoloFood database does not encompass metagenomics data; however,
such data is stored within the [MGnify](https://www.ebi.ac.uk/metagenomics)
database. Both packages offer analogous functionalities, streamlining the
integration of data and enhancing accessibility.

*[TreeSummarizedExperiment](https://bioconductor.org/packages/3.22/TreeSummarizedExperiment)*

# 2 Installation

`HoloFoodR` is hosted on Bioconductor, and can be installed using via
`BiocManager`.

```
BiocManager::install("HoloFoodR")
```

# 3 Load the package

Once installed, `HoloFoodR` is made available in the usual way.

```
library(HoloFoodR)
#> Loading required package: MultiAssayExperiment
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
#> Loading required package: TreeSummarizedExperiment
#> Loading required package: SingleCellExperiment
#> Loading required package: Biostrings
#> Loading required package: XVector
#>
#> Attaching package: 'Biostrings'
#> The following object is masked from 'package:base':
#>
#>     strsplit
```

# 4 Functionalities

`HoloFoodR` offers three functions `doQuery()`, `getResult()` and `getData()`
which can be utilized to search and fetch data from HoloFood database.

In this tutorial, we demonstrate how to search animals, subset animals based
on whether they have specific sample type, and finally fetch the data on
samples. Note that this same can be done with `doQuery()` and `getResult()`
(or `getData()` and `getResult()`) only by utilizing query filters. This
tutorial is for demonstrating the functionality of the package.

Additionally, the package includes `getMetaboLights()` function which can be
utilized to retrieve metabolomic data from MetaboLights database.

## 4.1 Search data

To search animals, genome catalogues, samples or viral catalogues, you can use
`doQuery()` function. You can also use `getData()` but `doQuery()` is optimized
for searching these datatypes. For example, instead of nested list of sample
types `doQuery()` returns sample types as presence/absence table which is more
convenient.

Here we search animals, and subset them based on whether they include
histological samples. Note that this same can be done also by using query
filters.

```
animals <- doQuery("animals", max.hits = 100)
animals <- animals[ animals[["histological"]], ]

colnames(animals) |> head()
#> [1] "accession"            "system"               "canonical_url"
#> [4] "histological"         "host_genomic"         "inflammatory_markers"
```

`doQuery()` returns a `data.frame` including information on type of data being
searched.

## 4.2 Get data

Now we have information on which animal has histological samples. Let’s get
data on those animals to know the sample IDs to fetch.

```
animal_data <- getData(
    accession.type = "animals", accession = animals[["accession"]])
```

The returned value of `getData()` function is a `list`. We can have the data
also as a `data.frame` when we specify `flatten = TRUE`. The data has
information on animals including samples that have been drawn from them.

```
samples <- animal_data[["samples"]]

colnames(samples) |> head()
#> [1] "accession"        "title"            "sample_type"      "animal"
#> [5] "canonical_url"    "metagenomics_url"
```

The elements of the `list` are `data.frames`. For example, “samples” table
contains information on samples drawn from animals that were specified in input.

Now we can collect sample IDs.

```
sample_ids <- unique(samples[["accession"]])
```

## 4.3 Get data on samples

To get data on samples, we can utilize `getResult()` function. It returns the
data in *[MultiAssayExperiment](https://bioconductor.org/packages/3.22/MultiAssayExperiment)* (`MAE`) format.

```
mae <- getResult(sample_ids)
#> Warning: Data for the following samples cannot be found. The sample types are metagenomic_assembly, host_genomic, transcriptomic and metatranscriptomic (Note that metagenomic assemblies can be found from the MGnify database. See MGnifyR package.):
#> 'SAMEA10130025', 'SAMEA13389405', 'SAMEA13389406', 'SAMEA13901590', 'SAMEA13901591', 'SAMEA13929779', 'SAMEA7697591', 'SAMEA10130091', 'SAMEA13389692', 'SAMEA13389693', 'SAMEA13901708', 'SAMEA7571845', 'SAMEA10158030', 'SAMEA13389419', 'SAMEA13389420', 'SAMEA13901594', 'SAMEA13901595', 'SAMEA13929781', 'SAMEA7697592', 'SAMEA10130039', 'SAMEA13389496', 'SAMEA13389497', 'SAMEA13901618', 'SAMEA13901619', 'SAMEA13929785', 'SAMEA7571815', 'SAMEA10130112', 'SAMEA13389794', 'SAMEA13389795', 'SAMEA13901758', 'SAMEA13901759', 'SAMEA13929811', 'SAMEA7571864', 'SAMEA10158022', 'SAMEA13389146', 'SAMEA13389147', 'SAMEA13901511', 'SAMEA13901512', 'SAMEA13929767', 'SAMEA7571777', 'SAMEA10130019', 'SAMEA13389353', 'SAMEA13389354', 'SAMEA13389355', 'SAMEA13901574', 'SAMEA13901575', 'SAMEA14095991', 'SAMEA7722475', 'SAMEA10130101', 'SAMEA13389738', 'SAMEA13389739', 'SAMEA13901730', 'SAMEA13901731', 'SAMEA13929802', 'SAMEA7571856', 'SAMEA10455480', 'SAMEA13389220', 'SAMEA10129993', 'SAMEA13389183', 'SAMEA13389184', 'SAMEA13901520', 'SAMEA13901521', 'SAMEA7697579', 'SAMEA10130017', 'SAMEA13389345', 'SAMEA13389346', 'SAMEA13901571', 'SAMEA13901572', 'SAMEA13929772', 'SAMEA7571801', 'SAMEA10130113', 'SAMEA13389807', 'SAMEA13389808', 'SAMEA13901762', 'SAMEA13901763', 'SAMEA13929813', 'SAMEA7571866', 'SAMEA10455481', 'SAMEA13389227', 'SAMEA10455479', 'SAMEA13389169', 'SAMEA10130020', 'SAMEA13389357', 'SAMEA13389358', 'SAMEA13901576', 'SAMEA13901577', 'SAMEA13929773', 'SAMEA7697587', 'SAMEA10130100', 'SAMEA13389734', 'SAMEA13389735', 'SAMEA13901728', 'SAMEA13901729', 'SAMEA13929801', 'SAMEA7697622', 'SAMEA10130016', 'SAMEA13389342', 'SAMEA13389343', 'SAMEA13901569', 'SAMEA13901570', 'SAMEA13929771', 'SAMEA7571800', 'SAMEA10130040', 'SAMEA13389503', 'SAMEA13389504', 'SAMEA13901620', 'SAMEA13901621', 'SAMEA13929786', 'SAMEA7571816', 'SAMEA10129979', 'SAMEA13389081', 'SAMEA13389082', 'SAMEA13901489', 'SAMEA13901490', 'SAMEA7571769', 'SAMEA10130002', 'SAMEA13389243', 'SAMEA13389244', 'SAMEA13901540', 'SAMEA13901541', 'SAMEA7697582', 'SAMEA10129985', 'SAMEA13389133', 'SAMEA13389134', 'SAMEA13901505', 'SAMEA13901506', 'SAMEA13929764', 'SAMEA7571775', 'SAMEA10455476', 'SAMEA13389110', 'SAMEA10130031', 'SAMEA13389443', 'SAMEA13389444', 'SAMEA13901602', 'SAMEA13901603', 'SAMEA7571811', 'SAMEA10130023', 'SAMEA13389395', 'SAMEA13389396', 'SAMEA13901586', 'SAMEA13901587', 'SAMEA13929777', 'SAMEA7571806', 'SAMEA10130090', 'SAMEA13389687', 'SAMEA13389688', 'SAMEA13901707', 'SAMEA7571844', 'SAMEA10130119', 'SAMEA13389832', 'SAMEA13389833', 'SAMEA13901773', 'SAMEA13929818', 'SAMEA7697633', 'SAMEA10129996', 'SAMEA13389204', 'SAMEA13389205', 'SAMEA13901529', 'SAMEA13901530', 'SAMEA7697580', 'SAMEA10130088', 'SAMEA13389677', 'SAMEA13389678', 'SAMEA13901704', 'SAMEA13929799', 'SAMEA7571843'
mae
#> A MultiAssayExperiment object of 8 listed
#>  experiments with user-defined names and respective classes.
#>  Containing an ExperimentList class object of length 8:
#>  [1] BIOGENIC AMINES: TreeSummarizedExperiment with 7 rows and 35 columns
#>  [2] FATTY ACIDS: TreeSummarizedExperiment with 19 rows and 57 columns
#>  [3] HISTOLOGY: TreeSummarizedExperiment with 20 rows and 57 columns
#>  [4] INFLAMMATORY MARKERS: TreeSummarizedExperiment with 14 rows and 58 columns
#>  [5] metagenomic_assembly: TreeSummarizedExperiment with 0 rows and 53 columns
#>  [6] host_genomic: TreeSummarizedExperiment with 0 rows and 53 columns
#>  [7] transcriptomic: TreeSummarizedExperiment with 0 rows and 44 columns
#>  [8] metatranscriptomic: TreeSummarizedExperiment with 0 rows and 16 columns
#> Functionality:
#>  experiments() - obtain the ExperimentList instance
#>  colData() - the primary/phenotype DataFrame
#>  sampleMap() - the sample coordination DataFrame
#>  `$`, `[`, `[[` - extract colData columns, subset, or experiment
#>  *Format() - convert into a long or wide DataFrame
#>  assays() - convert ExperimentList to a SimpleList of matrices
#>  exportClass() - save data to flat files
```

`MAE` object stores individual omics as
*[TreeSummarizedExperiment](https://bioconductor.org/packages/3.22/TreeSummarizedExperiment)* (`TreeSE`) objects.

```
mae[[1]]
#> class: TreeSummarizedExperiment
#> dim: 7 35
#> metadata(0):
#> assays(1): counts
#> rownames(7): Cadaverin Gesamtamine (Total biogenic amines) ... Spermin
#>   Tyramin
#> rowData names(4): marker.name marker.type marker.canonical_url units
#> colnames(35): SAMEA112906114 SAMEA112906592 ... SAMEA112906002
#>   SAMEA112906785
#> colData names(13): accession sample_type ... Project Sample code
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
#> rowLinks: NULL
#> rowTree: NULL
#> colLinks: NULL
#> colTree: NULL
```

In `TreeSE`, each column represents a sample and rows represent features.

## 4.4 Incorporate with MGnify data

`MGnifyR` is a package that can be utilized to fetch metagenomics data from
MGnify database. From the `MGnifyR` package, we can use
`MGnifyR::searchAnalysis()` function to search analyses based on sample IDs
that we have.

```
library(MGnifyR)

mg <- MgnifyClient(useCache = TRUE)

# Get those samples that are metagenomic samples
metagenomic_samples <- samples[
    samples[["sample_type"]] == "metagenomic_assembly", ]

# Get analysis IDs based on sample IDs
analysis_ids <- searchAnalysis(
    mg, type = "samples", metagenomic_samples[["accession"]])
```

```
head(analysis_ids)
#>  SAMEA10130025   SAMEA7697591  SAMEA10130091   SAMEA7571845  SAMEA10158030
#> "MGYA00606535" "MGYA00616692" "MGYA00606528" "MGYA00616689" "MGYA00606518"
#>   SAMEA7697592
#> "MGYA00615947"
```

Then we can fetch data based on accession IDs.

```
mae_metagenomic <- MGnifyR::getResult(mg, analysis_ids)
```

```
mae_metagenomic
#> A MultiAssayExperiment object of 6 listed
#>  experiments with user-defined names and respective classes.
#>  Containing an ExperimentList class object of length 6:
#>  [1] microbiota: TreeSummarizedExperiment with 675 rows and 52 columns
#>  [2] go-slim: TreeSummarizedExperiment with 116 rows and 52 columns
#>  [3] go-terms: TreeSummarizedExperiment with 3264 rows and 52 columns
#>  [4] interpro-identifiers: TreeSummarizedExperiment with 19681 rows and 52 columns
#>  [5] taxonomy: TreeSummarizedExperiment with 1438 rows and 52 columns
#>  [6] taxonomy-lsu: TreeSummarizedExperiment with 1856 rows and 52 columns
#> Functionality:
#>  experiments() - obtain the ExperimentList instance
#>  colData() - the primary/phenotype DataFrame
#>  sampleMap() - the sample coordination DataFrame
#>  `$`, `[`, `[[` - extract colData columns, subset, or experiment
#>  *Format() - convert into a long or wide DataFrame
#>  assays() - convert ExperimentList to a SimpleList of matrices
#>  exportClass() - save data to flat files
```

`MGnifyR::getResult()` returns `MAE` object just like `HoloFoodR`. However,
metagenomic data points to individual analyses instead of samples. We can
harmonize the data by replacing analysis IDs with sample IDs, and then we can
combine the data to single `MAE`.

```
# Get experiments from metagenomic data
exps <- experiments(mae_metagenomic)
# Convert analysis names to sample names
exps <- lapply(exps, function(x){
    # Get corresponding sample ID
    sample_id <- names(analysis_ids)[ match(colnames(x), analysis_ids) ]
    # Replace analysis ID with sample ID
    colnames(x) <- sample_id
    return(x)
})

# Add to original MultiAssayExperiment
mae <- c(experiments(mae), exps)
mae
```

Now, with the `MAE` object linking samples from various omics together,
compatibility is ensured as the single omics datasets are in
`(Tree)SummarizedExperiment` format. This compatibility allows us to harness
cutting-edge downstream analytics tools like
[miaverse framework](https://microbiome.github.io/) that support these data
containers seamlessly.

## 4.5 Extra: Get data from MetaboLights database

The HoloFood database exclusively contains targeted metabolomic data. However,
it provides URL addresses linking to the MetaboLights database, where untargeted
metabolomics data can be accessed. To retrieve this data, you can utilize the
getMetaboLights() function to retrieve information on available data. Moreover,
it returns processed metabolomic data (for processed data, you can also use
`getReturn(x, get.metabolomic=TRUE)`). Below, we retrieve all the processed
(mapped) metabolomic data associated with HoloFood.

```
# Get untargeted metabolomic samples
samples <- doQuery("samples", sample_type = "metabolomic")
# Get the data
metabolomic <- getMetaboLights(samples[["metabolomics_url"]])

# Show names of data.frames
names(metabolomic)
```

The result is a list that includes three data.frames:

```
- study metadata
- assay metadata
- assay that includes abundance table and feature metadata
```

For spectra data, you can either fetch files using `getMetaboLightsFile()`,
or follow this
[vignette](https://rformassspectrometry.github.io/MsIO/articles/MsIO.html#loading-data-from-metabolights)
for guidance on loading data directly into an object,
which is tailored for metabolomics spectra data.

# 5 Session info

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
#>  [1] HoloFoodR_1.4.0                 TreeSummarizedExperiment_2.18.0
#>  [3] Biostrings_2.78.0               XVector_0.50.0
#>  [5] SingleCellExperiment_1.32.0     MultiAssayExperiment_1.36.0
#>  [7] SummarizedExperiment_1.40.0     Biobase_2.70.0
#>  [9] GenomicRanges_1.62.0            Seqinfo_1.0.0
#> [11] IRanges_2.44.0                  S4Vectors_0.48.0
#> [13] BiocGenerics_0.56.0             generics_0.1.4
#> [15] MatrixGenerics_1.22.0           matrixStats_1.5.0
#> [17] knitr_1.50                      BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] httr2_1.2.1          xfun_0.53            bslib_0.9.0
#>  [4] lattice_0.22-7       vctrs_0.6.5          tools_4.5.1
#>  [7] yulab.utils_0.2.1    curl_7.0.0           parallel_4.5.1
#> [10] tibble_3.3.0         pkgconfig_2.0.3      BiocBaseUtils_1.12.0
#> [13] Matrix_1.7-4         lifecycle_1.0.4      compiler_4.5.1
#> [16] treeio_1.34.0        codetools_0.2-20     htmltools_0.5.8.1
#> [19] sass_0.4.10          yaml_2.3.10          lazyeval_0.2.2
#> [22] pillar_1.11.1        crayon_1.5.3         jquerylib_0.1.4
#> [25] tidyr_1.3.1          BiocParallel_1.44.0  DelayedArray_0.36.0
#> [28] cachem_1.1.0         abind_1.4-8          nlme_3.1-168
#> [31] tidyselect_1.2.1     digest_0.6.37        stringi_1.8.7
#> [34] dplyr_1.1.4          purrr_1.1.0          bookdown_0.45
#> [37] fastmap_1.2.0        grid_4.5.1           cli_3.6.5
#> [40] SparseArray_1.10.0   magrittr_2.0.4       S4Arrays_1.10.0
#> [43] ape_5.8-1            rappdirs_0.3.3       rmarkdown_2.30
#> [46] evaluate_1.0.5       rlang_1.1.6          Rcpp_1.1.0
#> [49] glue_1.8.0           tidytree_0.4.6       BiocManager_1.30.26
#> [52] jsonlite_2.0.0       R6_2.6.1             fs_1.6.6
```