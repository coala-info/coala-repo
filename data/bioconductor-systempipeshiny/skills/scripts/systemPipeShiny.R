# Code example from 'systemPipeShiny' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', eval=TRUE-------------------------
options(width=80, max.print=1000)
knitr::opts_chunk$set(
    eval=as.logical(Sys.getenv("KNITR_EVAL", "TRUE")),
    cache=as.logical(Sys.getenv("KNITR_CACHE", "TRUE")), 
    tidy.opts=list(width.cutoff=60), 
    tidy=TRUE,
    eval = FALSE)
# shiny::tagList(rmarkdown::html_dependency_font_awesome())

## ----setup, echo=FALSE, messages=FALSE, warnings=FALSE, eval=TRUE-------------
    suppressPackageStartupMessages(library(systemPipeShiny))

## ----logo, echo=FALSE, out.width='50%', fig.align='center', eval=TRUE---------
knitr::include_graphics(path = "../inst/app/www/img/logo.png")

## ----sps_load_package, eval=TRUE----------------------------------------------
library(systemPipeShiny)

## ----spsinit, eval=FALSE------------------------------------------------------
# spsInit()

## ----spsinit_temp, eval=TRUE, collapse=TRUE-----------------------------------
sps_tmp_dir <- tempdir()
spsInit(app_path = sps_tmp_dir, change_wd = FALSE, project_name = "SPSProject")
sps_dir <- file.path(sps_tmp_dir, "SPSProject")

## ----eval=FALSE---------------------------------------------------------------
# shiny::runApp()

## ----sessionInfo, eval=TRUE---------------------------------------------------
sessionInfo()

