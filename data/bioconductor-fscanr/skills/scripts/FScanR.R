# Code example from 'FScanR' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results="asis", message=FALSE-------------------------
knitr::opts_chunk$set(tidy = FALSE,
		   message = FALSE)

## ----echo=FALSE---------------------------------------------------------------
CRANpkg <- function (pkg) {
    cran <- "https://CRAN.R-project.org/package"
    fmt <- "[%s](%s=%s)"
    sprintf(fmt, pkg, cran, pkg)
}

Biocpkg <- function (pkg) {
    sprintf("[%s](http://bioconductor.org/packages/%s)", pkg, pkg)
}


## ----echo=FALSE, results='hide', message=FALSE--------------------------------
library(FScanR)

## ----eval = FALSE-------------------------------------------------------------
#  ##  Install FScanR in R (>= 3.5.0)
#  if(!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("FScanR")

## -----------------------------------------------------------------------------
## loading package
library(FScanR)
## loading test data
test_data <- read.table(system.file("extdata", "test.tab", package = "FScanR"), header=TRUE, sep="\t")

## -----------------------------------------------------------------------------
## loading packages
prf <- FScanR(test_data, evalue_cutoff = 1e-05, frameDist_cutoff = 10)
table(prf$FS_type)

## -----------------------------------------------------------------------------
## plot the 4-type PRF events detected
mytable <- table(prf$FS_type)
lbls <- paste(names(mytable), " : ", mytable, sep="")
pie(mytable, labels = NA, main=paste0("PRF events"), cex=0.5, col=cm.colors(length(mytable)))
legend("right",legend=lbls[!is.na(lbls)], bty="n", cex=1,  fill=cm.colors(length(mytable))[!is.na(lbls)])

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

