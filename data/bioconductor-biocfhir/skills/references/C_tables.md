# Transforming FHIR documents to tables with BiocFHIR

Vincent J. Carey, stvjc at channing.harvard.edu

#### October 29, 2025

# Contents

* [1 Introduction](#introduction)
* [2 Examining sample data, again](#examining-sample-data-again)
* [3 Bundle to data frames](#bundle-to-data-frames)
* [4 Filtering FHIR elements](#filtering-fhir-elements)
* [5 The resources extracted from a bundle](#the-resources-extracted-from-a-bundle)
* [6 Accumulating resources across bundles](#accumulating-resources-across-bundles)
* [7 Session information](#session-information)

# 1 Introduction

The purpose of this vignette is to provide
details on how FHIR documents are
transformed to tables in BiocFHIR.

This text uses R commands that will work for an R (version 4.2 or greater) in which
BiocFHIR (version 0.0.14 or greater) has been installed. The source codes are
always available at [github](https://github.com/vjcitn/BiocFHIR) and may
be available for installation by other means.

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

We perform a first stage of transformation with `process_fhir_bundle`:

```
bu = process_fhir_bundle(tfile)
bu
```

```
## BiocFHIR FHIR.bundle instance.
##   resource types are:
##    AllergyIntolerance CarePlan ... Patient Procedure
```

# 3 Bundle to data frames

Each processed bundle is a collection of data.frame instances, formed
by splitting the input “entry” element by “resourceType”.
These data.frames are mostly filled with NA missing values, but
some columns have been ingested as lists. Executive decisions
are made in the package regarding which columns are likely
to hold useful information. Thus we have

```
po1 <- process_Observation(bu$Observation)
dim(po1)
```

```
## [1] 127  11
```

```
datatable(po1)
```

# 4 Filtering FHIR elements

A list of vectors of field names serves as the
basis for filtering JSON elements into
records for tabulation.

```
FHIR_retention_schemas()
```

```
## $Condition
## [1] "id"            "onsetDateTime" "code"          "subject"
##
## $AllergyIntolerance
## [1] "id"            "onsetDateTime" "code"          "patient"
## [5] "category"
##
## $CarePlan
## [1] "id"       "activity" "subject"  "category"
##
## $Claim
## [1] "id"             "provider"       "patient"        "billablePeriod"
## [5] "insurance"      "created"
##
## $Encounter
## [1] "id"              "type"            "subject"         "period"
## [5] "serviceProvider" "class"
##
## $MedicationRequest
## [1] "id"                        "subject"
## [3] "status"                    "requester"
## [5] "medicationCodeableConcept"
##
## $Observation
## [1] "id"                "subject"           "code"
## [4] "valueQuantity"     "category"          "effectiveDateTime"
## [7] "issued"            "component"
##
## $Procedure
## [1] "id"              "subject"         "status"          "performedPeriod"
## [5] "code"
##
## $Patient
##  [1] "id"                   "identifier"           "name"
##  [4] "telecom"              "gender"               "birthDate"
##  [7] "address"              "maritalStatus"        "multipleBirthBoolean"
## [10] "communication"        "active"
##
## $Immunization
## [1] "id"                 "patient"            "vaccineCode"
## [4] "occurrenceDateTime"
```

Because each observation on Blood Pressure includes a “component”
element with two elements (for systolic and diastolic blood pressure readings),
special code is required to map the metadata for the Blood Pressure observations
to the specific values for each component.

# 5 The resources extracted from a bundle

The `process_*` functions in BiocFHIR address various
resource types. As of version 0.0.15 we have

```
ls("package:BiocFHIR") |> grep(x=_, "process_[A-Z]", value=TRUE)
```

```
##  [1] "process_AllergyIntolerance" "process_CarePlan"
##  [3] "process_Claim"              "process_Condition"
##  [5] "process_Encounter"          "process_Immunization"
##  [7] "process_MedicationRequest"  "process_Observation"
##  [9] "process_Patient"            "process_Procedure"
```

There is no guarantee that any given bundle with have
resources among all these types.

# 6 Accumulating resources across bundles

Bundles are not guaranteed to have any specific
resources. To assemble all information on
conditions recorded in the Synthea sample,
we must program defensively. We obtain
the indices of bundles possessing a “Condition” resource,
and then combine the resulting tables, which are
designed to have a common set of columns.

```
data("allin", package="BiocFHIR")
hascond = sapply(allin, function(x)length(x$Condition)>0)
oo = do.call(rbind, lapply(allin[hascond], function(x)process_Condition(x$Condition)))
dim(oo)
```

```
## [1] 406   5
```

```
length(unique(oo$subject.reference))
```

```
## [1] 49
```

The most commonly reported conditions in the sample are:

```
table(oo$code.coding.display) |> sort() |> tail()
```

```
##
##                             Prediabetes Body mass index 30+ - obesity (finding)
##                                      16                                      17
##                        Normal pregnancy             Acute bronchitis (disorder)
##                                      22                                      27
##      Acute viral pharyngitis (disorder)              Viral sinusitis (disorder)
##                                      30                                      63
```

# 7 Session information

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