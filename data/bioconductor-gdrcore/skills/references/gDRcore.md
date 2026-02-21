# gDRcore

gDR team

#### 30 October 2025

# Contents

* [1 Overview](#overview)
* [2 Introduction](#introduction)
  + [2.1 Data model](#data-model)
  + [2.2 Drug processing](#drug-processing)
  + [2.3 Required columns](#required-columns)
  + [2.4 gDR pipeline](#gdr-pipeline)
* [3 Use Cases](#use-cases)
  + [3.1 Data preprocessing](#data-preprocessing)
  + [3.2 Running gDR pipeline](#running-gdr-pipeline)
  + [3.3 Data extraction](#data-extraction)
* [SessionInfo](#sessioninfo)

# 1 Overview

The `gDRcore` is part of the `gDR` suite. The package provides a set of tools to process and analyze drug response data.

# 2 Introduction

## 2.1 Data model

The data model is built on the MultiAssayExperiment (MAE) structure. Within an MAE, each SummarizedExperiment (SE) contains a different experiment type (e.g., single-agent or combination treatment). Columns of the MAE are defined by the cell lines and any modifications to them and are shared with the SEs. Rows are defined by the treatments (e.g., drugs, perturbations) and are specific to each SE. Assays of the SE are the different levels of data processing (raw, control, normalized, averaged data, as well as metrics). Each nested element of the assays of the SEs comprises the series themselves as a table (data.table in practice). Although not all elements need to have a series or the same number of elements, the attributes (columns of the table) should be consistent across the SE.

## 2.2 Drug processing

For drug response data, the input files need to be merged such that each measurement (data) is associated with the correct metadata (cell line properties and treatment definition). Metadata can be added with the function `cleanup_metadata` if the right reference databases are in place.

## 2.3 Required columns

To process the data through `runDrugResponseProcessingPipeline`, the input data should contain the required columns as well as optional columns.

For single-agent experiments, the required columns are:
\* Gnumber
\* DrugName
\* drug\_moa
\* Concentration
\* clid
\* CellLineName
\* Tissue
\* ReferenceDivisionTime
\* parental\_identifier
\* subtype
\* Duration
\* ReadoutValue

For combination experiments, additional required fields are:
\* Gnumber\_2
\* DrugName\_2
\* drug\_moa\_2
\* Concentration\_2

gDR supports the inclusion of any additional metadata in the long table for the pipeline. However, the most common supported by default are:

* Barcode (or Plate)
* BackgroundValue
* WellRow
* WellColumn

## 2.4 gDR pipeline

When the data and metadata are merged into a long table, the wrapper function `runDrugResponseProcessingPipeline` can be used to generate an MAE with processed and analyzed data.

![Figure 1. The overview of the runDrugResponseProcessingPipeline.](data:image/png;base64...).

In practice, `runDrugResponseProcessingPipeline` performs the following steps:

* `create_SE`: Creates the structure of the MAE and the associated SEs by assigning metadata into the row and column attributes. The assignment is performed in the function `split_SE_components` (see details below for the assumptions made when building SE structures). `create_SE` also dispatches the raw data and controls into the right nested tables. Note that data may be duplicated between different SEs to make them self-contained.
* `normalize_SE`: Normalizes the raw data based on the control. Calculation of the GR value is based on a cell line division time provided by the reference database if no pre-treatment control is provided. If both pieces of information are missing, GR values cannot be calculated. Additional normalization can be added as new rows in the nested table.
* `average_SE`: Averages technical replicates that are stored in the same nested table.
* `fit_SE`: Fits the dose-response curves and calculates response metrics for each normalization type.
* `fit_SE.combinations`: Calculates synergy scores for drug combination data and, if the data is appropriate, fits along the two drugs and matrix-level metrics (e.g., isobolograms) are calculated. This is also performed for each normalization type independently.

![Figure 2. Detailed overview of the drug processing pipeline.](data:image/png;base64...).

The functions used to process the data have parameters for specifying the names of the variables and assays. Additional parameters are available to personalize the processing steps, such as forcing the nesting (or not) of an attribute and specifying attributes that should be considered as technical replicates or not.

# 3 Use Cases

## 3.1 Data preprocessing

Please familiarize yourself with the `gDRimport` package, which contains a variety of tools to prepare input data for `gDRcore`.

This example is based on the artificial dataset called `data1` available within the `gDRimport` package. `gDR` requires three types of data that should be used as the raw input: Template, Manifest, and RawData. More information about these three types of data can be found in our general documentation.

```
td <- gDRimport::get_test_data()
```

The provided dataset needs to be merged into one `data.table` object to be able to run the gDR pipeline. This process can be done using two functions: `gDRimport::load_data()` and `gDRcore::merge_data()`.

## 3.2 Running gDR pipeline

We provide an all-in-one function that splits data into appropriate data types, creates the SummarizedExperiment object for each data type, splits data into treatment and control assays, normalizes, averages, calculates gDR metrics, and finally, creates the MultiAssayExperiment object. This function is called `runDrugResponseProcessingPipeline`.

```
mae <- runDrugResponseProcessingPipeline(input_df)
```

```
mae
#> A MultiAssayExperiment object of 2 listed
#>  experiments with user-defined names and respective classes.
#>  Containing an ExperimentList class object of length 2:
#>  [1] combination: SummarizedExperiment with 2 rows and 6 columns
#>  [2] single-agent: SummarizedExperiment with 3 rows and 6 columns
#> Functionality:
#>  experiments() - obtain the ExperimentList instance
#>  colData() - the primary/phenotype DataFrame
#>  sampleMap() - the sample coordination DataFrame
#>  `$`, `[`, `[[` - extract colData columns, subset, or experiment
#>  *Format() - convert into a long or wide DataFrame
#>  assays() - convert ExperimentList to a SimpleList of matrices
#>  exportClass() - save data to flat files
```

And we can subset the MultiAssayExperiment to receive the SummarizedExperiment specific to any data type, e.g.

```
mae[["single-agent"]]
#> class: SummarizedExperiment
#> dim: 3 6
#> metadata(5): identifiers experiment_metadata Keys fit_parameters
#>   .internal
#> assays(5): RawTreated Controls Normalized Averaged Metrics
#> rownames(3): G00002_drug_002_moa_A_168 G00004_drug_004_moa_A_168
#>   G00011_drug_011_moa_B_168
#> rowData names(4): Gnumber DrugName drug_moa Duration
#> colnames(6): CL00011_cellline_BA_breast_cellline_BA_unknown_26
#>   CL00012_cellline_CA_breast_cellline_CA_unknown_30 ...
#>   CL00015_cellline_FA_breast_cellline_FA_unknown_42
#>   CL00018_cellline_IB_breast_cellline_IB_unknown_54
#> colData names(6): clid CellLineName ... subtype ReferenceDivisionTime
```

## 3.3 Data extraction

Extraction of the data from either `MultiAssayExperiment` or `SummarizedExperiment` objects into more user-friendly structures, as well as other data transformations, can be done using `gDRutils`. We encourage reading the `gDRutils` vignette to familiarize yourself with these functionalities.

# SessionInfo

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
#> [1] gDRcore_1.8.0     gDRtestData_1.7.3 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] SummarizedExperiment_1.40.0 xfun_0.53
#>  [3] bslib_0.9.0                 Biobase_2.70.0
#>  [5] lattice_0.22-7              vctrs_0.6.5
#>  [7] tools_4.5.1                 generics_0.1.4
#>  [9] sandwich_3.1-1              BumpyMatrix_1.18.0
#> [11] stats4_4.5.1                parallel_4.5.1
#> [13] tibble_3.3.0                BiocBaseUtils_1.12.0
#> [15] drc_3.0-1                   pkgconfig_2.0.3
#> [17] Matrix_1.7-4                data.table_1.17.8
#> [19] checkmate_2.3.3             RColorBrewer_1.1-3
#> [21] S4Vectors_0.48.0            gDRutils_1.8.0
#> [23] readxl_1.4.5                assertthat_0.2.1
#> [25] rematch_2.0.0               lifecycle_1.0.4
#> [27] farver_2.1.2                compiler_4.5.1
#> [29] stringr_1.5.2               brio_1.1.5
#> [31] Seqinfo_1.0.0               codetools_0.2-20
#> [33] carData_3.0-5               htmltools_0.5.8.1
#> [35] sass_0.4.10                 yaml_2.3.10
#> [37] Formula_1.2-5               pillar_1.11.1
#> [39] car_3.1-3                   jquerylib_0.1.4
#> [41] MASS_7.3-65                 BiocParallel_1.44.0
#> [43] DelayedArray_0.36.0         cachem_1.1.0
#> [45] multcomp_1.4-29             abind_1.4-8
#> [47] gtools_3.9.5                digest_0.6.37
#> [49] mvtnorm_1.3-3               stringi_1.8.7
#> [51] purrr_1.1.0                 bookdown_0.45
#> [53] splines_4.5.1               fastmap_1.2.0
#> [55] grid_4.5.1                  gDRimport_1.8.0
#> [57] cli_3.6.5                   SparseArray_1.10.0
#> [59] magrittr_2.0.4              S4Arrays_1.10.0
#> [61] dichromat_2.0-0.1           survival_3.8-3
#> [63] TH.data_1.1-4               scales_1.4.0
#> [65] backports_1.5.0             plotrix_3.8-4
#> [67] rmarkdown_2.30              lambda.r_1.2.4
#> [69] XVector_0.50.0              matrixStats_1.5.0
#> [71] futile.logger_1.4.3         cellranger_1.1.0
#> [73] zoo_1.8-14                  evaluate_1.0.5
#> [75] knitr_1.50                  GenomicRanges_1.62.0
#> [77] IRanges_2.44.0              MultiAssayExperiment_1.36.0
#> [79] testthat_3.2.3              rlang_1.1.6
#> [81] futile.options_1.0.1        glue_1.8.0
#> [83] BiocManager_1.30.26         formatR_1.14
#> [85] BiocGenerics_0.56.0         jsonlite_2.0.0
#> [87] R6_2.6.1                    MatrixGenerics_1.22.0
```