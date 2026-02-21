# Code example from 'header' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----eval=!exists("SCREENSHOT"), include=FALSE--------------------------------
SCREENSHOT <- function(x, ...) knitr::include_graphics(x)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    R = citation(),
    BiocStyle = citation("BiocStyle")[1],
    knitr = citation("knitr")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    sessioninfo = citation("sessioninfo")[1],
    testthat = citation("testthat")[1],
    iSEEindex = citation("iSEEindex")[1]
)

## ----message=FALSE------------------------------------------------------------
library("BiocFileCache")

##
# BiocFileCache ----
##

library(BiocFileCache)
bfc <- BiocFileCache(cache = tempdir())

##
# iSEEindex ----
##

dataset_fun <- function() {
  x <- yaml::read_yaml(system.file(package = "iSEEindex", "example.yaml"))
  x$datasets
}

initial_fun <- function() {
  x <- yaml::read_yaml(system.file(package = "iSEEindex", "example.yaml"))
  x$initial
}

## ----message=FALSE------------------------------------------------------------
library("shiny")
header <- fluidRow(shinydashboard::box(width = 12L, 
  column(width = 10,
    p(strong("Welcome to this demonstration app!")),
    p(
      "This is an example header that demonstrate how to use the functionality.",
      "A great place for branding and intros.",
    ),
    p("On the right, we demonstrate how other content such as images can be added to this header.")
  ),
  column(width = 2, img(src="www/iSEE.png", width = "100px", height = "120px"))
))
footer <- fluidRow(shinydashboard::box(width = 12L,
  p("This is a example footer. A great place for copyright statements and outros.", style="text-align: center;"),
  p(
    "© 2023 iSEE.",
    a("Artistic-2.0", href = "https://opensource.org/license/artistic-2-0/"),
    style="text-align: center;")
  ))

## ----message=FALSE------------------------------------------------------------
library("shiny")
addResourcePath("www", system.file(package = "iSEEindex"))

## ----message=FALSE------------------------------------------------------------
library("iSEEindex")
app <- iSEEindex(bfc, dataset_fun, initial_fun,
  body.header = header, body.footer = footer
)

if (interactive()) {
  shiny::runApp(app, port = 1234)
}

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/header_footer.png", delay=20)

## ----createVignette, eval=FALSE-----------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("header.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("header.Rmd", tangle = TRUE)

## ----reproduce1, echo=FALSE---------------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE---------------------------------------------------
## Processing time in seconds
totalTime <- diff(c(startTime, Sys.time()))
round(totalTime, digits = 3)

## ----reproduce3, echo=FALSE-----------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 100)
session_info()

## ----vignetteBiblio, results = "asis", echo = FALSE, warning = FALSE, message = FALSE-------------
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

