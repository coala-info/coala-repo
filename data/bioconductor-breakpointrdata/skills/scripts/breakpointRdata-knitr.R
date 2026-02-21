# Code example from 'breakpointRdata-knitr' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results='asis'--------------------
BiocStyle::latex()

## ----options, results='hide', message=FALSE, eval=TRUE, echo=FALSE----------------------
library(breakpointRdata)
options(width=90)

## ----eval=TRUE--------------------------------------------------------------------------
library(breakpointRdata)
?example_bams
?example_results

## ----eval=TRUE--------------------------------------------------------------------------
## Example BAM files
path <- system.file("extdata", "example_bams", package="breakpointRdata")
files <- list.files(path, full.names=TRUE, pattern=".bam$")

## ----message=FALSE, eval=TRUE, echo=FALSE-----------------------------------------------
files <- gsub(files, pattern=".*breakpointRdata", replacement="")

## ----eval=TRUE--------------------------------------------------------------------------
files

## ----eval=TRUE--------------------------------------------------------------------------
## Example results
path <- system.file("extdata", "example_results", package="breakpointRdata")
files <- list.files(path, full.names=TRUE)

## ----message=FALSE, eval=TRUE, echo=FALSE-----------------------------------------------
files <- gsub(files, pattern=".*breakpointRdata", replacement="")

## ----eval=TRUE--------------------------------------------------------------------------
files

## ----sessionInfo, results='asis', eval=TRUE---------------------------------------------
toLatex(sessionInfo())

