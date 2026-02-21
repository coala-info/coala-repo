# Code example from 'enterotyping' vignette. See references/ for full tutorial.

## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(mbOmic)
library(data.table)

## -----------------------------------------------------------------------------
dat <- read.delim('http://enterotypes.org/ref_samples_abundance_MetaHIT.txt')
dat <- impute::impute.knn(as.matrix(dat), k = 100)
dat <- as.data.frame(dat$data+0.001) 
setDT(dat, keep.rownames = TRUE)
dat

## -----------------------------------------------------------------------------
dat <- bSet(b =  dat)
res <- estimate_k(dat)
res

## -----------------------------------------------------------------------------
ret=enterotyping(dat, res$verOptCluster) 
ret

## -----------------------------------------------------------------------------
enterotypes <- read.table(system.file('extdata', 'enterotype.txt', package = 'mbOmic'))
enterotypes <- enterotypes[samples(dat),]
table(res$verOptCluster, enterotypes$ET)

## -----------------------------------------------------------------------------
devtools::session_info()

