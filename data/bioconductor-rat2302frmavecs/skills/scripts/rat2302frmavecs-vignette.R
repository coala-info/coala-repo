# Code example from 'rat2302frmavecs-vignette' vignette. See references/ for full tutorial.

## ----setup, include = FALSE------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ---- eval=TRUE, echo=TRUE, results='hide', message=FALSE, warning=FALSE----

library('affy')
library('frma')
library('rat2302frmavecs')

celfile = system.file("extdata", "sample.CEL", package = "rat2302frmavecs")
affybatch = ReadAffy(filenames = celfile, cdfname = 'rat2302cdf')
eset = frma(affybatch)


