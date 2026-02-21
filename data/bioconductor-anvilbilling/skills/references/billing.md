# Software for reckoning AnVIL/Terra usage

BJ Stubbs, Vincent J. Carey, rebjh/stvjc at channing.harvard.edu

#### October 29, 2025

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Setup](#setup)
* [4 Obtaining billing data](#obtaining-billing-data)
  + [4.1 Overview](#overview)
  + [4.2 Setting up a request](#setting-up-a-request)
  + [4.3 Output](#output)
* [5 Drilling down](#drilling-down)
* [6 Using the exploratory app](#using-the-exploratory-app)
* [7 Session Information](#session-information)

# 1 Introduction

Detailed billing information is essential for cost and resource planning in cloud based analysis projects, but it can be difficult to obtain. The goal of this software is to help users of the Terra/AnVIL platform get access to this data as easily as possible.

The google cloud platform console can be used to acquire
information at varying levels of detail. For example, it
is simple to generate a display like the following.

![](data:image/png;base64...)

Cost track from Google console.

However, the cost track here sums up charges for various
activities related to CPU usage, storage, and network use.
Our aim is to provide R functions
to help present information on charges arising
in the use of AnVIL.

To whet the appetite, we will show how to run an exploratory app
that looks like:

![](data:image/png;base64...)

Early view of reckoning app.

# 2 Installation

Install the *AnVILBilling* package with

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager", repos = "https://cran.r-project.org")
BiocManager::install("AnVILBilling")
```

Once installed, load the package with

```
library(AnVILBilling)
```

# 3 Setup

The functions in this vignette require a user to connect the billing export in the Google Cloud Platform project associated with Terra/AnVIL to a BigQuery dataset.

General information on this process can be found here:

<https://cloud.google.com/billing/docs/how-to/export-data-bigquery>

In order to set this up with the AnVIL/Terra system:

1. Create a new project in Google under the billing account linked to the Terra project
2. Create a BigQuery dataset to store the billing export
3. Go to the billing tab in the gcloud console and enable export to this dataset
4. Make sure the user of this software has the BigQuery scope on the billing project

Once this is accomplished you will be able to see

![](data:image/png;base64...)

exportview

with values appropriate to your project and account
configuration substituted for ‘landmarkMark2’ (the compute project name),
‘bjbilling’ (the Google project with BigQuery scope that is used
to transmit cost data on landmarkMark2 to Bigquery), and
‘anvilbilling’ (the BigQuery dataset name where next-day cost values
are stored).

# 4 Obtaining billing data

## 4.1 Overview

Billing data is generally available 1 day after incurring charges. Billing data is stored in BigQuery in a partitioned table, and is queryable using the bigrquery package.

## 4.2 Setting up a request

In order to generate a request you need:

1. start: date of start of reckoning
2. end: date of end of reckoning
3. project: GCP project id
4. dataset: GCP dataset id for billing data in BigQuery
5. table: GCP table for billing data in BigQuery

Then you can use the function:

```
setup_billing_request(start, end, project, dataset, table, billing_code)
```

To create a request.

Once you have a request object, then you can get the billing data associated with that request using the reckon() function on your billing request.

## 4.3 Output

The result of a reckoning on a billing request is an instance of `avReckoning`

We took a snapshot of usage in a project we work on, and it is available as demo\_rec. This request represents one day of usage in AnVIL/Terra.

```
suppressPackageStartupMessages({
library(AnVILBilling)
library(dplyr)
library(magrittr)
library(BiocStyle)
})

demo_rec
```

```
## AnVIL reckoning info for project  bjbilling
##   starting 2020-01-28, ending 2020-01-29.
## There are  1599  records.
## Available keys:
##  [1] "goog-resource-type"               "goog-metric-domain"
##  [3] "goog-dataproc-cluster-name"       "goog-dataproc-cluster-uuid"
##  [5] "goog-dataproc-location"           "cromwell-workflow-id"
##  [7] "goog-pipelines-worker"            "terra-submission-id"
##  [9] "wdl-task-name"                    "security"
## [11] "ad-anvil_devs"                    "ad-auth_anvil_anvil_gtex_v8_hg38"
## ---
## Use ab_reckoning() for full table
```

The available keys for the billing object are shown.

For Terra, 3 of the most useful keys are:

1. terra-submission-id : this key is associated with a cromwell workflow execution
2. cromwell-workflow-id : this key is associated with a job in a workflow, so if you apply a workflow to multiple inputs, you will have 1 terra id and multiple cromwell ids
3. goog-dataproc-cluster-name : this key is associated with a jupyter notebook or Rstudio cluster on Terra. The user of these resources can be
   determined using Bioconductor’s *[AnVIL](https://bioconductor.org/packages/3.22/AnVIL)* package.

The code, to be used while the cluster
is in use, would look like this:

```
library(AnVIL)
leo = Leonardo()
leo$getRuntime(clustername)
```

# 5 Drilling down

Given a key type, we want to know associated values.

```
v = getValues(demo_rec@reckoning, "terra-submission-id")
v
```

```
## [1] "terra-196d3163-4eef-46e8-a7e6-e71c0012003d"
```

To understand activities associated with this submission,
we subset the table.

```
s = subsetByKeyValue(demo_rec@reckoning, "terra-submission-id", v)
s
```

```
## # A tibble: 955 × 17
##    billing_account_id   service          sku              usage_start_time
##    <chr>                <list>           <list>           <dttm>
##  1 015E39-38569D-3CC771 <named list [2]> <named list [2]> 2020-01-28 20:00:00
##  2 015E39-38569D-3CC771 <named list [2]> <named list [2]> 2020-01-28 20:00:00
##  3 015E39-38569D-3CC771 <named list [2]> <named list [2]> 2020-01-28 20:00:00
##  4 015E39-38569D-3CC771 <named list [2]> <named list [2]> 2020-01-28 20:00:00
##  5 015E39-38569D-3CC771 <named list [2]> <named list [2]> 2020-01-28 20:00:00
##  6 015E39-38569D-3CC771 <named list [2]> <named list [2]> 2020-01-28 20:00:00
##  7 015E39-38569D-3CC771 <named list [2]> <named list [2]> 2020-01-28 20:00:00
##  8 015E39-38569D-3CC771 <named list [2]> <named list [2]> 2020-01-28 20:00:00
##  9 015E39-38569D-3CC771 <named list [2]> <named list [2]> 2020-01-28 20:00:00
## 10 015E39-38569D-3CC771 <named list [2]> <named list [2]> 2020-01-28 20:00:00
## # ℹ 945 more rows
## # ℹ 13 more variables: usage_end_time <dttm>, project <list>, labels <list>,
## #   system_labels <list>, location <list>, export_time <dttm>, cost <dbl>,
## #   currency <chr>, currency_conversion_rate <dbl>, usage <list>,
## #   credits <list>, invoice <list>, cost_type <chr>
```

The following data is available in this object

```
names(s)
```

```
##  [1] "billing_account_id"       "service"
##  [3] "sku"                      "usage_start_time"
##  [5] "usage_end_time"           "project"
##  [7] "labels"                   "system_labels"
##  [9] "location"                 "export_time"
## [11] "cost"                     "currency"
## [13] "currency_conversion_rate" "usage"
## [15] "credits"                  "invoice"
## [17] "cost_type"
```

You can drill down more to see what products used during the submission:

```
AnVILBilling:::getSkus(s)
```

```
##  [1] "Storage PD Capacity"
##  [2] "SSD backed PD Capacity"
##  [3] "Network Inter Zone Ingress"
##  [4] "Network Intra Zone Ingress"
##  [5] "External IP Charge on a Standard VM"
##  [6] "Custom Instance Ram running in Americas"
##  [7] "Custom Instance Core running in Americas"
##  [8] "Licensing Fee for Shielded COS (CPU cost)"
##  [9] "Licensing Fee for Shielded COS (RAM cost)"
## [10] "Network Internet Ingress from APAC to Americas"
## [11] "Network Internet Ingress from EMEA to Americas"
## [12] "Network Google Egress from Americas to Americas"
## [13] "Network Internet Ingress from China to Americas"
## [14] "Network Google Ingress from Americas to Americas"
## [15] "Network Internet Egress from Americas to Americas"
## [16] "Network Internet Ingress from Americas to Americas"
## [17] "Network Internet Ingress from Australia to Americas"
## [18] "Network HTTP Load Balancing Ingress from Load Balancer"
## [19] "Network Inter Region Ingress from Americas to Americas"
## [20] "Network Egress via Carrier Peering Network - Americas Based"
## [21] "Network Ingress via Carrier Peering Network - Americas Based"
## [22] "Licensing Fee for Container-Optimized OS from Google (CPU cost)"
## [23] "Licensing Fee for Container-Optimized OS from Google (RAM cost)"
## [24] "Licensing Fee for Container-Optimized OS - PCID Whitelisted (CPU cost)"
## [25] "Licensing Fee for Container-Optimized OS - PCID Whitelisted (RAM cost)"
```

You can also get the cost for a workflow using:

```
data(demo_rec) # makes rec
v = getValues(demo_rec@reckoning, "terra-submission-id")[1] # for instance
getSubmissionCost(demo_rec@reckoning,v)
```

```
## [1] 0.054044
```

And the ram usage as well:

```
data(demo_rec) # makes rec
v = getValues(demo_rec@reckoning, "terra-submission-id")[1] # for instance
getSubmissionRam(demo_rec@reckoning,v)
```

```
##                                 submissionID      workflow
## 1 terra-196d3163-4eef-46e8-a7e6-e71c0012003d runterratrial
## 2 terra-196d3163-4eef-46e8-a7e6-e71c0012003d runterratrial
## 3 terra-196d3163-4eef-46e8-a7e6-e71c0012003d runterratrial
## 4 terra-196d3163-4eef-46e8-a7e6-e71c0012003d runterratrial
## 5 terra-196d3163-4eef-46e8-a7e6-e71c0012003d runterratrial
##                                      cromwellID
## 1 cromwell-4dde8ce1-a8e5-47ba-a261-120ae8c7556c
## 2 cromwell-8edb23d6-a7d2-4b1f-96b4-496e96c1d707
## 3 cromwell-b1dcdbe1-b4ec-4428-8570-e2ab883087d0
## 4 cromwell-664b3519-7c7a-42ba-bb00-562ea1f650fd
## 5 cromwell-176a9f09-483c-4eb1-abf0-e5de2fdf36a7
##                                       sku       amount         unit
## 1 Custom Instance Ram running in Americas 1.676111e+12 byte-seconds
## 2 Custom Instance Ram running in Americas 1.737314e+12 byte-seconds
## 3 Custom Instance Ram running in Americas 1.607392e+12 byte-seconds
## 4 Custom Instance Ram running in Americas 1.573032e+12 byte-seconds
## 5 Custom Instance Ram running in Americas 1.582695e+12 byte-seconds
##     pricingUnit amountInPricingUnit
## 1 gibibyte hour           0.4336111
## 2 gibibyte hour           0.4494444
## 3 gibibyte hour           0.4158333
## 4 gibibyte hour           0.4069444
## 5 gibibyte hour           0.4094444
```

# 6 Using the exploratory app

To simplify some of the aspects of reporting on costs, we have introduced
`browse_reck`, which will authenticate the user to Google BigQuery, and
use user-specified inputs to identify an interval of days between which
usage data are sought. This function can be called with no arguments,
or you can supply the email address for the Google identity to be used
in working with Google Cloud Platform projects and BigQuery.

# 7 Session Information

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
## [1] magrittr_2.0.4      dplyr_1.1.4         AnVILBilling_1.20.0
## [4] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] utf8_1.2.6          shinytoastr_2.2.0   tidyr_1.3.1
##  [4] plotly_4.11.0       sass_0.4.10         generics_0.1.4
##  [7] digest_0.6.37       timechange_0.3.0    evaluate_1.0.5
## [10] grid_4.5.1          RColorBrewer_1.1-3  bookdown_0.45
## [13] fastmap_1.2.0       jsonlite_2.0.0      DBI_1.2.3
## [16] promises_1.4.0      BiocManager_1.30.26 httr_1.4.7
## [19] purrr_1.1.0         viridisLite_0.4.2   scales_1.4.0
## [22] lazyeval_0.2.2      jquerylib_0.1.4     cli_3.6.5
## [25] shiny_1.11.1        rlang_1.1.6         bit64_4.6.0-1
## [28] cachem_1.1.0        yaml_2.3.10         otel_0.2.0
## [31] tools_4.5.1         gargle_1.6.0        ggplot2_4.0.0
## [34] httpuv_1.6.16       DT_0.34.0           vctrs_0.6.5
## [37] R6_2.6.1            mime_0.13           lubridate_1.9.4
## [40] lifecycle_1.0.4     fs_1.6.6            htmlwidgets_1.6.4
## [43] bit_4.6.0           pkgconfig_2.0.3     pillar_1.11.1
## [46] bslib_0.9.0         later_1.4.4         gtable_0.3.6
## [49] data.table_1.17.8   glue_1.8.0          Rcpp_1.1.0
## [52] xfun_0.53           tibble_3.3.0        tidyselect_1.2.1
## [55] knitr_1.50          dichromat_2.0-0.1   farver_2.1.2
## [58] xtable_1.8-4        htmltools_0.5.8.1   rmarkdown_2.30
## [61] compiler_4.5.1      S7_0.2.0            bigrquery_1.6.1
```