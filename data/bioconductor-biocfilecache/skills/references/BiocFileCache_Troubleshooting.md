# BiocFileCache Troubleshooting

Lori Shepherd

#### 29 October 2025

# Contents

* [1 Overview](#overview)
  + [1.1 Installation and Loading](#installation-and-loading)
  + [1.2 Creating / Loading the Cache](#creating-loading-the-cache)
* [2 Access Behind a Proxy](#access-behind-a-proxy)
* [3 Other configuration options for resource downloading](#other-configuration-options-for-resource-downloading)
* [4 Group Cache Access](#group-cache-access)
* [5 Lock file Troubleshooting](#lock-file-troubleshooting)
  + [5.1 Permissions](#permissions)
  + [5.2 Cannot lock file / no lock available](#cannot-lock-file-no-lock-available)
* [6 Default Caching Location Update](#default-caching-location-update)
  + [6.1 Option 1: Moving Files](#option-1-moving-files)
  + [6.2 Option 2: Specify a Cache Location Explicitly](#option-2-specify-a-cache-location-explicitly)
  + [6.3 Option 3: Delete the old cache](#option-3-delete-the-old-cache)
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

# 2 Access Behind a Proxy

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

# 3 Other configuration options for resource downloading

As mentioned previously, There is no global option like `httr::set_config` to
set configuration options when using httr2. A `config` argument may be passed to
bfcadd, bfcupdate, bfcneedsupdate, and bfcdownload functions. This argument is a
R list object that will be passed to `httr2::req_options`. The names of the
items should be valid curl options as defined in `curl::curl_options`.

```
ssl_opts <- list(verbose = 1L,ssl_verifypeer = 0L, ssl_verifyhost = 0L)
bfcadd(bfc, rname="uniquename", fpath="https://remoteresource", config=ssl_opts)
```

# 4 Group Cache Access

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

# 5 Lock file Troubleshooting

Two issues have been commonly reported regarding the lock file.

## 5.1 Permissions

There could be permission ERROR regarding group and public access. See the
previous `Group Cache Access` section.

## 5.2 Cannot lock file / no lock available

This is an issue with filelock on particular systems. Particular partitions and
non standard file systems may not support filelock. The solution is to use a
different section of the system to create the cache. The easiest way to define a
new cache location is by using environment variables.

In R:

`Sys.setenv(BFC_CACHE=<new cache location>)`

Alternatively, you can set an environment variable globally to avoid having to
set uniquely in each R session. Please google for specific instructions for
setting environment variables globally for your particular OS system.

Other common filelock implemented packages that have specific environment
variables to control location are:

* BiocFileCache: BFC\_CACHE
* ExperimentHub: EXPERIMENT\_HUB\_CACHE
* AnnotationHub: ANNOTATION\_HUB\_CACHE
* biomaRt: BIOMART\_CACHE

# 6 Default Caching Location Update

As of BiocFileCache version > 1.15.1, the default caching location has
changed. The default cache is now controlled by the function `tools::R_user_dir`
instead of `rappdirs::user_cache_dir`. Users who have utilized the default
BiocFileCache location, to continue using the created cache, must move the cache and its
files to the new default location or delete the old cache and have to redownload
any previous files.

## 6.1 Option 1: Moving Files

The following steps can be used to move the files to the new location:

1. Determine the old location by running the following in R
   `rappdirs::user_cache_dir(appname="BiocFileCache")`
2. Determine the new location by running the following in R
   `tools::R_user_dir("BiocFileCache", which="cache")`
3. Move the files to the new location. You can do this manually or do the
   following steps in R. Remember if you have a lot of cached files, this may take
   awhile and you will need permissions on all the files in order to move them.

```
       # make sure you have permissions on the cache/files
       # use at own risk

    moveFiles<-function(package){
        olddir <- path.expand(rappdirs::user_cache_dir(appname=package))
        newdir <- tools::R_user_dir(package, which="cache")
        dir.create(path=newdir, recursive=TRUE)
        files <- list.files(olddir, full.names =TRUE)
        moveres <- vapply(files,
        FUN=function(fl){
          filename = basename(fl)
          newname = file.path(newdir, filename)
          file.rename(fl, newname)
        },
        FUN.VALUE = logical(1))
        if(all(moveres)) unlink(olddir, recursive=TRUE)
    }

    package="BiocFileCache"
    moveFiles(package)
```

## 6.2 Option 2: Specify a Cache Location Explicitly

Users may always specify a unique caching location by providing the `cache` argument to the BiocFileCache
constructor; however users must always specify this location as it will not be
recognized by default in subsequent runs.

Alternatively, the default caching location may also be controlled by a
user-wise or system-wide environment variable. Users may set the environment
variable `BFC_CACHE` to the old location to continue using as default location.

## 6.3 Option 3: Delete the old cache

Lastly, if a user does not care about the already existing default cache, the
old location may be deleted to move forward with the new default location. This
option should be used with caution. Once deleted, old cached resources will no
longer be available and have to be re-downloaded.

One can do this manually by navigating to the location indicated in the ERROR
message as `Problematic cache:` and deleting the folder and all its content.

The following can be done to delete through R code:

**CAUTION** This will remove the old cache and all downloaded resources.

```
library(BiocFileCache)

package = "BiocFileCache"

BFC_CACHE = rappdirs::user_cache_dir(appname=package)
Sys.setenv(BFC_CACHE = BFC_CACHE)
bfc = BiocFileCache(BFC_CACHE)
## CAUTION: This removes the cache and all downloaded resources
removebfc(bfc, ask=FALSE)

## create new empty cache in new default location
bfc = BiocFileCache(ask=FALSE)
```

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] dplyr_1.1.4         BiocFileCache_3.0.0 dbplyr_2.5.1
## [4] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] bit_4.6.0           jsonlite_2.0.0      compiler_4.5.1
##  [4] BiocManager_1.30.26 filelock_1.0.3      tidyselect_1.2.1
##  [7] blob_1.2.4          jquerylib_0.1.4     yaml_2.3.10
## [10] fastmap_1.2.0       R6_2.6.1            generics_0.1.4
## [13] curl_7.0.0          httr2_1.2.1         knitr_1.50
## [16] tibble_3.3.0        bookdown_0.45       DBI_1.2.3
## [19] bslib_0.9.0         pillar_1.11.1       rlang_1.1.6
## [22] utf8_1.2.6          cachem_1.1.0        xfun_0.53
## [25] sass_0.4.10         bit64_4.6.0-1       RSQLite_2.4.3
## [28] memoise_2.0.1       cli_3.6.5           withr_3.0.2
## [31] magrittr_2.0.4      digest_0.6.37       rappdirs_0.3.3
## [34] lifecycle_1.0.4     vctrs_0.6.5         evaluate_1.0.5
## [37] glue_1.8.0          purrr_1.1.0         rmarkdown_2.30
## [40] tools_4.5.1         pkgconfig_2.0.3     htmltools_0.5.8.1
```