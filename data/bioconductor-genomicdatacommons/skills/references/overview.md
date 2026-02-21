# The GenomicDataCommons Package

Sean Davis & Martin Morgan

#### Sunday, November 09, 2025

#### Abstract

The National Cancer Institute (NCI) has established the [Genomic Data Commons](https://gdc.nci.nih.gov/) (GDC). The GDC provides the cancer research community with an open and unified repository for sharing and accessing data across numerous cancer studies and projects via a high-performance data transfer and query infrastructure. The *GenomicDataCommons* Bioconductor package provides basic infrastructure for querying, accessing, and mining genomic datasets available from the GDC. We expect that the Bioconductor developer and the larger bioinformatics communities will build on the *GenomicDataCommons* package to add higher-level functionality and expose cancer genomics data to the plethora of state-of-the-art bioinformatics methods available in Bioconductor.

# 1 What is the GDC?

From the [Genomic Data Commons (GDC) website](https://gdc.cancer.gov/about-gdc):

> The National Cancer Institute’s (NCI’s) Genomic Data Commons (GDC) is
> a data sharing platform that promotes precision medicine in
> oncology. It is not just a database or a tool; it is an expandable
> knowledge network supporting the import and standardization of genomic
> and clinical data from cancer research programs.
> The GDC contains NCI-generated data from some of the largest and most
> comprehensive cancer genomic datasets, including The Cancer Genome
> Atlas (TCGA) and Therapeutically Applicable Research to Generate
> Effective Therapies (TARGET). For the first time, these datasets have
> been harmonized using a common set of bioinformatics pipelines, so
> that the data can be directly compared.
> As a growing knowledge system for cancer, the GDC also enables
> researchers to submit data, and harmonizes these data for import into
> the GDC. As more researchers add clinical and genomic data to the GDC,
> it will become an even more powerful tool for making discoveries about
> the molecular basis of cancer that may lead to better care for
> patients.

The
[data model for the GDC is complex](https://gdc.cancer.gov/developers/gdc-data-model/gdc-data-model-components),
but it worth a quick overview and a graphical representation is included here.

![](data:image/png;base64...)

The data model is encoded as a
so-called property graph. Nodes represent entities such as Projects,
Cases, Diagnoses, Files (various kinds), and Annotations. The
relationships between these entities are maintained as edges. Both
nodes and edges may have Properties that supply instance details.

The
GDC API exposes these nodes and edges in a somewhat simplified set
of
[RESTful](https://en.wikipedia.org/wiki/Representational_state_transfer) endpoints.

# 2 Quickstart

This quickstart section is just meant to show basic
functionality. More details of functionality are included further on
in this vignette and in function-specific help.

This software is available at Bioconductor.org and can be downloaded via
`BiocManager::install`.

To report bugs or problems, either
[submit a new issue](https://github.com/Bioconductor/GenomicDataCommons/issues)
or submit a `bug.report(package='GenomicDataCommons')` from within R (which
will redirect you to the new issue on GitHub).

## 2.1 Installation

Installation can be achieved via Bioconductor’s `BiocManager` package.

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install('GenomicDataCommons')
```

```
library(GenomicDataCommons)
```

## 2.2 Check connectivity and status

The *[GenomicDataCommons](https://bioconductor.org/packages/3.22/GenomicDataCommons)* package relies on having network
connectivity. In addition, the NCI GDC API must also be operational
and not under maintenance. Checking `status` can be used to check this
connectivity and functionality.

```
GenomicDataCommons::status()
```

```
## $commit
## [1] "5b5cdf2ed966f26acebc4ac9605790d6b996bb13"
##
## $data_release
## [1] "Data Release 44.0 - October 29, 2025"
##
## $data_release_version
## $data_release_version$major
## [1] 44
##
## $data_release_version$minor
## [1] 0
##
## $data_release_version$release_date
## [1] "2025-10-29"
##
##
## $status
## [1] "OK"
##
## $tag
## [1] "7.10.1"
##
## $version
## [1] 1
```

And to check the status in code:

```
stopifnot(GenomicDataCommons::status()$status=="OK")
```

## 2.3 Find data

The following code builds a `manifest` that can be used to guide the
download of raw data. Here, filtering finds gene expression files
quantified as raw counts using `STAR` from ovarian cancer patients.

```
ge_manifest <- files() |>
    filter( cases.project.project_id == 'TCGA-OV') |>
    filter( type == 'gene_expression' ) |>
    filter( analysis.workflow_type == 'STAR - Counts')  |>
    manifest()
head(ge_manifest)
```

## 2.4 Download data

After the 868 gene expression files
specified in the query above. Using multiple processes to do the download very
significantly speeds up the transfer in many cases. On a standard 1Gb
connection, the following completes in about 30 seconds. The first time the
data are downloaded, R will ask to create a cache directory (see `?gdc_cache`
for details of setting and interacting with the cache). Resulting
downloaded files will be stored in the cache directory. Future access to
the same files will be directly from the cache, alleviating multiple downloads.

```
fnames <- lapply(ge_manifest$id[1:20], gdcdata)
```

If the download had included controlled-access data, the download above would
have needed to include a `token`. Details are available in
[the authentication section below](#authentication).

## 2.5 Metadata queries

### 2.5.1 Clinical data

Accessing clinical data is a very common task. Given a set of `case_ids`,
the `gdc_clinical()` function will return a list of four `tibble`s.

* demographic
* diagnoses
* exposures
* main

```
case_ids = cases() |> results(size=10) |> ids()
clindat = gdc_clinical(case_ids)
names(clindat)
```

```
## [1] "demographic" "diagnoses"   "exposures"   "follow_ups"  "main"
```

```
head(clindat[["main"]])
```

```
head(clindat[["diagnoses"]])
```

### 2.5.2 General metadata queries

The *[GenomicDataCommons](https://bioconductor.org/packages/3.22/GenomicDataCommons)* package can access the significant
clinical, demographic, biospecimen, and annotation information
contained in the NCI GDC. The `gdc_clinical()` function will often
be all that is needed, but the API and *[GenomicDataCommons](https://bioconductor.org/packages/3.22/GenomicDataCommons)* package
make much flexibility if fine-tuning is required.

```
expands = c("diagnoses","annotations",
             "demographic","exposures")
clinResults = cases() |>
    GenomicDataCommons::select(NULL) |>
    GenomicDataCommons::expand(expands) |>
    results(size=50)
str(clinResults[[1]],list.len=6)
```

```
##  chr [1:50] "3f5a897d-1eaa-4d4c-8324-27ac07c90927" ...
```

```
# or listviewer::jsonedit(clinResults)
```

# 3 Basic design

This package design is meant to have some similarities to the “hadleyverse”
approach of dplyr. Roughly, the functionality for finding and accessing files
and metadata can be divided into:

1. Simple query constructors based on GDC API endpoints.
2. A set of verbs that when applied, adjust filtering, field selection, and
   faceting (fields for aggregation) and result in a new query object (an
   endomorphism)
3. A set of verbs that take a query and return results from the GDC

In addition, there are exhiliary functions for asking the GDC API for
information about available and default fields, slicing BAM files, and
downloading actual data files. Here is an overview of functionality111 See individual function and methods documentation for specific details..

* Creating a query
  + `projects()`
  + `cases()`
  + `files()`
  + `annotations()`
* Manipulating a query
  + `filter()`
  + `facet()`
  + `select()`
* Introspection on the GDC API fields
  + `mapping()`
  + `available_fields()`
  + `default_fields()`
  + `grep_fields()`
  + `available_values()`
  + `available_expand()`
* Executing an API call to retrieve query results
  + `results()`
  + `count()`
  + `response()`
* Raw data file downloads
  + `gdcdata()`
  + `transfer()`
  + `gdc_client()`
* Summarizing and aggregating field values (faceting)
  + `aggregations()`
* Authentication
  + `gdc_token()`
* BAM file slicing
  + `slicing()`

# 4 Usage

There are two main classes of operations when working with the NCI GDC.

1. [Querying metadata and finding data files](#querying-metadata) (e.g., finding
   all gene expression quantifications data files for all colon cancer patients).
2. [Transferring raw or processed data](#datafile-access-and-download) from the
   GDC to another computer (e.g., downloading raw or processed data)

Both classes of operation are reviewed in detail in the following sections.

## 4.1 Querying metadata

Vast amounts of metadata about cases (patients, basically), files, projects, and
so-called annotations are available via the NCI GDC API. Typically, one will
want to query metadata to either focus in on a set of files for download or
transfer *or* to perform so-called aggregations (pivot-tables, facets, similar
to the R `table()` functionality).

Querying metadata starts with [creating a “blank” query](#creating-a-query). One
will often then want to [`filter`](#filtering) the query to limit results prior
to [retrieving results](#retrieving-results). The GenomicDataCommons package has
[helper functions for listing fields](#fields-and-values) that are available for
filtering.

In addition to fetching results, the GDC API allows
[faceting, or aggregating,](#facets-and-aggregation), useful for compiling
reports, generating dashboards, or building user interfaces to GDC data (see GDC
web query interface for a non-R-based example).

### 4.1.1 Creating a query

A query of the GDC starts its life in R. Queries follow the four metadata
endpoints available at the GDC. In particular, there are four convenience
functions that each create `GDCQuery` objects (actually, specific subclasses of
`GDCQuery`):

* `projects()`
* `cases()`
* `files()`
* `annotations()`

```
pquery = projects()
```

The `pquery` object is now an object of (S3) class, `GDCQuery` (and
`gdc_projects` and `list`). The object contains the following elements:

* fields: This is a character vector of the fields that will be returned when we
  [retrieve data](#retrieving-results). If no fields are specified to, for
  example, the `projects()` function, the default fields from the GDC are used
  (see `default_fields()`)
* filters: This will contain results after calling the
  [`filter()` method](#filtering) and will be used to filter results on
  [retrieval](#retrieving-results).
* facets: A character vector of field names that will be used for
  [aggregating data](#facets-and-aggregation) in a call to `aggregations()`.
* token: A character(1) token from the GDC. See
  [the authentication section](#authentication) for details, but note that, in
  general, the token is not necessary for metadata query and retrieval, only for
  actual data download.

Looking at the actual object (get used to using `str()`!), note that the query
contains no results.

```
str(pquery)
```

```
## List of 4
##  $ fields : chr [1:10] "dbgap_accession_number" "disease_type" "intended_release_date" "name" ...
##  $ filters: NULL
##  $ facets : NULL
##  $ expand : NULL
##  - attr(*, "class")= chr [1:3] "gdc_projects" "GDCQuery" "list"
```

### 4.1.2 Retrieving results

[[ GDC pagination documentation ]](https://docs.gdc.cancer.gov/API/Users_Guide/Search_and_Retrieval/#size-and-from)

[[ GDC sorting documentation ]](https://docs.gdc.cancer.gov/API/Users_Guide/Search_and_Retrieval/#sort)

With a query object available, the next step is to retrieve results from the
GDC. The GenomicDataCommons package. The most basic type of results we can get
is a simple `count()` of records available that satisfy the filter criteria.
Note that we have not set any filters, so a `count()` here will represent all
the project records publicly available at the GDC in the “default” archive"

```
pcount = count(pquery)
# or
pcount = pquery |> count()
pcount
```

```
## [1] 88
```

The `results()` method will fetch actual results.

```
presults = pquery |> results()
```

These results are
returned from the GDC in [JSON](http://www.json.org/) format and
converted into a (potentially nested) list in R. The `str()` method is useful
for taking a quick glimpse of the data.

```
str(presults)
```

```
## List of 9
##  $ id                    : chr [1:10] "CTSP-DLBCL1" "TCGA-BRCA" "TCGA-LUAD" "CPTAC-3" ...
##  $ primary_site          :List of 10
##   ..$ CTSP-DLBCL1          : chr [1:2] "Lymph nodes" "Unknown"
##   ..$ TCGA-BRCA            : chr "Breast"
##   ..$ TCGA-LUAD            : chr "Bronchus and lung"
##   ..$ CPTAC-3              : chr [1:22] "Other and unspecified parts of tongue" "Floor of mouth" "Other and ill-defined sites in lip, oral cavity and pharynx" "Uterus, NOS" ...
##   ..$ APOLLO-LUAD          : chr "Bronchus and lung"
##   ..$ MATCH-B              : chr [1:17] "Small intestine" "Cervix uteri" "Colon" "Parotid gland" ...
##   ..$ CMI-ASC              : chr [1:9] "Heart, mediastinum, and pleura" "Bronchus and lung" "Breast" "Skin" ...
##   ..$ MATCH-C1             : chr [1:6] "Bronchus and lung" "Liver and intrahepatic bile ducts" "Stomach" "Palate" ...
##   ..$ BEATAML1.0-CRENOLANIB: chr "Hematopoietic and reticuloendothelial systems"
##   ..$ CDDP_EAGLE-1         : chr "Bronchus and lung"
##  $ dbgap_accession_number: chr [1:10] "phs001184" NA NA "phs001287" ...
##  $ project_id            : chr [1:10] "CTSP-DLBCL1" "TCGA-BRCA" "TCGA-LUAD" "CPTAC-3" ...
##  $ disease_type          :List of 10
##   ..$ CTSP-DLBCL1          : chr "Mature B-Cell Lymphomas"
##   ..$ TCGA-BRCA            : chr [1:9] "Adenomas and Adenocarcinomas" "Adnexal and Skin Appendage Neoplasms" "Fibroepithelial Neoplasms" "Ductal and Lobular Neoplasms" ...
##   ..$ TCGA-LUAD            : chr [1:4] "Acinar Cell Neoplasms" "Ductal and Lobular Neoplasms" "Adenomas and Adenocarcinomas" "Cystic, Mucinous and Serous Neoplasms"
##   ..$ CPTAC-3              : chr [1:12] "Lipomatous Neoplasms" "Nevi and Melanomas" "Gliomas" "Not Applicable" ...
##   ..$ APOLLO-LUAD          : chr "Adenomas and Adenocarcinomas"
##   ..$ MATCH-B              : chr [1:6] "Neoplasms, NOS" "Epithelial Neoplasms, NOS" "Ductal and Lobular Neoplasms" "Nerve Sheath Tumors" ...
##   ..$ CMI-ASC              : chr "Soft Tissue Tumors and Sarcomas, NOS"
##   ..$ MATCH-C1             : chr [1:3] "Nevi and Melanomas" "Adenomas and Adenocarcinomas" "Neoplasms, NOS"
##   ..$ BEATAML1.0-CRENOLANIB: chr "Myeloid Leukemias"
##   ..$ CDDP_EAGLE-1         : chr "Adenomas and Adenocarcinomas"
##  $ name                  : chr [1:10] "CTSP Diffuse Large B-Cell Lymphoma (DLBCL) CALGB 50303" "Breast Invasive Carcinoma" "Lung Adenocarcinoma" "CPTAC-Brain, Head and Neck, Kidney, Lung, Pancreas, Uterus" ...
##  $ releasable            : logi [1:10] TRUE TRUE TRUE TRUE TRUE FALSE ...
##  $ state                 : chr [1:10] "open" "open" "open" "open" ...
##  $ released              : logi [1:10] TRUE TRUE TRUE TRUE TRUE TRUE ...
##  - attr(*, "row.names")= int [1:10] 1 2 3 4 5 6 7 8 9 10
##  - attr(*, "class")= chr [1:3] "GDCprojectsResults" "GDCResults" "list"
```

A default of only 10 records are returned. We can use the `size` and `from`
arguments to `results()` to either page through results or to change the number
of results. Finally, there is a convenience method, `results_all()` that will
simply fetch all the available results given a query. Note that `results_all()`
may take a long time and return HUGE result sets if not used carefully. Use of a
combination of `count()` and `results()` to get a sense of the expected data
size is probably warranted before calling `results_all()`

```
length(ids(presults))
```

```
## [1] 10
```

```
presults = pquery |> results_all()
length(ids(presults))
```

```
## [1] 88
```

```
# includes all records
length(ids(presults)) == count(pquery)
```

```
## [1] TRUE
```

Extracting subsets of
results or manipulating the results into a more conventional R data
structure is not easily generalizable. However,
the
[purrr](https://github.com/hadley/purrr),
[rlist](https://renkun.me/rlist/),
and [data.tree](https://cran.r-project.org/web/packages/data.tree/vignettes/data.tree.html) packages
are all potentially of interest for manipulating complex, nested list
structures. For viewing the results in an interactive viewer, consider the
[listviewer](https://github.com/timelyportfolio/listviewer) package.

### 4.1.3 Fields and Values

[[ GDC `fields` documentation ]](https://docs.gdc.cancer.gov/API/Users_Guide/Search_and_Retrieval/#fields)

Central to querying and retrieving data from the GDC is the ability to specify
which fields to return, filtering by fields and values, and faceting or
aggregating. The GenomicDataCommons package includes two simple functions,
`available_fields()` and `default_fields()`. Each can operate on a character(1)
endpoint name (“cases”, “files”, “annotations”, or “projects”) or a `GDCQuery`
object.

```
default_fields('files')
```

```
##  [1] "access"                         "acl"
##  [3] "average_base_quality"           "average_insert_size"
##  [5] "average_read_length"            "cancer_dna_fraction"
##  [7] "channel"                        "chip_id"
##  [9] "chip_position"                  "contamination"
## [11] "contamination_error"            "created_datetime"
## [13] "data_category"                  "data_format"
## [15] "data_type"                      "error_type"
## [17] "experimental_strategy"          "file_autocomplete"
## [19] "file_id"                        "file_name"
## [21] "file_size"                      "genome_doubling"
## [23] "imaging_date"                   "magnification"
## [25] "md5sum"                         "mean_coverage"
## [27] "msi_score"                      "msi_status"
## [29] "pairs_on_diff_chr"              "plate_name"
## [31] "plate_well"                     "platform"
## [33] "proc_internal"                  "proportion_base_mismatch"
## [35] "proportion_coverage_10x"        "proportion_coverage_30x"
## [37] "proportion_reads_duplicated"    "proportion_reads_mapped"
## [39] "proportion_targets_no_coverage" "read_pair_number"
## [41] "revision"                       "stain_type"
## [43] "state"                          "state_comment"
## [45] "subclonal_genome_fraction"      "submitter_id"
## [47] "tags"                           "total_reads"
## [49] "tumor_ploidy"                   "tumor_purity"
## [51] "type"                           "updated_datetime"
## [53] "wgs_coverage"
```

```
# The number of fields available for files endpoint
length(available_fields('files'))
```

```
## [1] 1193
```

```
# The first few fields available for files endpoint
head(available_fields('files'))
```

```
## [1] "access"                      "acl"
## [3] "analysis.analysis_id"        "analysis.analysis_type"
## [5] "analysis.created_datetime"   "analysis.input_files.access"
```

The fields to be returned by a query can be specified following a similar
paradigm to that of the dplyr package. The `select()` function is a verb that
resets the fields slot of a `GDCQuery`; note that this is not quite analogous to
the dplyr `select()` verb that limits from already-present fields. We
*completely replace* the fields when using `select()` on a `GDCQuery`.

```
# Default fields here
qcases = cases()
qcases$fields
```

```
##  [1] "aliquot_ids"              "analyte_ids"
##  [3] "case_autocomplete"        "case_id"
##  [5] "consent_type"             "created_datetime"
##  [7] "days_to_consent"          "days_to_lost_to_followup"
##  [9] "diagnosis_ids"            "disease_type"
## [11] "index_date"               "lost_to_followup"
## [13] "portion_ids"              "primary_site"
## [15] "sample_ids"               "slide_ids"
## [17] "state"                    "submitter_aliquot_ids"
## [19] "submitter_analyte_ids"    "submitter_diagnosis_ids"
## [21] "submitter_id"             "submitter_portion_ids"
## [23] "submitter_sample_ids"     "submitter_slide_ids"
## [25] "updated_datetime"
```

```
# set up query to use ALL available fields
# Note that checking of fields is done by select()
qcases = cases() |> GenomicDataCommons::select(available_fields('cases'))
head(qcases$fields)
```

```
## [1] "case_id"                       "aliquot_ids"
## [3] "analyte_ids"                   "annotations.annotation_id"
## [5] "annotations.case_id"           "annotations.case_submitter_id"
```

Finding fields of interest is such a common operation that the
GenomicDataCommons includes the `grep_fields()` function.
See the appropriate help pages for details.

### 4.1.4 Facets and aggregation

[[ GDC `facet` documentation ]](https://docs.gdc.cancer.gov/API/Users_Guide/Search_and_Retrieval/#facets)

The GDC API offers a feature known as aggregation or faceting. By
specifying one or more fields (of appropriate type), the GDC can
return to us a count of the number of records matching each potential
value. This is similar to the R `table` method. Multiple fields can be
returned at once, but the GDC API does not have a cross-tabulation
feature; all aggregations are only on one field at a time. Results of
`aggregation()` calls come back as a list of data.frames (actually,
tibbles).

```
# total number of files of a specific type
res = files() |> facet(c('type','data_type')) |> aggregations()
res$type
```

Using `aggregations()` is an also easy way to learn the contents of individual
fields and forms the basis for faceted search pages.

### 4.1.5 Filtering

[[ GDC `filtering` documentation ]](https://docs.gdc.cancer.gov/API/Users_Guide/Search_and_Retrieval/#filters-specifying-the-query)

The GenomicDataCommons package uses a form of non-standard evaluation to specify
R-like queries that are then translated into an R list. That R list is, upon
calling a method that fetches results from the GDC API, translated into the
appropriate JSON string. The R expression uses the formula interface as
suggested by Hadley Wickham in his [vignette on non-standard evaluation](https://cran.r-project.org/web/packages/dplyr/vignettes/nse.html)

> It’s best to use a formula because a formula captures both the expression to
> evaluate and the environment where the evaluation occurs. This is important if
> the expression is a mixture of variables in a data frame and objects in the
> local environment [for example].

For the user, these details will not be too important except to note that a
filter expression must begin with a “~”.

```
qfiles = files()
qfiles |> count() # all files
```

```
## [1] 1223539
```

To limit the file type, we can refer back to the
[section on faceting](#facets-and-aggregation) to see the possible values for
the file field “type”. For example, to filter file results to only
“gene\_expression” files, we simply specify a filter.

```
qfiles = files() |> filter( type == 'gene_expression')
# here is what the filter looks like after translation
str(get_filter(qfiles))
```

```
## List of 2
##  $ op     : 'scalar' chr "="
##  $ content:List of 2
##   ..$ field: chr "type"
##   ..$ value: chr "gene_expression"
```

What if we want to create a filter based on the project (‘TCGA-OVCA’, for
example)? Well, we have a couple of possible ways to discover available fields.
The first is based on base R functionality and some intuition.

```
grep('pro',available_fields('files'),value=TRUE) |>
    head()
```

```
## [1] "analysis.input_files.proc_internal"
## [2] "analysis.input_files.proportion_base_mismatch"
## [3] "analysis.input_files.proportion_coverage_10x"
## [4] "analysis.input_files.proportion_coverage_30x"
## [5] "analysis.input_files.proportion_reads_duplicated"
## [6] "analysis.input_files.proportion_reads_mapped"
```

Interestingly, the project information is “nested” inside the case. We don’t
need to know that detail other than to know that we now have a few potential
guesses for where our information might be in the files records. We need to
know where because we need to construct the appropriate filter.

```
files() |>
    facet('cases.project.project_id') |>
    aggregations() |>
    head()
```

```
## $cases.project.project_id
##    doc_count                       key
## 1     100017                   CPTAC-3
## 2      70776                 TCGA-BRCA
## 3      54096                     FM-AD
## 4      59326                MP2PRT-ALL
## 5      52156                TARGET-AML
## 6      36224                 TCGA-LUAD
## 7      34816                 TCGA-HNSC
## 8      33337                 TCGA-UCEC
## 9      43656                 HCMI-CMDC
## 10     32864                   TCGA-OV
## 11     34535                 TCGA-KIRC
## 12     33411                 TCGA-THCA
## 13     33453                  TCGA-LGG
## 14     30326                  TCGA-GBM
## 15     32614                 TCGA-LUSC
## 16     31915                 TCGA-PRAD
## 17     31338                 TCGA-BLCA
## 18     31088                 TCGA-STAD
## 19     28900                 TCGA-COAD
## 20     28203                 TCGA-SKCM
## 21     34109             MMRF-COMMPASS
## 22     23930                 TCGA-LIHC
## 23     19315                 TCGA-CESC
## 24     18117             TARGET-ALL-P2
## 25     18618                 TCGA-KIRP
## 26     16252                 TCGA-SARC
## 27     18140                 REBC-THYR
## 28     12335                CGCI-BLGSP
## 29     16794         BEATAML1.0-COHORT
## 30     13513                TARGET-NBL
## 31     12853                 TCGA-PAAD
## 32     12851                 TCGA-TGCT
## 33     11823                 TCGA-PCPG
## 34     14457                  CCDI-MCI
## 35     11120                 TCGA-ESCA
## 36     10274                 TCGA-READ
## 37      7968                 TCGA-THYM
## 38      8839                 TCGA-LAML
## 39      9244                   CPTAC-2
## 40      6415                 TARGET-WT
## 41      6997             CGCI-HTMCP-CC
## 42      5993                 TCGA-KICH
## 43      5789                  TCGA-ACC
## 44      5511                 TCGA-MESO
## 45      5509                  TCGA-UVM
## 46      5454                   CMI-MBC
## 47      4239                 TARGET-OS
## 48      5286              NCICCR-DLBCL
## 49      3720                  TCGA-UCS
## 50      4127             TARGET-ALL-P3
## 51      3141                 TCGA-DLBC
## 52      3171                 TCGA-CHOL
## 53      2062          CGCI-HTMCP-DLBCL
## 54      2257                 MP2PRT-WT
## 55      2058               APOLLO-LUAD
## 56      1826 EXCEPTIONAL_RESPONDERS-ER
## 57      1801                WCDT-MCRPC
## 58      1796              CDDP_EAGLE-1
## 59      1655                 APOLLO-OV
## 60      1628                  OHSU-CNL
## 61      1419                   MATCH-I
## 62      1036                 TARGET-RT
## 63      1147             CGCI-HTMCP-LC
## 64      1305                   CMI-MPC
## 65      1091                   MATCH-W
## 66      1090                 MATCH-Z1A
## 67       980                  MATCH-S1
## 68       896       ORGANOID-PANCREATIC
## 69       891                 MATCH-Z1D
## 70       852                   MATCH-Q
## 71       806                   CMI-ASC
## 72       810                   MATCH-B
## 73       783                   MATCH-Y
## 74       700                   MATCH-R
## 75       694                 MATCH-Z1B
## 76       680                   MATCH-P
## 77       660                 MATCH-Z1I
## 78       553               CTSP-DLBCL1
## 79       547     BEATAML1.0-CRENOLANIB
## 80       545                   MATCH-U
## 81       510                   MATCH-N
## 82       509                   MATCH-H
## 83       339                  TRIO-CRU
## 84       263                  MATCH-C1
## 85       185               TARGET-CCSK
## 86       107             TARGET-ALL-P1
## 87        61                  MATCH-S2
## 88        42            VAREPOP-APOLLO
```

We note that `cases.project.project_id` looks like it is a good fit. We also
note that `TCGA-OV` is the correct project\_id, not `TCGA-OVCA`. Note that
*unlike with dplyr and friends, the `filter()` method here **replaces** the
filter and does not build on any previous filters*.

```
qfiles = files() |>
    filter( cases.project.project_id == 'TCGA-OV' & type == 'gene_expression')
str(get_filter(qfiles))
```

```
## List of 2
##  $ op     : 'scalar' chr "and"
##  $ content:List of 2
##   ..$ :List of 2
##   .. ..$ op     : 'scalar' chr "="
##   .. ..$ content:List of 2
##   .. .. ..$ field: chr "cases.project.project_id"
##   .. .. ..$ value: chr "TCGA-OV"
##   ..$ :List of 2
##   .. ..$ op     : 'scalar' chr "="
##   .. ..$ content:List of 2
##   .. .. ..$ field: chr "type"
##   .. .. ..$ value: chr "gene_expression"
```

```
qfiles |> count()
```

```
## [1] 868
```

Asking for a `count()` of results given these new filter criteria gives `r qfiles |> count()` results. Filters can be chained (or nested) to
accomplish the same effect as multiple `&` conditionals. The `count()`
below is equivalent to the `&` filtering done above.

```
qfiles2 = files() |>
    filter( cases.project.project_id == 'TCGA-OV') |>
    filter( type == 'gene_expression')
qfiles2 |> count()
```

```
## [1] 868
```

```
(qfiles |> count()) == (qfiles2 |> count()) #TRUE
```

```
## [1] TRUE
```

Generating a manifest for bulk downloads is as
simple as asking for the manifest from the current query.

```
manifest_df = qfiles |> manifest()
head(manifest_df)
```

Note that we might still not be quite there. Looking at filenames, there are
suspiciously named files that might include “FPKM”, “FPKM-UQ”, or “counts”.
Another round of `grep` and `available_fields`, looking for “type” turned up
that the field “analysis.workflow\_type” has the appropriate filter criteria.

```
qfiles = files() |> filter( ~ cases.project.project_id == 'TCGA-OV' &
                            type == 'gene_expression' &
                            access == "open" &
                            analysis.workflow_type == 'STAR - Counts')
manifest_df = qfiles |> manifest()
nrow(manifest_df)
```

```
## [1] 433
```

The GDC Data Transfer Tool can be used (from R, `transfer()` or from the
command-line) to orchestrate high-performance, restartable transfers of all the
files in the manifest. See [the bulk downloads section](bulk-downloads) for
details.

## 4.2 Authentication

[[ GDC authentication documentation ]](https://docs.gdc.cancer.gov/API/Users_Guide/Search_and_Retrieval/#facets)

The GDC offers both “controlled-access” and “open” data. As of this
writing, only data stored as files is “controlled-access”; that is,
metadata accessible via the GDC is all “open” data and some files are
“open” and some are “controlled-access”. Controlled-access data are
only available
after
[going through the process of obtaining access.](https://gdc.cancer.gov/access-data/obtaining-access-controlled-data)

After controlled-access to one or more datasets has been granted,
logging into the GDC web portal will allow you
to
[access a GDC authentication token](https://docs.gdc.cancer.gov/Data_Portal/Users_Guide/Authentication/#gdc-authentication-tokens),
which can be downloaded and then used to access available
controlled-access data via the GenomicDataCommons package.

The GenomicDataCommons uses authentication tokens only for downloading
data (see `transfer` and `gdcdata` documentation). The package
includes a helper function, `gdc_token`, that looks for the token to
be stored in one of three ways (resolved in this order):

1. As a string stored in the environment variable, `GDC_TOKEN`
2. As a file, stored in the file named by the environment variable,
   `GDC_TOKEN_FILE`
3. In a file in the user home directory, called `.gdc_token`

As a concrete example:

```
token = gdc_token()
transfer(...,token=token)
# or
transfer(...,token=get_token())
```

## 4.3 Datafile access and download

### 4.3.1 Data downloads via the GDC API

The `gdcdata` function takes a character vector of one or more file
ids. A simple way of producing such a vector is to produce a
`manifest` data frame and then pass in the first column, which will
contain file ids.

```
fnames = gdcdata(manifest_df$id[1:2],progress=FALSE)
```

Note that for controlled-access data, a
GDC [authentication token](#authentication) is required. Using the
`BiocParallel` package may be useful for downloading in parallel,
particularly for large numbers of smallish files.

### 4.3.2 Bulk downloads

The bulk download functionality is only efficient (as of v1.2.0 of the
GDC Data Transfer Tool) for relatively large files, so use this
approach only when transferring BAM files or larger VCF files, for
example. Otherwise, consider using the approach shown above, perhaps
in parallel.

```
# Requires gcd_client command-line utility to be isntalled
# separately.
fnames = gdcdata(manifest_df$id[3:10], access_method = 'client')
```

### 4.3.3 BAM slicing

# 5 Use Cases

## 5.1 Cases

### 5.1.1 How many cases are there per project\_id?

```
res = cases() |> facet("project.project_id") |> aggregations()
head(res)
```

```
## $project.project_id
##    doc_count                       key
## 1      18004                     FM-AD
## 2       3093                  CCDI-MCI
## 3       2492                TARGET-AML
## 4       1683                   CPTAC-3
## 5       1587             TARGET-ALL-P2
## 6       1510                MP2PRT-ALL
## 7       1132                TARGET-NBL
## 8       1098                 TCGA-BRCA
## 9        995             MMRF-COMMPASS
## 10       826         BEATAML1.0-COHORT
## 11       804                 HCMI-CMDC
## 12       652                 TARGET-WT
## 13       617                  TCGA-GBM
## 14       608                   TCGA-OV
## 15       585                 TCGA-LUAD
## 16       560                 TCGA-UCEC
## 17       537                 TCGA-KIRC
## 18       528                 TCGA-HNSC
## 19       516                  TCGA-LGG
## 20       507                 TCGA-THCA
## 21       504                 TCGA-LUSC
## 22       500                 TCGA-PRAD
## 23       489              NCICCR-DLBCL
## 24       470                 TCGA-SKCM
## 25       461                 TCGA-COAD
## 26       449                 REBC-THYR
## 27       443                 TCGA-STAD
## 28       412                 TCGA-BLCA
## 29       383                 TARGET-OS
## 30       377                 TCGA-LIHC
## 31       342                   CPTAC-2
## 32       339                  TRIO-CRU
## 33       324                CGCI-BLGSP
## 34       307                 TCGA-CESC
## 35       291                 TCGA-KIRP
## 36       263                 TCGA-TGCT
## 37       261                 TCGA-SARC
## 38       212             CGCI-HTMCP-CC
## 39       200                   CMI-MBC
## 40       200                 TCGA-LAML
## 41       191             TARGET-ALL-P3
## 42       185                 TCGA-ESCA
## 43       185                 TCGA-PAAD
## 44       179                 TCGA-PCPG
## 45       176                  OHSU-CNL
## 46       172                 TCGA-READ
## 47       124                 TCGA-THYM
## 48       113                 TCGA-KICH
## 49       101                WCDT-MCRPC
## 50        92                  TCGA-ACC
## 51        87               APOLLO-LUAD
## 52        87                 TCGA-MESO
## 53        84 EXCEPTIONAL_RESPONDERS-ER
## 54        80                  TCGA-UVM
## 55        70                 APOLLO-OV
## 56        70          CGCI-HTMCP-DLBCL
## 57        70       ORGANOID-PANCREATIC
## 58        69                 TARGET-RT
## 59        63                   CMI-MPC
## 60        60                   MATCH-I
## 61        58                 TCGA-DLBC
## 62        57                  TCGA-UCS
## 63        56     BEATAML1.0-CRENOLANIB
## 64        52                 MP2PRT-WT
## 65        51                 TCGA-CHOL
## 66        50              CDDP_EAGLE-1
## 67        45               CTSP-DLBCL1
## 68        45                   MATCH-W
## 69        45                 MATCH-Z1A
## 70        41                  MATCH-S1
## 71        39             CGCI-HTMCP-LC
## 72        36                   CMI-ASC
## 73        36                 MATCH-Z1D
## 74        35                   MATCH-Q
## 75        33                   MATCH-B
## 76        31                   MATCH-Y
## 77        29                 MATCH-Z1B
## 78        28                   MATCH-P
## 79        28                   MATCH-R
## 80        26                 MATCH-Z1I
## 81        24             TARGET-ALL-P1
## 82        23                   MATCH-U
## 83        21                   MATCH-H
## 84        21                   MATCH-N
## 85        13               TARGET-CCSK
## 86        11                  MATCH-C1
## 87         7            VAREPOP-APOLLO
## 88         3                  MATCH-S2
```

```
library(ggplot2)
ggplot(res$project.project_id,aes(x = key, y = doc_count)) +
    geom_bar(stat='identity') +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
```

![](data:image/png;base64...)

### 5.1.2 How many cases are included in all TARGET projects?

```
cases() |> filter(~ project.program.name=='TARGET') |> count()
```

```
## [1] 6543
```

### 5.1.3 How many cases are included in all TCGA projects?

```
cases() |> filter(~ project.program.name=='TCGA') |> count()
```

```
## [1] 11428
```

### 5.1.4 What is the breakdown of sample types in TCGA-BRCA?

```
# The need to do the "&" here is a requirement of the
# current version of the GDC API. I have filed a feature
# request to remove this requirement.
resp = cases() |> filter(~ project.project_id=='TCGA-BRCA' &
                              project.project_id=='TCGA-BRCA' ) |>
    facet('samples.sample_type') |> aggregations()
resp$samples.sample_type
```

### 5.1.5 Fetch all samples in TCGA-BRCA that use “Solid Tissue” as a normal.

```
# The need to do the "&" here is a requirement of the
# current version of the GDC API. I have filed a feature
# request to remove this requirement.
resp = cases() |> filter(~ project.project_id=='TCGA-BRCA' &
                              samples.sample_type=='Solid Tissue Normal') |>
    GenomicDataCommons::select(c(default_fields(cases()),'samples.sample_type')) |>
    response_all()
count(resp)
```

```
## [1] 162
```

```
res = resp |> results()
str(res[1],list.len=6)
```

```
## List of 1
##  $ id: chr [1:162] "f062cbd0-2426-40ac-a4be-e74ac61fa2a7" "9da462b0-93c2-4305-89f6-7199a30399a7" "f130f376-5801-40f9-975d-a7e2f7b5670d" "a1093598-d3a8-4ffe-83fc-bc7d1faff7e5" ...
```

```
head(ids(resp))
```

```
## [1] "f062cbd0-2426-40ac-a4be-e74ac61fa2a7"
## [2] "9da462b0-93c2-4305-89f6-7199a30399a7"
## [3] "f130f376-5801-40f9-975d-a7e2f7b5670d"
## [4] "a1093598-d3a8-4ffe-83fc-bc7d1faff7e5"
## [5] "92b5de82-0221-4df1-8094-80f40c0bb4fa"
## [6] "659b0170-e914-45ff-aa55-fcb8d3dc7b8a"
```

### 5.1.6 Get all TCGA case ids that are female

```
cases() |>
  GenomicDataCommons::filter(~ project.program.name == 'TCGA' &
    "cases.demographic.gender" %in% "female") |>
      GenomicDataCommons::results(size = 4) |>
        ids()
```

```
## [1] "0030a28c-81aa-44b0-8be0-b35e1dcbf98c"
## [2] "0e251c03-bf86-4ed8-b45d-3cbc97160502"
## [3] "0e9fcccc-0630-408d-a121-2c6413824cb7"
## [4] "1f971af1-6772-4fe6-8d35-bbe527a037fe"
```

### 5.1.7 Get all TCGA-COAD case ids that are NOT female

```
cases() |>
  GenomicDataCommons::filter(~ project.project_id == 'TCGA-COAD' &
    "cases.demographic.gender" %exclude% "female") |>
      GenomicDataCommons::results(size = 4) |>
        ids()
```

```
## [1] "265d7b06-65fe-42c5-ad21-e6b160e94718"
## [2] "d655bbf6-c710-411d-aff5-ceb0fb6e6680"
## [3] "4f601d7b-8db1-4c6d-9374-21dcd804980d"
## [4] "c085da47-d634-491a-80ea-514e5a231f70"
```

### 5.1.8 Get all TCGA cases that are missing gender

```
cases() |>
  GenomicDataCommons::filter(~ project.program.name == 'TCGA' &
    missing("cases.demographic.gender")) |>
      GenomicDataCommons::results(size = 4) |>
        ids()
```

```
## [1] "1ec1e2c4-ba2c-40fc-b5e1-e8f6e38caec6"
## [2] "24506980-2857-4069-9af3-79ce4527eb00"
## [3] "4263949c-f962-40dd-9998-02ad3fba4537"
## [4] "44f10972-9f1f-4f7d-b8a0-0062c961001b"
```

### 5.1.9 Get all TCGA cases that are NOT missing gender

```
cases() |>
  GenomicDataCommons::filter(~ project.program.name == 'TCGA' &
    !missing("cases.demographic.gender")) |>
      GenomicDataCommons::results(size = 4) |>
        ids()
```

```
## [1] "3f5a897d-1eaa-4d4c-8324-27ac07c90927"
## [2] "0030a28c-81aa-44b0-8be0-b35e1dcbf98c"
## [3] "0bf573ac-cd1e-42d8-90cf-b30d7b08679c"
## [4] "0e251c03-bf86-4ed8-b45d-3cbc97160502"
```

## 5.2 Files

### 5.2.1 How many of each type of file are available?

```
res = files() |> facet('type') |> aggregations()
res$type
```

```
ggplot(res$type,aes(x = key,y = doc_count)) + geom_bar(stat='identity') +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
```

![](data:image/png;base64...)

### 5.2.2 Find gene-level RNA-seq quantification files for GBM

```
q = files() |>
    GenomicDataCommons::select(available_fields('files')) |>
    filter(~ cases.project.project_id=='TCGA-GBM' &
               data_type=='Gene Expression Quantification')
q |> facet('analysis.workflow_type') |> aggregations()
```

```
## list()
```

```
# so need to add another filter
file_ids = q |> filter(~ cases.project.project_id=='TCGA-GBM' &
                            data_type=='Gene Expression Quantification' &
                            analysis.workflow_type == 'STAR - Counts') |>
    GenomicDataCommons::select('file_id') |>
    response_all() |>
    ids()
```

## 5.3 Slicing

### 5.3.1 Get all BAM file ids from TCGA-GBM

**I need to figure out how to do slicing reproducibly in a testing environment
and for vignette building**.

```
q = files() |>
    GenomicDataCommons::select(available_fields('files')) |>
    filter(~ cases.project.project_id == 'TCGA-GBM' &
               data_type == 'Aligned Reads' &
               experimental_strategy == 'RNA-Seq' &
               data_format == 'BAM')
file_ids = q |> response_all() |> ids()
```

```
bamfile = slicing(file_ids[1],regions="chr12:6534405-6538375",token=gdc_token())
library(GenomicAlignments)
aligns = readGAlignments(bamfile)
```

# 6 Troubleshooting

## 6.1 SSL connection errors

* Symptom: Trying to connect to the API results in:

```
Error in curl::curl_fetch_memory(url, handle = handle) :
SSL connect error
```

* Possible solutions: The [issue
  is that the GDC supports only recent security Transport Layer Security (TLS)](http://stackoverflow.com/a/42599546/459633),
  so the only known fix is to upgrade the system `openssl` to version
  1.0.1 or later.
  + [[Mac OS]](https://github.com/Bioconductor/GenomicDataCommons/issues/35#issuecomment-284233510),
  + [[Ubuntu]](http://askubuntu.com/a/434245)
  + [[Centos/RHEL]](https://www.liquidweb.com/kb/update-and-patch-openssl-for-the-ccs-injection-vulnerability/).
    After upgrading `openssl`, reinstall the R `curl` and `httr` packages.

# 7 sessionInfo()

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] ggplot2_4.0.0             GenomicDataCommons_1.34.1
## [3] knitr_1.50                BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3       sass_0.4.10          generics_0.1.4
##  [4] tidyr_1.3.1          xml2_1.4.1           hms_1.1.4
##  [7] digest_0.6.37        magrittr_2.0.4       evaluate_1.0.5
## [10] grid_4.5.1           RColorBrewer_1.1-3   bookdown_0.45
## [13] fastmap_1.2.0        jsonlite_2.0.0       tinytex_0.57
## [16] BiocManager_1.30.26  httr_1.4.7           purrr_1.2.0
## [19] scales_1.4.0         jquerylib_0.1.4      cli_3.6.5
## [22] rlang_1.1.6          crayon_1.5.3         withr_3.0.2
## [25] cachem_1.1.0         yaml_2.3.10          tools_4.5.1
## [28] tzdb_0.5.0           dplyr_1.1.4          BiocGenerics_0.56.0
## [31] curl_7.0.0           vctrs_0.6.5          R6_2.6.1
## [34] magick_2.9.0         stats4_4.5.1         lifecycle_1.0.4
## [37] Seqinfo_1.0.0        S4Vectors_0.48.0     IRanges_2.44.0
## [40] pkgconfig_2.0.3      pillar_1.11.1        bslib_0.9.0
## [43] gtable_0.3.6         Rcpp_1.1.0           glue_1.8.0
## [46] xfun_0.54            tibble_3.3.0         GenomicRanges_1.62.0
## [49] tidyselect_1.2.1     dichromat_2.0-0.1    farver_2.1.2
## [52] htmltools_0.5.8.1    labeling_0.4.3       rmarkdown_2.30
## [55] readr_2.1.5          compiler_4.5.1       S7_0.2.0
```

# 8 Developer notes

* The `S3` object-oriented programming paradigm is used.
* We have adopted a functional programming style with functions and methods that
  often take an “object” as the first argument. This style lends itself to
  pipeline-style programming.
* The GenomicDataCommons package uses the
  [alternative request format (POST)](https://docs.gdc.cancer.gov/API/Users_Guide/Search_and_Retrieval/#alternative-request-format)
  to allow very large request bodies.