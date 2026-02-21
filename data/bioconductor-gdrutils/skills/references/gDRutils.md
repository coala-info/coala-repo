# gDRutils

gDR team

#### 30 October 2025

# Contents

* [1 Overview](#overview)
* [2 Use cases](#use-cases)
  + [2.1 Data manipulation](#data-manipulation)
  + [2.2 Data extraction](#data-extraction)
  + [2.3 Managing gDR identifiers](#managing-gdr-identifiers)
    - [2.3.1 Overview](#overview-1)
    - [2.3.2 Validating identifiers](#validating-identifiers)
    - [2.3.3 Prettifying identifiers](#prettifying-identifiers)
  + [2.4 Data validation](#data-validation)
  + [2.5 Prettifying](#prettifying)
    - [2.5.1 Colnames of data.table(s)](#colnames-of-data.tables)
    - [2.5.2 Assay names](#assay-names)
* [SessionInfo](#sessioninfo)

```
library(gDRutils)
suppressPackageStartupMessages(library(MultiAssayExperiment))
```

# 1 Overview

`gDRutils` is part of the `gDR` suite. This package provides a bunch of tools for, among others:

* data manipulation, especially output of the `gDRcore` package (`MultiAssayExperiments` and `SummarizedExperiment`),
* data extraction,
* managing identifiers used for creating `gDR` experiments,
* data validation.

# 2 Use cases

## 2.1 Data manipulation

The basic output of `gDRcore` package is the `MultiAssayExperiment` object. Function `MAEpply` allows for the data manipulation of this object, and can be used in a similar way as a basic function `lapply`.

```
mae <- get_synthetic_data("finalMAE_combo_matrix_small")
MAEpply(mae, dim)
#> $combination
#> [1] 6 2
#>
#> $`single-agent`
#> [1] 5 2
```

```
MAEpply(mae, rowData)
#> $combination
#> DataFrame with 6 rows and 7 columns
#>                                                    Gnumber    DrugName
#>                                                <character> <character>
#> G00004_drug_004_moa_A_G00021_drug_021_moa_D_72      G00004    drug_004
#> G00004_drug_004_moa_A_G00026_drug_026_moa_E_72      G00004    drug_004
#> G00005_drug_005_moa_A_G00021_drug_021_moa_D_72      G00005    drug_005
#> G00005_drug_005_moa_A_G00026_drug_026_moa_E_72      G00005    drug_005
#> G00006_drug_006_moa_A_G00021_drug_021_moa_D_72      G00006    drug_006
#> G00006_drug_006_moa_A_G00026_drug_026_moa_E_72      G00006    drug_006
#>                                                   drug_moa   Gnumber_2
#>                                                <character> <character>
#> G00004_drug_004_moa_A_G00021_drug_021_moa_D_72       moa_A      G00021
#> G00004_drug_004_moa_A_G00026_drug_026_moa_E_72       moa_A      G00026
#> G00005_drug_005_moa_A_G00021_drug_021_moa_D_72       moa_A      G00021
#> G00005_drug_005_moa_A_G00026_drug_026_moa_E_72       moa_A      G00026
#> G00006_drug_006_moa_A_G00021_drug_021_moa_D_72       moa_A      G00021
#> G00006_drug_006_moa_A_G00026_drug_026_moa_E_72       moa_A      G00026
#>                                                 DrugName_2  drug_moa_2
#>                                                <character> <character>
#> G00004_drug_004_moa_A_G00021_drug_021_moa_D_72    drug_021       moa_D
#> G00004_drug_004_moa_A_G00026_drug_026_moa_E_72    drug_026       moa_E
#> G00005_drug_005_moa_A_G00021_drug_021_moa_D_72    drug_021       moa_D
#> G00005_drug_005_moa_A_G00026_drug_026_moa_E_72    drug_026       moa_E
#> G00006_drug_006_moa_A_G00021_drug_021_moa_D_72    drug_021       moa_D
#> G00006_drug_006_moa_A_G00026_drug_026_moa_E_72    drug_026       moa_E
#>                                                 Duration
#>                                                <numeric>
#> G00004_drug_004_moa_A_G00021_drug_021_moa_D_72        72
#> G00004_drug_004_moa_A_G00026_drug_026_moa_E_72        72
#> G00005_drug_005_moa_A_G00021_drug_021_moa_D_72        72
#> G00005_drug_005_moa_A_G00026_drug_026_moa_E_72        72
#> G00006_drug_006_moa_A_G00021_drug_021_moa_D_72        72
#> G00006_drug_006_moa_A_G00026_drug_026_moa_E_72        72
#>
#> $`single-agent`
#> DataFrame with 5 rows and 4 columns
#>                              Gnumber    DrugName    drug_moa  Duration
#>                          <character> <character> <character> <numeric>
#> G00004_drug_004_moa_A_72      G00004    drug_004       moa_A        72
#> G00005_drug_005_moa_A_72      G00005    drug_005       moa_A        72
#> G00006_drug_006_moa_A_72      G00006    drug_006       moa_A        72
#> G00021_drug_021_moa_D_72      G00021    drug_021       moa_D        72
#> G00026_drug_026_moa_E_72      G00026    drug_026       moa_E        72
```

This function allows also for extraction of unified data across all the `SummarizedExperiment`s inside `MultiAssayExperiment`, e.g.

```
MAEpply(mae, rowData, unify = TRUE)
#>     Gnumber DrugName drug_moa Gnumber_2 DrugName_2 drug_moa_2 Duration
#>      <char>   <char>   <char>    <char>     <char>     <char>    <num>
#>  1:  G00004 drug_004    moa_A    G00021   drug_021      moa_D       72
#>  2:  G00004 drug_004    moa_A    G00026   drug_026      moa_E       72
#>  3:  G00005 drug_005    moa_A    G00021   drug_021      moa_D       72
#>  4:  G00005 drug_005    moa_A    G00026   drug_026      moa_E       72
#>  5:  G00006 drug_006    moa_A    G00021   drug_021      moa_D       72
#>  6:  G00006 drug_006    moa_A    G00026   drug_026      moa_E       72
#>  7:  G00004 drug_004    moa_A      <NA>       <NA>       <NA>       72
#>  8:  G00005 drug_005    moa_A      <NA>       <NA>       <NA>       72
#>  9:  G00006 drug_006    moa_A      <NA>       <NA>       <NA>       72
#> 10:  G00021 drug_021    moa_D      <NA>       <NA>       <NA>       72
#> 11:  G00026 drug_026    moa_E      <NA>       <NA>       <NA>       72
```

## 2.2 Data extraction

All the metrics data are stored inside `assays` of `SummarizedExperiment`. For the downstream analyses we provide tools allowing for the extraction of the data into user-friendly `data.table` style.

There is a function working on the `MultiAssayExperiment` object as well as a set of functions working on the `SummarizedExperiment` object:

* convert\_mae\_assay\_to\_dt
* convert\_se\_assay\_to\_dt
* convert\_se\_assay\_to\_custom\_dt
* convert\_combo\_data\_to\_dt

```
mdt <- convert_mae_assay_to_dt(mae, "Metrics")
#> Loading required namespace: BumpyMatrix
head(mdt, 3)
#>                                               rId
#>                                            <char>
#> 1: G00004_drug_004_moa_A_G00021_drug_021_moa_D_72
#> 2: G00004_drug_004_moa_A_G00021_drug_021_moa_D_72
#> 3: G00004_drug_004_moa_A_G00021_drug_021_moa_D_72
#>                                cId  x_mean  x_AOC x_AOC_range  xc50   x_max
#>                             <char>   <num>  <num>       <num> <num>   <num>
#> 1: CL00016_cellline_GB_tissue_y_46 -0.7046 1.7046      1.7046  -Inf -0.7046
#> 2: CL00016_cellline_GB_tissue_y_46 -0.7039 1.7039      1.7039  -Inf -0.7039
#> 3: CL00016_cellline_GB_tissue_y_46 -0.6920 1.6920      1.6920  -Inf -0.6920
#>     ec50   x_inf     x_0     h    r2 p_value   rss maxlog10Concentration N_conc
#>    <num>   <num>   <num> <num> <num>   <num> <num>                 <num>  <int>
#> 1:     0 -0.7046 -0.7046 1e-04     0      NA    NA             0.4996871      8
#> 2:     0 -0.7039 -0.7039 1e-04     0      NA    NA             0.4996871      8
#> 3:     0 -0.6920 -0.6920 1e-04     0      NA    NA             0.4996871      8
#>    x_sd_avg             fit_type normalization_type fit_source cotrt_value
#>       <num>               <char>             <char>     <char>       <num>
#> 1:        0 DRCConstantFitResult                 GR        gDR       3.160
#> 2:        0 DRCConstantFitResult                 GR        gDR       1.000
#> 3:        0 DRCConstantFitResult                 GR        gDR       0.316
#>    ratio dilution_drug Gnumber DrugName drug_moa Gnumber_2 DrugName_2
#>    <num>        <char>  <char>   <char>   <char>    <char>     <char>
#> 1:    NA        drug_2  G00004 drug_004    moa_A    G00021   drug_021
#> 2:    NA        drug_2  G00004 drug_004    moa_A    G00021   drug_021
#> 3:    NA        drug_2  G00004 drug_004    moa_A    G00021   drug_021
#>    drug_moa_2 Duration    clid CellLineName   Tissue ReferenceDivisionTime
#>        <char>    <num>  <char>       <char>   <char>                 <num>
#> 1:      moa_D       72 CL00016  cellline_GB tissue_y                    46
#> 2:      moa_D       72 CL00016  cellline_GB tissue_y                    46
#> 3:      moa_D       72 CL00016  cellline_GB tissue_y                    46
```

or alternatively for `SummarizedExperiment` object:

```
se <- mae[[1]]
sdt <- convert_se_assay_to_dt(se, "Metrics")
head(sdt, 3)
#>                                               rId
#>                                            <char>
#> 1: G00004_drug_004_moa_A_G00021_drug_021_moa_D_72
#> 2: G00004_drug_004_moa_A_G00021_drug_021_moa_D_72
#> 3: G00004_drug_004_moa_A_G00021_drug_021_moa_D_72
#>                                cId  x_mean  x_AOC x_AOC_range  xc50   x_max
#>                             <char>   <num>  <num>       <num> <num>   <num>
#> 1: CL00016_cellline_GB_tissue_y_46 -0.7046 1.7046      1.7046  -Inf -0.7046
#> 2: CL00016_cellline_GB_tissue_y_46 -0.7039 1.7039      1.7039  -Inf -0.7039
#> 3: CL00016_cellline_GB_tissue_y_46 -0.6920 1.6920      1.6920  -Inf -0.6920
#>     ec50   x_inf     x_0     h    r2 p_value   rss maxlog10Concentration N_conc
#>    <num>   <num>   <num> <num> <num>   <num> <num>                 <num>  <int>
#> 1:     0 -0.7046 -0.7046 1e-04     0      NA    NA             0.4996871      8
#> 2:     0 -0.7039 -0.7039 1e-04     0      NA    NA             0.4996871      8
#> 3:     0 -0.6920 -0.6920 1e-04     0      NA    NA             0.4996871      8
#>    x_sd_avg             fit_type normalization_type fit_source cotrt_value
#>       <num>               <char>             <char>     <char>       <num>
#> 1:        0 DRCConstantFitResult                 GR        gDR       3.160
#> 2:        0 DRCConstantFitResult                 GR        gDR       1.000
#> 3:        0 DRCConstantFitResult                 GR        gDR       0.316
#>    ratio dilution_drug Gnumber DrugName drug_moa Gnumber_2 DrugName_2
#>    <num>        <char>  <char>   <char>   <char>    <char>     <char>
#> 1:    NA        drug_2  G00004 drug_004    moa_A    G00021   drug_021
#> 2:    NA        drug_2  G00004 drug_004    moa_A    G00021   drug_021
#> 3:    NA        drug_2  G00004 drug_004    moa_A    G00021   drug_021
#>    drug_moa_2 Duration    clid CellLineName   Tissue ReferenceDivisionTime
#>        <char>    <num>  <char>       <char>   <char>                 <num>
#> 1:      moa_D       72 CL00016  cellline_GB tissue_y                    46
#> 2:      moa_D       72 CL00016  cellline_GB tissue_y                    46
#> 3:      moa_D       72 CL00016  cellline_GB tissue_y                    46
```

## 2.3 Managing gDR identifiers

### 2.3.1 Overview

In `gDR` we require standard identifiers that should be visible in the input data, such as e.g. `Gnumber`, `CLID`, `Concentration`. However, user can define their own custom identifiers.

To display gDR default identifier they can use `get_env_identifiers` function:

```
get_env_identifiers()
#> $duration
#> [1] "Duration"
#>
#> $cellline
#> [1] "clid"
#>
#> $cellline_name
#> [1] "CellLineName"
#>
#> $cellline_tissue
#> [1] "Tissue"
#>
#> $cellline_ref_div_time
#> [1] "ReferenceDivisionTime"
#>
#> $cellline_parental_identifier
#> [1] "parental_identifier"
#>
#> $cellline_subtype
#> [1] "subtype"
#>
#> $drug
#> [1] "Gnumber"
#>
#> $drug_name
#> [1] "DrugName"
#>
#> $drug_moa
#> [1] "drug_moa"
#>
#> $untreated_tag
#> [1] "vehicle"   "untreated"
#>
#> $masked_tag
#> [1] "masked"
#>
#> $well_position
#> [1] "WellRow"    "WellColumn"
#>
#> $concentration
#> [1] "Concentration"
#>
#> $template
#> [1] "Template"  "Treatment"
#>
#> $barcode
#> [1] "Barcode" "Plate"
#>
#> $drug2
#> [1] "Gnumber_2"
#>
#> $drug_name2
#> [1] "DrugName_2"
#>
#> $drug_moa2
#> [1] "drug_moa_2"
#>
#> $concentration2
#> [1] "Concentration_2"
#>
#> $drug3
#> [1] "Gnumber_3"
#>
#> $drug_name3
#> [1] "DrugName_3"
#>
#> $drug_moa3
#> [1] "drug_moa_3"
#>
#> $concentration3
#> [1] "Concentration_3"
#>
#> $data_source
#> [1] "data_source"
#>
#> $replicate
#> [1] "Replicate"
#>
#> $normalization_type
#> [1] "normalization_type"
```

To change any of these identifiers user can use `set_env_identifier`, e.g.

```
set_env_identifier("concentration", "Dose")
```

and confirm, by displaying:

```
get_env_identifiers("concentration")
#> [1] "Dose"
```

To restore default identifiers user can use `reset_env_identifiers`.

```
reset_env_identifiers()
```

```
get_env_identifiers("concentration")
#> [1] "Concentration"
```

### 2.3.2 Validating identifiers

The `validate_identifiers` function checks if the specified identifier values exist in the data and (if needed) tries to modify them to pass validation.

```
# Example data.table
dt <- data.table::data.table(
  Barcode = c("A1", "A2", "A3"),
  Duration = c(24, 48, 72),
  Template = c("T1", "T2", "T3"),
  clid = c("C1", "C2", "C3")
)

# Validate identifiers
validated_identifiers <- validate_identifiers(
  dt,
  req_ids = c("barcode", "duration", "template", "cellline")
)

print(validated_identifiers)
#> $duration
#> [1] "Duration"
#>
#> $cellline
#> [1] "clid"
#>
#> $cellline_name
#> [1] "CellLineName"
#>
#> $cellline_tissue
#> [1] "Tissue"
#>
#> $cellline_ref_div_time
#> [1] "ReferenceDivisionTime"
#>
#> $cellline_parental_identifier
#> [1] "parental_identifier"
#>
#> $cellline_subtype
#> [1] "subtype"
#>
#> $drug
#> [1] "Gnumber"
#>
#> $drug_name
#> [1] "DrugName"
#>
#> $drug_moa
#> [1] "drug_moa"
#>
#> $untreated_tag
#> [1] "vehicle"   "untreated"
#>
#> $masked_tag
#> [1] "masked"
#>
#> $well_position
#> [1] "WellRow"    "WellColumn"
#>
#> $concentration
#> [1] "Concentration"
#>
#> $template
#> [1] "Template"
#>
#> $barcode
#> [1] "Barcode"
#>
#> $drug2
#> [1] "Gnumber_2"
#>
#> $drug_name2
#> [1] "DrugName_2"
#>
#> $drug_moa2
#> [1] "drug_moa_2"
#>
#> $concentration2
#> [1] "Concentration_2"
#>
#> $drug3
#> [1] "Gnumber_3"
#>
#> $drug_name3
#> [1] "DrugName_3"
#>
#> $drug_moa3
#> [1] "drug_moa_3"
#>
#> $concentration3
#> [1] "Concentration_3"
#>
#> $data_source
#> [1] "data_source"
#>
#> $replicate
#> [1] "Replicate"
#>
#> $normalization_type
#> [1] "normalization_type"
```

In detail, `validate_identifiers` wraps the following steps:

* modify identifier values to reflect the data, handling many-to-one mappings via the `.modify_polymapped_identifiers` function
* ensure that all required identifiers are present in the data via the `.check_required_identifiers` function
* check for polymapped identifiers in the data via the `.check_polymapped_identifiers` function

### 2.3.3 Prettifying identifiers

Prettifying identifiers means making them more user-friendly and human-readable and is handled by the `prettify_flat_metrics` function. Please see [the relevant section](#prettifying) for more details.

```
# Example of prettifying identifiers
x <- c("CellLineName", "Tissue", "Concentration_2")
prettified_names <- prettify_flat_metrics(x, human_readable = TRUE)
print(prettified_names)
#> [1] "Cell Line Name"  "Tissue"          "Concentration 2"
```

## 2.4 Data validation

Applied custom changes in the gDR output can disrupt internal functions operation. Custom changes can be validated using `validate_MAE`

```
validate_MAE(mae)
```

or `validate_SE`.

```
validate_SE(se)
```

```
assay(se, "Normalized") <- NULL
validate_SE(se)
#> Error in validate_SE(se): Assertion on 'exp_assay_names' failed: Must be a subset of {'RawTreated','Controls','Averaged','excess','all_iso_points','isobolograms','scores','Metrics'}, but has additional elements {'Normalized'}.
```

There is also a group of functions to validate data used in the gDR application:

* is\_combo\_data
* has\_single\_codrug\_data
* has\_valid\_codrug\_data
* get\_additional\_variables

## 2.5 Prettifying

Prettifying involves transforming data into a more descriptive and human-readable version. This is particularly useful for front-end applications where user-friendly names are preferred over technical or abbreviated terms.

In gdrplatform there are two entities that can be prettified:

* colnames of data.tables
* assay names

### 2.5.1 Colnames of data.table(s)

One can prettify the columns of the data.table(s) with a single function called `prettify_flat_metrics`.

```
dt <- get_testdata()[["raw_data"]]
colnames(dt)
prettify_flat_metrics(colnames(dt), human_readable = TRUE)
```

The `prettify_flat_metrics` function is in fact a wrapper for the following actions:

* conversion of the normalization-specific metric names via the `.convert_norm_specific_metrics` function
* moving the GDS source info to the end of the column name via the `.prettify_GDS_columns`
* prettifying the metadata columns via the `.prettify_metadata_columns` function
* prettifying the metric columns via the `.prettify_metric_columns` function
* prettifying the co-treatment column names. via the `.prettify_cotreatment_columns`
* minor corrections (removal of ‘gDR’ and "\_" prefixes, removal of spaces at the end/beginning, other)

In case of data.table(s) with combo excess and score assays some of the columns are prettified with the dedicated helper functions instead of using `prettify_flat_metrics`:

* get\_combo\_excess\_field\_names()
* get\_combo\_score\_field\_names()

These helpers depend on the DATA\_COMBO\_INFO\_TBL, (gDRutils) internal data.table.

### 2.5.2 Assay names

The function `get_assay_names` is the primary solution for obtaining prettified versions of the assay names. It wraps the `get_env_assay_names` function which depends on ASSAY\_INFO\_TBL, (gDRutils) internal data.table.

There are some functions that wrap the `get_assay_names` function for combo data:

* get\_combo\_assay\_names
* get\_combo\_score\_assay\_names
* get\_combo\_base\_assay\_names

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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
#>  [3] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [5] Seqinfo_1.0.0               IRanges_2.44.0
#>  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
#>  [9] generics_0.1.4              MatrixGenerics_1.22.0
#> [11] matrixStats_1.5.0           gDRutils_1.8.0
#> [13] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] Matrix_1.7-4          jsonlite_2.0.0        compiler_4.5.1
#>  [4] BiocManager_1.30.26   BiocBaseUtils_1.12.0  Rcpp_1.1.0
#>  [7] stringr_1.5.2         jquerylib_0.1.4       BumpyMatrix_1.18.0
#> [10] yaml_2.3.10           fastmap_1.2.0         lattice_0.22-7
#> [13] R6_2.6.1              XVector_0.50.0        S4Arrays_1.10.0
#> [16] knitr_1.50            backports_1.5.0       checkmate_2.3.3
#> [19] DelayedArray_0.36.0   bookdown_0.45         stringfish_0.17.0
#> [22] bslib_0.9.0           rlang_1.1.6           stringi_1.8.7
#> [25] cachem_1.1.0          xfun_0.53             sass_0.4.10
#> [28] RcppParallel_5.1.11-1 SparseArray_1.10.0    cli_3.6.5
#> [31] magrittr_2.0.4        digest_0.6.37         grid_4.5.1
#> [34] lifecycle_1.0.4       glue_1.8.0            evaluate_1.0.5
#> [37] data.table_1.17.8     abind_1.4-8           RApiSerialize_0.1.4
#> [40] rmarkdown_2.30        qs_0.27.3             tools_4.5.1
#> [43] htmltools_0.5.8.1
```