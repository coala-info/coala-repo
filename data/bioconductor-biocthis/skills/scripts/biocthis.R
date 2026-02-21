# Code example from 'biocthis' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    R = citation(),
    BiocStyle = citation("BiocStyle")[1],
    biocthis = citation("biocthis")[1],
    covr = citation("covr")[1],
    devtools = citation("devtools")[1],
    fs = citation("fs")[1],
    glue = citation("glue")[1],
    knitr = citation("knitr")[1],
    pkgdown = citation("pkgdown")[1],
    rlang = citation("rlang")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    sessioninfo = citation("sessioninfo")[1],
    styler = citation("styler")[1],
    testthat = citation("testthat")[1],
    usethis = citation("usethis")[1]
)

## ----"install", eval = FALSE--------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("biocthis")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----'install_dev', eval = FALSE----------------------------------------------
# BiocManager::install("lcolladotor/biocthis")

## ----"citation"---------------------------------------------------------------
## Citation info
citation("biocthis")

## ----"start", message=FALSE---------------------------------------------------
library("biocthis")

## Load other R packages used in this vignette
library("usethis")
library("styler")

## ----'create_example_pkg'-----------------------------------------------------
## Create an example package for illustrative purposes.
## Note: you do not need to run this for your own package!
pkgdir <- biocthis_example_pkg("biocthispkg", use_git = TRUE)

## ----'create_dev'-------------------------------------------------------------
## Create the bioc templates
biocthis::use_bioc_pkg_templates()

## ----'bioc_badges'------------------------------------------------------------
## Create some Bioconductor software package badges on your README files
biocthis::use_bioc_badges()

## ----'style_code'-------------------------------------------------------------
## Automatically style the example package
styler::style_pkg(pkgdir, transformers = biocthis::bioc_style())

## ----'bioc_citation'----------------------------------------------------------
## Create a template CITATION file that is Bioconductor-friendly
biocthis::use_bioc_citation()

## ----'bioc_description'-------------------------------------------------------
## Create a template DESCRIPTION file that is Bioconductor-friendly
biocthis::use_bioc_description()

## ----'bioc_feature_request_template'------------------------------------------
## Create a GitHub template for feature requests that is Bioconductor-friendly
biocthis::use_bioc_feature_request_template()

## ----'bioc_github_action'-----------------------------------------------------
## Create a GitHub Actions workflow that is Bioconductor-friendly
biocthis::use_bioc_github_action()

## ----"biocthis_options"-------------------------------------------------------
## Open your .Rprofile file with usethis::edit_r_profile()

## For biocthis
options("biocthis.pkgdown" = TRUE)
options("biocthis.testthat" = TRUE)

## ----'bioc_issue_template'----------------------------------------------------
## Create a GitHub issue template file that is Bioconductor-friendly
biocthis::use_bioc_issue_template()

## ----'bioc_news'--------------------------------------------------------------
## Create a template NEWS.md file that is Bioconductor-friendly
biocthis::use_bioc_news_md()

## ----"bioc_pkgdown_css"-------------------------------------------------------
## Create the pkgdown/extra.css file to configure pkgdown with
## Bioconductor's official colors
biocthis::use_bioc_pkgdown_css()

## ----'bioc_readme_rmd'--------------------------------------------------------
## Create a template README.Rmd file that is Bioconductor-friendly
biocthis::use_bioc_readme_rmd()

## ----'bioc_support'-----------------------------------------------------------
## Create a template GitHub support file that is Bioconductor-friendly
biocthis::use_bioc_support()

## ----'bioc_vignette'----------------------------------------------------------
## Create a template vignette file that is Bioconductor-friendly
biocthis::use_bioc_vignette("biocthispkg", "Introduction to biocthispkg")

## ----createVignette, eval=FALSE-----------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("biocthis.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("biocthis.Rmd", tangle = TRUE)

## ----reproduce1, echo=FALSE---------------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE---------------------------------------------------
## Processing time in seconds
totalTime <- diff(c(startTime, Sys.time()))
round(totalTime, digits = 3)

## ----reproduce3, echo=FALSE-------------------------------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 120)
session_info()

## ----vignetteBiblio, results = "asis", echo = FALSE, warning = FALSE, message = FALSE---------------------------------
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

