# 03 Working with UK Biobank summary statistics

Vincent J. Carey, stvjc at channing.harvard.edu

#### October 29, 2025

# Contents

* [1 Overview](#overview)
  + [1.1 Initialization and description](#initialization-and-description)
    - [1.1.1 Standalone](#standalone)
    - [1.1.2 Terra](#terra)
  + [1.2 Exploring the subset](#exploring-the-subset)
    - [1.2.1 Metadata on study phenotypes](#metadata-on-study-phenotypes)
    - [1.2.2 Metadata on loci](#metadata-on-loci)
    - [1.2.3 Summary statistics](#summary-statistics)
* [2 Exercises](#exercises)
  + [2.1 Infrastructure](#infrastructure)
  + [2.2 Substantive](#substantive)
* [3 Installing `BiocHail`](#installing-biochail)
* [SessionInfo](#sessioninfo)

# 1 Overview

In this document we illustrate some approaches to
working with UK Biobank summary statistics.
Be sure that that the python module `ukbb_pan_ancestry`
has been installed where reticulate can find it.
(We don’t use basilisk as of 12/24/2022 because of
issues in the terra spark cluster.)

```
library(BiocHail)
```

If the above command indicates that BiocHail is not available,
see the Installation section near the end of this document.

## 1.1 Initialization and description

### 1.1.1 Standalone

We have produced a representation of summary
statistics for a sample of 9888 loci. This 5GB resource
can be retrieved and cached with the following code:

```
hl = hail_init()
ss = get_ukbb_sumstat_10kloci_mt(hl) # can take about a minute to unzip 5GB
ss$count()   # but if a persistent MatrixTable is at the location given
             # by env var HAIL_UKBB_SUMSTAT_10K_PATH it goes quickly
```

To get a description of available content, we need a python chunk:

```
r.ss.describe()
```

### 1.1.2 Terra

Here’s a basic description of the summary stats table, with code that
works in terra.bio:

```
hl = bare_hail()
hl$init(idempotent=TRUE, spark_conf=list(
  'spark.hadoop.fs.gs.requester.pays.mode'= 'CUSTOM',
  'spark.hadoop.fs.gs.requester.pays.buckets'= 'ukb-diverse-pops-public',
  'spark.hadoop.fs.gs.requester.pays.project.id'= Sys.getenv("GOOGLE_PROJECT")))
```

We need to use a python chunk to get the output, using gs:// storage references.

```
r.hl.read_matrix_table('gs://ukb-diverse-pops-public/sumstats_release/results_full.mt').describe()
```

## 1.2 Exploring the subset

### 1.2.1 Metadata on study phenotypes

We’ll collect the column metadata to start to understand details
of annotation of phenotypes.

```
sscol = ss$cols()$collect() # OK because we are just working over column metadata
ss1 = sscol[[1]]
names(ss1)
ss1$get("phenocode")
ss1$get("description")
```

We’ve introduced a function that extracts selected fields for a given
phenotype, that accommodates availability of results for specific populations.

```
multipop_df(ss1)
```

This can be iterated over all the elements of `sscol` to produce
a comprehensive searchable table. Here’s a small illustration:

```
library(DT)
ndf = do.call(rbind, lapply(sscol[1:10], multipop_df))
datatable(ndf)
```

### 1.2.2 Metadata on loci

We’ll trim the material to be worked with by sampling both rows and columns.
(2023.01.08: In future revisions we will be able to control the seed for random sampling.)

```
sss = ss$sample_rows(.01)$sample_cols(.01)
sss$count()
```

Row metadata are simple to collect:

```
rss = sss$rows()$collect()
rss1 = rss[[1]]
names(rss1)
names(rss1$locus)
rss1$locus$contig
sapply(c("contig", "position"), function(x) rss1$locus[[x]])
```

### 1.2.3 Summary statistics

The summary statistics themselves reside in entries of the MatrixTable. This
can be expensive to collect and so filtering methods beyond random sampling
must be mastered. But here is a basic view.

```
sse = sss$entries()$collect()
length(sse)
names(sse[[1]])
sse1 = sse[[1]]
```

The `summary_stats` component has the association p-values – log10 transformed?

```
length(sse1$summary_stats)
names(sse1$summary_stats[[1]])
sse1$summary_stats[[1]]$Pvalue
```

# 2 Exercises

## 2.1 Infrastructure

* Define an interface to this subset of 10k loci that supports queries like
  + has disease x been studied in UK Biobank?
  + how many phenotypes have been studied in K populations, K=2, 3, …?
  + how consistent is the annotation – are numbers of controls and cases always
    recorded?
* Do the UK Biobank portals produce information to resolve these questions?
  + if so, what are the API calls to obtain answers?
  + if not, what is missing from the portals to allow answers to be obtained?

## 2.2 Substantive

* List the genes that are near the loci collected in the 10k random sample
* (Hard) What is the most significant finding (position, phenotype, population) in the 10k subset?

# 3 Installing `BiocHail`

`BiocHail` should be installed as follows:

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("BiocHail")
```

# SessionInfo

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
## [1] ggplot2_4.0.0    BiocHail_1.10.0  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3      sass_0.4.10         generics_0.1.4
##  [4] RSQLite_2.4.3       lattice_0.22-7      digest_0.6.37
##  [7] magrittr_2.0.4      RColorBrewer_1.1-3  evaluate_1.0.5
## [10] grid_4.5.1          bookdown_0.45       fastmap_1.2.0
## [13] blob_1.2.4          jsonlite_2.0.0      Matrix_1.7-4
## [16] DBI_1.2.3           tinytex_0.57        BiocManager_1.30.26
## [19] scales_1.4.0        httr2_1.2.1         jquerylib_0.1.4
## [22] cli_3.6.5           rlang_1.1.6         dbplyr_2.5.1
## [25] bit64_4.6.0-1       withr_3.0.2         cachem_1.1.0
## [28] yaml_2.3.10         tools_4.5.1         dir.expiry_1.18.0
## [31] parallel_4.5.1      memoise_2.0.1       dplyr_1.1.4
## [34] filelock_1.0.3      basilisk_1.22.0     BiocGenerics_0.56.0
## [37] curl_7.0.0          reticulate_1.44.0   vctrs_0.6.5
## [40] R6_2.6.1            png_0.1-8           magick_2.9.0
## [43] BiocFileCache_3.0.0 lifecycle_1.0.4     bit_4.6.0
## [46] pkgconfig_2.0.3     gtable_0.3.6        pillar_1.11.1
## [49] bslib_0.9.0         glue_1.8.0          Rcpp_1.1.0
## [52] xfun_0.53           tibble_3.3.0        tidyselect_1.2.1
## [55] dichromat_2.0-0.1   knitr_1.50          farver_2.1.2
## [58] htmltools_0.5.8.1   rmarkdown_2.30      compiler_4.5.1
## [61] S7_0.2.0
```