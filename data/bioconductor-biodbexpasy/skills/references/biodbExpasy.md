# An introduction to biodbExpasy

Pierrick Roger

#### 1 November 2022

#### Abstract

How to use the biodbExpasy connector and its methods.

#### Package

biodbExpasy 1.2.0

# 1 Introduction

biodbExpasy is a *biodb* extension package that implements a connector to the
[Expasy ENZYME](https://enzyme.expasy.org/) database (Bairoch 2000).

# 2 Installation

Install using Bioconductor:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install('biodbExpasy')
```

# 3 Initialization

The first step in using *biodbExpasy*, is to create an instance of the biodb
class `Biodb` from the main *biodb* package. This is done by calling the
constructor of the class:

```
mybiodb <- biodb::newInst()
```

During this step the configuration is set up, the cache system is initialized
and extension packages are loaded.

We will see at the end of this vignette that the *biodb* instance needs to be
terminated with a call to the `terminate()` method.

# 4 Creating a connector to Expasy ENZYME database.

In *biodb* the connection to a database is handled by a connector instance that
you can get from the factory.
biodbExpasy implements a connector to a remote database.
Here is the code to instantiate a connector:

```
conn <- mybiodb$getFactory()$createConn('expasy.enzyme')
```

```
## Loading required package: biodbExpasy
```

# 5 Accessing entries

To get the number of entries stored inside the database, run:

```
conn$getNbEntries()
```

```
## [1] NA
```

To get some of the first entry IDs (accession numbers) from the database, run:

```
ids <- conn$getEntryIds(2)
```

```
## INFO  [16:56:59.409] Create cache folder "/home/biocbuild/.cache/R/biodb/expasy.enzyme-b59b84d962b6741050ba8f70ff4db280" for "expasy.enzyme-b59b84d962b6741050ba8f70ff4db280".
```

```
ids
```

```
## [1] "1.1.1.1" "1.1.1.2"
```

To retrieve entries, use:

```
entries <- conn$getEntry(ids)
entries
```

```
## [[1]]
## Biodb Expasy ENZYME database. entry instance 1.1.1.1.
##
## [[2]]
## Biodb Expasy ENZYME database. entry instance 1.1.1.2.
```

To convert a list of entries into a dataframe, run:

```
x <- mybiodb$entriesToDataframe(entries)
x
```

```
##   accession
## 1   1.1.1.1
## 2   1.1.1.2
##                                                                                                     catalytic.activity
## 1 (1) a primary alcohol + NAD(+) = an aldehyde + H(+) + NADH;(2) a secondary alcohol + NAD(+) = a ketone + H(+) + NADH
## 2                                                             a primary alcohol + NADP(+) = an aldehyde + H(+) + NADPH
##                                                         name expasy.enzyme.id
## 1                   alcohol dehydrogenase;aldehyde reductase          1.1.1.1
## 2 alcohol dehydrogenase (NADP(+));aldehyde reductase (NADPH)          1.1.1.2
```

# 6 Running the “wsEnzymeByName” web service

You can access the web service “find” directly with the *wsEnzymeByName* method:

```
conn$wsEnzymeByName(name="Alcohol", retfmt="ids")
```

```
##  [1] "1.1.1.1"     "1.1.1.2"     "1.1.1.54"    "1.1.1.71"    "1.1.1.90"
##  [6] "1.1.1.91"    "1.1.1.97"    "1.1.1.144"   "1.1.1.192"   "1.1.1.194"
## [11] "1.1.1.195"   "1.1.1.284"   "1.1.2.6"     "1.1.2.8"     "1.1.3.7"
## [16] "1.1.3.13"    "1.1.3.18"    "1.1.3.20"    "1.1.3.30"    "1.1.3.38"
## [21] "1.1.5.5"     "1.1.5.7"     "1.1.9.1"     "1.1.98.5"    "1.1.99.36"
## [26] "1.2.1.84"    "1.14.13.229" "1.14.19.48"  "2.3.1.75"    "2.3.1.84"
## [31] "2.3.1.152"   "2.3.1.196"   "2.3.1.224"   "2.4.1.111"   "2.4.1.172"
## [36] "2.7.1.66"    "2.7.8.13"    "2.8.2.2"     "3.6.1.53"    "4.2.3.2"
```

# 7 Running the “wsEnzymeByComment” web service

You can access the web service “find” directly with the *wsEnzymeByComment* method:

```
conn$wsEnzymeByComment(comment="best", retfmt="ids")
```

```
##   [1] "1.1.1.91"   "1.1.3.7"    "1.1.3.20"   "1.2.1.48"   "1.2.3.14"
##   [6] "1.1.1.288"  "1.13.11.51" "1.14.13.93" "1.3.1.31"   "1.3.1.124"
##  [11] "1.3.1.34"   "1.3.3.13"   "1.3.5.2"    "1.3.98.1"   "1.3.1.14"
##  [16] "1.3.1.15"   "1.3.99.11"  "1.5.99.5"   "1.6.5.5"    "1.6.5.2"
##  [21] "1.10.5.1"   "1.6.5.2"    "1.10.99.2"  "1.11.1.20"  "1.13.11.50"
##  [26] "1.13.12.24" "1.13.99.3"  "1.14.13.92" "1.14.14.48" "1.14.14.49"
##  [31] "1.14.14.48" "1.14.17.3"  "4.3.2.5"    "1.14.99.15" "2.1.1.160"
##  [36] "2.1.1.339"  "2.3.1.75"   "2.3.1.77"   "2.3.1.121"  "2.3.1.184"
##  [41] "2.3.1.185"  "2.3.1.186"  "2.3.1.232"  "2.3.1.196"  "2.4.1.78"
##  [46] "2.4.1.136"  "2.4.1.165"  "2.4.1.181"  "2.4.1.358"  "2.6.1.21"
##  [51] "2.6.1.10"   "2.6.1.84"   "2.7.1.62"   "3.1.3.9"    "3.1.1.2"
##  [56] "3.1.1.55"   "3.1.1.1"    "3.1.1.2"    "3.1.1.7"    "3.1.1.8"
##  [61] "3.1.1.67"   "3.1.3.38"   "3.1.3.76"   "3.3.2.10"   "3.3.2.10"
##  [66] "3.3.2.9"    "3.1.7.1"    "3.2.1.99"   "3.2.1.153"  "3.2.1.80"
##  [71] "3.2.1.154"  "3.2.1.154"  "3.2.1.80"   "3.2.1.153"  "3.2.1.214"
##  [76] "3.4.11.24"  "3.4.13.18"  "3.4.3.1"    "3.4.3.2"    "3.4.3.3"
##  [81] "3.4.3.6"    "3.4.13.1"   "3.4.13.2"   "3.4.13.3"   "3.4.13.8"
##  [86] "3.4.13.11"  "3.4.13.13"  "3.4.13.15"  "3.4.13.19"  "3.4.3.1"
##  [91] "3.4.3.2"    "3.4.3.6"    "3.4.13.1"   "3.4.13.2"   "3.4.13.8"
##  [96] "3.4.13.11"  "3.4.13.15"  "3.4.19.1"   "3.4.14.3"   "3.4.19.12"
## [101] "3.4.22.34"  "3.4.22.46"  "3.4.24.61"  "3.5.1.60"   "3.5.1.99"
## [106] "3.5.1.91"   "3.6.1.45"   "3.6.1.21"   "3.1.3.5"    "4.2.1.74"
## [111] "4.2.1.17"   "4.2.2.20"   "4.2.2.21"   "4.2.2.20"   "4.2.2.4"
## [116] "4.2.99.6"   "4.2.2.21"   "4.2.2.20"   "4.2.2.4"    "4.2.99.6"
## [121] "4.6.1.15"   "6.2.1.23"   "7.5.2.6"    "7.5.2.5"    "7.5.2.11"
```

# 8 Closing biodb instance

When done with your *biodb* instance you have to terminate it, in order to
ensure release of resources (file handles, database connection, etc):

```
mybiodb$terminate()
```

```
## INFO  [16:57:12.027] Closing BiodbMain instance...
## INFO  [16:57:12.029] Connector "expasy.enzyme" deleted.
```

# 9 Session information

```
sessionInfo()
```

```
## R version 4.2.1 (2022-06-23)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.5 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.16-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.16-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] biodbExpasy_1.2.0 BiocStyle_2.26.0
##
## loaded via a namespace (and not attached):
##  [1] progress_1.2.2      tidyselect_1.2.0    xfun_0.34
##  [4] bslib_0.4.0         vctrs_0.5.0         generics_0.1.3
##  [7] htmltools_0.5.3     BiocFileCache_2.6.0 yaml_2.3.6
## [10] utf8_1.2.2          blob_1.2.3          XML_3.99-0.12
## [13] rlang_1.0.6         jquerylib_0.1.4     pillar_1.8.1
## [16] withr_2.5.0         glue_1.6.2          DBI_1.1.3
## [19] rappdirs_0.3.3      bit64_4.0.5         dbplyr_2.2.1
## [22] lifecycle_1.0.3     plyr_1.8.7          stringr_1.4.1
## [25] memoise_2.0.1       evaluate_0.17       knitr_1.40
## [28] fastmap_1.1.0       curl_4.3.3          fansi_1.0.3
## [31] biodb_1.6.0         Rcpp_1.0.9          openssl_2.0.4
## [34] filelock_1.0.2      BiocManager_1.30.19 cachem_1.0.6
## [37] jsonlite_1.8.3      bit_4.0.4           chk_0.8.1
## [40] askpass_1.1         hms_1.1.2           digest_0.6.30
## [43] stringi_1.7.8       bookdown_0.29       dplyr_1.0.10
## [46] bitops_1.0-7        cli_3.4.1           tools_4.2.1
## [49] magrittr_2.0.3      sass_0.4.2          RCurl_1.98-1.9
## [52] RSQLite_2.2.18      tibble_3.1.8        crayon_1.5.2
## [55] pkgconfig_2.0.3     ellipsis_0.3.2      prettyunits_1.1.1
## [58] assertthat_0.2.1    rmarkdown_2.17      httr_1.4.4
## [61] lgr_0.4.4           R6_2.5.1            compiler_4.2.1
```

# References

Bairoch, A. 2000. “The Enzyme Database in 2000.” *Nucleic Acids Research* 28 (1): 304–5. <https://doi.org/10.1093/nar/28.1.304>.