Code

* Show All Code
* Hide All Code

# Contributing to iSEEhub

Kevin Rue-Albrecht1\*

1University of Oxford

\*kevin.rue-albrecht@imm.ox.ac.uk

#### 30 October 2025

#### Package

iSEEhub 1.12.0

# 1 Initial app configurations

## 1.1 Overview

Initial app configurations configure the set of panels and their respective initial state when the main *[iSEE](https://bioconductor.org/packages/3.22/iSEE)* app is launched.

Initial app configurations are implemented as *R* scripts that are stored in the `inst/initial` subdirectory of the *[iSEEhub](https://bioconductor.org/packages/3.22/iSEEhub)* package.
Within that directory, the app expects a subdirectory named exactly as the `EH` identifier of each dataset for which additional configurations are made available.
Within each dataset-specific directory, the app expects any number of *R* scripts, each script defining one configuration.

Contributions to initial app configurations are welcome to the *[iSEEhub](https://bioconductor.org/packages/3.22/iSEEhub)* as pull requests, both as new configurations and edits to existing configurations.

## 1.2 Requirements

An initial configuration script must define at least one object called `initial`, that contains a list of instances of panel classes defined in the *[iSEE](https://bioconductor.org/packages/3.22/iSEE)* package – so-called built-in panels – and other packages that extend *[iSEE](https://bioconductor.org/packages/3.22/iSEE)* functionality.
That is, packages like *[iSEEu](https://bioconductor.org/packages/3.22/iSEEu)* and *[iSEEhex](https://bioconductor.org/packages/3.22/iSEEhex)*.

Other objects created by configuration scripts are ignored.
We encourage users to refrain from creating any other object than `initial`, to avoid any unexpected behaviour in the app.

## 1.3 Example

For demonstration, the package includes two configurations for the dataset `EH1`.

The scripts that define those configurations are stored within the directory `inst/initial/EH1`.
Within that directory, the files are named `config_1.R` and `config_error.R`.

The script `config_1.R` defines an initial app state that contains only one panel, namely a `ComplexHeatmapPlot`, that is configured to span half the width of the app (6 out of 12 units in *[shiny](https://bioconductor.org/packages/3.22/shiny)* units), and displays the metadata `gender` and `status` as color bars next to the heat map.

```
## EH1/config_1.R
library(iSEE)

initial <- list(
    ComplexHeatmapPlot(
        PanelWidth = 6L,
        ColumnData = c("gender", "tumor_status")
    )
)
```

Conversely, the script `config_error.R` provides a brutal example of an invalid script that throws an error.
This script is only included in the package to test and demonstrate that the app fails elegantly when an invalid configuration is supplied (which should never happen in the first place).

```
## EH1/config_error.R
# This script demonstrates how the app handles a bad configuration.

stop("Bad config script!")
```

## 1.4 Process for contributing

* Fork the GitHub repository for [iSEEhub](https://github.com/iSEE/iSEEhub/).
* Create and/or edit appropriate files and directories within the `inst/initial` directory.
* Test your new configuration(s) locally; install the updated *[iSEEhub](https://bioconductor.org/packages/3.22/iSEEhub)* package, launch the app, and load dataset(s) using the new configuration(s).
* Open a pull request on the GitHub repository [iSEEhub](https://github.com/iSEE/iSEEhub/).
* Wait for maintainers to review and approve the pull request.

# 2 Reproducibility

The *[iSEEhub](https://bioconductor.org/packages/3.22/iSEEhub)* package (Rue-Albrecht, 2025) was made possible thanks to:

* R (R Core Team, 2025)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2025)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight, Müller, and Hester, 2025)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)

This package was developed using *[biocthis](https://bioconductor.org/packages/3.22/biocthis)*.

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("iSEEhub.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("iSEEhub.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2025-10-30 00:38:59 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 0.619 secs
```

*R* session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
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
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package     * version date (UTC) lib source
#>  backports     1.5.0   2024-05-23 [2] CRAN (R 4.5.1)
#>  bibtex        0.5.1   2023-01-26 [2] CRAN (R 4.5.1)
#>  BiocManager   1.30.26 2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocStyle   * 2.38.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bookdown      0.45    2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib         0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem        1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
#>  cli           3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
#>  digest        0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
#>  evaluate      1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
#>  fastmap       1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
#>  generics      0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
#>  glue          1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
#>  htmltools     0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
#>  httr          1.4.7   2023-08-15 [2] CRAN (R 4.5.1)
#>  jquerylib     0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite      2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
#>  knitr         1.50    2025-03-16 [2] CRAN (R 4.5.1)
#>  lifecycle     1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
#>  lubridate     1.9.4   2024-12-08 [2] CRAN (R 4.5.1)
#>  magrittr      2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
#>  plyr          1.8.9   2023-10-02 [2] CRAN (R 4.5.1)
#>  R6            2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
#>  Rcpp          1.1.0   2025-07-02 [2] CRAN (R 4.5.1)
#>  RefManageR  * 1.4.0   2022-09-30 [2] CRAN (R 4.5.1)
#>  rlang         1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown     2.30    2025-09-28 [2] CRAN (R 4.5.1)
#>  sass          0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
#>  sessioninfo * 1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
#>  stringi       1.8.7   2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr       1.5.2   2025-09-08 [2] CRAN (R 4.5.1)
#>  timechange    0.3.0   2024-01-18 [2] CRAN (R 4.5.1)
#>  xfun          0.53    2025-08-19 [2] CRAN (R 4.5.1)
#>  xml2          1.4.1   2025-10-27 [2] CRAN (R 4.5.1)
#>  yaml          2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpUtyVXz/Rinst11fb6b4522f493
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 3 Bibliography

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

[[5]](#cite-ruealbrecht2025iseehub)
K. Rue-Albrecht.
*iSEEhub: iSEE for the Bioconductor ExperimentHub*.
R package version 1.12.0.
2025.
DOI: [10.18129/B9.bioc.iSEEhub](https://doi.org/10.18129/B9.bioc.iSEEhub).
URL: <https://bioconductor.org/packages/iSEEhub>.

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