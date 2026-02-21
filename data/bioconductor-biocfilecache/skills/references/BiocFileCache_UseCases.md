# BiocFileCache Use Cases

Lori Shepherd

#### 29 October 2025

# Contents

* [1 Overview](#overview)
  + [1.1 Installation and Loading](#installation-and-loading)
  + [1.2 Creating / Loading the Cache](#creating-loading-the-cache)
* [2 Use Cases](#use-cases)
  + [2.1 Local cache of an internet resource](#local-cache-of-an-internet-resource)
  + [2.2 Cache of experimental computations](#cache-of-experimental-computations)
  + [2.3 Cache to manage package data](#cache-to-manage-package-data)
  + [2.4 Processing web resources before caching](#processing-web-resources-before-caching)
* [3 Access Behind a Proxy](#access-behind-a-proxy)
* [4 Other configuration options for resource downloading](#other-configuration-options-for-resource-downloading)
* [5 Group Cache Access](#group-cache-access)
* [6 Summary](#summary)
* [7 SessionInfo](#sessioninfo)

# 1 Overview

Organization of files on a local machine can be cumbersome. This is especially
true for local copies of remote resources that may periodically require a new
download to have the most updated information available. [BiocFileCache](https://bioconductor.org/packages/BiocFileCache) is
designed to help manage local and remote resource files stored locally. It
provides a convenient location to organize files and once added to the cache
management, the package provides functions to determine if remote resources are
out of date and require a new download.

## 1.1 Installation and Loading

`BiocFileCache` is a *Bioconductor* package and can be installed through
`BiocManager::install()`.

```
if (!"BiocManager" %in% rownames(installed.packages()))
     install.packages("BiocManager")
BiocManager::install("BiocFileCache", dependencies=TRUE)
```

After the package is installed, it can be loaded into *R* workspace by

```
library(BiocFileCache)
```

## 1.2 Creating / Loading the Cache

The initial step to utilizing [BiocFileCache](https://bioconductor.org/packages/BiocFileCache) in managing files is to create a
cache object specifying a location. We will create a temporary directory for use
with examples in this vignette. If a path is not specified upon creation, the
default location is a directory `~/.BiocFileCache` in the typical user cache
directory as defined by `tools::R_user_dir("", which="cache")`.

```
path <- tempfile()
bfc <- BiocFileCache(path, ask = FALSE)
```

# 2 Use Cases

## 2.1 Local cache of an internet resource

One use for [BiocFileCache](https://bioconductor.org/packages/BiocFileCache) is to save local copies of remote
resources. The benefits of this approach include reproducibility,
faster access, and access (once cached) without need for an internet
connection. An example is an Ensembl GTF file (also available via
[AnnotationHub][])

```
## paste to avoid long line in vignette
url <- paste(
    "ftp://ftp.ensembl.org/pub/release-71/gtf",
    "homo_sapiens/Homo_sapiens.GRCh37.71.gtf.gz",
    sep="/")
```

For a system-wide cache, simply load the [BiocFileCache](https://bioconductor.org/packages/BiocFileCache) package and
ask for the local resource path (`rpath`) of the resource.

```
library(BiocFileCache)
bfc <- BiocFileCache()
path <- bfcrpath(bfc, url)
```

Use the path returned by `bfcrpath()` as usual, e.g.,

```
gtf <- rtracklayer::import.gff(path)
```

A more compact use, the first or any time, is

```
gtf <- rtracklayer::import.gff(bfcrpath(BiocFileCache(), url))
```

Ensembl releases do not change with time, so there is no need to check
whether the cached resource needs to be updated.

## 2.2 Cache of experimental computations

One might use [BiocFileCache](https://bioconductor.org/packages/BiocFileCache) to cache results from experimental
analysis. The `rname` field provides an opportunity to provide
descriptive metadata to help manage collections of resources, without
relying on cryptic file naming conventions.

Here we create or use a local file cache in the directory in which we are
doing our analysis.

```
library(BiocFileCache)
bfc <- BiocFileCache("~/my-experiment/results")
```

We perform our analysis…

```
suppressPackageStartupMessages({
    library(DESeq2)
    library(airway)
})
data(airway)
dds <- DESeqDataData(airway, design = ~ cell + dex)
result <- DESeq(dds)
```

…and then save our result in a location provided by
[BiocFileCache](https://bioconductor.org/packages/BiocFileCache).

```
saveRDS(result, bfcnew(bfc, "airway / DESeq standard analysis"))
```

Retrieve the result at a later date

```
result <- readRDS(bfcrpath(bfc, "airway / DESeq standard analysis"))
```

One might imagine the following workflow:

```
suppressPackageStartupMessages({
    library(BiocFileCache)
    library(rtracklayer)
})

# load the cache
path <- file.path(tempdir(), "tempCacheDir")
bfc <- BiocFileCache(path)

# the web resource of interest
url <- "ftp://ftp.ensembl.org/pub/release-71/gtf/homo_sapiens/Homo_sapiens.GRCh37.71.gtf.gz"

# check if url is being tracked
res <- bfcquery(bfc, url, exact=TRUE)

if (bfccount(res) == 0L) {

    # if it is not in cache, add
    ans <- bfcadd(bfc, rname="ensembl, homo sapien", fpath=url)

} else {

  # if it is in cache, get path to load
  rid = res$rid
  ans <- bfcrpath(bfc, rid)

  # check to see if the resource needs to be updated
  check <- bfcneedsupdate(bfc, rid)
  # check can be NA if it cannot be determined, choose how to handle
  if (is.na(check)) check <- TRUE
  if (check){
    ans < - bfcdownload(bfc, rid)
  }
}

# ans is the path of the file to load
ans

# we know because we search for the url that the file is a .gtf.gz,
# if we searched on other terms we can use 'bfcpath' to see the
# original fpath to know the appropriate load/read/import method
bfcpath(bfc, names(ans))

temp = GTFFile(ans)
info = import(temp)
```

```
#
# A simpler test to see if something is in the cache
# and if not start tracking it is using `bfcrpath`
#

suppressPackageStartupMessages({
    library(BiocFileCache)
    library(rtracklayer)
})

# load the cache
path <- file.path(tempdir(), "tempCacheDir")
bfc <- BiocFileCache(path, ask=FALSE)

# the web resources of interest
url <- "ftp://ftp.ensembl.org/pub/release-71/gtf/homo_sapiens/Homo_sapiens.GRCh37.71.gtf.gz"

url2 <- "ftp://ftp.ensembl.org/pub/release-71/gtf/rattus_norvegicus/Rattus_norvegicus.Rnor_5.0.71.gtf.gz"

# if not in cache will download and create new entry
pathsToLoad <- bfcrpath(bfc, c(url, url2))
## adding rname 'ftp://ftp.ensembl.org/pub/release-71/gtf/homo_sapiens/Homo_sapiens.GRCh37.71.gtf.gz'
## adding rname 'ftp://ftp.ensembl.org/pub/release-71/gtf/rattus_norvegicus/Rattus_norvegicus.Rnor_5.0.71.gtf.gz'

pathsToLoad
##                                                                              BFC1
##       "/tmp/RtmpA24XLX/tempCacheDir/36414c2a7ec454_Homo_sapiens.GRCh37.71.gtf.gz"
##                                                                              BFC2
## "/tmp/RtmpA24XLX/tempCacheDir/36414c1c801f5_Rattus_norvegicus.Rnor_5.0.71.gtf.gz"

# now load files as see fit
info = import(GTFFile(pathsToLoad[1]))
class(info)
## [1] "GRanges"
## attr(,"package")
## [1] "GenomicRanges"
summary(info)
## [1] "GRanges object with 2253155 ranges and 12 metadata columns"
```

```
#
# One could also imagine the following:
#

library(BiocFileCache)

# load the cache
bfc <- BiocFileCache()

#
# Do some work!
#

# add a location in the cache
filepath <- bfcnew(bfc, "R workspace")

save(list = ls(), file=filepath)

# now the R workspace is being tracked in the cache
```

## 2.3 Cache to manage package data

A package may desire to use BiocFileCache to manage remote data. The following
is example code providing some best practice guidelines.

1. Creating the cache

Assumingly, the cache could potentially be called in a variety of places within
code, examples, and vignette. It is desirable to have a wrapper to the
BiocFileCache constructor. The following is a suggested example for a package
called `MyNewPackage`:

```
.get_cache <-
    function()
{
    cache <- tools::R_user_dir("MyNewPackage", which="cache")
    BiocFileCache::BiocFileCache(cache)
}
```

Essentially this will create a unique cache for the package. If run
interactively, the user will have the option to permanently create the package
cache, else a temporary directory will be used.

2. Resources in the cache

Managing remote resources then involves a function that will query to see if the
resource has been added, if it is not it will add to the cache and if it has it
checks if the file needs to be updated.

```
download_data_file <-
    function( verbose = FALSE )
{
    fileURL <- "http://a_path_to/someremotefile.tsv.gz"

    bfc <- .get_cache()
    rid <- bfcquery(bfc, "geneFileV2", "rname")$rid
    if (!length(rid)) {
     if( verbose )
         message( "Downloading GENE file" )
     rid <- names(bfcadd(bfc, "geneFileV2", fileURL ))
    }
    if (!isFALSE(bfcneedsupdate(bfc, rid)))
    bfcdownload(bfc, rid)

    bfcrpath(bfc, rids = rid)
}
```

## 2.4 Processing web resources before caching

A case has been identified where it may be desired to do some
processing of web-based resources before saving the resource in the
cache. This can be done through specific options of the `bfcadd()` and
`bfcdownload()` functions.

1. Add the resource with `bfcadd()` using the `download=FALSE` argument.
2. Download the resource with `bfcdownload()` using the `FUN` argument.

The `FUN` argument is the name of a function to be applied before
saving the downloaded file into the cache. The default is
`file.rename`, simply copying the downloaded file into the cache. A
user-supplied function must take ONLY two arguments. When invoked, the
arguments will be:

1. `character(1)` A temporary file containing the resource as
   retrieved from the web.
2. `character(1)` The BiocFileCache location where the processed file
   should be saved.

The function should return a `TRUE` on success or a `character(1)`
description for failure on error. As an example:

```
url <- "http://bioconductor.org/packages/stats/bioc/BiocFileCache/BiocFileCache_stats.tab"

headFile <-                         # how to process file before caching
    function(from, to)
{
    dat <- readLines(from)
    writeLines(head(dat), to)
    TRUE
}

rid <- bfcquery(bfc, url, "fpath")$rid
if (!length(rid))                   # not in cache, add but do not download
    rid <- names(bfcadd(bfc, url, download = FALSE))

update <- bfcneedsupdate(bfc, rid)  # TRUE if newly added or stale
if (!isFALSE(update))               # download & process
    bfcdownload(bfc, rid, ask = FALSE, FUN = headFile)
## Warning in readLines(from): incomplete final line found on
## '/tmp/RtmpA24XLX/tempCacheDir/file36414c57f93fbf'
##                                                                  BFC3
## "/tmp/RtmpA24XLX/tempCacheDir/36414c4da55588_BiocFileCache_stats.tab"

rpath <- bfcrpath(bfc, rids=rid)    # path to processed result
readLines(rpath)                    # read processed result
## [1] "Year\tMonth\tNb_of_distinct_IPs\tNb_of_downloads"
## [2] "2025\tJan\t21827\t35513"
## [3] "2025\tFeb\t23750\t38833"
## [4] "2025\tMar\t27254\t46437"
## [5] "2025\tApr\t27878\t46663"
## [6] "2025\tMay\t27632\t46392"
```

Note: By default bfcadd uses the webfile name as the saved local file. If the
processing step involves saving the data in a different format, utilize the
bfcadd argument `ext` to assign an extension to identify the type of file that
was saved.
For example

```
url = "https://httpbin.org/get"
bfcadd("myfile", url, download=FALSE)
# would save a file `<uniqueid>_get` in the cache
bfcadd("myfile", url, download=FALSE, ext=".Rdata")
# would save a file `<uniqueid>_get.Rdata` in the cache
```

# 3 Access Behind a Proxy

BiocFileCache uses CRAN package `httr2` functions for accessing and downloading
web resources. This can be problematic if operating behind a
proxy. Unfortunately unlike the previously used `httr::set_config`, there is no
option to globally set the proxy for httr2 requests. You can pass proxy
information into the bfcadd, bfcupdate, bfcneedsupdate, and bfcdownload
functions.

```
proxy <- "http://my_user:my_password@myproxy:8080"
bfcadd(bfc, rname="uniquename", fpath="https://remoteresource", proxy=proxy)
```

You can also set a `https_proxy` environment variable. It should be a character
vector similar to the format above.

# 4 Other configuration options for resource downloading

As mentioned previously, There is no global option like `httr::set_config` to
set configuration options when using httr2. A `config` argument may be passed to
bfcadd, bfcupdate, bfcneedsupdate, and bfcdownload functions. This argument is a
R list object that will be passed to `httr2::req_options`. The names of the
items should be valid curl options as defined in `curl::curl_options`.

```
ssl_opts <- list(verbose = 1L,ssl_verifypeer = 0L, ssl_verifyhost = 0L)
bfcadd(bfc, rname="uniquename", fpath="https://remoteresource", config=ssl_opts)
```

# 5 Group Cache Access

The situation may occur where a cache is desired to be shared across multiple
users on a system. This presents permissions errors. To allow access to
multiple users create a group that the users belong to and that the cache
belongs too. Permissions of potentially two files need to be altered depending
on what you would like individuals to be able to accomplish with the cache. A
read-only cache will require manual manipulatios of the
BiocFileCache.sqlite.LOCK so that the group permissions are `g+rw`. To allow
users to download files to the shared cache, both the
BiocFileCache.sqlite.LOCK file and the BiocFileCache.sqlite file will need group
permissions to `g+rw`. Please google how to create a user group for your system
of interest. To find the location of the cache to be able to change the group
and file permissions, you may run the following in R if you used the default location:
`tools::R_user_dir("BiocFileCache", which="cache")` or if you created a unique
location, something like the following: `bfc = BiocFileCache(cache="someUniquelocation"); bfccache(bfc)`. For quick reference
in linux you will use `chown currentuser:newgroup` to change the group and
`chmod` to change the file permissions: `chmod 660` or `chmod g+rw` should
accomplish the correct permissions.

# 6 Summary

It is our hope that this package allows for easier management of local and
remote resources.

# 7 SessionInfo

```
sessionInfo()
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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] rtracklayer_1.70.0   GenomicRanges_1.62.0 Seqinfo_1.0.0
##  [4] IRanges_2.44.0       S4Vectors_0.48.0     BiocGenerics_0.56.0
##  [7] generics_0.1.4       dplyr_1.1.4          BiocFileCache_3.0.0
## [10] dbplyr_2.5.1         BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] SummarizedExperiment_1.40.0 rjson_0.2.23
##  [3] xfun_0.53                   bslib_0.9.0
##  [5] httr2_1.2.1                 lattice_0.22-7
##  [7] Biobase_2.70.0              vctrs_0.6.5
##  [9] tools_4.5.1                 bitops_1.0-9
## [11] curl_7.0.0                  parallel_4.5.1
## [13] tibble_3.3.0                RSQLite_2.4.3
## [15] blob_1.2.4                  pkgconfig_2.0.3
## [17] Matrix_1.7-4                cigarillo_1.0.0
## [19] lifecycle_1.0.4             compiler_4.5.1
## [21] Rsamtools_2.26.0            Biostrings_2.78.0
## [23] codetools_0.2-20            htmltools_0.5.8.1
## [25] sass_0.4.10                 RCurl_1.98-1.17
## [27] yaml_2.3.10                 pillar_1.11.1
## [29] crayon_1.5.3                jquerylib_0.1.4
## [31] BiocParallel_1.44.0         DelayedArray_0.36.0
## [33] cachem_1.1.0                abind_1.4-8
## [35] tidyselect_1.2.1            digest_0.6.37
## [37] purrr_1.1.0                 restfulr_0.0.16
## [39] bookdown_0.45               grid_4.5.1
## [41] fastmap_1.2.0               SparseArray_1.10.0
## [43] cli_3.6.5                   magrittr_2.0.4
## [45] S4Arrays_1.10.0             XML_3.99-0.19
## [47] utf8_1.2.6                  withr_3.0.2
## [49] filelock_1.0.3              rappdirs_0.3.3
## [51] bit64_4.6.0-1               rmarkdown_2.30
## [53] XVector_0.50.0              httr_1.4.7
## [55] matrixStats_1.5.0           bit_4.6.0
## [57] memoise_2.0.1               evaluate_1.0.5
## [59] knitr_1.50                  BiocIO_1.20.0
## [61] rlang_1.1.6                 glue_1.8.0
## [63] DBI_1.2.3                   BiocManager_1.30.26
## [65] jsonlite_2.0.0              R6_2.6.1
## [67] MatrixGenerics_1.22.0       GenomicAlignments_1.46.0
```