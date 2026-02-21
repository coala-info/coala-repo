# Generating HCAMatrix queries with the API

#### 28 October 2020

# 1 Installation

Pull the development branch from `Bioconductor/HCAMatrixBrowser`

```
if (!requireNamespace("BiocManager", quietly = TRUE)
    install.packages("BiocManager")

BiocManager::install("HCAMatrixBrowser")
```

# 2 Load packages

```
library(HCAMatrixBrowser)
library(rapiclient)
library(AnVIL)
```

Create an HCA api object using the `rapiclient` package:

```
(hca <- HCAMatrix())
```

```
## service: HCAMatrix
## tags(); use hcamatrix$<tab completion>:
## # A tibble: 14 x 3
##    tag      operation                          summary
##    <chr>    <chr>                              <chr>
##  1 internal matrix.lambdas.api.v0.core.dss_no… matrix.lambdas.api.v0.core.dss_n…
##  2 v0       matrix.lambdas.api.v0.core.get_fo… matrix.lambdas.api.v0.core.get_f…
##  3 v0       matrix.lambdas.api.v0.core.get_ma… matrix.lambdas.api.v0.core.get_m…
##  4 v0       matrix.lambdas.api.v0.core.post_m… matrix.lambdas.api.v0.core.post_…
##  5 v1       matrix.lambdas.api.v1.core.get_fe… matrix.lambdas.api.v1.core.get_f…
##  6 v1       matrix.lambdas.api.v1.core.get_fe… matrix.lambdas.api.v1.core.get_f…
##  7 v1       matrix.lambdas.api.v1.core.get_fi… matrix.lambdas.api.v1.core.get_f…
##  8 v1       matrix.lambdas.api.v1.core.get_fi… matrix.lambdas.api.v1.core.get_f…
##  9 v1       matrix.lambdas.api.v1.core.get_fi… matrix.lambdas.api.v1.core.get_f…
## 10 v1       matrix.lambdas.api.v1.core.get_fi… matrix.lambdas.api.v1.core.get_f…
## 11 v1       matrix.lambdas.api.v1.core.get_fo… matrix.lambdas.api.v1.core.get_f…
## 12 v1       matrix.lambdas.api.v1.core.get_fo… matrix.lambdas.api.v1.core.get_f…
## 13 v1       matrix.lambdas.api.v1.core.get_ma… matrix.lambdas.api.v1.core.get_m…
## 14 v1       matrix.lambdas.api.v1.core.post_m… matrix.lambdas.api.v1.core.post_…
## tag values:
##   internal, v0, v1
## schemas():
##   v0_MatrixRequest, v0_MatrixResponse, v0_MatrixErrorResponse,
##   v0_DssNotification, v1_ComparisonFilter
##   # ... with 14 more elements
```

# 3 Schemas

Check that the schemas are available as found in the api configuration file:
**Note**. Due to downgrade from Open API Specification (OAS) version 3 to
OAS version 2 (formerly known as Swagger), the full list of schemas may not
be shown.

```
schemas(hca)
```

```
## $v0_MatrixRequest
##   v0_MatrixRequest(bundle_fqids, bundle_fqids_url, format)
##
## $v0_MatrixResponse
##   v0_MatrixResponse(request_id, status, matrix_location, eta, message)
##
## $v0_MatrixErrorResponse
##   v0_MatrixErrorResponse(message)
##
## $v0_DssNotification
##   v0_DssNotification(transaction_id, subscription_id, event_type,
##     match)
##
## $v1_ComparisonFilter
##   v1_ComparisonFilter(op, field, value)
##
## $v1_LogicalFilter
##   v1_LogicalFilter(op, value)
##
## $v1_MatrixRequest
##   v1_MatrixRequest(filter, fields, format, feature)
##
## $v1_MatrixResponse
##   v1_MatrixResponse(request_id, status, matrix_url, message, eta)
##
## $v1_MatrixErrorResponse
##   v1_MatrixErrorResponse(status_code, message)
##
## $v1_MatrixFeatureDetail
##   v1_MatrixFeatureDetail(feature, feature_description)
##
## $v1_FieldDetail
##   v1_FieldDetail(field_name, field_description, field_type)
##
## $v1_NumericFieldDetail
##   v1_NumericFieldDetail(field_name, field_description, field_type,
##     minimum, maximum)
##
## $v1_CategoricalFieldDetail
##   v1_CategoricalFieldDetail(field_name, field_description, field_type,
##     cell_counts)
##
## $Match
##   Match(bundle_uuid, bundle_version)
```

# 4 Exploring the endpoints

Here we make available a number of helper functions that allow the user to
explore the possible queries supported by the HCA Matrix Service data model.

## 4.1 Filters

```
available_filters(hca)
```

```
##  [1] "cell_suspension.provenance.document_id"
##  [2] "genes_detected"
##  [3] "total_umis"
##  [4] "barcode"
##  [5] "emptydrops_is_cell"
##  [6] "specimen_from_organism.provenance.document_id"
##  [7] "cell_suspension.genus_species.ontology"
##  [8] "cell_suspension.genus_species.ontology_label"
##  [9] "donor_organism.provenance.document_id"
## [10] "donor_organism.human_specific.ethnicity.ontology"
## [11] "donor_organism.human_specific.ethnicity.ontology_label"
## [12] "donor_organism.diseases.ontology"
## [13] "donor_organism.diseases.ontology_label"
## [14] "donor_organism.development_stage.ontology"
## [15] "donor_organism.development_stage.ontology_label"
## [16] "donor_organism.sex"
## [17] "donor_organism.is_living"
## [18] "derived_organ_ontology"
## [19] "derived_organ_label"
## [20] "derived_organ_parts_ontology"
## [21] "derived_organ_parts_label"
## [22] "specimen_from_organism.organ.ontology"
## [23] "specimen_from_organism.organ.ontology_label"
## [24] "specimen_from_organism.organ_parts.ontology"
## [25] "specimen_from_organism.organ_parts.ontology_label"
## [26] "library_preparation_protocol.provenance.document_id"
## [27] "library_preparation_protocol.input_nucleic_acid_molecule.ontology"
## [28] "library_preparation_protocol.input_nucleic_acid_molecule.ontology_label"
## [29] "library_preparation_protocol.library_construction_method.ontology"
## [30] "library_preparation_protocol.library_construction_method.ontology_label"
## [31] "library_preparation_protocol.end_bias"
## [32] "library_preparation_protocol.strand"
## [33] "project.provenance.document_id"
## [34] "project.project_core.project_short_name"
## [35] "project.project_core.project_title"
## [36] "analysis_protocol.provenance.document_id"
## [37] "dss_bundle_fqid"
## [38] "bundle_uuid"
## [39] "bundle_version"
## [40] "file_uuid"
## [41] "file_version"
## [42] "analysis_protocol.protocol_core.protocol_id"
## [43] "analysis_working_group_approval_status"
```

We can get details for a particular filter:

```
filter_detail(hca, "genes_detected")
```

```
## $field_description
## [1] "Count of genes with a non-zero count."
##
## $field_name
## [1] "genes_detected"
##
## $field_type
## [1] "numeric"
##
## $maximum
## [1] 13108
##
## $minimum
## [1] 2
```

## 4.2 Formats

We can obtain the available formats for any request by doing:

```
available_formats(hca)
```

```
## [1] "loom" "csv"  "mtx"
```

We can get additional details (via HTML pop-up page):

```
format_detail(hca, "mtx")
```

## 4.3 Features

The matrix service provides two types of features (i.e., genes and
transcripts):

```
available_features(hca)
```

```
## [1] "gene"       "transcript"
```

and a short description of a selected feature:

```
feature_detail(hca, "gene")
```

```
## $feature
## [1] "gene"
##
## $feature_description
## [1] "Genes from the GENCODE v27 comprehensive annotation."
```

# 5 Request generation from schema

Using the `rapiclient` package, we can obtain schema or models for queries:

```
bundle_fqids <-
    c("980b814a-b493-4611-8157-c0193590e7d9.2018-11-12T131442.994059Z",
    "7243c745-606d-4827-9fea-65a925d5ab98.2018-11-07T002256.653887Z")
req <- schemas(hca)$v0_MatrixRequest(
    bundle_fqids = bundle_fqids, format = "loom"
)
req
```

```
## $bundle_fqids
## [1] "980b814a-b493-4611-8157-c0193590e7d9.2018-11-12T131442.994059Z"
## [2] "7243c745-606d-4827-9fea-65a925d5ab98.2018-11-07T002256.653887Z"
##
## $format
## [1] "loom"
```

For requests such as these, it is better to use the API layer provided by
`HCAMatrixBrowser` (see examples below).

# 6 Python example

The HCA group has provided example JSON requests written in python:

The published notebook is available here:
<https://github.com/HumanCellAtlas/matrix-service/blob/master/docs/HCA%20Matrix%20Service%20to%20Scanpy.ipynb>

The following JSON request applies a couple of filters on the project
short name and the number of genes detected.

The provided example request looks like:

```
jsonlite::fromJSON(
    txt = '{"filter": {"op": "and", "value": [ {"op": "=", "value": "Single cell transcriptome analysis of human pancreas", "field": "project.project_core.project_short_name"}, {"op": ">=", "value": 300, "field": "genes_detected"} ] }}'
)
```

```
## $filter
## $filter$op
## [1] "and"
##
## $filter$value
##   op                                                value
## 1  = Single cell transcriptome analysis of human pancreas
## 2 >=                                                  300
##                                     field
## 1 project.project_core.project_short_name
## 2                          genes_detected
```

# 7 HCAMatrixBrowser example

*Advanced usage note*. We are interested in using the following endpoint:

```
hca$matrix.lambdas.api.v1.core.post_matrix
```

```
## matrix.lambdas.api.v1.core.post_matrix
## matrix.lambdas.api.v1.core.post_matrix
## Description:
##   Request an expression matrix using a set of filters to be ANDed and
##   applied to the HCA expression data.
##
## Parameters:
##   filter (object)
##     Filter to apply in a matrix request.
##   fields (array[string])
##     Metadata fields to include in output matrix.
##   format (string)
##     Format for the output matrix.
##   feature (string)
##     Feature type to include in the output matrix. For example, genes
##     vs. transcripts.
```

The `HCAMatrixBrowser` allows filtering using a non-standard evaluation
method typical of the ‘tidyverse’. Here we recreate the filters provided
in the example above.

```
hcafilt <- filter(hca,
    project.project_core.project_short_name ==
        "Single cell transcriptome analysis of human pancreas" &
        genes_detected >= 300)
```

We can subsequently view the generated filter from the operation:

```
filters(hcafilt)
```

```
## $op
## [x] "and"
##
## $value
##    op                                   field
## 2   = project.project_core.project_short_name
## 21 >=                          genes_detected
##                                                   value
## 2  Single cell transcriptome analysis of human pancreas
## 21                                                  300
```

# 8 Query send-off

In order to send the query with the appropriate filters, we simply use
the provided `loadHCAMatrix` function along with the API object that contains
the filter structure. See the following section for more information.

## 8.1 Data representations

The matrix service allows you to request three different file formats:

1. loom (default)
2. mtx
3. csv

These can be requested using the `format` argument in the `loadHCAMatrix`
function:

### 8.1.1 loom

The `loom` format is supported by the `LoomExperiment` package in Bioconductor.

```
(loomex <- loadHCAMatrix(hcafilt, format = "loom"))
```

```
## HCAMatrixBrowser cache directory set to:
##     /home/biocbuild/.cache/R/HCAMatrixBrowser
```

```
## class: LoomExperiment
## dim: 58347 2544
## metadata(0):
## assays(1): matrix
## rownames: NULL
## rowData names(9): Accession Gene ... genus_species isgene
## colnames(2544): 00ca0d37-b787-41a4-be59-2aff5b13b0bd
##   0103aed0-29c2-4b29-a02a-2b58036fe875 ...
##   fdb8ed17-e2f0-460a-bb25-9781d63eabf6
##   fe0d170e-af6e-4420-827b-27b125fec214
## colData names(44): CellID analysis_protocol.protocol_core.protocol_id
##   ... specimen_from_organism.provenance.document_id total_umis
## rowGraphs(0): NULL
## colGraphs(0): NULL
```

### 8.1.2 mtx

For the `mtx` format, we represent the data as a `SingleCellExperiment` class:

```
(mtmat <- loadHCAMatrix(hcafilt, format = "mtx"))
```

```
## class: SingleCellExperiment
## dim: 58347 2544
## metadata(0):
## assays(1): counts
## rownames(58347): ENSG00000000003 ENSG00000000005 ... ENSG00000284747
##   ENSG00000284748
## rowData names(8): V2 V3 ... V8 V9
## colnames(2544): 00ca0d37-b787-41a4-be59-2aff5b13b0bd
##   0103aed0-29c2-4b29-a02a-2b58036fe875 ...
##   fdb8ed17-e2f0-460a-bb25-9781d63eabf6
##   fe0d170e-af6e-4420-827b-27b125fec214
## colData names(43): genes_detected file_uuid ...
##   analysis_protocol.protocol_core.protocol_id
##   analysis_working_group_approval_status
## reducedDimNames(0):
## altExpNames(0):
```

### 8.1.3 csv

The `csv` format option gives the user the option to obtain the data
as a list of `tibble` data.frames from the output of the `readr` package in the
‘tidyverse’.

**Note**. Loading multiple CSV files may take considerable time depending on
system configuration.

```
(tib <- loadHCAMatrix(hcafilt, format = "csv"))
```

```
## This may take a while...
```

```
##
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   featurekey = col_character(),
##   featurename = col_character(),
##   featuretype = col_character(),
##   chromosome = col_character(),
##   featurestart = col_double(),
##   featureend = col_double(),
##   isgene = col_logical(),
##   genus_species = col_character()
## )
```

```
##
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   .default = col_double(),
##   cellkey = col_character()
## )
## ℹ Use `spec()` for the full column specifications.
```

```
##
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   .default = col_character(),
##   genes_detected = col_double(),
##   file_version = col_datetime(format = ""),
##   total_umis = col_logical(),
##   emptydrops_is_cell = col_logical(),
##   barcode = col_logical(),
##   bundle_version = col_datetime(format = "")
## )
## ℹ Use `spec()` for the full column specifications.
```

```
## $genes.csv
## # A tibble: 58,347 x 8
##    featurekey featurename featuretype chromosome featurestart featureend isgene
##    <chr>      <chr>       <chr>       <chr>             <dbl>      <dbl> <lgl>
##  1 ENSG00000… TSPAN6      protein_co… chrX          100627109  100639991 TRUE
##  2 ENSG00000… TNMD        protein_co… chrX          100584802  100599885 TRUE
##  3 ENSG00000… DPM1        protein_co… chr20          50934867   50958555 TRUE
##  4 ENSG00000… SCYL3       protein_co… chr1          169849631  169894267 TRUE
##  5 ENSG00000… C1orf112    protein_co… chr1          169662007  169854080 TRUE
##  6 ENSG00000… FGR         protein_co… chr1           27612064   27635277 TRUE
##  7 ENSG00000… CFH         protein_co… chr1          196651878  196747504 TRUE
##  8 ENSG00000… FUCA2       protein_co… chr6          143494811  143511690 TRUE
##  9 ENSG00000… GCLC        protein_co… chr6           53497341   53616970 TRUE
## 10 ENSG00000… NFYA        protein_co… chr6           41072945   41099976 TRUE
## # … with 58,337 more rows, and 1 more variable: genus_species <chr>
##
## $expression.csv
## # A tibble: 2,544 x 58,348
##    cellkey ENSG00000000003 ENSG00000000005 ENSG00000000419 ENSG00000000457
##    <chr>             <dbl>           <dbl>           <dbl>           <dbl>
##  1 00ca0d…               0               0              11               0
##  2 0103ae…               0               0               0               0
##  3 01a5dd…               0               0              37               0
##  4 020d39…               0               0               0               0
##  5 025836…               0               0             213               0
##  6 041637…               0               0               0               6
##  7 044472…               0               0               0               0
##  8 046c1a…             127               0              58             105
##  9 04f60c…               0               0               0               0
## 10 061f92…               0               0               5               0
## # … with 2,534 more rows, and 58,343 more variables: ENSG00000000460 <dbl>,
## #   ENSG00000000938 <dbl>, ENSG00000000971 <dbl>, ENSG00000001036 <dbl>,
## #   ENSG00000001084 <dbl>, ENSG00000001167 <dbl>, ENSG00000001460 <dbl>,
## #   ENSG00000001461 <dbl>, ENSG00000001497 <dbl>, ENSG00000001561 <dbl>,
## #   ENSG00000001617 <dbl>, ENSG00000001626 <dbl>, ENSG00000001629 <dbl>,
## #   ENSG00000001630 <dbl>, ENSG00000001631 <dbl>, ENSG00000002016 <dbl>,
## #   ENSG00000002079 <dbl>, ENSG00000002330 <dbl>, ENSG00000002549 <dbl>,
## #   ENSG00000002586 <dbl>, ENSG00000002586_PAR_Y <dbl>, ENSG00000002587 <dbl>,
## #   ENSG00000002726 <dbl>, ENSG00000002745 <dbl>, ENSG00000002746 <dbl>,
## #   ENSG00000002822 <dbl>, ENSG00000002834 <dbl>, ENSG00000002919 <dbl>,
## #   ENSG00000002933 <dbl>, ENSG00000003056 <dbl>, ENSG00000003096 <dbl>,
## #   ENSG00000003137 <dbl>, ENSG00000003147 <dbl>, ENSG00000003249 <dbl>,
## #   ENSG00000003393 <dbl>, ENSG00000003400 <dbl>, ENSG00000003402 <dbl>,
## #   ENSG00000003436 <dbl>, ENSG00000003509 <dbl>, ENSG00000003756 <dbl>,
## #   ENSG00000003987 <dbl>, ENSG00000003989 <dbl>, ENSG00000004059 <dbl>,
## #   ENSG00000004139 <dbl>, ENSG00000004142 <dbl>, ENSG00000004399 <dbl>,
## #   ENSG00000004455 <dbl>, ENSG00000004468 <dbl>, ENSG00000004478 <dbl>,
## #   ENSG00000004487 <dbl>, ENSG00000004534 <dbl>, ENSG00000004660 <dbl>,
## #   ENSG00000004700 <dbl>, ENSG00000004766 <dbl>, ENSG00000004776 <dbl>,
## #   ENSG00000004777 <dbl>, ENSG00000004779 <dbl>, ENSG00000004799 <dbl>,
## #   ENSG00000004809 <dbl>, ENSG00000004838 <dbl>, ENSG00000004846 <dbl>,
## #   ENSG00000004848 <dbl>, ENSG00000004864 <dbl>, ENSG00000004866 <dbl>,
## #   ENSG00000004897 <dbl>, ENSG00000004939 <dbl>, ENSG00000004948 <dbl>,
## #   ENSG00000004961 <dbl>, ENSG00000004975 <dbl>, ENSG00000005001 <dbl>,
## #   ENSG00000005007 <dbl>, ENSG00000005020 <dbl>, ENSG00000005022 <dbl>,
## #   ENSG00000005059 <dbl>, ENSG00000005073 <dbl>, ENSG00000005075 <dbl>,
## #   ENSG00000005100 <dbl>, ENSG00000005102 <dbl>, ENSG00000005108 <dbl>,
## #   ENSG00000005156 <dbl>, ENSG00000005175 <dbl>, ENSG00000005187 <dbl>,
## #   ENSG00000005189 <dbl>, ENSG00000005194 <dbl>, ENSG00000005206 <dbl>,
## #   ENSG00000005238 <dbl>, ENSG00000005243 <dbl>, ENSG00000005249 <dbl>,
## #   ENSG00000005302 <dbl>, ENSG00000005339 <dbl>, ENSG00000005379 <dbl>,
## #   ENSG00000005381 <dbl>, ENSG00000005421 <dbl>, ENSG00000005436 <dbl>,
## #   ENSG00000005448 <dbl>, ENSG00000005469 <dbl>, ENSG00000005471 <dbl>,
## #   ENSG00000005483 <dbl>, ENSG00000005486 <dbl>, ENSG00000005513 <dbl>, …
##
## $cells.csv
## # A tibble: 2,544 x 44
##    cellkey genes_detected file_uuid file_version        total_umis
##    <chr>            <dbl> <chr>     <dttm>              <lgl>
##  1 00ca0d…           6924 6770c8ea… 2019-05-15 01:06:43 NA
##  2 0103ae…           3171 68efbcbe… 2019-05-30 21:24:07 NA
##  3 01a5dd…           3838 209d615a… 2019-05-14 16:08:18 NA
##  4 020d39…           4111 143a7005… 2019-05-14 21:41:52 NA
##  5 025836…           5834 45e82c84… 2019-05-14 16:15:19 NA
##  6 041637…           2564 cb0b32b2… 2019-05-14 21:16:51 NA
##  7 044472…           3152 2b5338c5… 2019-05-14 14:38:01 NA
##  8 046c1a…           6375 66515cc6… 2019-05-14 13:35:49 NA
##  9 04f60c…           4650 45e89c83… 2019-05-14 13:09:27 NA
## 10 061f92…           4420 476dc6ce… 2019-05-14 12:04:56 NA
## # … with 2,534 more rows, and 39 more variables: emptydrops_is_cell <lgl>,
## #   barcode <lgl>, cell_suspension.provenance.document_id <chr>,
## #   specimen_from_organism.provenance.document_id <chr>,
## #   derived_organ_ontology <chr>, derived_organ_label <chr>,
## #   derived_organ_parts_ontology <chr>, derived_organ_parts_label <chr>,
## #   cell_suspension.genus_species.ontology <chr>,
## #   cell_suspension.genus_species.ontology_label <chr>,
## #   donor_organism.provenance.document_id <chr>,
## #   donor_organism.human_specific.ethnicity.ontology <chr>,
## #   donor_organism.human_specific.ethnicity.ontology_label <chr>,
## #   donor_organism.diseases.ontology <chr>,
## #   donor_organism.diseases.ontology_label <chr>,
## #   donor_organism.development_stage.ontology <chr>,
## #   donor_organism.development_stage.ontology_label <chr>,
## #   donor_organism.sex <chr>, donor_organism.is_living <chr>,
## #   specimen_from_organism.organ.ontology <chr>,
## #   specimen_from_organism.organ.ontology_label <chr>,
## #   specimen_from_organism.organ_parts.ontology <chr>,
## #   specimen_from_organism.organ_parts.ontology_label <chr>,
## #   library_preparation_protocol.provenance.document_id <chr>,
## #   library_preparation_protocol.input_nucleic_acid_molecule.ontology <chr>,
## #   library_preparation_protocol.input_nucleic_acid_molecule.ontology_label <chr>,
## #   library_preparation_protocol.library_construction_method.ontology <chr>,
## #   library_preparation_protocol.library_construction_method.ontology_label <chr>,
## #   library_preparation_protocol.end_bias <chr>,
## #   library_preparation_protocol.strand <chr>,
## #   project.provenance.document_id <chr>,
## #   project.project_core.project_short_name <chr>,
## #   project.project_core.project_title <chr>,
## #   analysis_protocol.provenance.document_id <chr>, dss_bundle_fqid <chr>,
## #   bundle_uuid <chr>, bundle_version <dttm>,
## #   analysis_protocol.protocol_core.protocol_id <chr>,
## #   analysis_working_group_approval_status <chr>
```

# 9 Advanced Usage

To use a lower level API endpoint, we can use the API object to select a
particular endpoint. This will usually show you a description of the endpoint
and the parameters for the query.

```
hca$matrix.lambdas.api.v0.core.post_matrix
```

```
## matrix.lambdas.api.v0.core.post_matrix
## matrix.lambdas.api.v0.core.post_matrix
## Description:
##   Prepares a single expression matrix combining all expression matrices
##   belonging to the specified analysis bundles. On success, this request
##   will asynchronously start a job to prepare the expression matrix and
##   return with the request ID of the job. The request ID can be used to
##   retrieve the status and results of the job from the GET endpoint.
##
## Parameters:
##   bundle_fqids (array[string])
##   bundle_fqids_url (string)
##   format (v0_MatrixFormat)
```

In the above example, there are three parameters required:

* `bundle_fqids`
* `bundle_fqids_url`
* `format`