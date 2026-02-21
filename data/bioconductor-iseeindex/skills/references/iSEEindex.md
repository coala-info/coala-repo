Code

* Show All Code
* Hide All Code

# Introduction to iSEEindex

Kevin Rue-Albrecht1\*

1University of Oxford

\*kevin.rue-albrecht@imm.ox.ac.uk

#### 30 October 2025

#### Package

iSEEindex 1.8.0

# 1 Basics

## 1.1 Install `iSEEindex`

`R` is an open-source statistical environment which can be easily modified to enhance its functionality via packages. *[iSEEindex](https://bioconductor.org/packages/3.22/iSEEindex)* is a `R` package available via the [Bioconductor](http://bioconductor.org) repository for packages. `R` can be installed on any operating system from [CRAN](https://cran.r-project.org/) after which you can install *[iSEEindex](https://bioconductor.org/packages/3.22/iSEEindex)* by using the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
      install.packages("BiocManager")
  }

BiocManager::install("iSEEindex")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

## 1.2 Required knowledge

*[iSEEindex](https://bioconductor.org/packages/3.22/iSEEindex)* is based on many other packages and in particular those that have implemented the infrastructure needed for dealing with omics data and interactive visualisation.
That is, packages like *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*, *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)*, *[iSEE](https://bioconductor.org/packages/3.22/iSEE)* and *[shiny](https://bioconductor.org/packages/3.22/shiny)*.

If you are asking yourself the question “Where do I start using Bioconductor?” you might be interested in [this blog post](http://lcolladotor.github.io/2014/10/16/startbioc/#.VkOKbq6rRuU).

## 1.3 Asking for help

As package developers, we try to explain clearly how to use our packages and in which order to use the functions. But `R` and `Bioconductor` have a steep learning curve so it is critical to learn where to ask for help. The blog post quoted above mentions some but we would like to highlight the [Bioconductor support site](https://support.bioconductor.org/) as the main resource for getting help: remember to use the `iSEEindex` tag and check [the older posts](https://support.bioconductor.org/t/iSEEindex/). Other alternatives are available such as creating GitHub issues and tweeting. However, please note that if you want to receive help you should adhere to the [posting guidelines](http://www.bioconductor.org/help/support/posting-guide/). It is particularly critical that you provide a small reproducible example and your session information so package developers can track down the source of the error.

## 1.4 Citing `iSEEindex`

We hope that *[iSEEindex](https://bioconductor.org/packages/3.22/iSEEindex)* will be useful for your research. Please use the following information to cite the package and the overall approach. Thank you!

```
## Citation info
citation("iSEEindex")
#> To cite package 'iSEEindex' in publications use:
#>
#>   Rue-Albrecht K, Marini F (2025). _iSEEindex: iSEE extension for a landing page to a
#>   custom collection of data sets_. doi:10.18129/B9.bioc.iSEEindex
#>   <https://doi.org/10.18129/B9.bioc.iSEEindex>, R package version 1.8.0,
#>   <https://bioconductor.org/packages/iSEEindex>.
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Manual{,
#>     title = {iSEEindex: iSEE extension for a landing page to a custom collection of data sets},
#>     author = {Kevin Rue-Albrecht and Federico Marini},
#>     year = {2025},
#>     note = {R package version 1.8.0},
#>     url = {https://bioconductor.org/packages/iSEEindex},
#>     doi = {10.18129/B9.bioc.iSEEindex},
#>   }
```

# 2 Quick start to using `iSEEindex`

This is a basic example which shows you how to launch an application that lists publicly available data sets hosted on [zenodo.org](https://zenodo.org/record/7304331):

```
library("iSEEindex")
library("BiocFileCache")

bfc <- BiocFileCache(cache = tempdir())

dataset_fun <- function() {
    x <- yaml::read_yaml(system.file(package="iSEEindex", "example.yaml"))
    x$datasets
}

initial_fun <- function() {
    x <- yaml::read_yaml(system.file(package="iSEEindex", "example.yaml"))
    x$initial
}

app <- iSEEindex(bfc, dataset_fun, initial_fun)

if (interactive()) {
  shiny::runApp(app, port = 1234)
}
```

![](data:image/png;base64...)

Let’s break down this example step by step, to illustrate the functionality and flexibility of *[iSEEindex](https://bioconductor.org/packages/3.22/iSEEindex)*.

First, we load the *[iSEEindex](https://bioconductor.org/packages/3.22/iSEEindex)* and *[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)* packages, to access their functionality.

Next, we use the `BiocFileCache::BiocFileCache()` function, to create a persistent on-disk cache of files that the app can use for adding and retrieving data files between sessions.
This is particularly useful in this example, as we demonstrate the hosting of data sets and configuration scripts in RDS files and R scripts remotely, in a [zenodo.org repository](https://zenodo.org/record/7304331).

Next, we define a function – in this example, named `dataset_fun` – that returns a `list` of metadata for available data sets.
In this example, the information is parsed from an example file distributed in the `inst/` directory of the package.
However, users may define a function that fetches that information in any way they see fit, e.g. authenticating and accessing data from privately accessible sources.
Requirements for that function are detailed in the help page `?iSEEindex`, for the argument `FUN.datasets`.

Next, we define another function – in this example, named `initial_fun` – that returns a `list` of metadata for available initial configurations of the application state, for each individual data set.
In this example, the information is parsed from an example file distributed in the `inst/` directory of the package.
However, similarly to the previous function, users may define a function that fetches that information in any way they see fit.
Requirements for that function are detailed in the help page `?iSEEindex`, for the argument `FUN.initial`.

Then, we pass the `BiocFileCache` object and the two custom functions defined above to the `iSEEindex::iSEEindex()` function, to create an *[iSEE](https://bioconductor.org/packages/3.22/iSEE)* application that incorporates a landing page offering users the choice of data sets and initial configurations fetched by the custom functions.

Finally, we use the `shiny::runApp()` function to launch the app.

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
system.time(render("iSEEindex.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("iSEEindex.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2025-10-30 00:39:25 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 0.464 secs
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