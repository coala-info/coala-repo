Code

* Show All Code
* Hide All Code

# Implementing custom iSEEindex resources

Kevin Rue-Albrecht1\*

1University of Oxford

\*kevin.rue-albrecht@imm.ox.ac.uk

#### 30 October 2025

#### Package

iSEEindex 1.8.0

# 1 iSEEindex resources

## 1.1 Overview

*[iSEEindex](https://bioconductor.org/packages/3.22/iSEEindex)* imports data sets and initial app configurations from files.
Each of those files is represented by a Uniform Resource Identifier (URI) in the lists of metadata returned by the functions supplied to the `FUN.datasets` and `FUN.initial` arguments of `iSEEindex()`.

*[iSEEindex](https://bioconductor.org/packages/3.22/iSEEindex)* requires each URI to contain a scheme component ([Wikipedia](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier#Syntax) ), to identify the type of resource and invoke the associated method for accessing it.

This system allows *[iSEEindex](https://bioconductor.org/packages/3.22/iSEEindex)* users to use both standard and custom schemes in the URI of their resources, to fetch files from virtually any logical or physical resource, local or remote.

In this vignette, we describe the implementation of *[iSEEindex](https://bioconductor.org/packages/3.22/iSEEindex)* resources, using built-in classes of resources as examples.

## 1.2 Implementation

Given a scheme `<scheme>`, *[iSEEindex](https://bioconductor.org/packages/3.22/iSEEindex)* automatically attempts to create an object of class `iSEEindex<Scheme>Resource` that contains the class `iSEEindexResource`.
For instance, the scheme `https` produces an object of class `iSEEindexHttpsResource`.

*[iSEEindex](https://bioconductor.org/packages/3.22/iSEEindex)* provides a range of built-in `iSEEindexResource` sub-classes, described in [dedicated sections below](#builtin).

The raw value of the URI (including the scheme component) is always stored in the `uri` slot of the `iSEEindexResource` object.

Each `iSEEindexResource` sub-class must define the method `precache()`.

On first use, `precache()` processes the raw value of the URI, downloads the resource file locally using custom code if necessary, caches the file using *[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)*, and returns the path to the cached file.

In subsequent uses, *[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)* is used to fetch the cached file directly.

# 2 Built-in resources

## 2.1 iSEEindexHttpsResource

This type of resource is documented in `help("iSEEindexHttpsResource-class")`.

### 2.1.1 Structure

Briefly, this class is used to represent files that are publicly accessible online over HTTPS.

The URI must use the standard scheme “https”, followed by the URI to the file on the internet.

Example:

```
https://zenodo.org/record/7304331/files/ReprocessedAllenData.rds?download=1
```

### 2.1.2 Caching

The *[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)* package can handle HTTPS perfectly well.

In this instance, the `precache()` function has no other job than to cache the file located at the given URI using *[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)*.

## 2.2 iSEEindexLocalhostResource

### 2.2.1 Structure

This type of resource is documented in `help("iSEEindexLocalhostResource-class")`.

Briefly, this class is used to represent files that are already present on the filesystem of the machine that runs the application.

The URI must use the custom scheme “localhost”, followed by the path – absolute or relative – to the file on disk.

Example:

```
localhost:///absolute/path/to/file
localhost://relative/path/to/file
```

### 2.2.2 Caching

Now, while the *[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)* package can perfectly well handle local files, it does not know how to deal with the custom scheme `localhost`.

In this instance, the `precache()` function has for only job to remove the `localhost://` prefix from the URI, and cache the file located at the resulting file path using *[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)*.

## 2.3 iSEEindexRcallResource

### 2.3.1 Structure

This type of resource is documented in `help("iSEEindexRcallResource-class")`.

Briefly, this class is used to represent files whose local file path is obtained as the result of executing R code.

The URI must use the custom scheme “rcall”, followed by the R code to execute.

This custom scheme was created mainly to dynamically fetch the example files distributed and installed with the package.

Example:

```
rcall://system.file(package='iSEEindex','ReprocessedAllenData_config_01.R')
```

### 2.3.2 Caching

The custom scheme `rcall` is entirely made up for the purpose described here; it is not in any way recognised as a standard scheme by the [Internet Assigned Numbers Authority (IANA)](https://www.iana.org/assignments/uri-schemes/uri-schemes.xhtml).
As such, the *[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)* package cannot possibly know how to handle that custom scheme.

In this instance, the `precache()` function has the job to remove the `rcall://` prefix from the URI, evaluate the remainder of the URI as R code, and cache the file located at the resulting file path using *[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)*.

## 2.4 iSEEindexS3Resource

### 2.4.1 Structure

This type of resource is documented in `help("iSEEindexS3Resource-class")`.

Briefly, this class is used to represent files that are accessible from [Amazon S3](https://aws.amazon.com/s3/).

The URI must use the custom scheme “s3”, followed by the S3 URI to the file.

Example:

```
s3://bucket/prefix/file
```

### 2.4.2 Caching

Now, while the scheme `s3` is recognised by the [AWS Command Line Interface](https://aws.amazon.com/cli/), the *[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)* package does not know how to deal with it.

In this instance, the `precache()` function has the job to parse the URI for information that is passed to the *[paws.storage](https://CRAN.R-project.org/package%3Dpaws.storage)* package to download the file, which is then cached using *[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)*.

## 2.5 iSEEindexRunrResource

### 2.5.1 Structure

This type of resource is documented in `help("iSEEindexRunrResource-class")`.

This class is used to represent directly objects that are generated via a call to arbitrary R code.

The URI must use the custom scheme “runr”, followed by the code itself to be run to obtain the object to explore.

Example:

```
runr://function_to_call(param1 = "value1", param2 = "value2")
```

### 2.5.2 Caching

As this class does not directly specify a path, but rather focus on the object itself, the classical *[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)*-based caching will not work automatically.

Nonetheless, since a typical use case would be to host a collection of datasets provided in a data package, chances are that these packages implement some form of *[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)*-enabled caching.

# 3 Reproducibility

The *[iSEEindex](https://bioconductor.org/packages/3.22/iSEEindex)* package (Rue-Albrecht and Marini, 2025) was made possible thanks to:

* R (R Core Team, 2025)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight et al., 2025)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)

This package was developed using *[biocthis](https://bioconductor.org/packages/3.22/biocthis)*.

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("resources.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("resources.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2025-10-30 00:39:27 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 0.261 secs
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-30
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────
#>  package              * version date (UTC) lib source
#>  abind                  1.4-8   2024-09-12 [2] CRAN (R 4.5.1)
#>  backports              1.5.0   2024-05-23 [2] CRAN (R 4.5.1)
#>  bibtex                 0.5.1   2023-01-26 [2] CRAN (R 4.5.1)
#>  Biobase              * 2.70.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocFileCache        * 3.0.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26 2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocStyle            * 2.38.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                    4.6.0   2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                  4.6.0-1 2025-01-16 [2] CRAN (R 4.5.1)
#>  blob                   1.2.4   2023-03-17 [2] CRAN (R 4.5.1)
#>  bookdown               0.45    2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
#>  circlize               0.4.16  2024-02-20 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
#>  clue                   0.3-66  2024-11-13 [2] CRAN (R 4.5.1)
#>  cluster                2.1.8.1 2025-03-12 [3] CRAN (R 4.5.1)
#>  codetools              0.2-20  2024-03-31 [3] CRAN (R 4.5.1)
#>  colorspace             2.1-2   2025-09-22 [2] CRAN (R 4.5.1)
#>  colourpicker           1.3.0   2023-08-21 [2] CRAN (R 4.5.1)
#>  ComplexHeatmap         2.26.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  crayon                 1.5.3   2024-06-20 [2] CRAN (R 4.5.1)
#>  curl                   7.0.0   2025-08-19 [2] CRAN (R 4.5.1)
#>  DBI                    1.2.3   2024-06-02 [2] CRAN (R 4.5.1)
#>  dbplyr               * 2.5.1   2025-09-10 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  dichromat              2.0-0.1 2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
#>  doParallel             1.0.17  2022-02-07 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4   2023-11-17 [2] CRAN (R 4.5.1)
#>  DT                     0.34.0  2025-09-02 [2] CRAN (R 4.5.1)
#>  evaluate               1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
#>  farver                 2.1.2   2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
#>  filelock               1.0.3   2023-12-11 [2] CRAN (R 4.5.1)
#>  fontawesome            0.5.3   2024-11-16 [2] CRAN (R 4.5.1)
#>  foreach                1.5.2   2022-02-02 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicRanges        * 1.62.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GetoptLong             1.0.5   2020-12-15 [2] CRAN (R 4.5.1)
#>  ggplot2                4.0.0   2025-09-11 [2] CRAN (R 4.5.1)
#>  ggrepel                0.9.6   2024-09-07 [2] CRAN (R 4.5.1)
#>  GlobalOptions          0.1.2   2020-06-10 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6   2024-10-25 [2] CRAN (R 4.5.1)
#>  htmltools              0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
#>  htmlwidgets            1.6.4   2023-12-06 [2] CRAN (R 4.5.1)
#>  httpuv                 1.6.16  2025-04-16 [2] CRAN (R 4.5.1)
#>  httr                   1.4.7   2023-08-15 [2] CRAN (R 4.5.1)
#>  httr2                  1.2.1   2025-07-22 [2] CRAN (R 4.5.1)
#>  igraph                 2.2.1   2025-10-27 [2] CRAN (R 4.5.1)
#>  IRanges              * 2.44.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  iSEE                   2.22.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  iSEEindex            * 1.8.0   2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  iterators              1.0.14  2022-02-05 [2] CRAN (R 4.5.1)
#>  jquerylib              0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
#>  knitr                  1.50    2025-03-16 [2] CRAN (R 4.5.1)
#>  later                  1.4.4   2025-08-27 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7  2025-04-02 [3] CRAN (R 4.5.1)
#>  lifecycle              1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
#>  listviewer             4.0.0   2023-09-30 [2] CRAN (R 4.5.1)
#>  lubridate              1.9.4   2024-12-08 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4   2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics       * 1.22.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats          * 1.5.0   2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                2.0.1   2021-11-26 [2] CRAN (R 4.5.1)
#>  mgcv                   1.9-3   2025-04-04 [3] CRAN (R 4.5.1)
#>  mime                   0.13    2025-03-17 [2] CRAN (R 4.5.1)
#>  miniUI                 0.1.2   2025-04-17 [2] CRAN (R 4.5.1)
#>  nlme                   3.1-168 2025-03-31 [3] CRAN (R 4.5.1)
#>  otel                   0.2.0   2025-08-29 [2] CRAN (R 4.5.1)
#>  paws.common            0.8.5   2025-07-25 [2] CRAN (R 4.5.1)
#>  paws.storage           0.9.0   2025-03-14 [2] CRAN (R 4.5.1)
#>  pillar                 1.11.1  2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3   2019-09-22 [2] CRAN (R 4.5.1)
#>  plyr                   1.8.9   2023-10-02 [2] CRAN (R 4.5.1)
#>  png                    0.1-8   2022-11-29 [2] CRAN (R 4.5.1)
#>  promises               1.4.0   2025-10-22 [2] CRAN (R 4.5.1)
#>  purrr                  1.1.0   2025-07-10 [2] CRAN (R 4.5.1)
#>  R6                     2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
#>  rappdirs               0.3.3   2021-01-31 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3   2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0   2025-07-02 [2] CRAN (R 4.5.1)
#>  RefManageR           * 1.4.0   2022-09-30 [2] CRAN (R 4.5.1)
#>  rintrojs               0.3.4   2024-01-11 [2] CRAN (R 4.5.1)
#>  rjson                  0.2.23  2024-09-16 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30    2025-09-28 [2] CRAN (R 4.5.1)
#>  RSQLite                2.4.3   2025-08-20 [2] CRAN (R 4.5.1)
#>  S4Arrays               1.10.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0   2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
#>  scales                 1.4.0   2025-04-24 [2] CRAN (R 4.5.1)
#>  Seqinfo              * 1.0.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo          * 1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
#>  shape                  1.4.6.1 2024-02-23 [2] CRAN (R 4.5.1)
#>  shiny                * 1.11.1  2025-07-03 [2] CRAN (R 4.5.1)
#>  shinyAce               0.4.4   2025-02-03 [2] CRAN (R 4.5.1)
#>  shinydashboard         0.7.3   2025-04-21 [2] CRAN (R 4.5.1)
#>  shinyjs                2.1.0   2021-12-23 [2] CRAN (R 4.5.1)
#>  shinyWidgets           0.9.0   2025-02-21 [2] CRAN (R 4.5.1)
#>  SingleCellExperiment * 1.32.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  SparseArray            1.10.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  stringi                1.8.7   2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                1.5.2   2025-09-08 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment * 1.40.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble                 3.3.0   2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1   2024-03-11 [2] CRAN (R 4.5.1)
#>  timechange             0.3.0   2024-01-18 [2] CRAN (R 4.5.1)
#>  triebeard              0.4.1   2023-03-04 [2] CRAN (R 4.5.1)
#>  urltools               1.7.3.1 2025-06-12 [2] CRAN (R 4.5.1)
#>  vctrs                  0.6.5   2023-12-01 [2] CRAN (R 4.5.1)
#>  vipor                  0.4.7   2023-12-18 [2] CRAN (R 4.5.1)
#>  viridisLite            0.4.2   2023-05-02 [2] CRAN (R 4.5.1)
#>  xfun                   0.53    2025-08-19 [2] CRAN (R 4.5.1)
#>  xml2                   1.4.1   2025-10-27 [2] CRAN (R 4.5.1)
#>  xtable                 1.8-4   2019-04-21 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpAyBpYW/Rinst11fee4138fefc8
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────
```

# 4 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025) running behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[3]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[4]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[5]](#cite-ruealbrecht2025iseeindex)
K. Rue-Albrecht and F. Marini.
*iSEEindex: iSEE extension for a landing page to a custom collection of data sets*.
R package version 1.8.0.
2025.
DOI: [10.18129/B9.bioc.iSEEindex](https://doi.org/10.18129/B9.bioc.iSEEindex).
URL: <https://bioconductor.org/packages/iSEEindex>.

[[6]](#cite-wickham2011testthat)
H. Wickham.
“testthat: Get Started with Testing”.
In: *The R Journal* 3 (2011), pp. 5–10.
URL: <https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[[7]](#cite-wickham2025sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.3.
2025.
DOI: [10.32614/CRAN.package.sessioninfo](https://doi.org/10.32614/CRAN.package.sessioninfo).
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[8]](#cite-xie2025knitr)
Y. Xie.
*knitr: A General-Purpose Package for Dynamic Report Generation in R*.
R package version 1.50.
2025.
URL: <https://yihui.org/knitr/>.