# Handling FHIR documents with BiocFHIR

Vincent J. Carey, stvjc at channing.harvard.edu

#### October 29, 2025

# Contents

* [1 Introduction](#introduction)
* [2 Examining sample data, again](#examining-sample-data-again)
* [3 Choosing an approach to FHIR JSON ingestion](#choosing-an-approach-to-fhir-json-ingestion)
* [4 Working with a specific type](#working-with-a-specific-type)
  + [4.1 List-based operations](#list-based-operations)
  + [4.2 Processing with BiocFHIR](#processing-with-biocfhir)
* [5 Direct querying of FHIR JSON](#direct-querying-of-fhir-json)
* [6 Session information](#session-information)

# 1 Introduction

The purpose of this vignette is to provide
details on how FHIR documents are
handled in BiocFHIR.

This text uses R commands that will work for an R (version 4.2 or greater) in which
BiocFHIR (version 0.0.14 or greater) has been installed. The source codes are
always available at [github](https://github.com/vjcitn/BiocFHIR) and may
be available for installation by other means.

We conclude this vignette with a very brief example of the
use of consjson to interrogate the FHIR JSON documents directly.

# 2 Examining sample data, again

In the “Upper level FHIR concepts” vignette, we used the
following code to get a peek at the information
structure in a single document representing a Bundle
associated with a patient.

```
tfile = dir(system.file("json", package="BiocFHIR"), full=TRUE)
peek = jsonlite::fromJSON(tfile)
names(peek)
```

```
## [1] "resourceType" "type"         "entry"
```

```
peek$resourceType
```

```
## [1] "Bundle"
```

```
names(peek$entry)
```

```
## [1] "fullUrl"  "resource" "request"
```

```
length(names(peek$entry$resource))
```

```
## [1] 72
```

```
class(peek$entry$resource)
```

```
## [1] "data.frame"
```

```
dim(peek$entry$resource)
```

```
## [1] 301  72
```

```
head(names(peek$entry$resource))
```

```
## [1] "resourceType" "id"           "text"         "extension"    "identifier"
## [6] "name"
```

# 3 Choosing an approach to FHIR JSON ingestion

Some of the complexity of working with FHIR JSON in R in this way
can be seen in the following:

```
head(which(vapply(peek$entry$resource$category,
   function(x)!is.null(x), logical(1))))
```

```
## [1]  6 10 11 12 13 14
```

```
peek$entry$resource$category[[6]]
```

```
##         coding      text
## 1 http://s.... Self care
```

```
peek$entry$resource$category[[6]]$coding
```

```
## [[1]]
##                   system            code   display
## 1 http://snomed.info/sct 326051000000105 Self care
```

```
peek$entry$resource$category[[10]]
```

```
## [1] "food"
```

Elements of category can be data.frame or atomic.
This is a consequence of naive use of `jsonlite::fromJSON`.

When we reduce the transformations attempted by `fromJSON`,
empty fields are not propagated.

```
peek2 = jsonlite::fromJSON(dir(system.file("json", package="BiocFHIR"), full=TRUE), simplifyVector=FALSE)
lapply(peek2$entry[1:5], function(x) names(x[["resource"]]))
```

```
## [[1]]
##  [1] "resourceType"         "id"                   "text"
##  [4] "extension"            "identifier"           "name"
##  [7] "telecom"              "gender"               "birthDate"
## [10] "deceasedDateTime"     "address"              "maritalStatus"
## [13] "multipleBirthBoolean" "communication"
##
## [[2]]
## [1] "resourceType" "id"           "identifier"   "active"       "type"
## [6] "name"         "telecom"      "address"
##
## [[3]]
## [1] "resourceType" "id"           "identifier"   "active"       "name"
## [6] "telecom"      "address"      "gender"
##
## [[4]]
## [1] "resourceType"    "id"              "status"          "class"
## [5] "type"            "subject"         "participant"     "period"
## [9] "serviceProvider"
##
## [[5]]
## [1] "resourceType"         "id"                   "status"
## [4] "subject"              "encounter"            "period"
## [7] "participant"          "managingOrganization"
```

Because the JSON ingestion does not attempt to simplify
table-like content, we have a list of lists with varying
depths of nesting.

We can tabulate the resource types using

```
rtyvec = vapply(peek2$entry, function(x)
   x[["resource"]]$resourceType, character(1))
table(rtyvec)
```

```
## rtyvec
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

# 4 Working with a specific type

## 4.1 List-based operations

Let’s use `peek2` to extract
Conditions recorded on the patient.

```
iscond = which(rtyvec == "Condition")
conds = peek2$entry[iscond]
length(conds)
```

```
## [1] 15
```

```
str(conds[[1]])
```

```
## List of 3
##  $ fullUrl : chr "urn:uuid:adc05f8e-0e90-4217-b1d7-fa41b8e33638"
##  $ resource:List of 9
##   ..$ resourceType      : chr "Condition"
##   ..$ id                : chr "adc05f8e-0e90-4217-b1d7-fa41b8e33638"
##   ..$ clinicalStatus    :List of 1
##   .. ..$ coding:List of 1
##   .. .. ..$ :List of 2
##   .. .. .. ..$ system: chr "http://terminology.hl7.org/CodeSystem/condition-clinical"
##   .. .. .. ..$ code  : chr "active"
##   ..$ verificationStatus:List of 1
##   .. ..$ coding:List of 1
##   .. .. ..$ :List of 2
##   .. .. .. ..$ system: chr "http://terminology.hl7.org/CodeSystem/condition-ver-status"
##   .. .. .. ..$ code  : chr "confirmed"
##   ..$ code              :List of 2
##   .. ..$ coding:List of 1
##   .. .. ..$ :List of 3
##   .. .. .. ..$ system : chr "http://snomed.info/sct"
##   .. .. .. ..$ code   : chr "446096008"
##   .. .. .. ..$ display: chr "Perennial allergic rhinitis"
##   .. ..$ text  : chr "Perennial allergic rhinitis"
##   ..$ subject           :List of 1
##   .. ..$ reference: chr "urn:uuid:eedf9986-9cf8-4e90-bf68-12a6dd9a31c2"
##   ..$ encounter         :List of 1
##   .. ..$ reference: chr "urn:uuid:9c95930d-83a4-4a89-9bbb-8e540e729233"
##   ..$ onsetDateTime     : chr "1973-06-29T07:25:09-04:00"
##   ..$ recordedDate      : chr "1973-06-29T07:25:09-04:00"
##  $ request :List of 2
##   ..$ method: chr "POST"
##   ..$ url   : chr "Condition"
```

Digging out the data and metadata on the first condition
recorded (Perennial allergic rhinitis), is somewhat
complex using R. Direct operations on JSON with JMESPATH
might be more effective, but we postpone this investigation.

## 4.2 Processing with BiocFHIR

In the `process_fhir_bundle` function of BiocFHIR
we allow `jsonlite::fromJSON` to conduct some
simplification of list structures amenable to representation
as tables (data.frames).

```
tbu = process_fhir_bundle(tfile)
tbu
```

```
## BiocFHIR FHIR.bundle instance.
##   resource types are:
##    AllergyIntolerance CarePlan ... Patient Procedure
```

For the reports of Conditions, we extract specific
fields that are commonly used in the Synthea examples.
Other bundle sets may use different fields.

```
ctab = process_Condition(tbu$Condition)
dim(ctab)
```

```
## [1] 15  5
```

```
datatable(ctab)
```

The fields collected in `process_Condition` are specified
in `FHIR_retention_schemas()`. Eventually this will
need to become a user-specified element of ingestion and
transformation.

# 5 Direct querying of FHIR JSON

We’ve shown how we can operate on FHIR documents from the Synthea
project using specific schemas to select elements from lists
produced by parsing JSON. The FHIR specification is very
flexible, and the `process_*` methods defined here may
not work for FHIR documents from other sources.

The jsoncons library provides C++ code for parsing and
filtering JSON, and the [rjsoncons](https://CRAN.R-project.org/package%3Drjsoncons)
package is available to support JMESPATH queries.

In this example, we’ll take 4 Synthea FHIR documents and
extract patient addresses to a data.frame.

```
z = make_test_json_set()
myl = lapply(z[1:4], jsonlite::fromJSON) # list that rconsjson will convert to JSON
library(rjsoncons)
tmp = jmespath(myl, "[*].entry[0].resource.address") |> jsonlite::fromJSON()
do.call(rbind,lapply(tmp, function(x) x[,-(1:2)]))
```

```
##          city         state postalCode country
## 1      Malden Massachusetts      02148      US
## 2 Springfield Massachusetts      01013      US
## 3    Brewster Massachusetts      02631      US
## 4     Webster Massachusetts      01570      US
```

The JMESPATH query projects from all documents via the initial `[*]`.
It then retrieves the address element from the resource element of
the first ([0]) entry. An overview of the hierarchical structure of
`myl` can be obtained using `listviewer::jsonedit`.

# 6 Session information

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