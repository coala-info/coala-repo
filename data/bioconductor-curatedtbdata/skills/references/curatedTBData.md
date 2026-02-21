# curatedTBData

Xutao Wang1\*, Prasad Patil1\*\* and W. Evan Johnson2\*\*\*

1Department of Biostatistics, Boston University School of Public Health, Boston, MA, U.S.A.
2Section of Computational Biomedicine, Boston University School of Medicine, Boston, MA, U.S.A.

\*xutaow@bu.edu
\*\*patil@bu.edu
\*\*\*wej@bu.edu

#### 2025-11-06

#### Abstract

The curatedTBData is an R package that provides standardized, curated tuberculosis(TB) transcriptomic studies. The initial release of the package contains 49 studies. The curatedTBData package allows users to access tuberculosis trancriptomic efficiently and to make easy comparison for different TB gene signatures across multiple datasets.

#### Package

curatedTBData 2.6.0

# Contents

* [1 Installation](#installation)
* [2 R packages](#r-packages)
* [3 Access to MetaData](#access-to-metadata)
* [4 Access curated tuberculosis gene expression profile](#access-curated-tuberculosis-gene-expression-profile)
* [5 Subset/Combine MultiAssayExperiment objects](#subsetcombine-multiassayexperiment-objects)
  + [5.1 Subset](#subset)
* [6 Dataset integeration](#dataset-integeration)
  + [6.1 Merge Studies with common gene symbols](#merge-studies-with-common-gene-symbols)
  + [6.2 Batch correction](#batch-correction)
* [7 Dataset subset](#dataset-subset)
  + [7.1 Select patients with Active TB and LTBI](#select-patients-with-active-tb-and-ltbi)
  + [7.2 Select other outcome of interests](#select-other-outcome-of-interests)
* [8 Session Info](#session-info)

# 1 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("curatedTBData")
```

# 2 R packages

```
library(curatedTBData)
library(dplyr)
library(SummarizedExperiment)
library(sva)
```

# 3 Access to MetaData

The `DataSummary` table summarized the list of available studies and
their metadata information contained in the curatedTBData package.

```
# Remove GeographicalRegion, Age, DiagnosisMethod, Notes, Tissue, HIVStatus for concise display
data("DataSummary", package = "curatedTBData")
DataSummary |>
  dplyr::select(-c(`Country/Region`, Age, DiagnosisMethod, Notes,
                   Tissue, HIVStatus)) |>
  DT::datatable()
```

# 4 Access curated tuberculosis gene expression profile

Users can use `curatedTBData()` function to access data.
There are three arguments in the function.
The first argument `study_name` represents the names of the data that are used
to determine the resources of interests.
Users can find all available resource names from `DataSummary$Study`.
The second argument `dry.run` enables users to determine the resources’s
availability before actually downloading them.
When `dry.run` is set to `TRUE`, the output includes names of the resources.
The third argument `curated.only` allows the users to access
the curated ready-to-use data.
If `curated.only` is `TRUE`, the function only download the curated
gene expression profile and the clinical annotation of the corresponding data.
If `curated.only` is `FALSE`, the function downloads all available resources
for input studies.

```
curatedTBData("GSE19439", dry.run = TRUE, curated.only = FALSE)
```

```
## dry.run = TRUE, listing dataset(s) to be downloaded
## Set dry.run = FALSE to download dataset(s).
```

```
## Will download the following resources for GSE19439 from the ExperimentHub:
## GSE19439_assay_raw
## GSE19439_assay_curated
## GSE19439_column_data
## GSE19439_row_data
## GSE19439_meta_data
```

To download complete data for a Microarry study (e.g. [GSE19439](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE19439)),
we set `dry.run = FALSE` and `curated.only = FALSE`.
There are two experiments assay being included in the output Microarray studies.
The first experiment is `assay_curated`, which is a `matrix` that represents
normalized, curated version of the gene expression profile.
The second experiment is `assay_raw`, which is a
*[SummarziedExperiment](https://bioconductor.org/packages/3.22/SummarziedExperiment)* object that contains the raw gene expression profile and information about probe features.

```
GSE19439 <- curatedTBData("GSE19439", dry.run = FALSE, curated.only = FALSE)
```

```
## Downloading: GSE19439
```

```
##
  |
  |                                                                      |   0%
  |
  |==============                                                        |  20%
  |
  |============================                                          |  40%
  |
  |==========================================                            |  60%
  |
  |========================================================              |  80%
  |
  |======================================================================| 100%
```

```
## Finished!
```

```
GSE19439
```

```
## $GSE19439
## A MultiAssayExperiment object of 2 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 2:
##  [1] assay_curated: matrix with 25417 rows and 42 columns
##  [2] object_raw: SummarizedExperiment with 48803 rows and 42 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

When accessing data for RNA sequencing studies, another assay called
`assay_reprocess` is included. This `matrix` represents the reprocessed version
of gene expression profile from the raw .fastq files using
*[Rsubread](https://bioconductor.org/packages/3.22/Rsubread)*.

```
GSE79362 <- curatedTBData("GSE79362", dry.run = FALSE, curated.only = FALSE)
```

```
## Downloading: GSE79362
```

```
##
  |
  |                                                                      |   0%
  |
  |==========                                                            |  14%
  |
  |====================                                                  |  29%
  |
  |==============================                                        |  43%
  |
  |========================================                              |  57%
  |
  |==================================================                    |  71%
  |
  |============================================================          |  86%
  |
  |======================================================================| 100%
```

```
## Finished!
```

```
GSE79362
```

```
## $GSE79362
## A MultiAssayExperiment object of 4 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 4:
##  [1] assay_curated: matrix with 13419 rows and 355 columns
##  [2] assay_reprocess_hg19: matrix with 25369 rows and 355 columns
##  [3] assay_reprocess_hg38: matrix with 60642 rows and 355 columns
##  [4] object_raw: SummarizedExperiment with 134866 rows and 355 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

A list of *[MultiAssayExperiment](https://bioconductor.org/packages/3.22/MultiAssayExperiment)* objects is returned
when `dry.run` is `FALSE`.

```
myGEO <- c("GSE19435", "GSE19439", "GSE19442", "GSE19444", "GSE22098")
object_list <- curatedTBData(myGEO, dry.run = FALSE, curated.only = TRUE)
```

```
## curated.only = TRUE. Download curated version.
## Set curated.only = FALSE if want to download both raw and curated data.
```

```
## Downloading: GSE19435
```

```
## Downloading: GSE19439
```

```
## Downloading: GSE19442
```

```
## Downloading: GSE19444
```

```
## Downloading: GSE22098
```

```
## Finished!
```

```
object_list[1:2]
```

```
## $GSE19435
## A MultiAssayExperiment object of 1 listed
##  experiment with a user-defined name and respective class.
##  Containing an ExperimentList class object of length 1:
##  [1] assay_curated: matrix with 25417 rows and 33 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
##
## $GSE19439
## A MultiAssayExperiment object of 1 listed
##  experiment with a user-defined name and respective class.
##  Containing an ExperimentList class object of length 1:
##  [1] assay_curated: matrix with 25417 rows and 42 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

A full version example for RNA sequencing data:
[GSE79362](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE79362).

```
GSE79362 <- curatedTBData("GSE79362", dry.run = FALSE, curated.only = FALSE)
```

```
## Downloading: GSE79362
```

```
## Finished!
```

```
GSE79362
```

```
## $GSE79362
## A MultiAssayExperiment object of 4 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 4:
##  [1] assay_curated: matrix with 13419 rows and 355 columns
##  [2] assay_reprocess_hg19: matrix with 25369 rows and 355 columns
##  [3] assay_reprocess_hg38: matrix with 60642 rows and 355 columns
##  [4] object_raw: SummarizedExperiment with 134866 rows and 355 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

# 5 Subset/Combine MultiAssayExperiment objects

## 5.1 Subset

The major advantage of using *[MultiAssayExperiment](https://bioconductor.org/packages/3.22/MultiAssayExperiment)*
is the coordination of the meta-data and assays when sub-setting.
The MultiAssayExperiment object has built-in function for subsetting samples
based on column condition.

```
GSE19439 <- object_list$GSE19439
GSE19439[, GSE19439$TBStatus == "PTB"]["assay_curated"] # 13 samples
```

```
## A MultiAssayExperiment object of 1 listed
##  experiment with a user-defined name and respective class.
##  Containing an ExperimentList class object of length 1:
##  [1] assay_curated: matrix with 0 rows and 13 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

The following example shows how to subset patients with active TB and LTBI

```
GSE19439[, GSE19439$TBStatus %in% c("PTB", "LTBI")]["assay_curated"] # 30 samples
```

```
## A MultiAssayExperiment object of 1 listed
##  experiment with a user-defined name and respective class.
##  Containing an ExperimentList class object of length 1:
##  [1] assay_curated: matrix with 0 rows and 30 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

# 6 Dataset integeration

## 6.1 Merge Studies with common gene symbols

The `combine_objects()` function provides an easy implementation for
combining different studies based on common gene symbols.
The function returns a *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* object that contains
the merged assay and associated clinical annotation. Noticed that [GSE74092](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi) is usually
removed from merging, because it used quantitative PCR,
which did not have enough coverage to capture all genes.
There are two arguments in the `combine_objects()` function.
The first one is `object_list`, which takes a list of
*[MultiAssayExperiment](https://bioconductor.org/packages/3.22/MultiAssayExperiment)* objects obtained from `curatedTBData()`. Notice that the `names(object_list)` should not be `NULL`
and must be unique for each object within the list,
so that we can keep track the original study after merging.
The second argument is `experiment_name`, which can be a string or vector of strings representing the name of the assay from the object.

```
GSE19491 <- combine_objects(object_list, experiment_name = "assay_curated",
                            update_genes = TRUE)
```

```
## "update_genes" is TRUE, updating gene symbols
```

```
GSE19491
```

```
## class: SummarizedExperiment
## dim: 25065 454
## metadata(0):
## assays(1): assay1
## rownames(25065): A1BG A1CF ... ZZZ3 dJ341D10.1
## rowData names(0):
## colnames(454): GSM484368 GSM484369 ... GSM550399 GSM550400
## colData names(32): Age Gender ... StaphStatus StrepStatus
```

When the objects are merged, the original individual data tag can be found
in the `Study` section from the metadata.

```
unique(GSE19491$Study)
```

```
## [1] "GSE19435" "GSE19439" "GSE19442" "GSE19444" "GSE22098"
```

It is also possible to combine the given list of objects with
different experiment names. In this case, the `experiment_name` is a vector of
string that corresponds to each of object from the input list.

```
exp <- combine_objects(c(GSE79362[1], object_list[1]),
                       experiment_name = c("assay_reprocess_hg19",
                                           "assay_curated"),
                       update_genes = TRUE)
```

```
## Found more than one "experiment_name".
```

```
## "update_genes" is TRUE, updating gene symbols
```

```
exp
```

```
## class: SummarizedExperiment
## dim: 18925 388
## metadata(0):
## assays(1): assay1
## rownames(18925): A1BG A1CF ... ZZEF1 ZZZ3
## rowData names(0):
## colnames(388): GSM2092905 GSM2092906 ... GSM484399 GSM484400
## colData names(31): Age Gender ... DiabetesStatus Treatment
```

## 6.2 Batch correction

If datasets are merged, it is typically recommended to
remove a very likely batch effect.
We use the `ComBat()` function from *[sva](https://bioconductor.org/packages/3.22/sva)* to remove
potential batch effect between studies.
In the following example, each study is viewed as one batch. The batch corrected
assay will be stored in a *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* object.

```
batch1 <- colData(GSE19491)$Study
combat_edata1 <- sva::ComBat(dat = assay(GSE19491), batch = batch1)
assays(GSE19491)[["Batch_corrected_assay"]] <- combat_edata1
GSE19491
```

```
## class: SummarizedExperiment
## dim: 25065 454
## metadata(0):
## assays(2): assay1 Batch_corrected_assay
## rownames(25065): A1BG A1CF ... ZZZ3 dJ341D10.1
## rowData names(0):
## colnames(454): GSM484368 GSM484369 ... GSM550399 GSM550400
## colData names(32): Age Gender ... StaphStatus StrepStatus
```

# 7 Dataset subset

The function `subset_curatedTBData()` allows the users to subset a list of
*[MultiAssayExperiment](https://bioconductor.org/packages/3.22/MultiAssayExperiment)* with the output contains
the exact conditions given by the `annotationCondition`.
With `subset_curatedTBData()`, users can quickly subset desired results
from *[curatedTBData](https://bioconductor.org/packages/3.22/curatedTBData)* database without checking individual object.
There are four arguments in this function.
The `theObject` represents a *[MultiAssayExperiment](https://bioconductor.org/packages/3.22/MultiAssayExperiment)* or
*[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* object.
The `annotationColName` is a character that indicates the
column name in the metadata. The `annotationCondition` is a character or
vector of characters that the users intend to select.

## 7.1 Select patients with Active TB and LTBI

In the following example, we call `subset_curatedTBData()` function to
subset samples with active TB (`PTB`) and latent TB infection (`LTBI`) for
binary classification.

```
multi_set_PTB_LTBI <- lapply(object_list, function(x)
  subset_curatedTBData(x, annotationColName = "TBStatus",
                       annotationCondition = c("LTBI", "PTB"),
                       assayName = "assay_curated"))
# Remove NULL from the list
multi_set_PTB_LTBI <- multi_set_PTB_LTBI[!sapply(multi_set_PTB_LTBI, is.null)]
multi_set_PTB_LTBI[1:3]
```

```
## $GSE19439
## class: SummarizedExperiment
## dim: 25417 30
## metadata(0):
## assays(1): assay1
## rownames(25417): 7A5 A1BG ... ZZEF1 ZZZ3
## rowData names(0):
## colnames(30): GSM484448 GSM484449 ... GSM484488 GSM484489
## colData names(24): Age Gender ... DiabetesStatus QFT_GIT
##
## $GSE19442
## class: SummarizedExperiment
## dim: 25417 51
## metadata(0):
## assays(1): assay1
## rownames(25417): 7A5 A1BG ... ZZEF1 ZZZ3
## rowData names(0):
## colnames(51): GSM484500 GSM484501 ... GSM484549 GSM484550
## colData names(23): Age Gender ... isolate_sensitivity DiabetesStatus
##
## $GSE19444
## class: SummarizedExperiment
## dim: 25417 42
## metadata(0):
## assays(1): assay1
## rownames(25417): 7A5 A1BG ... ZZEF1 ZZZ3
## rowData names(0):
## colnames(42): GSM484595 GSM484596 ... GSM484645 GSM484646
## colData names(24): Age Gender ... DiabetesStatus QFT_GIT
```

## 7.2 Select other outcome of interests

The HIV status (`HIVStatus`) and diabetes status (`DiabetesStatus`) for each
subject were also recorded for each study in the *[curatedTBData](https://bioconductor.org/packages/3.22/curatedTBData)*.
In the following example, we select subjects with HIV positive from the input.
Users can also find HIV status information for each study by
looking at the column: `HIVStatus` from `DataSummary`.
When the the length of the `annotationCondition` equals to 1, we can subset using
either `MultiAssayExperiment` built-in procedure or `subset_curatedTBData`.

```
multi_set_HIV <- lapply(object_list, function(x)
  subset_curatedTBData(x, annotationColName = "HIVStatus",
                       annotationCondition = "Negative",
                       assayName = "assay_curated"))
# Remove NULL from the list
multi_set_HIV <- multi_set_HIV[!vapply(multi_set_HIV, is.null, TRUE)]
multi_set_HIV[1:3]
```

```
## $GSE19435
## class: SummarizedExperiment
## dim: 25417 33
## metadata(0):
## assays(1): assay1
## rownames(25417): 7A5 A1BG ... ZZEF1 ZZZ3
## rowData names(0):
## colnames(33): GSM484368 GSM484369 ... GSM484399 GSM484400
## colData names(24): Age Gender ... DiabetesStatus Treatment
##
## $GSE19439
## class: SummarizedExperiment
## dim: 25417 42
## metadata(0):
## assays(1): assay1
## rownames(25417): 7A5 A1BG ... ZZEF1 ZZZ3
## rowData names(0):
## colnames(42): GSM484448 GSM484449 ... GSM484488 GSM484489
## colData names(24): Age Gender ... DiabetesStatus QFT_GIT
##
## $GSE19442
## class: SummarizedExperiment
## dim: 25417 51
## metadata(0):
## assays(1): assay1
## rownames(25417): 7A5 A1BG ... ZZEF1 ZZZ3
## rowData names(0):
## colnames(51): GSM484500 GSM484501 ... GSM484549 GSM484550
## colData names(23): Age Gender ... isolate_sensitivity DiabetesStatus
```

# 8 Session Info

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] sva_3.58.0                  BiocParallel_1.44.0
##  [3] genefilter_1.92.0           mgcv_1.9-3
##  [5] nlme_3.1-168                SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [13] generics_0.1.4              MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0           dplyr_1.1.4
## [17] curatedTBData_2.6.0         BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            blob_1.2.4
##  [3] filelock_1.0.3              Biostrings_2.78.0
##  [5] fastmap_1.2.0               BiocFileCache_3.0.0
##  [7] XML_3.99-0.19               digest_0.6.37
##  [9] lifecycle_1.0.4             statmod_1.5.1
## [11] survival_3.8-3              KEGGREST_1.50.0
## [13] RSQLite_2.4.3               magrittr_2.0.4
## [15] compiler_4.5.1              rlang_1.1.6
## [17] sass_0.4.10                 tools_4.5.1
## [19] yaml_2.3.10                 data.table_1.17.8
## [21] knitr_1.50                  htmlwidgets_1.6.4
## [23] S4Arrays_1.10.0             bit_4.6.0
## [25] curl_7.0.0                  splitstackshape_1.4.8
## [27] DelayedArray_0.36.0         abind_1.4-8
## [29] purrr_1.2.0                 withr_3.0.2
## [31] grid_4.5.1                  ExperimentHub_3.0.0
## [33] xtable_1.8-4                edgeR_4.8.0
## [35] MultiAssayExperiment_1.36.0 cli_3.6.5
## [37] rmarkdown_2.30              crayon_1.5.3
## [39] httr_1.4.7                  BiocBaseUtils_1.12.0
## [41] DBI_1.2.3                   cachem_1.1.0
## [43] splines_4.5.1               parallel_4.5.1
## [45] AnnotationDbi_1.72.0        BiocManager_1.30.26
## [47] XVector_0.50.0              vctrs_0.6.5
## [49] Matrix_1.7-4                jsonlite_2.0.0
## [51] bookdown_0.45               bit64_4.6.0-1
## [53] crosstalk_1.2.2             locfit_1.5-9.12
## [55] limma_3.66.0                jquerylib_0.1.4
## [57] annotate_1.88.0             glue_1.8.0
## [59] codetools_0.2-20            DT_0.34.0
## [61] BiocVersion_3.22.0          tibble_3.3.0
## [63] pillar_1.11.1               rappdirs_0.3.3
## [65] htmltools_0.5.8.1           R6_2.6.1
## [67] dbplyr_2.5.1                httr2_1.2.1
## [69] evaluate_1.0.5              lattice_0.22-7
## [71] AnnotationHub_4.0.0         png_0.1-8
## [73] memoise_2.0.1               bslib_0.9.0
## [75] SparseArray_1.10.1          HGNChelper_0.8.15
## [77] xfun_0.54                   pkgconfig_2.0.3
```