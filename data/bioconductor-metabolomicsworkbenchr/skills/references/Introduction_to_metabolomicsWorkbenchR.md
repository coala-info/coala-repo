# Introduction to `metabolomicsWorkbenchR`

Gavin R Lloyd1\* and Ralf J Weber1\*\*

1Phenome Centre Birmingham, University of Birmingham, UK

\*g.r.lloyd@bham.ac.uk
\*\*r.j.weber@bham.ac.uk

#### 22 December 2025

#### Package

metabolomicsWorkbenchR 1.20.0

# 1 Introduction

Metabolomics Workbench [(link)](www.metabolomicsworkbench.org) hosts a metabolomics
data repository. It contains over 1000 publicly available studies including raw data,
processed data and metabolite/compound information.

The repository is searchable using a REST service API. The metabolomicsWorkbenchR
package makes the endpoints of this service available in R and provides functionality
to search the database and import datasets and metabolite information into commonly used
formats such as data frames and SummarizedExperiment objects.

# 2 Installation

To install this package enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("metabolomicsWorkbenchR")
```

For older versions, please refer to the appropriate Bioconductor release.

# 3 Running a query

The Metabolomics Workbench API has a number of endpoints that can be used to
query several different databases. Complete details are provided in the API
documentation [(link)](https://www.metabolomicsworkbench.org/tools/MWRestAPIv1.0.pdf).

`metabolomicsWorkbenchR` provides a simple interface to all API endpoints via
the `do_query` method. Four inputs are required:

* `context` - The context determines the type of data to be accessed from the Metabolomics Workbench,
  such as metadata or results related to the submitted studies, data from metabolites, genes/proteins and
  analytical chemistry databases as well as other services related to mass spectrometry and metabolite
  identification. Valid contexts are “study”, “compound”, “refmet”,
  “gene”, “protein”, “moverz” and “exactmass”.
* `input_item` - Input items direct the search towards a specific part of the database.
  If the database is a table, then `input_item` is a column in that table that will be searched for matching values.
* `input_value` - The value to search for in the named `input_item`.
* `output_item` - The type of output to be returned. Usually some data in the form of a table, but sometimes a file (e.g. png, mol).

By combining different context, input and output items a variety of information can be returned. In this first example, we query the study context for study titles containing the keyword “Diabetes” and request a summary of each matching study.

```
# search for all studies with "Diabetes" in the title and return a summary
df = do_query(
    context = 'study',
    input_item = 'study_title',
    input_value = 'Diabetes',
    output_item = 'summary'
)
df[1:3,c(1,4)]
```

```
##   study_id                       institute
## 1 ST000057 University of California, Davis
## 2 ST000075 University of California, Davis
## 3 ST000091                     Mayo Clinic
```

The result is a 14x12 data.frame with study titles, authors, descriptions etc.

In the next example we query the compound context for “regno” identifier 11 and request all available information for the matching compound.

```
df = do_query(
    context = 'compound',
    input_item = 'regno',
    input_value = '11',
    output_item = 'compound_exact'
)

df[,1:3]
```

```
##   regno    formula  exactmass
## 1    11 C47H75N5O8 837.561565
```

We can also request an image of the molecular structure:

```
img = do_query(
        context = 'compound',
        input_item = 'regno',
        input_value = '11',
        output_item = 'png'
      )

grid.raster(img)
```

Valid contexts, input items and output items can be listed using the `names` function:

```
# valid contexts
names(context) # context, input_item or output_item
```

```
## [1] "study"     "compound"  "refmet"    "gene"      "protein"   "moverz"
## [7] "exactmass"
```

Valid inputs and outputs for a context can be displayed by accessing the list of context objects. Valid inputs for a particular output can also be displayed by accessing the list of output item objects. Use of `metabolmicsWorkbenchR` objects is detailed in a later section. In addition, functions `context_inputs`, `context_outputs` and `input_example` are provided for convenience.

```
# valid inputs for "study" context
context_inputs('study')
```

```
## [1] "study_id"      "study_title"   "institute"     "last_name"
## [5] "analysis_id"   "metabolite_id"
```

More information about the different contexts can be found in the API documentation
[(link)](https://www.metabolomicsworkbench.org/tools/MWRestAPIv1.0.pdf)

# 4 Special cases

`metabolomicsWorkBenchR` includes some output items in addition to those specified by the API documentation. These special cases are described here.

## 4.1 `input_item` “ignored”

The input item is used with the “study” context and the “untarg\_studies” input\_item. The API ignores the input\_item and the input\_value when using this query and returns a list of studies with untargeted data.

```
df = do_query(
  context = 'study',
  input_item = 'ignored',
  input_value = 'ignored',
  output_item = 'untarg_studies'
)

df[1:3,1:3]
```

```
##   study_id analysis_id                         analysis_display
## 1 ST000009    AN000023 LC/Electro-spray /QTOF positive ion mode
## 2 ST000009    AN000024 LC/Electro-spray /QTOF negative ion mode
## 3 ST000010    AN000025 LC/Electro-spray /QTOF positive ion mode
```

## 4.2 `output_item` “compound\_exact”, “protein\_exact” and “gene\_exact”

These outputs refer to compound, protein and gene context API outputs that can be used with exact matching. This means that only exact matches to the input\_value will be returned. For these outputs all available output fields will be returned. These output items are used in place of the ‘all’ item specified in the API documentation.

```
df = do_query(
  context = 'compound',
  input_item = 'regno',
  input_value = '11',
  output_item = 'compound_exact'
)

df[,1:3]
```

```
##   regno    formula  exactmass
## 1    11 C47H75N5O8 837.561565
```

## 4.3 `output_item` “protein\_partial” and “gene\_partial”

These outputs refer to protein and gene contexts API outputs that can be used with partial matching. This means that all records with a partial match to the input\_value will be returned. For these outputs all available output fields will be returned.

```
df = do_query(
  context = 'gene',
  input_item = 'gene_name',
  input_value = 'acetyl-CoA',
  output_item = 'gene_partial'
)

df[1:3,1:3]
```

```
##                      gene_name    mgp_id gene_id
## 1 acetyl-CoA acyltransferase 1 MGP000015      30
## 2 acetyl-CoA carboxylase alpha MGP000016      31
## 3  acetyl-CoA carboxylase beta MGP000017      32
```

## 4.4 `output_item` “SummarizedExperiment” and “DatasetExperiment”

This output refers to the study context and uses multiple queries to return a SummarizedExperiment or DatasetExperiment object for a study\_id or analysis\_id.

```
SE = do_query(
    context = 'study',
    input_item = 'study_id',
    input_value = 'ST000001',
    output_item = 'SummarizedExperiment' # or 'DatasetExperiment'
)

SE
```

```
## class: SummarizedExperiment
## dim: 102 24
## metadata(8): data_source study_id ... description subject_type
## assays(1): ''
## rownames(102): ME000097 ME000096 ... ME000002 ME000001
## rowData names(3): metabolite_name metabolite_id refmet_name
## colnames(24): LabF_115811 LabF_115816 ... LabF_115924 LabF_115929
## colData names(4): local_sample_id study_id Arabidopsis_Genotype
##   Plant_Wounding_Treatment
```

## 4.5 `output_item` “MultiAssayExperiment”

This output refers to the study context and uses multiple queries to return a MultiAssayExperiment object for a study\_id.

```
MAE = do_query(
    context = 'study',
    input_item = 'study_id',
    input_value = 'ST000009',
    output_item = 'MultiAssayExperiment'
)

MAE
```

```
## A MatchedAssayExperiment object of 2 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 2:
##  [1] AN000023: SummarizedExperiment with 230 rows and 114 columns
##  [2] AN000024: SummarizedExperiment with 172 rows and 114 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

## 4.6 `output_item` “untarg\_SummarizedExperiment” and “untarg\_DatasetExperiment”

This output refers to the study context and uses multiple queries to return a SummarizedExperiment or DatasetExperiment object of untargeted data for an analysis\_id.

```
SE = do_query(
    context = 'study',
    input_item = 'analysis_id',
    input_value = 'AN000025',
    output_item = 'untarg_SummarizedExperiment' # or 'untarg_DatasetExperiment'
)

SE
```

# 5 S4 classes

A number of classes have been defined in this package and for completeness they are described below. They are used to
implement access to the API endpoints and it is not expected that they will be used as objects by the user. The `do_query` function uses character strings to access predefined instances of these objects and simplify the query.

## 5.1 Contexts

Each database is referred to as a ‘context’. These contexts can be searched using
input/output pairs to search the database for matches and return the results.

In `metabolmicsWorkbenchR` a predefined list called `context` contains
`mw_context` objects. These objects define which inputs and outputs are valid
options for a context.

The name of all valid contexts can be displayed:

```
# list all context names
names(metabolomicsWorkbenchR::context)
```

```
## [1] "study"     "compound"  "refmet"    "gene"      "protein"   "moverz"
## [7] "exactmass"
```

Information about a specific context can be obtained using the show method for a
an `mw_context` object:

```
# list valid inputs/outputs for the "study" context
metabolomicsWorkbenchR::context$study
```

```
## A Metabolomics Workbench "context"
##
## Name:    "study"
##
## Valid input_item names:
##  "study_id"
##  "study_title"
##  "institute"
##  "last_name"
##  "analysis_id"
##  "metabolite_id"
##
## Valid output_item names:
##  "summary"
##  "factors"
##  "analysis"
##  "metabolites"
##  "mwtab"
##  "source"
##  "species"
##  "disease"
##  "number_of_metabolites"
##  "data"
##  "datatable"
##  "untarg_studies"
##  "untarg_factors"
##  "untarg_data"
##  "metabolite_info"
##  "SummarizedExperiment"
##  "untarg_SummarizedExperiment"
##  "DatasetExperiment"
##  "untarg_DatasetExperiment"
```

## 5.2 Input / Output Items

Once the context of the search has been decided upon valid inputs and outputs can
be chosen. All input and output items have been predefined as lists called
`input_item` and `output_item`.

The `input_item` list contains `mw_input_item` objects that specify valid pattern
matching of the input value using regex.

```
# input item "study_id" info
input_item$study_id
```

```
## A Metabolomics Workbench "input_item"
##
## Name:    "study_id"
##
## Exact pattern matching:
##  "^ST[0-9]{6}$"
##
## Partial pattern matching:
##  "^S(T[0-9]{0,6})?$"
##
## Examples:
##  "ST000001"
##  "ST"
```

The `output_item` list contains `mw_output_item` objects that specify valid inputs,
the expected return fields (if the return is a data.frame) and the type of input matching that is supported.

```
# output item 'summary' info
output_item$summary
```

```
## A Metabolomics Workbench "output_item"
##
## Name:    "summary"
##
## Returns:
##  "study_id"
##  "study_title"
##  "study_type"
##  "institute"
##  "department"
##  "last_name"
##  "first_name"
##  "email"
##  "phone"
##  "submit_date"
##  "study_summary"
##  "subject_species"
##
## Allowed input_item names:
##  "study_id"
##  "study_title"
##  "institute"
##  "last_name"
##
## Type of matching supported:  "partial"
```

# 6 Session Info

```
## R version 4.5.2 (2025-10-31)
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
## [1] grid      stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
## [1] curl_7.0.0                    metabolomicsWorkbenchR_1.20.0
## [3] httptest_4.2.3                testthat_3.3.1
## [5] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10                 generics_0.1.4
##  [3] SparseArray_1.10.8          lattice_0.22-7
##  [5] digest_0.6.39               magrittr_2.0.4
##  [7] evaluate_1.0.5              bookdown_0.46
##  [9] fastmap_1.2.0               jsonlite_2.0.0
## [11] Matrix_1.7-4                ontologyIndex_2.12
## [13] brio_1.1.5                  BiocManager_1.30.27
## [15] httr_1.4.7                  jquerylib_0.1.4
## [17] abind_1.4-8                 cli_3.6.5
## [19] rlang_1.1.6                 XVector_0.50.0
## [21] Biobase_2.70.0              cachem_1.1.0
## [23] DelayedArray_0.36.0         yaml_2.3.12
## [25] otel_0.2.0                  BiocBaseUtils_1.12.0
## [27] S4Arrays_1.10.1             tools_4.5.2
## [29] SummarizedExperiment_1.40.0 BiocGenerics_0.56.0
## [31] MultiAssayExperiment_1.36.1 R6_2.6.1
## [33] matrixStats_1.5.0           stats4_4.5.2
## [35] lifecycle_1.0.4             Seqinfo_1.0.0
## [37] S4Vectors_0.48.0            IRanges_2.44.0
## [39] bslib_0.9.0                 data.table_1.17.8
## [41] xfun_0.55                   GenomicRanges_1.62.1
## [43] MatrixGenerics_1.22.0       knitr_1.51
## [45] htmltools_0.5.9             rmarkdown_2.30
## [47] compiler_4.5.2              struct_1.22.1
```