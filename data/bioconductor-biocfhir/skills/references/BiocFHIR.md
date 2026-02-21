# BiocFHIR – infrastructure for parsing and analyzing FHIR data

Vincent J. Carey, stvjc at channing.harvard.edu

#### October 29, 2025

# Contents

* [1 Introduction](#introduction)
  + [1.1 The basic structure of FHIR R4 JSON](#the-basic-structure-of-fhir-r4-json)
  + [1.2 Example: a table on Conditions recorded on the patient.](#example-a-table-on-conditions-recorded-on-the-patient.)
  + [1.3 A family of documents](#a-family-of-documents)
* [2 Session information](#session-information)

# 1 Introduction

FHIR stands for Fast Health Interoperability Resources.

The [Wikipedia article](https://en.wikipedia.org/wiki/Fast_Healthcare_Interoperability_Resources)
is a useful overview. The official website is [fhir.org](http://fhir.org).

This R package addresses very basic tasks of parsing FHIR R4 documents in JSON format.
The overall information model of FHIR documents is complex and various
decisions are made to help extract and annotate fields presumed to have
high value. Submit github issues if important fields are not being
propagated.

Install this package using

```
BiocManager::install("BiocFHIR")
```

## 1.1 The basic structure of FHIR R4 JSON

We use `jsonlite::fromJSON` to import a randomly selected
FHIR document from a collection simulated by the MITRE corporation.
See the associated [site](https://synthea.mitre.org/downloads) for details.

We’ll drill down through the hierarchy of elements collected in
a FHIR document with some base R commands, after importing the JSON.

```
testf = dir(system.file("json", package="BiocFHIR"), full=TRUE)
tt = fromJSON(testf)
names(tt)
```

```
## [1] "resourceType" "type"         "entry"
```

```
tt[1:2]
```

```
## $resourceType
## [1] "Bundle"
##
## $type
## [1] "transaction"
```

```
tte = tt$entry
class(tte)
```

```
## [1] "data.frame"
```

```
dim(tte)
```

```
## [1] 301   3
```

```
head(names(tte))
```

```
## [1] "fullUrl"  "resource" "request"
```

```
tter = tte$resource
dim(tter)
```

```
## [1] 301  72
```

```
head(names(tter))
```

```
## [1] "resourceType" "id"           "text"         "extension"    "identifier"
## [6] "name"
```

```
table(tter$resourceType)
```

```
##
##   AllergyIntolerance             CarePlan             CareTeam
##                    8                    3                    3
##                Claim            Condition     DiagnosticReport
##                   46                   15                    3
##            Encounter ExplanationOfBenefit         Immunization
##                   37                   37                   10
##    MedicationRequest          Observation         Organization
##                    9                  114                    3
##              Patient         Practitioner            Procedure
##                    1                    3                    9
```

It is by filtering the data frame `tter` that we acquire
information that may be useful in data analysis. The
data frame is sparse: many fields are not used in many records.
Code in this package attempts to produce useful tables
from the sparse information.

As a prologue to table extraction, we do some basic
decomposition of `tter` using `process_fhir_bundle`.

```
bu1 = process_fhir_bundle(testf) # just give file path
bu1
```

```
## BiocFHIR FHIR.bundle instance.
##   resource types are:
##    AllergyIntolerance CarePlan ... Patient Procedure
```

`bu1` is just a list of data.frames, but with considerable
nesting of data.frames and lists within the basic
data.frames corresponding to the major FHIR concepts.
“Flattening” of such structures is not fully automatic.

## 1.2 Example: a table on Conditions recorded on the patient.

We use `process_Condition` to extract information.

```
cond1 = process_Condition(bu1$Condition)
datatable(cond1)
```

## 1.3 A family of documents

We have collected 50 documents from the synthea resource.
These were obtained using random draws from the 1180 records
provided. A temporary folder holding them can be produced
as follows:

```
tset = make_test_json_set()
tset[1]
```

```
## [1] "/tmp/RtmpPvOCje/jsontest/Angel97_Swift555_c072e6ad-b03f-4eee-abe0-2dbc93bbadfe.json"
```

We import ten documents into a list.

```
myl = lapply(tset[1:10], process_fhir_bundle)
myl[1:2]
```

```
## [[1]]
## BiocFHIR FHIR.bundle instance.
##   resource types are:
##    AllergyIntolerance CarePlan ... Patient Procedure
##
## [[2]]
## BiocFHIR FHIR.bundle instance.
##   resource types are:
##    CarePlan Claim ... Patient Procedure
```

```
sapply(myl,length)
```

```
##  [1] 10  9  7  9  9  9  9  9  9 10
```

We see with the last command that documents can have different numbers
of components present.

# 2 Session information

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
## [1] rjsoncons_1.3.2  jsonlite_2.0.0   DT_0.34.0        BiocFHIR_1.12.0
## [5] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] dplyr_1.1.4          compiler_4.5.1       BiocManager_1.30.26
##  [4] BiocBaseUtils_1.12.0 promises_1.4.0       tidyselect_1.2.1
##  [7] Rcpp_1.1.0           tidyr_1.3.1          later_1.4.4
## [10] jquerylib_0.1.4      yaml_2.3.10          fastmap_1.2.0
## [13] mime_0.13            R6_2.6.1             generics_0.1.4
## [16] knitr_1.50           htmlwidgets_1.6.4    visNetwork_2.1.4
## [19] BiocGenerics_0.56.0  graph_1.88.0         tibble_3.3.0
## [22] bookdown_0.45        shiny_1.11.1         bslib_0.9.0
## [25] pillar_1.11.1        rlang_1.1.6          cachem_1.1.0
## [28] httpuv_1.6.16        xfun_0.53            sass_0.4.10
## [31] otel_0.2.0           cli_3.6.5            magrittr_2.0.4
## [34] crosstalk_1.2.2      digest_0.6.37        xtable_1.8-4
## [37] lifecycle_1.0.4      vctrs_0.6.5          evaluate_1.0.5
## [40] glue_1.8.0           stats4_4.5.1         purrr_1.1.0
## [43] rmarkdown_2.30       tools_4.5.1          pkgconfig_2.0.3
## [46] htmltools_0.5.8.1
```