# gDR annotation

gDR team

#### 30 October 2025

# Contents

* [1 Data Annotation Process for gDR Pipeline](#data-annotation-process-for-gdr-pipeline)
  + [1.1 Introduction](#introduction)
  + [1.2 Annotation Files](#annotation-files)
    - [1.2.1 Annotation File Locations](#annotation-file-locations)
  + [1.3 Annotation Requirements](#annotation-requirements)
    - [1.3.1 Drug Annotation Requirements](#drug-annotation-requirements)
    - [1.3.2 Cell Line Annotation Requirements](#cell-line-annotation-requirements)
  + [1.4 Annotating SummarizedExperiment and MultiAssayExperiment Objects](#annotating-summarizedexperiment-and-multiassayexperiment-objects)
  + [1.5 Additional Information for Genentech/Roche Users](#additional-information-for-genentechroche-users)
  + [1.6 Conclusion](#conclusion)
* [SessionInfo](#sessioninfo)

# 1 Data Annotation Process for gDR Pipeline

## 1.1 Introduction

Before running the gDR pipeline, it is essential to annotate the data properly with drug and cell line information. This document outlines the process of data annotation and the requirements for the annotation files.

## 1.2 Annotation Files

gDR uses two types of annotation: drug annotation and cell line annotation. These annotations are added to a data table before running the pipeline. The scripts for adding data annotation are located in `R/add_annotation.R`, which contains several primary functions: `annotate_dt_with_cell_line`, `annotate_dt_with_drug`, `get_cell_line_annotation`, and `get_drug_annotation` for receiving the default annotation for the data. Additionally, `annotate_se_with_drug`, `annotate_mae_with_drug`, `annotate_se_with_cell_line`, and `annotate_mae_with_cell_line` are provided to annotate `SummarizedExperiment` and `MultiAssayExperiment` objects. It is recommended to run the `cleanup_metadata` function, which adds annotations and performs some data cleaning.

### 1.2.1 Annotation File Locations

Both drug and cell line annotation files are stored in `gDRtestData/inst/annotation_data`. There are two files:

* `cell_lines.csv`
* `drugs.csv`

Users can edit these files to add their own annotations. After updating, it is required to reinstall `gDRtestData` to use the new annotations.

Alternatively, users can use other annotation files stored outside of this package. For this purpose, it is necessary to set two environmental variables:

* `GDR_CELLLINE_ANNOTATION`: Represents the path to the cell line annotation CSV file.
* `GDR_DRUG_ANNOTATION`: Represents the path to the drug annotation CSV file.

```
Sys.setenv(GDR_CELLLINE_ANNOTATION = "some/path/to/cell_line_annotation.csv")
Sys.setenv(GDR_DRUG_ANNOTATION = "some/path/to/drug_annotation.csv")
```

**NOTE:** gDR annotation can be sourced from different locations. Setting environmental variables with paths for annotation has the highest priority and will be used as the first source of annotation, even if other sources are available. To clarify, if both the environmental variables and the internal annotation databases are set, gDR will prioritize the environmental variables for annotation.

To turn off the usage of external paths for data annotation, please set these two environmental variables to empty.

```
Sys.setenv(GDR_CELLLINE_ANNOTATION = "")
Sys.setenv(GDR_DRUG_ANNOTATION = "")
```

## 1.3 Annotation Requirements

gDR has specific requirements for the annotation files to properly annotate the data.

### 1.3.1 Drug Annotation Requirements

The obligatory fields for drug annotation are:

* `Gnumber`: Represents the ID of the drug.
* `DrugName`: Represents the name of the drug.
* `drug_moa`: Represents the drug mechanism of action.

### 1.3.2 Cell Line Annotation Requirements

The obligatory fields for cell line annotation are:

* `clid`: Represents the cell line ID.
* `CellLineName`: Represents the name of the cell line.
* `Tissue`: Represents the primary tissue of the cell line.
* `ReferenceDivisionTime`: Represents the doubling time of the cell line in hours.
* `parental_identifier`: Represents the name of the parental cell line.
* `subtype`: Represents the subtype of the cell line.

If some information is not known for the cell line or drug, the corresponding field should be left empty or NA. Nonetheless, since the fill parameter is consistently specified in the annotation function, the default value of ‘unknown’ can be altered by the user.

## 1.4 Annotating SummarizedExperiment and MultiAssayExperiment Objects

To annotate `SummarizedExperiment` and `MultiAssayExperiment` objects, use the functions `annotate_se_with_drug`, `annotate_mae_with_drug`, `annotate_se_with_cell_line`, and `annotate_mae_with_cell_line`. These functions take the experiment objects and the corresponding annotation tables as input and return the annotated objects.

```
# Example for SummarizedExperiment
se <- SummarizedExperiment::SummarizedExperiment(
  rowData = data.table::data.table(Gnumber = c("D1", "D2", "D3"))
)
drug_annotation <- get_drug_annotation(data.table::as.data.table(SummarizedExperiment::rowData(se)))
annotated_se <- annotate_se_with_drug(se, drug_annotation)

# Example for MultiAssayExperiment
mae <- MultiAssayExperiment::MultiAssayExperiment(
  experiments = list(exp1 = SummarizedExperiment::SummarizedExperiment(
    rowData = data.table::data.table(clid = c("CL1", "CL2", "CL3"))
  ))
)
cell_line_annotation <- get_cell_line_annotation(data.table::as.data.table(
  SummarizedExperiment::rowData(
    MultiAssayExperiment::experiments(mae)[[1]])))
annotated_mae <- annotate_mae_with_cell_line(mae, cell_line_annotation)
```

## 1.5 Additional Information for Genentech/Roche Users

For users within Genentech/Roche, we recommend utilizing our internal annotation databases. We provide the `gDRinternal` package specifically for internal users, which includes functions for managing internal annotation data. If you are an internal user, you can install the `gDRinternal` package, and `gDRcore` will automatically utilize this package as a source of data annotation.

## 1.6 Conclusion

Proper annotation of drug and cell line data is crucial for running the gDR pipeline effectively. By adhering to the annotation requirements and following the outlined process, users can ensure accurate and reliable results from the pipeline.

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
#> [1] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
#>  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
#>  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
#> [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
#> [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
#> [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
#> [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```