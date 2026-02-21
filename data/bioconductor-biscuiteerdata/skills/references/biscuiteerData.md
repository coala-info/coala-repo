# BiscuiteerData User Guide

#### 30 Oct 2025

# BiscuiteerData

`biscuiteerData` is a complementary package to the Bioconductor package `biscuiteer`. It contains a handful of datasets to be used when running functions in `biscuiteer`.

# Quick Start

## Installing

From Bioconductor,

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("biscuiteerData")
```

A development version is available on GitHub and can be installed via:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("trichelab/biscuiteerData")
```

# Usage

Loading the library for the first time should cache the associated data files. After the initial library load, future loads will skip the cache step.

```
library(biscuiteerData)
```

```
## Loading required package: ExperimentHub
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: AnnotationHub
```

```
## Loading required package: BiocFileCache
```

```
## Loading required package: dbplyr
```

```
## Loading biscuiteerData.
```

`biscuiteerData` data is accessible using the `biscuiteerDataGet` function:

```
PMDs.hg19 <- biscuiteerDataGet("PMDs.hg19.rda")
```

A list of the titles for the available data can be retrieved via:

```
biscuiteerDataList()
```

```
## [1] "Zhou_solo_WCGW_inCommonPMDs.hg19.rda"
## [2] "PMDs.hg19.rda"
## [3] "Zhou_solo_WCGW_inCommonPMDs.hg38.rda"
## [4] "PMDs.hg38.rda"
```

A list of all versions (where the versions are the dates uploaded) is produced via:

```
biscuiteerDataListDates()
```

```
## [1] "2019-09-25"
```

An older version of the data can be retrieved using the `dateAdded` argument of `biscuiteerDataGet`:

```
PMDs.hg19 <- biscuiteerDataGet("PMDs.hg19.rda", dateAdded = "2019-09-25")
```